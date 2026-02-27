---
tags:
  - database
  - mysql
  - HKCU
  - HKLM
  - exe-installer
  - developer-tools
description: >-
  Windows registry keys created by HeidiSQL — install paths, uninstall keys, HKCU and HKLM entries for sysadmin automation and cleanup.
---

# HeidiSQL

**Version tested:** 12.6.0
**Installer type:** `.exe` official installer from heidisql.com

## 📦 Package Managers

| Manager    | Install Command |
|------------|-----------------|
| winget     | `winget install HeidiSQL.HeidiSQL` |
| Chocolatey | `choco install heidisql` |
| Scoop      | `scoop install heidisql` |

## 📁 Registry Paths

- `HKEY_CURRENT_USER\Software\HeidiSQL`
- `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\HeidiSQL_is1`

## 🔑 Keys

### User settings (`HKCU\Software\HeidiSQL`)

| Key Name                  | Type        | Description                                               |
|---------------------------|-------------|-----------------------------------------------------------|
| `Servers`                 | Subkey      | Parent key containing all saved database connection profiles |
| `Servers\<n>\Host`        | `REG_SZ`    | Hostname or IP address of the database server             |
| `Servers\<n>\User`        | `REG_SZ`    | Login username                                            |
| `Servers\<n>\Password`    | `REG_SZ`    | Obfuscated stored password                                |
| `Servers\<n>\Port`        | `REG_DWORD` | Database port (e.g., `3306` for MySQL)                   |
| `Servers\<n>\NetType`     | `REG_DWORD` | Connection type: `0` = MySQL TCP/IP, `1` = MySQL Socket, `2` = MSSQL, `3` = PostgreSQL |
| `Servers\<n>\DatabasesExpanded` | `REG_SZ` | Comma-separated list of expanded databases in the tree  |
| `ApplicationFont`         | `REG_SZ`    | UI font name                                              |
| `ApplicationFontSize`     | `REG_DWORD` | UI font size in points                                    |

### Uninstall entry (`HKLM\...\Uninstall\HeidiSQL_is1`)

| Key Name          | Type     | Description                                        |
|-------------------|----------|----------------------------------------------------|
| `DisplayName`     | `REG_SZ` | `HeidiSQL 12.6.0.6765`                             |
| `DisplayVersion`  | `REG_SZ` | Installed version                                  |
| `InstallLocation` | `REG_SZ` | Root installation directory                        |
| `Publisher`       | `REG_SZ` | `Ansgar Becker`                                   |
| `UninstallString` | `REG_SZ` | Path to the Inno Setup uninstaller                 |

## 📝 Notes

- HeidiSQL stores all connection profiles directly in the registry under `HKCU\Software\HeidiSQL\Servers`. Each connection is numbered sequentially (`1`, `2`, ...).
- ⚠️ **Security warning**: Stored passwords are obfuscated (not encrypted). Anyone with read access to `HKCU` can decode them. Use Windows Credential Manager or SSH tunnels for sensitive connections.
- To **migrate connections** between machines, export `HKCU\Software\HeidiSQL` and import on the target, or use HeidiSQL's built-in export (Settings → Export settings).
- The **portable version** (ZIP download) stores all settings in `portable_settings.txt` alongside the executable and does not use the registry.
- HeidiSQL supports MySQL/MariaDB, PostgreSQL, SQLite, MSSQL, and Interbase — all use the same registry structure; the `NetType` value differentiates the engine.

## 🗑️ Cleanup

```powershell
Remove-Item -Path "HKCU:\Software\HeidiSQL"  -Recurse -Force -ErrorAction SilentlyContinue

Get-ChildItem "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall" |
  Where-Object { $_.GetValue("DisplayName") -like "HeidiSQL*" } |
  ForEach-Object { Remove-Item $_.PSPath -Recurse -Force }
```
