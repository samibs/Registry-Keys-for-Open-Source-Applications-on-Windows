---
tags:
  - archive
  - compression
  - zip
  - file-manager
description: >-
  Windows registry keys created by PeaZip — install paths, uninstall keys, HKCU and HKLM entries for sysadmin automation and cleanup.
---

# PeaZip

**Version documented:** 9.7.0
**Installer type:** `.exe` (NSIS) / Portable
**Hives written:** HKCU, HKLM, HKCR

---

## 📁 Registry Paths

| Path | Hive | Purpose |
|------|------|---------|
| `SOFTWARE\PeaZip` | HKLM | Installation metadata |
| `SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\PeaZip` | HKLM | Uninstall entry |
| `HKCR\.zip\OpenWithProgIds\PeaZip` | HKCR | .zip association |
| `HKCR\.7z\OpenWithProgIds\PeaZip` | HKCR | .7z association |
| `HKCR\.tar\OpenWithProgIds\PeaZip` | HKCR | .tar association |
| `HKCR\PeaZip` | HKCR | ProgID definition |
| `HKCR\*\shell\PeaZip` | HKCR | Explorer context menu |

---

## 🔑 Keys

### HKLM\SOFTWARE\PeaZip

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `InstallDir` | REG_SZ | `C:\Program Files\PeaZip` | Installation directory |
| `Version` | REG_SZ | `9.7.0` | Installed version |

### HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\PeaZip

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `DisplayName` | REG_SZ | `PeaZip 9.7.0` | Display name |
| `DisplayVersion` | REG_SZ | `9.7.0` | Version |
| `Publisher` | REG_SZ | `Giorgio Tani` | Publisher |
| `InstallLocation` | REG_SZ | `C:\Program Files\PeaZip` | Install path |
| `UninstallString` | REG_SZ | `"...\unins000.exe"` | Uninstaller |

### HKCR\PeaZip

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `(Default)` | REG_SZ | `PeaZip Archive` | Friendly type name |
| `shell\open\command` (Default) | REG_SZ | `"peazip.exe" "%1"` | Open command |

### HKCR\*\shell\PeaZip

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `(Default)` | REG_SZ | `Open with PeaZip` | Context menu label |
| `command` (Default) | REG_SZ | `"peazip.exe" "%1"` | Shell command |

---

## 📝 Notes

- PeaZip supports 200+ archive formats. File associations are registered selectively based on what's configured during install.
- The context menu entries (`HKCR\*\shell\PeaZip`, `HKCR\Directory\shell\PeaZip`) provide Extract Here and Add to Archive options.
- Portable version writes no registry keys; settings go to `res\conf\peazip.cfg`.

```powershell
# Remove PeaZip Explorer context menu without uninstalling
Remove-Item -Path "HKCR:\*\shell\PeaZip" -Recurse -ErrorAction SilentlyContinue
Remove-Item -Path "HKCR:\Directory\shell\PeaZip" -Recurse -ErrorAction SilentlyContinue
```

---

## 🗑️ Cleanup

```powershell
# Remove PeaZip installation and file associations
Remove-Item -Path "HKLM:\SOFTWARE\PeaZip" -Recurse -ErrorAction SilentlyContinue
Remove-Item -Path "HKCR:\PeaZip" -Recurse -ErrorAction SilentlyContinue
Remove-Item -Path "HKCR:\*\shell\PeaZip" -Recurse -ErrorAction SilentlyContinue
Remove-Item -Path "HKCR:\Directory\shell\PeaZip" -Recurse -ErrorAction SilentlyContinue
foreach ($ext in @('.zip','.7z','.tar','.gz','.bz2','.rar')) {
    Remove-ItemProperty "HKCR:\$ext\OpenWithProgIds" -Name "PeaZip" -ErrorAction SilentlyContinue
}
```

---

## 📦 Package Managers

| Manager | ID / Command |
|---------|-------------|
| winget | `winget install Giorgiotani.Peazip` |
| Chocolatey | `choco install peazip` |
| Scoop | `scoop install extras/peazip` |
