---
tags:
  - backup
  - cloud
  - service
---

# Duplicati

**Version:** 2.0.8.1  
**Installer:** `.exe` (setup) / `.msi`  
**Hives:** HKCU, HKLM, SYSTEM

Duplicati is a free, open-source backup client that stores encrypted, incremental, compressed backups on cloud storage services, FTP, SSH, WebDAV, and local drives. It runs as a background service with a web-based UI.

---

## 📁 Registry Paths

| Path | Hive | Description |
|------|------|-------------|
| `SOFTWARE\Duplicati` | HKCU | Per-user settings |
| `SOFTWARE\Duplicati` | HKLM | Machine-wide installation info |
| `SYSTEM\CurrentControlSet\Services\Duplicati` | SYSTEM | Windows service registration |
| `SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Duplicati_is1` | HKLM | Uninstall entry |

---

## 🔑 Keys

### HKLM\SOFTWARE\Duplicati

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `InstallPath` | `REG_SZ` | `C:\Program Files\Duplicati 2\` | Installation directory |
| `Version` | `REG_SZ` | `2.0.8.1` | Installed version |

### SYSTEM\CurrentControlSet\Services\Duplicati

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `Type` | `REG_DWORD` | `16` | Win32 own process |
| `Start` | `REG_DWORD` | `2` | Automatic start |
| `ImagePath` | `REG_EXPAND_SZ` | `"C:\Program Files\Duplicati 2\Duplicati.Server.exe" /server-datafolder="%PROGRAMDATA%\Duplicati"` | Service command |
| `DisplayName` | `REG_SZ` | `Duplicati` | Service display name |
| `Description` | `REG_SZ` | `Keeps backups up to date` | Service description |
| `ObjectName` | `REG_SZ` | `LocalSystem` | Service account |

### HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Duplicati_is1

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `DisplayName` | `REG_SZ` | `Duplicati 2.0.8.1` | Display name |
| `DisplayVersion` | `REG_SZ` | `2.0.8.1` | Installed version |
| `Publisher` | `REG_SZ` | `Duplicati Team` | Publisher |
| `InstallLocation` | `REG_SZ` | `C:\Program Files\Duplicati 2\` | Install path |
| `UninstallString` | `REG_SZ` | `"C:\Program Files\Duplicati 2\unins000.exe"` | Uninstall command |

---

## 📝 Notes

- Duplicati runs a local web server on port 8200 by default — the UI is accessed via browser.
- Backup configuration, schedules, and encryption keys are stored in `%PROGRAMDATA%\Duplicati\` as SQLite databases and JSON files, not in the registry.
- The service can be switched to run as a specific user account (not LocalSystem) for accessing network shares.
- Duplicati also supports a "user-installed" mode without a Windows service — the tray icon launches the server on demand.

---

## 🗑️ Cleanup

Stop the service before removing registry entries:

```powershell
Stop-Service Duplicati
sc.exe delete Duplicati
```

```reg
Windows Registry Editor Version 5.00

[-HKEY_CURRENT_USER\SOFTWARE\Duplicati]
[-HKEY_LOCAL_MACHINE\SOFTWARE\Duplicati]
[-HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Duplicati]
[-HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Duplicati_is1]
```

---

## 📦 Package Managers

| Manager | Install Command |
|---------|----------------|
| winget | `winget install Duplicati.Duplicati` |
| Chocolatey | `choco install duplicati` |
