---
stub: true
description: >-
  Windows registry keys created by MusicBrainz Picard — install paths, uninstall keys,
  HKCU and HKLM entries for sysadmin automation and cleanup.
tags:
  - audio
  - tag-editor
  - HKCU
  - HKLM
  - msi-installer
---

<!-- Community stub: paths below are best-effort estimates. Verify against a live installation before removing stub: true. -->

# MusicBrainz Picard

**Version tested:** *community contribution needed — install and verify*
**Installer type:** `.msi`

## 📦 Package Managers

| Manager | Command |
|---------|---------|
| **winget** | `winget install MusicBrainz.Picard` |
| **choco** | `choco install musicbrainz-picard` |
| **scoop** | `scoop install musicbrainz-picard` |

## 📁 Registry Paths

| Hive | Path | Purpose |
|------|------|---------|
| `HKCU` | `SOFTWARE\MusicBrainz\Picard` | Application settings and preferences |
| `HKLM` | `SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\MusicBrainz Picard` | Uninstall entry (named key) |
| `HKLM` | `SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{GUID}` | Uninstall entry (MSI GUID — verify on live install) |

## 🔑 Keys

| Path | Hive | Value Name | Type |
|------|------|------------|------|
| `SOFTWARE\MusicBrainz\Picard` | `HKCU` | *(verify key names and values against a live installation)* | REG_SZ |
| `SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\MusicBrainz Picard` | `HKLM` | `DisplayName` | REG_SZ |
| `SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\MusicBrainz Picard` | `HKLM` | `DisplayVersion` | REG_SZ |
| `SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\MusicBrainz Picard` | `HKLM` | `InstallLocation` | REG_EXPAND_SZ |
| `SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\MusicBrainz Picard` | `HKLM` | `UninstallString` | REG_SZ |

## 📝 Notes

- **Installer type:** `.msi`
- **Winget ID:** `MusicBrainz.Picard`
- This stub was auto-generated from the app backlog. Registry paths above are best-effort estimates.
- Please install MusicBrainz Picard on a clean Windows environment, run `reg export` on the listed paths, and update this file with confirmed values.
- See [CONTRIBUTING.md](https://github.com/samibs/Registry-Keys-for-Open-Source-Applications-on-Windows/blob/main/CONTRIBUTING.md) for the contribution workflow.