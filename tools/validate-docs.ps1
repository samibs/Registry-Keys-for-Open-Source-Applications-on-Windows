<#
.SYNOPSIS
    Validates that all markdown files in the windows/ directory follow the required template.

.DESCRIPTION
    Checks each .md file under windows/ for the mandatory sections defined by the project template:
      - ## 📁 Registry Paths
      - ## 🔑 Keys
      - ## 📝 Notes
    Also checks that no file contains placeholder warnings.
    Exits with code 1 if any file fails validation.

.EXAMPLE
    PS C:\path\to\tools> .\validate-docs.ps1

.EXAMPLE
    # Run from repo root
    PS C:\repo> .\tools\validate-docs.ps1
#>

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

# Resolve the windows/ directory relative to this script's location
$repoRoot = Split-Path -Parent $PSScriptRoot
$windowsDir = Join-Path $repoRoot "windows"

if (-not (Test-Path $windowsDir)) {
    Write-Error "windows/ directory not found at: $windowsDir"
    exit 1
}

$files = Get-ChildItem -Path $windowsDir -Filter "*.md" | Where-Object { $_.Name -notin @('index.md', 'tags.md') }

if ($files.Count -eq 0) {
    Write-Warning "No markdown files found in: $windowsDir"
    exit 0
}

$requiredSections = @(
    "## 📁 Registry Paths",
    "## 🔑 Keys",
    "## 📝 Notes"
)

$forbiddenPhrases = @(
    "placeholder",
    "TODO",
    "FIXME",
    "coming soon",
    "not yet verified"
)

$failCount = 0

foreach ($file in $files) {
    $content = Get-Content -Path $file.FullName -Raw
    $fileErrors = [System.Collections.Generic.List[string]]::new()

    # Check required sections
    foreach ($section in $requiredSections) {
        if ($content -notmatch [regex]::Escape($section)) {
            $fileErrors.Add("Missing required section: '$section'")
        }
    }

    # Check for forbidden placeholder phrases (case-insensitive)
    foreach ($phrase in $forbiddenPhrases) {
        if ($content -match "(?i)$([regex]::Escape($phrase))") {
            $fileErrors.Add("Contains forbidden phrase: '$phrase'")
        }
    }

    # Check that there is at least one Markdown table header separator row (|---|)
    # This confirms the Keys section actually has a populated table
    if ($content -notmatch '(?m)^\|[-| ]+\|') {
        $fileErrors.Add("No markdown table found in file (expected at least one | --- | separator row)")
    }

    if ($fileErrors.Count -gt 0) {
        Write-Host "❌ $($file.Name)" -ForegroundColor Red
        foreach ($err in $fileErrors) {
            Write-Host "   • $err" -ForegroundColor Red
        }
        $failCount++
    }
    else {
        Write-Host "✅ $($file.Name)" -ForegroundColor Green
    }
}

Write-Host ""
if ($failCount -gt 0) {
    Write-Host "$failCount file(s) failed validation." -ForegroundColor Red
    exit 1
}
else {
    Write-Host "All $($files.Count) file(s) passed validation." -ForegroundColor Green
    exit 0
}
