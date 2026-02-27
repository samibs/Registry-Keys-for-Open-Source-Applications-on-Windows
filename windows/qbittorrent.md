---
tags:
  - torrent
  - HKCU
  - HKLM
  - HKCR
  - exe-installer
  - network
description: >-
  Windows registry keys created by qBittorrent — install paths, uninstall keys, HKCU and HKLM entries for sysadmin automation and cleanup.
---

# qBittorrent

**Version tested:** 4.6.3
**Installer type:** `.exe` official installer from qbittorrent.org


## 📦 Package Managers

| Manager    | Install Command |
|------------|-----------------|
| winget     | `winget install qBittorrent.qBittorrent` |
| Chocolatey | `choco install qbittorrent` |
| Scoop      | `scoop install qbittorrent` |

## 📁 Registry Paths

- `HKEY_CURRENT_USER\Software\qBittorrent`
- `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\qBittorrent`
- `HKEY_CLASSES_ROOT\.torrent` *(if set as default .torrent handler)*
- `HKEY_CLASSES_ROOT\magnet` *(optional magnet URI handler)*

## 🔑 Keys

### User settings (`HKCU\Software\qBittorrent`) — created at first launch

| Key Name                  | Type        | Description                                               |
|---------------------------|-------------|-----------------------------------------------------------|
| `ported_to_new_savepath_system` | `REG_DWORD` | Internal migration flag for download path storage  |

> Most settings are written to `%APPDATA%\qBittorrent\qBittorrent.ini` (an INI file), not the registry. The key above is one of the few values qBittorrent stores in the registry.

### Uninstall entry (`HKLM\...\Uninstall\qBittorrent`)

| Key Name           | Type        | Description                                         |
|--------------------|-------------|-----------------------------------------------------|
| `DisplayName`      | `REG_SZ`    | `qBittorrent 4.6.3`                                |
| `DisplayVersion`   | `REG_SZ`    | Installed version (e.g., `4.6.3`)                  |
| `DisplayIcon`      | `REG_SZ`    | Path to `qbittorrent.exe`                          |
| `InstallLocation`  | `REG_SZ`    | Root installation directory (e.g., `C:\Program Files\qBittorrent`) |
| `Publisher`        | `REG_SZ`    | `The qBittorrent project`                          |
| `UninstallString`  | `REG_SZ`    | Path to the NSIS uninstaller                        |
| `URLInfoAbout`     | `REG_SZ`    | `https://www.qbittorrent.org`                      |
| `NoModify`         | `REG_DWORD` | `1` — no modify option in ARP                      |

## 📝 Notes

- All meaningful configuration (download paths, speed limits, RSS feeds, WebUI settings) is stored in `%APPDATA%\qBittorrent\qBittorrent.ini`, not the registry.
- Torrent metadata and the download queue are stored in `%LOCALAPPDATA%\qBittorrent\BT_backup\`.
- The **portable version** stores its INI alongside the executable and creates no registry entries.
- `magnet:` URI handler registration is optional during install; if enabled, it creates `HKCU\Software\Classes\magnet` (or `HKLM\SOFTWARE\Classes\magnet` for system-wide).

## 🌐 HKCR — File & Protocol Handlers

### Torrent file handler (`HKCR\.torrent`)

| Key Path                               | Type     | Description                                           |
|----------------------------------------|----------|-------------------------------------------------------|
| `(Default)`                            | `REG_SZ` | ProgID pointer, e.g. `qBittorrent`                    |
| `Content Type`                         | `REG_SZ` | `application/x-bittorrent`                            |

### Magnet URI handler (`HKCR\magnet`) — optional

| Key Path                               | Type     | Description                                           |
|----------------------------------------|----------|-------------------------------------------------------|
| `(Default)`                            | `REG_SZ` | `URL:Magnet Protocol`                                 |
| `URL Protocol`                         | `REG_SZ` | Empty string — marks as URL protocol handler          |
| `shell\open\command\(Default)`        | `REG_SZ` | `"C:\...\qbittorrent.exe" "%1"`                       |

## 🗑️ Cleanup

```powershell
Remove-Item -Path "HKCU:\Software\qBittorrent"               -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path "HKLM:\SOFTWARE\qBittorrent"               -Recurse -Force -ErrorAction SilentlyContinue
```
