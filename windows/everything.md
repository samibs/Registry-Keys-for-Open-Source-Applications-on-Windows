---
tags:
  - search
  - utilities
  - HKCU
  - HKLM
  - HKCR
  - exe-installer
description: >-
  Windows registry keys created by Everything (voidtools) — install paths, uninstall keys, HKCU and HKLM entries for sysadmin automation and cleanup.
---

# Everything (voidtools)

**Version tested:** 1.4.1.1024
**Installer type:** `.exe` official installer from voidtools.com

## 📦 Package Managers

| Manager    | Install Command |
|------------|-----------------|
| winget     | `winget install voidtools.Everything` |
| Chocolatey | `choco install everything` |
| Scoop      | `scoop install everything` |

## 📁 Registry Paths

- `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Everything`
- `HKEY_CURRENT_USER\Software\Voidtools\Everything`
- `HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run` *(startup entry)*
- `HKEY_CLASSES_ROOT\es` *(es:// URI handler for Everything Search)*

## 🔑 Keys

### User settings (`HKCU\Software\Voidtools\Everything`)

| Key Name                 | Type        | Description                                               |
|--------------------------|-------------|-----------------------------------------------------------|
| `search_history_count`   | `REG_DWORD` | Number of search history entries to keep                  |
| `start_menu_shortcut`    | `REG_DWORD` | `1` = Start Menu shortcut created                        |
| `taskbar_notification_icon` | `REG_DWORD` | `1` = show icon in system tray                        |
| `http_server_enabled`    | `REG_DWORD` | `1` = enable built-in HTTP server for remote search       |
| `http_server_port`       | `REG_DWORD` | HTTP server port (default: `80`)                          |
| `efu_associations`       | `REG_DWORD` | `1` = register `.efu` file list file associations         |

### Startup entry (`HKCU\...\Run`)

| Key Name     | Type     | Description                                                  |
|--------------|----------|--------------------------------------------------------------|
| `Everything` | `REG_SZ` | Path to `Everything.exe` — launches at Windows logon         |

### URI handler (`HKCR\es`)

| Key Path                              | Type     | Description                                          |
|---------------------------------------|----------|------------------------------------------------------|
| `(Default)`                           | `REG_SZ` | `URL:Everything Search`                              |
| `URL Protocol`                        | `REG_SZ` | Empty string — marks as URL protocol handler          |
| `shell\open\command\(Default)`       | `REG_SZ` | `"C:\...\Everything.exe" -search "%1"`               |

### Uninstall entry

| Key Name          | Type     | Description                                        |
|-------------------|----------|----------------------------------------------------|
| `DisplayName`     | `REG_SZ` | `Everything 1.4.1.1024`                            |
| `DisplayVersion`  | `REG_SZ` | Installed version                                  |
| `Publisher`       | `REG_SZ` | `voidtools`                                        |
| `InstallLocation` | `REG_SZ` | Root installation directory                        |
| `UninstallString` | `REG_SZ` | Path to the NSIS uninstaller                       |

## 📝 Notes

- Everything builds and maintains a file index in `%APPDATA%\Everything\Everything.db` using the Windows NTFS Master File Table (MFT) — no registry storage for the index.
- The **HTTP server** feature (disabled by default) allows searching Everything from a browser or script; enable it in Options → HTTP Server.
- The `es.exe` command-line companion searches Everything from scripts: `es.exe -regex "\.log$"` — it does not create registry entries.
- Everything registers `.efu` (Everything File List) file associations when `efu_associations` is enabled.
- The **portable version** stores all settings in `Everything.ini` alongside the executable and creates no registry entries.
- ⚠️ Everything requires **administrator rights** to index all NTFS volumes; without admin, it falls back to folder enumeration which is slower.

## 🗑️ Cleanup

```powershell
Remove-Item -Path "HKCU:\Software\Voidtools"  -Recurse -Force -ErrorAction SilentlyContinue
Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run" -Name "Everything" -ErrorAction SilentlyContinue
Remove-Item -Path "HKCR:\es"  -Recurse -Force -ErrorAction SilentlyContinue

Get-ChildItem "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall" |
  Where-Object { $_.GetValue("DisplayName") -like "Everything*" } |
  ForEach-Object { Remove-Item $_.PSPath -Recurse -Force }
```
