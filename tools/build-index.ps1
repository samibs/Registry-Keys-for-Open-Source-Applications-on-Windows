<#
.SYNOPSIS
    Regenerates windows/index.json from the markdown files in windows/.

.DESCRIPTION
    Parses each .md file in the windows/ directory to extract:
      - Application name (from the H1 heading)
      - Version tested
      - Installer type
      - Registry paths (from the "Registry Paths" section bullet list)
      - Hives (HKCU / HKLM / HKCR / HKU — derived from paths)

    Writes the result to windows/index.json sorted alphabetically by slug.

    Run this script whenever a new app is added or an existing doc is updated.
    The CI workflow validates that the committed index.json matches what this
    script would generate.

.EXAMPLE
    PS C:\repo> .\tools\build-index.ps1

.EXAMPLE
    # Check if index.json is stale without writing it
    PS C:\repo> .\tools\build-index.ps1 -DryRun
#>

[CmdletBinding()]
param (
    [switch]$DryRun
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$repoRoot   = Split-Path -Parent $PSScriptRoot
$windowsDir = Join-Path $repoRoot "windows"
$indexPath  = Join-Path $windowsDir "index.json"

if (-not (Test-Path $windowsDir)) {
    Write-Error "windows/ directory not found at: $windowsDir"
    exit 1
}

$files = Get-ChildItem -Path $windowsDir -Filter "*.md" | Where-Object { $_.Name -notin @('index.md', 'tags.md', 'registry-types.md', 'cookbook.md') } | Sort-Object Name

$entries = [System.Collections.Generic.List[object]]::new()

foreach ($file in $files) {
    $content = Get-Content -Path $file.FullName -Raw
    $lines   = Get-Content -Path $file.FullName

    # --- App name: first H1 heading ---
    $nameLine = $lines | Where-Object { $_ -match '^# ' } | Select-Object -First 1
    if (-not $nameLine) {
        Write-Warning "$($file.Name): No H1 heading found — skipping."
        continue
    }
    $appName = $nameLine -replace '^# ', ''

    # --- Slug: filename without extension ---
    $slug = $file.BaseName

    # --- Version tested ---
    $versionLine = $lines | Where-Object { $_ -match '^\*\*Version tested:\*\*' } | Select-Object -First 1
    $version = if ($versionLine -match '^\*\*Version tested:\*\*\s*(.+)$') { $Matches[1].Trim() } else { '' }

    # --- Installer type ---
    $installerLine = $lines | Where-Object { $_ -match '^\*\*Installer type:\*\*' } | Select-Object -First 1
    $installerType = if ($installerLine -match '^\*\*Installer type:\*\*\s*(.+)$') { $Matches[1].Trim() } else { '' }

    # --- Registry paths: bullet lines under "## 📁 Registry Paths" ---
    $inPathsSection = $false
    $paths = [System.Collections.Generic.List[string]]::new()

    foreach ($line in $lines) {
        if ($line -match '^## .*Registry Paths') {
            $inPathsSection = $true
            continue
        }
        if ($inPathsSection -and $line -match '^## ') {
            break  # hit the next section
        }
        if ($inPathsSection -and $line -match '^\s*-\s+`(.+)`') {
            $paths.Add($Matches[1])
        }
    }

    # --- Hives: derive from paths ---
    $hives = [System.Collections.Generic.SortedSet[string]]::new()
    foreach ($p in $paths) {
        $hive = ($p -split '\\')[0]
        switch ($hive) {
            'HKEY_CURRENT_USER'   { [void]$hives.Add('HKCU') }
            'HKEY_LOCAL_MACHINE'  { [void]$hives.Add('HKLM') }
            'HKEY_CLASSES_ROOT'   { [void]$hives.Add('HKCR') }
            'HKEY_USERS'          { [void]$hives.Add('HKU')  }
        }
    }

    $entries.Add([PSCustomObject]@{
        name             = $appName
        slug             = $slug
        file             = "windows/$($file.Name)"
        version_tested   = $version
        installer_type   = $installerType
        hives            = @($hives)
        registry_paths   = @($paths)
    })

    Write-Host "  Parsed: $($file.Name) → $appName ($($paths.Count) paths)" -ForegroundColor Cyan
}

# Sort by slug for stable output
$sorted = $entries | Sort-Object slug

$json = $sorted | ConvertTo-Json -Depth 5

if ($DryRun) {
    $existing = if (Test-Path $indexPath) { Get-Content $indexPath -Raw } else { '' }
    # Normalize line endings for comparison
    if ($json.Trim() -eq $existing.Trim()) {
        Write-Host "`n✅ index.json is up to date." -ForegroundColor Green
        exit 0
    }
    else {
        Write-Host "`n❌ index.json is STALE — run build-index.ps1 to update it." -ForegroundColor Red
        exit 1
    }
}

$json | Out-File -FilePath $indexPath -Encoding utf8 -NoNewline
Write-Host "`n✅ Written $($sorted.Count) entries to: $indexPath" -ForegroundColor Green
