---
tags:
  - audio
  - podcast
  - media-player
---

# Clementine

**Version:** 1.4.0  
**Installer:** `.exe` (setup)  
**Hives:** HKCU, HKLM, HKCR

Clementine is a modern music player and library organizer inspired by Amarok 1.4. It supports local libraries, internet radio, podcast subscriptions, and cloud storage (Dropbox, Google Drive, OneDrive).

---

## 📁 Registry Paths

| Path | Hive | Description |
|------|------|-------------|
| `SOFTWARE\Clementine Music Player` | HKCU | Per-user preferences |
| `SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Clementine Music Player` | HKLM | Uninstall entry |
| `.mp3\OpenWithProgids` | HKCR | Open-with association for MP3 files |

---

## 🔑 Keys

### HKCU\SOFTWARE\Clementine Music Player

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `language` | `REG_SZ` | `en` | UI language code |
| `mainwindow_size` | `REG_BINARY` | `(binary)` | Saved window geometry |
| `show_sidebar` | `REG_DWORD` | `1` | Show sidebar panel |

### HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Clementine Music Player

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `DisplayName` | `REG_SZ` | `Clementine 1.4.0` | Display name |
| `DisplayVersion` | `REG_SZ` | `1.4.0` | Installed version |
| `Publisher` | `REG_SZ` | `David Sansome` | Publisher |
| `InstallLocation` | `REG_SZ` | `C:\Program Files\Clementine\` | Install directory |
| `UninstallString` | `REG_SZ` | `"C:\Program Files\Clementine\uninstall.exe"` | Uninstall command |
| `URLInfoAbout` | `REG_SZ` | `https://www.clementine-player.org` | Product URL |

### HKCR\.mp3\OpenWithProgids

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `Clementine.mp3` | `REG_NONE` | `` | Registers Clementine as an Open With option for MP3 |

---

## 📝 Notes

- Clementine stores its music library in a SQLite database at `%LOCALAPPDATA%\Clementine Entertainment\Clementine\clementine.db`.
- Playlist and settings are stored in `%APPDATA%\Clementine Entertainment\Clementine\` using Qt's QSettings (INI format on Windows), not the registry.
- The `HKCU\SOFTWARE\Clementine Music Player` key holds only basic UI state.
- Clementine is no longer actively maintained; Strawberry is its active fork.

---

## 🗑️ Cleanup

```reg
Windows Registry Editor Version 5.00

[-HKEY_CURRENT_USER\SOFTWARE\Clementine Music Player]
[-HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Clementine Music Player]
```

---

## 📦 Package Managers

| Manager | Install Command |
|---------|----------------|
| winget | `winget install ClementinePlayer.Clementine` |
| Chocolatey | `choco install clementine` |
| Scoop | `scoop install clementine` |
