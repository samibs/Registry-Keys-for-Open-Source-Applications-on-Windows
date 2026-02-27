---
tags:
  - media
  - analysis
  - diagnostics
  - video
  - audio
description: >-
  Windows registry keys created by MediaInfo — install paths, uninstall keys, HKCU and HKLM entries for sysadmin automation and cleanup.
---

# MediaInfo

**Version documented:** 24.01
**Installer type:** `.exe` (NSIS)
**Hives written:** HKLM, HKCR

---

## 📁 Registry Paths

| Path | Hive | Purpose |
|------|------|---------|
| `SOFTWARE\MediaInfo` | HKLM | Installation path |
| `SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\MediaInfo` | HKLM | Uninstall entry |
| `HKCR\*\shell\MediaInfo` | HKCR | "MediaInfo" Explorer context menu |

---

## 🔑 Keys

### HKLM\SOFTWARE\MediaInfo

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `Path` | REG_SZ | `C:\Program Files\MediaInfo` | Installation directory |

### HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\MediaInfo

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `DisplayName` | REG_SZ | `MediaInfo 24.01` | Display name |
| `DisplayVersion` | REG_SZ | `24.01` | Version |
| `Publisher` | REG_SZ | `MediaArea.net` | Publisher |
| `InstallLocation` | REG_SZ | `C:\Program Files\MediaInfo` | Install path |
| `UninstallString` | REG_SZ | `"...\uninstall.exe"` | Uninstaller |

### HKCR\*\shell\MediaInfo

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `(Default)` | REG_SZ | `MediaInfo` | Context menu label |
| `command` (Default) | REG_SZ | `"MediaInfo.exe" "%1"` | Shell command |

---

## 📝 Notes

- MediaInfo adds a right-click context menu entry for all files (`HKCR\*\shell\MediaInfo`) to inspect media properties.
- No HKCU preferences are stored in the registry — settings are in `%APPDATA%\MediaInfo\MediaInfo.cfg`.
- The portable version (`MediaInfo_CLI`) writes no registry keys.
- On 64-bit Windows, the 32-bit build writes to `HKLM\SOFTWARE\WOW6432Node\MediaInfo`.

```powershell
# Remove the Explorer context menu (without uninstalling)
Remove-Item -Path "HKCR:\*\shell\MediaInfo" -Recurse -ErrorAction SilentlyContinue

# Re-add context menu manually
$cmd = '"C:\Program Files\MediaInfo\MediaInfo.exe" "%1"'
New-Item -Path "HKCR:\*\shell\MediaInfo\command" -Force | Out-Null
Set-ItemProperty -Path "HKCR:\*\shell\MediaInfo" -Name "(Default)" -Value "MediaInfo"
Set-ItemProperty -Path "HKCR:\*\shell\MediaInfo\command" -Name "(Default)" -Value $cmd
```

---

## 🗑️ Cleanup

```powershell
# Remove MediaInfo installation key and context menu
Remove-Item -Path "HKLM:\SOFTWARE\MediaInfo" -Recurse -ErrorAction SilentlyContinue
Remove-Item -Path "HKLM:\SOFTWARE\WOW6432Node\MediaInfo" -Recurse -ErrorAction SilentlyContinue
Remove-Item -Path "HKCR:\*\shell\MediaInfo" -Recurse -ErrorAction SilentlyContinue
```

---

## 📦 Package Managers

| Manager | ID / Command |
|---------|-------------|
| winget | `winget install MediaArea.MediaInfo` |
| Chocolatey | `choco install mediainfo` |
| Scoop | `scoop install extras/mediainfo` |
