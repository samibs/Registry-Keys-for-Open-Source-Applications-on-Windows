---
tags:
  - image-viewer
  - graphics
  - photo
  - batch
---

# XnView MP

**Version documented:** 1.7.2
**Installer type:** `.exe` (NSIS) / Portable
**Hives written:** HKCU, HKLM, HKCR

---

## 📁 Registry Paths

| Path | Hive | Purpose |
|------|------|---------|
| `SOFTWARE\XnviewMP` | HKCU | User preferences |
| `SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\XnViewMP_is1` | HKLM | Uninstall entry |
| `HKCR\.jpg\OpenWithProgIds\XnViewMP` | HKCR | .jpg association |
| `HKCR\.png\OpenWithProgIds\XnViewMP` | HKCR | .png association |
| `HKCR\.gif\OpenWithProgIds\XnViewMP` | HKCR | .gif association |
| `HKCR\XnViewMP` | HKCR | ProgID definition |

---

## 🔑 Keys

### HKCU\SOFTWARE\XnviewMP

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `Language` | REG_SZ | `en` | UI language |
| `LastDir` | REG_SZ | `C:\Users\User\Pictures` | Last browsed directory |
| `SkinName` | REG_SZ | `Dark` | UI skin |
| `CheckForUpdates` | REG_DWORD | `1` | Update check at startup |
| `SlideShowDelay` | REG_DWORD | `3000` | Slideshow delay (ms) |

### HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\XnViewMP_is1

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `DisplayName` | REG_SZ | `XnViewMP 1.7.2` | Display name |
| `DisplayVersion` | REG_SZ | `1.7.2` | Version |
| `Publisher` | REG_SZ | `Gougelet Pierre-Emmanuel` | Publisher |
| `InstallLocation` | REG_SZ | `C:\Program Files\XnViewMP` | Install path |
| `UninstallString` | REG_SZ | `"...\unins000.exe"` | Uninstaller |

### HKCR\XnViewMP

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `(Default)` | REG_SZ | `XnView Image File` | Friendly type name |
| `shell\open\command` (Default) | REG_SZ | `"XnViewMP.exe" "%1"` | Open command |

---

## 📝 Notes

- XnView MP supports 500+ image formats. File associations are registered for common formats (.jpg, .png, .gif, .bmp, .tif, .webp, .heic, .raw, .psd) during install.
- The portable version writes no registry keys — preferences are stored in `xnview.ini` alongside the binary.
- XnView MP also registers an Explorer shell extension for thumbnail previews.

```powershell
# Export XnView MP settings for migration
reg export "HKCU\SOFTWARE\XnviewMP" "$env:USERPROFILE\xnviewmp-settings.reg"

# Check last browsed directory
(Get-ItemProperty "HKCU:\SOFTWARE\XnviewMP" -ErrorAction SilentlyContinue).LastDir
```

---

## 🗑️ Cleanup

```powershell
# Remove XnView MP user settings
Remove-Item -Path "HKCU:\SOFTWARE\XnviewMP" -Recurse -ErrorAction SilentlyContinue

# Remove file associations
foreach ($ext in @('.jpg','.jpeg','.png','.gif','.bmp','.tif','.webp')) {
    Remove-ItemProperty "HKCR:\$ext\OpenWithProgIds" -Name "XnViewMP" -ErrorAction SilentlyContinue
}
Remove-Item -Path "HKCR:\XnViewMP" -Recurse -ErrorAction SilentlyContinue
```

---

## 📦 Package Managers

| Manager | ID / Command |
|---------|-------------|
| winget | `winget install XnSoft.XnViewMP` |
| Chocolatey | `choco install xnviewmp` |
| Scoop | `scoop install extras/xnviewmp` |
