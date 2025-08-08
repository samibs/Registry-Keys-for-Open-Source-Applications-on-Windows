# VLC Media Player

**Version tested:** 3.0.20  
**Installer type:** Official `.exe` from VideoLAN website

## 📁 Registry Paths

- `HKEY_CURRENT_USER\Software\VideoLAN\VLC`
- `HKEY_LOCAL_MACHINE\SOFTWARE\VideoLAN\VLC`

## 🔑 Keys

| Key Name              | Type         | Description                                   |
|-----------------------|--------------|-----------------------------------------------|
| `InstallDir`          | `REG_SZ`     | VLC installation path                         |
| `MRL`                 | `REG_SZ`     | Last opened media file                        |
| `Subtitles Encoding`  | `REG_SZ`     | Default subtitle encoding                     |
| `WinPosX`             | `REG_DWORD`  | Last known X position of VLC window           |
| `WinPosY`             | `REG_DWORD`  | Last known Y position of VLC window           |

## 📝 Notes

- Settings are user-specific (`HKCU`), but install location is stored in `HKLM`.
- The Store version uses a different containerized registry structure.
