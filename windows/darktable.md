---
stub: true
description: >-
  Windows registry keys created by Darktable — install paths, uninstall keys,
  HKCU and HKLM entries for sysadmin automation and cleanup.
tags:
  - photo-editing
  - raw-processing
  - HKCU
  - HKLM
  - exe-installer
---

<!-- Community stub: paths below are best-effort estimates. Verify against a live installation before removing stub: true. -->

# Darktable

**Version tested:** *community contribution needed — install and verify*
**Installer type:** `.exe`

## 📦 Package Managers

| Manager | Command |
|---------|---------|
| **winget** | `winget install darktable.darktable` |
| **choco** | `choco install darktable` |
| **scoop** | `scoop install darktable` |

## 📁 Registry Paths

| Hive | Path | Purpose |
|------|------|---------|
| `HKCU` | `SOFTWARE\darktable\darktable` | Application settings and preferences |
| `HKLM` | `SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Darktable` | Uninstall entry (named key) |

## 🔑 Keys

| Path | Hive | Value Name | Type |
|------|------|------------|------|
| `SOFTWARE\darktable\darktable` | `HKCU` | *(verify key names and values against a live installation)* | REG_SZ |
| `SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Darktable` | `HKLM` | `DisplayName` | REG_SZ |
| `SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Darktable` | `HKLM` | `DisplayVersion` | REG_SZ |
| `SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Darktable` | `HKLM` | `InstallLocation` | REG_EXPAND_SZ |
| `SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Darktable` | `HKLM` | `UninstallString` | REG_SZ |

## 📝 Notes

- **Installer type:** `.exe`
- **Winget ID:** `darktable.darktable`
- This stub was auto-generated from the app backlog. Registry paths above are best-effort estimates.
- Please install Darktable on a clean Windows environment, run `reg export` on the listed paths, and update this file with confirmed values.
- See [CONTRIBUTING.md](https://github.com/samibs/Registry-Keys-for-Open-Source-Applications-on-Windows/blob/main/CONTRIBUTING.md) for the contribution workflow.