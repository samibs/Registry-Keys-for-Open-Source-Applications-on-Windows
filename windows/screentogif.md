---
tags:
  - screen-capture
  - gif
  - recording
  - productivity
---

# ScreenToGif

**Version documented:** 2.41
**Installer type:** `.exe` (NSIS) / Portable
**Hives written:** HKCU, HKLM

---

## 📁 Registry Paths

| Path | Hive | Purpose |
|------|------|---------|
| `SOFTWARE\ScreenToGif` | HKCU | User preferences and settings |
| `SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\ScreenToGif_is1` | HKLM | Uninstall entry |

---

## 🔑 Keys

### HKCU\SOFTWARE\ScreenToGif

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `Language` | REG_SZ | `en` | UI language |
| `RecorderLeft` | REG_DWORD | `100` | Recorder window left position |
| `RecorderTop` | REG_DWORD | `100` | Recorder window top position |
| `RecorderWidth` | REG_DWORD | `600` | Capture area width |
| `RecorderHeight` | REG_DWORD` | `400` | Capture area height |
| `DefaultSaveFolder` | REG_SZ | `C:\Users\User\Videos` | Default output folder |
| `DefaultOutputType` | REG_SZ | `Gif` | Default export format |
| `FrameRate` | REG_DWORD | `15` | Default capture frame rate |
| `CheckForUpdates` | REG_DWORD | `1` | Check for updates on startup |
| `StartMinimized` | REG_DWORD | `0` | Start minimized to tray |

### HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\ScreenToGif_is1

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `DisplayName` | REG_SZ | `ScreenToGif 2.41` | Display name |
| `DisplayVersion` | REG_SZ | `2.41` | Version |
| `Publisher` | REG_SZ | `Nicke Manarin` | Publisher |
| `InstallLocation` | REG_SZ | `C:\Program Files\ScreenToGif` | Install path |
| `UninstallString` | REG_SZ | `"...\unins000.exe"` | Uninstaller |

---

## 📝 Notes

- The portable version stores settings in `ScreenToGif.settings` XML alongside the `.exe` — no registry writes.
- Default export format can be set to `Gif`, `Apng`, `Video`, `Webp`, or `Psd`.
- ScreenToGif also supports webcam and whiteboard recording modes.

```powershell
# Set default save folder and frame rate for deployment
$path = "HKCU:\SOFTWARE\ScreenToGif"
if (-not (Test-Path $path)) { New-Item -Path $path -Force | Out-Null }
Set-ItemProperty -Path $path -Name "DefaultSaveFolder" -Value "C:\Recordings"
Set-ItemProperty -Path $path -Name "FrameRate" -Value 20 -Type DWord
```

---

## 🗑️ Cleanup

```powershell
# Remove ScreenToGif user preferences
Remove-Item -Path "HKCU:\SOFTWARE\ScreenToGif" -Recurse -ErrorAction SilentlyContinue
```

---

## 📦 Package Managers

| Manager | ID / Command |
|---------|-------------|
| winget | `winget install NickeManarin.ScreenToGif` |
| Chocolatey | `choco install screentogif` |
| Scoop | `scoop install extras/screentogif` |
