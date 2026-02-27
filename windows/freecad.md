---
tags:
  - cad
  - 3d-modeling
  - engineering
  - design
description: >-
  Windows registry keys created by FreeCAD — install paths, uninstall keys, HKCU and HKLM entries for sysadmin automation and cleanup.
---

# FreeCAD

**Version documented:** 0.21.2
**Installer type:** `.exe` (NSIS)
**Hives written:** HKCU, HKLM, HKCR

---

## 📁 Registry Paths

| Path | Hive | Purpose |
|------|------|---------|
| `SOFTWARE\FreeCAD` | HKCU | User preferences |
| `SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\FreeCAD 0.21.2` | HKLM | Uninstall entry |
| `HKCR\.FCStd` | HKCR | FreeCAD project file association |
| `HKCR\FreeCAD.FCStd` | HKCR | ProgID for .FCStd |

---

## 🔑 Keys

### HKCU\SOFTWARE\FreeCAD

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `InstallPath` | REG_SZ | `C:\Program Files\FreeCAD 0.21` | Installation path |
| `Version` | REG_SZ | `0.21.2` | Installed version |

### HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\FreeCAD 0.21.2

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `DisplayName` | REG_SZ | `FreeCAD 0.21.2` | Display name |
| `DisplayVersion` | REG_SZ | `0.21.2` | Version |
| `Publisher` | REG_SZ | `FreeCAD Team` | Publisher |
| `InstallLocation` | REG_SZ | `C:\Program Files\FreeCAD 0.21` | Install path |
| `UninstallString` | REG_SZ | `"...\uninstall.exe"` | Uninstaller |

### HKCR\.FCStd

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `(Default)` | REG_SZ | `FreeCAD.FCStd` | ProgID reference |

### HKCR\FreeCAD.FCStd

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `(Default)` | REG_SZ | `FreeCAD Document` | Friendly type name |
| `shell\open\command` (Default) | REG_SZ | `"FreeCAD.exe" "%1"` | Open command |

---

## 📝 Notes

- FreeCAD stores all workbench preferences in `%APPDATA%\FreeCAD\` as `.cfg` files — the registry contains only install metadata and file associations.
- Multiple versions can be installed side-by-side; each creates its own uninstall key with the version in the key name.
- `.FCStd` files are ZIP archives containing XML geometry data.

```powershell
# Check installed FreeCAD version and path
Get-ChildItem "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall" |
  Where-Object { (Get-ItemProperty $_.PSPath).DisplayName -like "FreeCAD*" } |
  ForEach-Object { Get-ItemProperty $_.PSPath } |
  Select-Object DisplayName, InstallLocation
```

---

## 🗑️ Cleanup

```powershell
# Remove FreeCAD user registry entries
Remove-Item -Path "HKCU:\SOFTWARE\FreeCAD" -Recurse -ErrorAction SilentlyContinue

# Remove .FCStd file association
Remove-Item -Path "HKCR:\FreeCAD.FCStd" -Recurse -ErrorAction SilentlyContinue
Remove-ItemProperty -Path "HKCR:\.FCStd" -Name "(Default)" -ErrorAction SilentlyContinue
```

---

## 📦 Package Managers

| Manager | ID / Command |
|---------|-------------|
| winget | `winget install FreeCAD.FreeCAD` |
| Chocolatey | `choco install freecad` |
| Scoop | `scoop install extras/freecad` |
