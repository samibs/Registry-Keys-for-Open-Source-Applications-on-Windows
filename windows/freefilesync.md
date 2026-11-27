---
stub: true
description: >-
  Windows registry keys created by FreeFileSync — install paths, uninstall keys,
  HKCU and HKLM entries for sysadmin automation and cleanup.
tags:
  - file-sync
  - backup
  - HKCU
  - HKLM
  - exe-installer
---

<!-- Community stub: paths below are best-effort estimates. Verify against a live installation before removing stub: true. -->

# FreeFileSync

**Version tested:** *community contribution needed — install and verify*
**Installer type:** `.exe`

## 📦 Package Managers

| Manager | Command |
|---------|---------|
| **winget** | `winget install FreeFileSync.FreeFileSync` |
| **choco** | `choco install freefilesync` |
| **scoop** | `scoop install freefilesync` |

## 📁 Registry Paths

| Hive | Path | Purpose |
|------|------|---------|
| `HKCU` | `SOFTWARE\FreeFileSync\FreeFileSync` | Application settings and preferences |
| `HKLM` | `SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\FreeFileSync` | Uninstall entry (named key) |

## 🔑 Keys

| Path | Hive | Value Name | Type |
|------|------|------------|------|
| `SOFTWARE\FreeFileSync\FreeFileSync` | `HKCU` | *(verify key names and values against a live installation)* | REG_SZ |
| `SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\FreeFileSync` | `HKLM` | `DisplayName` | REG_SZ |
| `SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\FreeFileSync` | `HKLM` | `DisplayVersion` | REG_SZ |
| `SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\FreeFileSync` | `HKLM` | `InstallLocation` | REG_EXPAND_SZ |
| `SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\FreeFileSync` | `HKLM` | `UninstallString` | REG_SZ |

## 📝 Notes

- **Installer type:** `.exe`
- **Winget ID:** `FreeFileSync.FreeFileSync`
- This stub was auto-generated from the app backlog. Registry paths above are best-effort estimates.
- Please install FreeFileSync on a clean Windows environment, run `reg export` on the listed paths, and update this file with confirmed values.
- See [CONTRIBUTING.md](https://github.com/samibs/Registry-Keys-for-Open-Source-Applications-on-Windows/blob/main/CONTRIBUTING.md) for the contribution workflow.