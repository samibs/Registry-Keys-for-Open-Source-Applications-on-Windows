---
tags:
  - audio
  - music-player
  - media
  - library
description: >-
  Windows registry keys created by MusicBee — install paths, uninstall keys, HKCU and HKLM entries for sysadmin automation and cleanup.
---

# MusicBee

**Version documented:** 3.5.8698
**Installer type:** `.exe` (NSIS) / Portable
**Hives written:** HKCU, HKLM, HKCR

---

## 📁 Registry Paths

| Path | Hive | Purpose |
|------|------|---------|
| `SOFTWARE\Bee\MusicBee` | HKCU | User settings and last state |
| `SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\MusicBee` | HKLM | Uninstall entry |
| `HKCR\.mp3\OpenWithProgIds\MusicBee.mp3` | HKCR | .mp3 association |
| `HKCR\.flac\OpenWithProgIds\MusicBee.flac` | HKCR | .flac association |
| `HKCR\MusicBee.mp3` | HKCR | ProgID for .mp3 |

---

## 🔑 Keys

### HKCU\SOFTWARE\Bee\MusicBee

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `MusicBeeLibraryFolder` | REG_SZ | `C:\Users\User\Music\` | Library root folder |
| `LastVolume` | REG_DWORD | `75` | Last volume level (0-100) |
| `WindowState` | REG_DWORD | `1` | Window state (1=normal, 2=minimized, 3=maximized) |
| `Skin` | REG_SZ | `Dark` | UI skin name |

### HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\MusicBee

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `DisplayName` | REG_SZ | `MusicBee` | Display name |
| `DisplayVersion` | REG_SZ | `3.5.8698` | Version string |
| `Publisher` | REG_SZ | `Steven Mayall` | Publisher |
| `InstallLocation` | REG_SZ | `C:\Program Files (x86)\MusicBee` | Install path |
| `UninstallString` | REG_SZ | `"...\unins000.exe"` | Uninstaller |

### HKCR\MusicBee.mp3

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `(Default)` | REG_SZ | `MP3 Audio File` | Friendly type name |
| `shell\open\command` (Default) | REG_SZ | `"MusicBee.exe" "%1"` | Open command |

---

## 📝 Notes

- MusicBee registers file associations for: `.mp3`, `.flac`, `.ogg`, `.aac`, `.m4a`, `.wav`, `.wma`, `.opus`, `.ape`.
- Library and playback preferences are primarily stored in XML at `%APPDATA%\MusicBee\`.
- Portable version writes no registry keys.

```powershell
# Check configured library folder
(Get-ItemProperty "HKCU:\SOFTWARE\Bee\MusicBee" -ErrorAction SilentlyContinue).MusicBeeLibraryFolder
```

---

## 🗑️ Cleanup

```powershell
# Remove MusicBee user settings
Remove-Item -Path "HKCU:\SOFTWARE\Bee\MusicBee" -Recurse -ErrorAction SilentlyContinue
Remove-Item -Path "HKCU:\SOFTWARE\Bee" -Recurse -ErrorAction SilentlyContinue

# Remove audio file associations
foreach ($ext in @('.mp3','.flac','.ogg','.aac','.m4a','.wav','.wma','.opus','.ape')) {
    Remove-ItemProperty "HKCR:\$ext\OpenWithProgIds" -Name "MusicBee$ext" -ErrorAction SilentlyContinue
}
Remove-Item -Path "HKCR:\MusicBee.mp3" -Recurse -ErrorAction SilentlyContinue
```

---

## 📦 Package Managers

| Manager | ID / Command |
|---------|-------------|
| winget | `winget install StevenMayall.MusicBee` |
| Chocolatey | `choco install musicbee` |
| Scoop | `scoop install extras/musicbee` |
