<#
.SYNOPSIS
    Inserts a new application entry into the Applications section of mkdocs.yml
    in the correct alphabetical position.

.DESCRIPTION
    Reads mkdocs.yml, finds the Applications nav section, and inserts
    '    - <Name>: <slug>.md' in sorted order (case-insensitive by display name).
    Writes the file back in-place.

.PARAMETER Name
    Display name of the application (must match the nav entry label).

.PARAMETER Slug
    Filename slug without .md extension.

.EXAMPLE
    .\tools\update-nav.ps1 -Name "Blender" -Slug "blender"
#>

[CmdletBinding()]
param (
    [Parameter(Mandatory)][string]$Name,
    [Parameter(Mandatory)][string]$Slug
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$repoRoot    = Split-Path -Parent $PSScriptRoot
$mkdocsPath  = Join-Path $repoRoot "mkdocs.yml"
$newEntry    = "    - ${Name}: ${Slug}.md"

$lines = Get-Content $mkdocsPath

# Check if entry already exists
if ($lines | Where-Object { $_ -match [regex]::Escape("${Slug}.md") }) {
    Write-Warning "Nav entry for '$Slug' already exists — skipping."
    exit 0
}

# Find the Applications: section and collect existing entries
$appSectionStart = -1
$appEntries      = [System.Collections.Generic.List[int]]::new()

for ($i = 0; $i -lt $lines.Count; $i++) {
    if ($lines[$i] -match '^\s*- Applications:') {
        $appSectionStart = $i
        continue
    }
    if ($appSectionStart -ge 0) {
        # App entries are indented with 4 spaces and start with '    - '
        if ($lines[$i] -match '^    - .+\.md') {
            $appEntries.Add($i)
        }
        # Stop when we hit a new top-level nav item (2-space indent or no indent)
        elseif ($lines[$i] -match '^  - ' -or ($lines[$i].Trim() -ne '' -and $lines[$i] -notmatch '^    ')) {
            break
        }
    }
}

if ($appSectionStart -lt 0 -or $appEntries.Count -eq 0) {
    Write-Error "Could not locate Applications: nav section in mkdocs.yml"
    exit 1
}

# Extract display names from existing entries and find insert position
$insertBeforeIndex = $lines.Count  # default: append after last entry

foreach ($idx in $appEntries) {
    $existingName = ($lines[$idx] -replace '^\s*- ', '' -replace ':.*$', '').Trim()
    if ([string]::Compare($Name, $existingName, $true) -lt 0) {
        $insertBeforeIndex = $idx
        break
    }
}

# Build new lines list with insertion
$newLines = [System.Collections.Generic.List[string]]::new()

for ($i = 0; $i -lt $lines.Count; $i++) {
    if ($i -eq $insertBeforeIndex) {
        $newLines.Add($newEntry)
    }
    $newLines.Add($lines[$i])
}

# If we never found a spot (Name sorts after all entries), append after last entry
if ($insertBeforeIndex -eq $lines.Count) {
    $lastEntryLine = $appEntries[-1]
    $newLines2 = [System.Collections.Generic.List[string]]::new()
    for ($i = 0; $i -lt $newLines.Count; $i++) {
        $newLines2.Add($newLines[$i])
        if ($newLines[$i] -eq $lines[$lastEntryLine]) {
            $newLines2.Add($newEntry)
        }
    }
    $newLines = $newLines2
}

$newLines | Set-Content $mkdocsPath -Encoding UTF8
Write-Host "✅ Inserted nav entry for '$Name' into mkdocs.yml" -ForegroundColor Green
