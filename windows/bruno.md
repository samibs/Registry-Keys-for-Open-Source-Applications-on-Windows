---
tags:
  - developer
  - api
  - rest
  - testing
description: >-
  Windows registry keys created by Bruno — install paths, uninstall keys, HKCU and HKLM entries for sysadmin automation and cleanup.
---

# Bruno

**Version:** 1.21.0  
**Installer:** `.exe` (setup) / `.msi`  
**Hives:** HKCU, HKLM

Bruno is a fast, open-source API client for exploring and testing APIs. Unlike cloud-based alternatives, all collections are stored as plain text files on disk (Bru format), enabling native Git version control. It is a privacy-respecting alternative to Postman and Insomnia.

---

## 📁 Registry Paths

| Path | Hive | Description |
|------|------|-------------|
| `SOFTWARE\Bruno` | HKCU | Per-user preferences |
| `SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Bruno` | HKLM | Uninstall entry |

---

## 🔑 Keys

### HKCU\SOFTWARE\Bruno

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `lastOpenedCollection` | `REG_SZ` | `C:\Users\User\projects\my-api\` | Path to last-opened collection |
| `theme` | `REG_SZ` | `dark` | UI theme (`dark`, `light`) |
| `fontSize` | `REG_DWORD` | `13` | Editor font size |
| `checkForUpdates` | `REG_DWORD` | `1` | Auto-check for updates |

### HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Bruno

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `DisplayName` | `REG_SZ` | `Bruno 1.21.0` | Display name |
| `DisplayVersion` | `REG_SZ` | `1.21.0` | Installed version |
| `Publisher` | `REG_SZ` | `Anoop M D` | Publisher |
| `InstallLocation` | `REG_SZ` | `C:\Program Files\Bruno\` | Install directory |
| `UninstallString` | `REG_SZ` | `"C:\Program Files\Bruno\Uninstall Bruno.exe"` | Uninstall command |
| `URLInfoAbout` | `REG_SZ` | `https://www.usebruno.com` | Product URL |

---

## 📝 Notes

- Bruno stores all API collections as `.bru` files on the local filesystem — there is no cloud sync or account requirement.
- Collections can be committed directly to Git alongside application code.
- Preferences beyond the registry are stored in `%APPDATA%\Bruno\` as JSON.
- Bruno does not register URI protocol handlers or file associations by default.
- Built on Electron; the HKCU key is minimal (Electron apps often write very little to the registry).

---

## 🗑️ Cleanup

```reg
Windows Registry Editor Version 5.00

[-HKEY_CURRENT_USER\SOFTWARE\Bruno]
[-HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Bruno]
```

---

## 📦 Package Managers

| Manager | Install Command |
|---------|----------------|
| winget | `winget install Bruno.Bruno` |
| Chocolatey | `choco install bruno` |
| Scoop | `scoop install bruno` |
