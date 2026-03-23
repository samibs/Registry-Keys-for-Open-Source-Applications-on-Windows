---
stub: true
description: >-
  Windows registry keys created by VeraCrypt — install paths, uninstall keys,
  HKCU and HKLM entries for sysadmin automation and cleanup.
tags:
  - encryption
  - security
  - HKCU
  - HKLM
  - exe-installer
---

<!-- Community stub: paths below are best-effort estimates. Verify against a live installation before removing stub: true. -->

# VeraCrypt

**Version tested:** *community contribution needed — install and verify*
**Installer type:** `.exe`

## 📦 Package Managers

| Manager | Command |
|---------|---------|
| **winget** | `winget install IDRIX.VeraCrypt` |
| **choco** | `choco install veracrypt` |
| **scoop** | `scoop install veracrypt` |

## 📁 Registry Paths

| Hive | Path | Purpose |
|------|------|---------|
| `HKCU` | `SOFTWARE\IDRIX\VeraCrypt` | Application settings and preferences |
| `HKLM` | `SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\VeraCrypt` | Uninstall entry (named key) |

## 🔑 Keys

| Path | Hive | Value Name | Type |
|------|------|------------|------|
| `SOFTWARE\IDRIX\VeraCrypt` | `HKCU` | *(verify key names and values against a live installation)* | REG_SZ |
| `SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\VeraCrypt` | `HKLM` | `DisplayName` | REG_SZ |
| `SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\VeraCrypt` | `HKLM` | `DisplayVersion` | REG_SZ |
| `SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\VeraCrypt` | `HKLM` | `InstallLocation` | REG_EXPAND_SZ |
| `SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\VeraCrypt` | `HKLM` | `UninstallString` | REG_SZ |

## 📝 Notes

- **Installer type:** `.exe`
- **Winget ID:** `IDRIX.VeraCrypt`
- This stub was auto-generated from the app backlog. Registry paths above are best-effort estimates.
- Please install VeraCrypt on a clean Windows environment, run `reg export` on the listed paths, and update this file with confirmed values.
- See [CONTRIBUTING.md](https://github.com/samibs/Registry-Keys-for-Open-Source-Applications-on-Windows/blob/main/CONTRIBUTING.md) for the contribution workflow.