---
stub: true
description: >-
  Windows registry keys created by DB Browser for SQLite — install paths, uninstall keys,
  HKCU and HKLM entries for sysadmin automation and cleanup.
tags:
  - database
  - sqlite
  - HKCU
  - HKLM
  - msi-installer
---

<!-- Community stub: paths below are best-effort estimates. Verify against a live installation before removing stub: true. -->

# DB Browser for SQLite

**Version tested:** *community contribution needed — install and verify*
**Installer type:** `.msi`

## 📦 Package Managers

| Manager | Command |
|---------|---------|
| **winget** | `winget install DBBrowserForSQLite.DBBrowserForSQLite` |
| **choco** | `choco install db-browser-for-sqlite` |
| **scoop** | `scoop install db-browser-for-sqlite` |

## 📁 Registry Paths

| Hive | Path | Purpose |
|------|------|---------|
| `HKCU` | `SOFTWARE\DBBrowserForSQLite\DBBrowserForSQLite` | Application settings and preferences |
| `HKLM` | `SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\DB Browser for SQLite` | Uninstall entry (named key) |
| `HKLM` | `SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{GUID}` | Uninstall entry (MSI GUID — verify on live install) |

## 🔑 Keys

| Path | Hive | Value Name | Type |
|------|------|------------|------|
| `SOFTWARE\DBBrowserForSQLite\DBBrowserForSQLite` | `HKCU` | *(verify key names and values against a live installation)* | REG_SZ |
| `SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\DB Browser for SQLite` | `HKLM` | `DisplayName` | REG_SZ |
| `SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\DB Browser for SQLite` | `HKLM` | `DisplayVersion` | REG_SZ |
| `SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\DB Browser for SQLite` | `HKLM` | `InstallLocation` | REG_EXPAND_SZ |
| `SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\DB Browser for SQLite` | `HKLM` | `UninstallString` | REG_SZ |

## 📝 Notes

- **Installer type:** `.msi`
- **Winget ID:** `DBBrowserForSQLite.DBBrowserForSQLite`
- This stub was auto-generated from the app backlog. Registry paths above are best-effort estimates.
- Please install DB Browser for SQLite on a clean Windows environment, run `reg export` on the listed paths, and update this file with confirmed values.
- See [CONTRIBUTING.md](https://github.com/samibs/Registry-Keys-for-Open-Source-Applications-on-Windows/blob/main/CONTRIBUTING.md) for the contribution workflow.