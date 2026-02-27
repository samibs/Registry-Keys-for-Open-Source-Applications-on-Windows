---
tags:
  - media-player
  - video
  - audio
  - lightweight
description: >-
  Windows registry keys created by MPC-HC (Media Player Classic – Home Cinema) — install paths, uninstall keys, HKCU and HKLM entries for sysadmin automation and cleanup.
---

# MPC-HC (Media Player Classic – Home Cinema)

**Version documented:** 2.3.0
**Installer type:** `.exe` (NSIS) / Portable
**Hives written:** HKCU, HKLM, HKCR

---

## 📁 Registry Paths

| Path | Hive | Purpose |
|------|------|---------|
| `SOFTWARE\MPC-HC\MPC-HC` | HKCU | User settings and playback preferences |
| `SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\MPC-HC` | HKLM | Uninstall entry |
| `HKCR\.mkv\OpenWithProgIds\MPC-HC.mkv` | HKCR | .mkv association |
| `HKCR\.mp4\OpenWithProgIds\MPC-HC.mp4` | HKCR | .mp4 association |
| `HKCR\.avi\OpenWithProgIds\MPC-HC.avi` | HKCR | .avi association |
| `HKCR\MPC-HC.mkv` | HKCR | ProgID for MKV files |

---

## 🔑 Keys

### HKCU\SOFTWARE\MPC-HC\MPC-HC

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `ExePath` | REG_SZ | `C:\Program Files\MPC-HC\mpc-hc64.exe` | Executable path |
| `Volume` | REG_DWORD | `100` | Last volume level (0-100) |
| `Balance` | REG_DWORD | `0` | Audio balance (-100 to 100) |
| `SubtitleDelay` | REG_DWORD | `0` | Subtitle delay (ms) |
| `AudioDelay` | REG_DWORD | `0` | Audio delay (ms) |
| `FullScreen` | REG_DWORD | `0` | Start in fullscreen (1=yes) |
| `RememberLastPos` | REG_DWORD | `1` | Resume from last position |
| `LastOpenDir` | REG_SZ | `C:\Videos` | Last folder opened |
| `TrayIcon` | REG_DWORD | `0` | Show tray icon |
| `HideCaptionMenu` | REG_DWORD | `0` | Hide menu bar (fullscreen style) |

### HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\MPC-HC

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `DisplayName` | REG_SZ | `Media Player Classic - Home Cinema 2.3.0` | Display name |
| `DisplayVersion` | REG_SZ | `2.3.0` | Version |
| `Publisher` | REG_SZ | `MPC-HC Team` | Publisher |
| `InstallLocation` | REG_SZ | `C:\Program Files\MPC-HC` | Install path |
| `UninstallString` | REG_SZ | `"...\Uninstall.exe"` | Uninstaller |

### HKCR\MPC-HC.mkv

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `(Default)` | REG_SZ | `MKV Video File` | Friendly type name |
| `shell\open\command` (Default) | REG_SZ | `"mpc-hc64.exe" "%1"` | Open command |

---

## 📝 Notes

- MPC-HC registers associations for a wide range of video/audio formats: `.mkv`, `.mp4`, `.avi`, `.mov`, `.wmv`, `.flv`, `.ts`, `.m2ts`, `.mp3`, `.flac`, `.ogg`, and more.
- The portable version writes no registry keys — settings go to `mpc-hc.ini` alongside the `.exe`.
- `RememberLastPos = 1` stores per-file playback positions in a separate registry subkey `Recent File List`.

```powershell
# Export all MPC-HC settings for migration
reg export "HKCU\SOFTWARE\MPC-HC\MPC-HC" "$env:USERPROFILE\mpchc-settings.reg"

# Clear recently played file list
Remove-Item -Path "HKCU:\SOFTWARE\MPC-HC\MPC-HC\Recent File List" -Recurse -ErrorAction SilentlyContinue
```

---

## 🗑️ Cleanup

```powershell
# Remove MPC-HC user settings
Remove-Item -Path "HKCU:\SOFTWARE\MPC-HC" -Recurse -ErrorAction SilentlyContinue

# Remove video file associations
foreach ($ext in @('.mkv','.mp4','.avi','.mov','.wmv','.flv','.ts','.m2ts')) {
    Remove-ItemProperty "HKCR:\$ext\OpenWithProgIds" -Name "MPC-HC$ext" -ErrorAction SilentlyContinue
}
Remove-Item -Path "HKCR:\MPC-HC.mkv" -Recurse -ErrorAction SilentlyContinue
```

---

## 📦 Package Managers

| Manager | ID / Command |
|---------|-------------|
| winget | `winget install clsid2.mpc-hc` |
| Chocolatey | `choco install mpc-hc` |
| Scoop | `scoop install extras/mpc-hc` |
