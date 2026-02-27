<#
.SYNOPSIS
    Generates a stub documentation file for an open-source Windows application.

.DESCRIPTION
    Creates a markdown stub in windows/ with correct frontmatter (stub: true),
    required sections (Registry Paths, Keys, Notes), and a best-effort registry
    path table based on the app's installer type and known hives.

    Stub files are excluded from validate-docs.ps1 and build-index.ps1 until
    a contributor fills in the verified data and removes 'stub: true'.

.PARAMETER Name
    Display name of the application (used in the H1 heading).

.PARAMETER Slug
    Filename slug (lowercase, hyphens only). Output: windows/<slug>.md

.PARAMETER WingetId
    Winget package identifier (e.g. BlenderFoundation.Blender).

.PARAMETER InstallerType
    One of: exe | msi | portable | msix | winget

.PARAMETER Tags
    Comma-separated list of frontmatter tags (e.g. "3d-graphics,HKCU,HKLM").

.PARAMETER Hives
    Comma-separated hives expected (e.g. "HKCU,HKLM").

.EXAMPLE
    .\tools\generate-stub.ps1 -Name "Blender" -Slug "blender" `
        -WingetId "BlenderFoundation.Blender" -InstallerType "msi" `
        -Tags "3d-graphics,HKCU,HKLM,msi-installer" -Hives "HKCU,HKLM"
#>

[CmdletBinding()]
param (
    [Parameter(Mandatory)][string]$Name,
    [Parameter(Mandatory)][string]$Slug,
    [Parameter(Mandatory)][string]$WingetId,
    [Parameter(Mandatory)][ValidateSet('exe','msi','portable','msix','winget')][string]$InstallerType,
    [Parameter(Mandatory)][string]$Tags,
    [Parameter(Mandatory)][string]$Hives
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$repoRoot   = Split-Path -Parent $PSScriptRoot
$outputPath = Join-Path $repoRoot "windows\$Slug.md"

if (Test-Path $outputPath) {
    Write-Warning "File already exists, skipping: $outputPath"
    exit 0
}

# ── Parse inputs ─────────────────────────────────────────────────────────────
$tagList  = $Tags  -split ',' | ForEach-Object { $_.Trim() } | Where-Object { $_ }
$hiveList = $Hives -split ',' | ForEach-Object { $_.Trim() } | Where-Object { $_ }

$tagYaml = ($tagList | ForEach-Object { "  - $_" }) -join "`n"

# ── Build installer section ───────────────────────────────────────────────────
$installerExt = switch ($InstallerType) {
    'exe'      { '`.exe`' }
    'msi'      { '`.msi`' }
    'portable' { 'portable `.zip` / `.exe`' }
    'msix'     { '`.msix`' }
    'winget'   { 'winget package' }
}

$pkgManagerSection = @"
## 📦 Package Managers

| Manager | Command |
|---------|---------|
| **winget** | ``winget install $WingetId`` |
| **choco** | ``choco install $($Slug)`` |
| **scoop** | ``scoop install $($Slug)`` |
"@

# ── Build registry paths table ────────────────────────────────────────────────
$pathRows = [System.Collections.Generic.List[string]]::new()

foreach ($hive in $hiveList) {
    switch ($hive) {
        'HKCU' {
            # Derive vendor/app from winget ID
            $parts  = $WingetId -split '\.'
            $vendor = if ($parts.Count -ge 2) { $parts[0] } else { $Name }
            $app    = if ($parts.Count -ge 2) { $parts[-1] } else { $Name }
            $pathRows.Add("| ``$hive`` | ``SOFTWARE\$vendor\$app`` | Application settings and preferences |")
        }
        'HKLM' {
            $pathRows.Add("| ``$hive`` | ``SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$Name`` | Uninstall entry (named key) |")
            if ($InstallerType -eq 'msi') {
                $pathRows.Add("| ``$hive`` | ``SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{GUID}`` | Uninstall entry (MSI GUID — verify on live install) |")
            }
        }
        'HKCR' {
            $pathRows.Add("| ``$hive`` | ``$Name`` | File association / COM registration |")
        }
    }
}

$pathTable = @"
## 📁 Registry Paths

| Hive | Path | Purpose |
|------|------|---------|
$($pathRows -join "`n")
"@

# ── Build keys table ──────────────────────────────────────────────────────────
$keyRows = [System.Collections.Generic.List[string]]::new()

foreach ($hive in $hiveList) {
    switch ($hive) {
        'HKCU' {
            $parts  = $WingetId -split '\.'
            $vendor = if ($parts.Count -ge 2) { $parts[0] } else { $Name }
            $app    = if ($parts.Count -ge 2) { $parts[-1] } else { $Name }
            $keyRows.Add("| ``SOFTWARE\$vendor\$app`` | ``HKCU`` | *(verify key names and values against a live installation)* | REG_SZ |")
        }
        'HKLM' {
            $keyRows.Add("| ``SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$Name`` | ``HKLM`` | ``DisplayName`` | REG_SZ |")
            $keyRows.Add("| ``SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$Name`` | ``HKLM`` | ``DisplayVersion`` | REG_SZ |")
            $keyRows.Add("| ``SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$Name`` | ``HKLM`` | ``InstallLocation`` | REG_EXPAND_SZ |")
            $keyRows.Add("| ``SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$Name`` | ``HKLM`` | ``UninstallString`` | REG_SZ |")
        }
    }
}

$keysTable = @"
## 🔑 Keys

| Path | Hive | Value Name | Type |
|------|------|------------|------|
$($keyRows -join "`n")
"@

# ── Notes section ─────────────────────────────────────────────────────────────
$notesSection = @"
## 📝 Notes

- **Installer type:** $installerExt
- **Winget ID:** ``$WingetId``
- This stub was auto-generated from the app backlog. Registry paths above are best-effort estimates.
- Please install $Name on a clean Windows environment, run ``reg export`` on the listed paths, and update this file with confirmed values.
- See [CONTRIBUTING.md](https://github.com/samibs/Registry-Keys-for-Open-Source-Applications-on-Windows/blob/main/CONTRIBUTING.md) for the contribution workflow.
"@

# ── Assemble full document ────────────────────────────────────────────────────
$doc = @"
---
stub: true
description: >-
  Windows registry keys created by $Name — install paths, uninstall keys,
  HKCU and HKLM entries for sysadmin automation and cleanup.
tags:
$tagYaml
---

<!-- Community stub: paths below are best-effort estimates. Verify against a live installation before removing stub: true. -->

# $Name

**Version tested:** *community contribution needed — install and verify*
**Installer type:** $installerExt

$pkgManagerSection

$pathTable

$keysTable

$notesSection
"@

# ── Write file ────────────────────────────────────────────────────────────────
$doc | Set-Content -Path $outputPath -Encoding UTF8 -NoNewline
Write-Host "✅ Created stub: windows\$Slug.md" -ForegroundColor Green
