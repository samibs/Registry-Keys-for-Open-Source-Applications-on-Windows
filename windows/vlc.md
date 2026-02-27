---
tags:
  - media-player
  - HKCU
  - HKLM
  - HKCR
  - exe-installer
---

# VLC Media Player

**Version tested:** 3.0.20  
**Installer type:** Official `.exe` from VideoLAN website


## 📦 Package Managers

| Manager    | Install Command |
|------------|-----------------|
| winget     | `winget install VideoLAN.VLC` |
| Chocolatey | `choco install vlc` |
| Scoop      | `scoop install vlc` |

## 📁 Registry Paths

- `HKEY_CURRENT_USER\Software\VideoLAN\VLC`
- `HKEY_LOCAL_MACHINE\SOFTWARE\VideoLAN\VLC`
- `HKEY_CLASSES_ROOT\VLC.*` *(ProgID entries per media format)*
- `HKEY_CLASSES_ROOT\.mp4`, `.mkv`, `.avi`, `.mp3` *(file extension → ProgID pointers, when VLC is set as default)*

## 🔑 Keys

| Key Name              | Type         | Description                                   |
|-----------------------|--------------|-----------------------------------------------|
| `InstallDir`          | `REG_SZ`     | VLC installation path                         |
| `MRL`                 | `REG_SZ`     | Last opened media file                        |
| `Subtitles Encoding`  | `REG_SZ`     | Default subtitle encoding                     |
| `WinPosX`             | `REG_DWORD`  | Last known X position of VLC window           |
| `WinPosY`             | `REG_DWORD`  | Last known Y position of VLC window           |

### File association ProgIDs (`HKCR\VLC.<ext>`)

VLC registers a ProgID for each format it handles (when set as default). The pattern is consistent across all formats:

| Key Path                              | Type     | Description                                          |
|---------------------------------------|----------|------------------------------------------------------|
| `HKCR\VLC.<ext>\(Default)`           | `REG_SZ` | Human-readable name, e.g. `VLC media file (.mp4)`    |
| `HKCR\VLC.<ext>\shell\Open\command`  | `REG_SZ` | `"C:\Program Files\VideoLAN\VLC\vlc.exe" --started-from-file "%1"` |

Common registered extensions: `.mp4`, `.mkv`, `.avi`, `.mov`, `.wmv`, `.flv`, `.mp3`, `.aac`, `.flac`, `.ogg`, `.wav`, `.m3u`, `.m3u8`.

## 📝 Notes

- Settings are user-specific (`HKCU`), but install location is stored in `HKLM`.
- The Store version uses a different containerized registry structure.

## 🗑️ Cleanup

```powershell
Remove-Item -Path "HKCU:\Software\VideoLAN"                        -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path "HKLM:\SOFTWARE\VideoLAN\VLC"                    -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path "HKLM:\SOFTWARE\WOW6432Node\VideoLAN\VLC"        -Recurse -Force -ErrorAction SilentlyContinue
```
