---
tags:
  - video
  - streaming
  - media-server
description: >-
  Windows registry keys created by Jellyfin — install paths, uninstall keys, HKCU and HKLM entries for sysadmin automation and cleanup.
---

# Jellyfin

**Version:** 10.9.7  
**Installer:** `.exe` (setup) / `.zip` (portable server)  
**Hives:** HKLM, SYSTEM

Jellyfin is a free and open-source media server and suite of multimedia applications. It enables users to stream their media collection to devices over a local network or the internet, with no license fees or tracking.

---

## 📁 Registry Paths

| Path | Hive | Description |
|------|------|-------------|
| `SOFTWARE\Jellyfin\Server` | HKLM | Installation settings |
| `SYSTEM\CurrentControlSet\Services\JellyfinServer` | SYSTEM | Windows service registration |
| `SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{A4E50EA8-7E2A-4B6A-9C3B-5C5A4B3B7A3E}_is1` | HKLM | Uninstall entry (NSIS GUID) |

---

## 🔑 Keys

### HKLM\SOFTWARE\Jellyfin\Server

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `InstallFolder` | `REG_SZ` | `C:\Program Files\Jellyfin\Server\` | Installation directory |
| `DataFolder` | `REG_SZ` | `C:\ProgramData\Jellyfin\Server\` | Data directory for config, metadata, and DB |

### SYSTEM\CurrentControlSet\Services\JellyfinServer

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `Type` | `REG_DWORD` | `16` | Win32 own process service |
| `Start` | `REG_DWORD` | `2` | Automatic start |
| `ImagePath` | `REG_EXPAND_SZ` | `"C:\Program Files\Jellyfin\Server\jellyfin.exe" --service` | Service executable and arguments |
| `DisplayName` | `REG_SZ` | `Jellyfin Server` | Name in Services console |
| `Description` | `REG_SZ` | `Jellyfin Media Server` | Service description |
| `ObjectName` | `REG_SZ` | `LocalSystem` | Service account |

### HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{GUID}_is1

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `DisplayName` | `REG_SZ` | `Jellyfin Server 10.9.7` | Display name |
| `DisplayVersion` | `REG_SZ` | `10.9.7` | Installed version |
| `Publisher` | `REG_SZ` | `Jellyfin Contributors` | Publisher |
| `InstallLocation` | `REG_SZ` | `C:\Program Files\Jellyfin\Server\` | Install path |
| `UninstallString` | `REG_SZ` | `"C:\Program Files\Jellyfin\Server\unins000.exe"` | Uninstall command |
| `URLInfoAbout` | `REG_SZ` | `https://jellyfin.org` | Product URL |

---

## 📝 Notes

- Jellyfin runs as a **Windows service** (`JellyfinServer`), starting automatically at boot.
- All configuration, database, logs, and transcoding temp files are stored under `C:\ProgramData\Jellyfin\Server\`.
- The web interface is accessible at `http://localhost:8096` by default.
- Jellyfin does not register file associations — clients connect via HTTP/HTTPS.
- The Jellyfin Media Player (desktop client) is a separate application with its own registry entries.
- The uninstall GUID varies between versions — check `HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\` for the current entry.

---

## 🗑️ Cleanup

Stop and remove the service before cleaning registry:

```powershell
Stop-Service JellyfinServer
sc.exe delete JellyfinServer
```

```reg
Windows Registry Editor Version 5.00

[-HKEY_LOCAL_MACHINE\SOFTWARE\Jellyfin]
[-HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\JellyfinServer]
```

Run the official uninstaller for the `Uninstall` entry removal.

---

## 📦 Package Managers

| Manager | Install Command |
|---------|----------------|
| winget | `winget install Jellyfin.Server` |
| Chocolatey | `choco install jellyfin` |
| Scoop | `scoop install jellyfin` |
