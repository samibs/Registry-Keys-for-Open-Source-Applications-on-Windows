<#
.SYNOPSIS
    Checks whether each app doc is up to date against the latest winget version.

.DESCRIPTION
    Reads the Version and winget install command from each app markdown file,
    queries winget for the current latest version, and reports which docs are
    potentially stale (doc version != latest available version).

.PARAMETER OutputFormat
    'table'   - Pretty console table (default)
    'json'    - JSON array, suitable for CI consumption
    'issues'  - Markdown suitable for GitHub issue bodies

.PARAMETER StaleOnly
    When specified, only outputs apps whose doc version differs from winget latest.

.PARAMETER MaxApps
    Limit the number of apps to check (useful for testing). Default: all.

.EXAMPLE
    pwsh -File tools/check-versions.ps1
    pwsh -File tools/check-versions.ps1 -StaleOnly
    pwsh -File tools/check-versions.ps1 -OutputFormat json -StaleOnly
#>

param(
    [ValidateSet('table', 'json', 'issues')]
    [string]$OutputFormat = 'table',

    [switch]$StaleOnly,

    [int]$MaxApps = 0
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'SilentlyContinue'

$repoRoot   = Split-Path $PSScriptRoot -Parent
$docsDir    = Join-Path $repoRoot 'windows'
$excludeFiles = @('index.md','tags.md','registry-types.md','cookbook.md','stats.md')

# --------------------------------------------------------------------------- #
# Helpers
# --------------------------------------------------------------------------- #

function Get-WingetLatestVersion {
    param([string]$WingetId)
    try {
        # winget show returns structured output; grab the Version line
        $raw = winget show --id $WingetId --exact --accept-source-agreements 2>$null
        if (-not $raw) { return $null }
        $versionLine = $raw | Where-Object { $_ -match '^\s*Version\s*:' } | Select-Object -First 1
        if ($versionLine) {
            return ($versionLine -replace '^\s*Version\s*:\s*', '').Trim()
        }
    } catch {
        # winget not available or package not found
    }
    return $null
}

function Extract-DocVersion {
    param([string]$Content)
    # Matches: **Version:** 1.2.3  or  Version: 1.2.3
    if ($Content -match '\*\*Version:\*\*\s*([^\s\r\n]+)') {
        return $Matches[1].Trim()
    }
    if ($Content -match '^Version:\s*(.+)$') {
        return $Matches[1].Trim()
    }
    return $null
}

function Extract-WingetId {
    param([string]$Content)
    # Matches: winget install Foo.Bar  (from the Package Managers table)
    if ($Content -match 'winget install\s+`?([A-Za-z0-9.\-_]+)`?') {
        return $Matches[1].Trim('`')
    }
    return $null
}

function Compare-Versions {
    param([string]$DocVer, [string]$LatestVer)
    # Normalize: strip leading 'v', take only the numeric part before any dash/space
    $d = ($DocVer  -replace '^v','') -replace '[\s\-].*',''
    $l = ($LatestVer -replace '^v','') -replace '[\s\-].*',''
    try {
        $dv = [System.Version]::Parse($d)
        $lv = [System.Version]::Parse($l)
        return $lv.CompareTo($dv)   # >0 means latest is newer
    } catch {
        return [string]::Compare($l, $d, $true)
    }
}

# --------------------------------------------------------------------------- #
# Main
# --------------------------------------------------------------------------- #

$mdFiles = Get-ChildItem "$docsDir\*.md" |
    Where-Object { $_.Name -notin $excludeFiles } |
    Sort-Object Name

if ($MaxApps -gt 0) { $mdFiles = $mdFiles | Select-Object -First $MaxApps }

$results = [System.Collections.Generic.List[PSObject]]::new()

$i = 0
foreach ($file in $mdFiles) {
    $i++
    $content   = Get-Content $file.FullName -Raw
    $appName   = ($content | Select-String '(?m)^# (.+)$' | Select-Object -First 1).Matches[0].Groups[1].Value.Trim()
    $docVer    = Extract-DocVersion $content
    $wingetId  = Extract-WingetId  $content

    $latest    = $null
    $status    = 'unknown'
    $cmp       = 0

    if ($wingetId) {
        Write-Progress -Activity "Checking versions" -Status "$appName ($wingetId)" -PercentComplete ([int]($i / $mdFiles.Count * 100))
        $latest = Get-WingetLatestVersion $wingetId
    }

    if ($docVer -and $latest) {
        $cmp = Compare-Versions $docVer $latest
        $status = if ($cmp -gt 0) { 'stale' } elseif ($cmp -lt 0) { 'ahead' } else { 'current' }
    } elseif ($docVer -and -not $wingetId) {
        $status = 'no-winget-id'
    } elseif (-not $docVer) {
        $status = 'no-version'
    } elseif (-not $latest) {
        $status = 'winget-error'
    }

    $obj = [PSCustomObject]@{
        App       = $appName
        File      = $file.Name
        DocVer    = $docVer    ?? '-'
        Latest    = $latest    ?? '-'
        WingetId  = $wingetId  ?? '-'
        Status    = $status
    }
    $results.Add($obj)
}

Write-Progress -Activity "Checking versions" -Completed

# Filter if --StaleOnly
$output = if ($StaleOnly) { $results | Where-Object { $_.Status -eq 'stale' } } else { $results }

# --------------------------------------------------------------------------- #
# Output
# --------------------------------------------------------------------------- #

switch ($OutputFormat) {

    'json' {
        $output | ConvertTo-Json -Depth 3
    }

    'issues' {
        $stale = $results | Where-Object { $_.Status -eq 'stale' }
        if ($stale.Count -eq 0) {
            Write-Host "All docs are current — no issues to open."
        } else {
            foreach ($app in $stale) {
                Write-Output "## Stale doc: $($app.App)"
                Write-Output ""
                Write-Output "**File:** \`windows/$($app.File)\`"
                Write-Output "**Doc version:** $($app.DocVer)"
                Write-Output "**Latest (winget):** $($app.Latest)"
                Write-Output "**Winget ID:** \`$($app.WingetId)\`"
                Write-Output ""
                Write-Output "Please update the doc to reflect version $($app.Latest)."
                Write-Output ""
                Write-Output "---"
                Write-Output ""
            }
        }
    }

    default {
        # Pretty table
        $staleCount   = ($results | Where-Object { $_.Status -eq 'stale'   }).Count
        $currentCount = ($results | Where-Object { $_.Status -eq 'current' }).Count
        $unknownCount = ($results | Where-Object { $_.Status -notin 'stale','current' }).Count

        Write-Host ""
        Write-Host "Registry Keys — Version Staleness Report" -ForegroundColor Cyan
        Write-Host "$(Get-Date -Format 'yyyy-MM-dd HH:mm')" -ForegroundColor DarkGray
        Write-Host ""

        $colWidth = @{ App=30; DocVer=14; Latest=14; Status=14 }

        # Header
        $header = ("App".PadRight($colWidth.App)) + ("Doc Ver".PadRight($colWidth.DocVer)) + ("Latest".PadRight($colWidth.Latest)) + "Status"
        Write-Host $header -ForegroundColor White
        Write-Host ("-" * ($colWidth.App + $colWidth.DocVer + $colWidth.Latest + 14))

        foreach ($r in $output) {
            $color = switch ($r.Status) {
                'stale'        { 'Yellow' }
                'current'      { 'Green'  }
                'ahead'        { 'Cyan'   }
                'no-winget-id' { 'DarkGray' }
                default        { 'Gray'   }
            }
            $line = ($r.App.Substring(0, [Math]::Min($r.App.Length, $colWidth.App-1))).PadRight($colWidth.App) +
                    ($r.DocVer.PadRight($colWidth.DocVer)) +
                    ($r.Latest.PadRight($colWidth.Latest)) +
                    $r.Status
            Write-Host $line -ForegroundColor $color
        }

        Write-Host ""
        Write-Host "Summary: " -NoNewline
        Write-Host "$currentCount current  " -ForegroundColor Green -NoNewline
        Write-Host "$staleCount stale  " -ForegroundColor Yellow -NoNewline
        Write-Host "$unknownCount unknown/no-winget" -ForegroundColor DarkGray
        Write-Host ""

        if ($staleCount -gt 0) {
            Write-Host "Run with -StaleOnly to list only stale apps." -ForegroundColor DarkGray
            Write-Host "Run with -OutputFormat issues to get GitHub issue bodies." -ForegroundColor DarkGray
        }
    }
}
