---
stub: true
description: >-
  Windows registry keys created by Joplin — install paths, uninstall keys,
  HKCU and HKLM entries for sysadmin automation and cleanup.
tags:
  - note-taking
  - HKCU
  - HKLM
  - exe-installer
---

<!-- Community stub: paths below are best-effort estimates. Verify against a live installation before removing stub: true. -->

# Joplin

**Version tested:** *community contribution needed — install and verify*
**Installer type:** `.exe`

## 📦 Package Managers

| Manager | Command |
|---------|---------|
| **winget** | `winget install Joplin.Joplin` |
| **choco** | `choco install joplin` |
| **scoop** | `scoop install joplin` |

## 📁 Registry Paths

| Hive | Path | Purpose |
|------|------|---------|
| `HKCU` | `SOFTWARE\Joplin\Joplin` | Application settings and preferences |
| `HKLM` | `SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Joplin` | Uninstall entry (named key) |

## 🔑 Keys

| Path | Hive | Value Name | Type |
|------|------|------------|------|
| `SOFTWARE\Joplin\Joplin` | `HKCU` | *(verify key names and values against a live installation)* | REG_SZ |
| `SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Joplin` | `HKLM` | `DisplayName` | REG_SZ |
| `SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Joplin` | `HKLM` | `DisplayVersion` | REG_SZ |
| `SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Joplin` | `HKLM` | `InstallLocation` | REG_EXPAND_SZ |
| `SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Joplin` | `HKLM` | `UninstallString` | REG_SZ |

## 📝 Notes

- **Installer type:** `.exe`
- **Winget ID:** `Joplin.Joplin`
- This stub was auto-generated from the app backlog. Registry paths above are best-effort estimates.
- Please install Joplin on a clean Windows environment, run `reg export` on the listed paths, and update this file with confirmed values.
- See [CONTRIBUTING.md](https://github.com/samibs/Registry-Keys-for-Open-Source-Applications-on-Windows/blob/main/CONTRIBUTING.md) for the contribution workflow.