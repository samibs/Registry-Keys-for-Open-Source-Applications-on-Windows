---
tags:
  - image-viewer
  - graphics
  - lightweight
  - photo
description: >-
  Windows registry keys created by IrfanView — install paths, uninstall keys, HKCU and HKLM entries for sysadmin automation and cleanup.
---

# IrfanView

**Version documented:** 4.66
**Installer type:** `.exe` (custom NSIS)
**Hives written:** HKCU, HKLM, HKCR

---

## 📁 Registry Paths

| Path | Hive | Purpose |
|------|------|---------|
| `SOFTWARE\IrfanView` | HKCU | User settings and preferences |
| `SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\IrfanView` | HKLM | Uninstall entry |
| `HKCR\.jpg\OpenWithProgIds\IrfanView.jpg` | HKCR | .jpg association |
| `HKCR\.png\OpenWithProgIds\IrfanView.png` | HKCR | .png association |
| `HKCR\.bmp\OpenWithProgIds\IrfanView.bmp` | HKCR | .bmp association |
| `HKCR\IrfanView.jpg` | HKCR | ProgID for JPEG |

---

## 🔑 Keys

### HKCU\SOFTWARE\IrfanView

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `Directory` | REG_SZ | `C:\Program Files\IrfanView` | Install directory |
| `Language` | REG_SZ | `English` | UI language |
| `CheckForUpdates` | REG_DWORD | `1` | Check for updates at start |
| `FitToDesktop` | REG_DWORD | `0` | Fit large images to window |
| `ShowScrollbars` | REG_DWORD | `1` | Show scrollbars |
| `SlideShowInterval` | REG_DWORD | `3` | Slideshow interval (seconds) |

### HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\IrfanView

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `DisplayName` | REG_SZ | `IrfanView 4.66 (64-bit)` | Display name |
| `DisplayVersion` | REG_SZ | `4.66` | Version |
| `Publisher` | REG_SZ | `Irfan Skiljan` | Publisher |
| `InstallLocation` | REG_SZ | `C:\Program Files\IrfanView` | Install path |
| `UninstallString` | REG_SZ | `"iv_uninstall.exe"` | Uninstaller |

### HKCR\IrfanView.jpg

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `(Default)` | REG_SZ | `JPEG Image` | Friendly type name |
| `shell\open\command` (Default) | REG_SZ | `"i_view64.exe" "%1"` | Open command |

---

## 📝 Notes

- IrfanView registers associations for a large number of formats: `.jpg`, `.jpeg`, `.png`, `.bmp`, `.gif`, `.tif`, `.tga`, `.ico`, `.webp`, `.heic`, and more (dependent on plugins installed).
- Plugins extend format support and are tracked separately in `HKCU\SOFTWARE\IrfanView\Plugins`.
- Settings are also stored in `i_view64.ini` in the install directory; registry and INI are kept in sync.

```powershell
# Check configured install directory
(Get-ItemProperty "HKCU:\SOFTWARE\IrfanView" -ErrorAction SilentlyContinue).Directory

# Export full settings for migration
reg export "HKCU\SOFTWARE\IrfanView" "$env:USERPROFILE\irfanview-settings.reg"
```

---

## 🗑️ Cleanup

```powershell
# Remove IrfanView user settings
Remove-Item -Path "HKCU:\SOFTWARE\IrfanView" -Recurse -ErrorAction SilentlyContinue

# Remove key image file associations
foreach ($ext in @('.jpg','.jpeg','.png','.bmp','.gif','.tif','.tga','.ico','.webp')) {
    Remove-ItemProperty "HKCR:\$ext\OpenWithProgIds" -Name "IrfanView$ext" -ErrorAction SilentlyContinue
}
Remove-Item -Path "HKCR:\IrfanView.jpg" -Recurse -ErrorAction SilentlyContinue
```

---

## 📦 Package Managers

| Manager | ID / Command |
|---------|-------------|
| winget | `winget install IrfanSkiljan.IrfanView` |
| Chocolatey | `choco install irfanview` |
| Scoop | `scoop install extras/irfanview` |
