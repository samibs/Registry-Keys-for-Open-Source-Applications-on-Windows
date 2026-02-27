---
stub: true
description: >-
  Windows registry keys created by Blender — install paths, uninstall keys,
  HKCU and HKLM entries for sysadmin automation and cleanup.
tags:
  - 3d-graphics
  - HKCU
  - HKLM
  - msi-installer
---

<!-- Community stub: paths below are best-effort estimates. Verify against a live installation before removing stub: true. -->

# Blender

**Version tested:** *community contribution needed — install and verify*
**Installer type:** `.msi`

## 📦 Package Managers

| Manager | Command |
|---------|---------|
| **winget** | `winget install BlenderFoundation.Blender` |
| **choco** | `choco install blender` |
| **scoop** | `scoop install blender` |

## 📁 Registry Paths

| Hive | Path | Purpose |
|------|------|---------|
| `HKCU` | `SOFTWARE\BlenderFoundation\Blender` | Application settings and preferences |
| `HKLM` | `SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Blender` | Uninstall entry (named key) |
| `HKLM` | `SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{GUID}` | Uninstall entry (MSI GUID — verify on live install) |

## 🔑 Keys

| Path | Hive | Value Name | Type |
|------|------|------------|------|
| `SOFTWARE\BlenderFoundation\Blender` | `HKCU` | *(verify key names and values against a live installation)* | REG_SZ |
| `SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Blender` | `HKLM` | `DisplayName` | REG_SZ |
| `SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Blender` | `HKLM` | `DisplayVersion` | REG_SZ |
| `SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Blender` | `HKLM` | `InstallLocation` | REG_EXPAND_SZ |
| `SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Blender` | `HKLM` | `UninstallString` | REG_SZ |

## 📝 Notes

- **Installer type:** `.msi`
- **Winget ID:** `BlenderFoundation.Blender`
- This stub was auto-generated from the app backlog. Registry paths above are best-effort estimates.
- Please install Blender on a clean Windows environment, run `reg export` on the listed paths, and update this file with confirmed values.
- See [CONTRIBUTING.md](https://github.com/samibs/Registry-Keys-for-Open-Source-Applications-on-Windows/blob/main/CONTRIBUTING.md) for the contribution workflow.