---
stub: true
description: >-
  Windows registry keys created by Mp3tag — install paths, uninstall keys,
  HKCU and HKLM entries for sysadmin automation and cleanup.
tags:
  - audio
  - tag-editor
  - HKCU
  - HKLM
  - exe-installer
---

<!-- Community stub: paths below are best-effort estimates. Verify against a live installation before removing stub: true. -->

# Mp3tag

**Version tested:** *community contribution needed — install and verify*
**Installer type:** `.exe`

## 📦 Package Managers

| Manager | Command |
|---------|---------|
| **winget** | `winget install Mp3tag.Mp3tag` |
| **choco** | `choco install mp3tag` |
| **scoop** | `scoop install mp3tag` |

## 📁 Registry Paths

| Hive | Path | Purpose |
|------|------|---------|
| `HKCU` | `SOFTWARE\Mp3tag\Mp3tag` | Application settings and preferences |
| `HKLM` | `SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Mp3tag` | Uninstall entry (named key) |

## 🔑 Keys

| Path | Hive | Value Name | Type |
|------|------|------------|------|
| `SOFTWARE\Mp3tag\Mp3tag` | `HKCU` | *(verify key names and values against a live installation)* | REG_SZ |
| `SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Mp3tag` | `HKLM` | `DisplayName` | REG_SZ |
| `SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Mp3tag` | `HKLM` | `DisplayVersion` | REG_SZ |
| `SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Mp3tag` | `HKLM` | `InstallLocation` | REG_EXPAND_SZ |
| `SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Mp3tag` | `HKLM` | `UninstallString` | REG_SZ |

## 📝 Notes

- **Installer type:** `.exe`
- **Winget ID:** `Mp3tag.Mp3tag`
- This stub was auto-generated from the app backlog. Registry paths above are best-effort estimates.
- Please install Mp3tag on a clean Windows environment, run `reg export` on the listed paths, and update this file with confirmed values.
- See [CONTRIBUTING.md](https://github.com/samibs/Registry-Keys-for-Open-Source-Applications-on-Windows/blob/main/CONTRIBUTING.md) for the contribution workflow.