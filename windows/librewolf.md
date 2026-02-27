---
tags:
  - browser
  - privacy
  - firefox-based
description: >-
  Windows registry keys created by LibreWolf — install paths, uninstall keys, HKCU and HKLM entries for sysadmin automation and cleanup.
---

# LibreWolf

**Version:** 124.0-1  
**Installer:** `.exe` (NSIS setup) / Portable  
**Hives:** HKCU, HKLM, HKCR

LibreWolf is a custom and independent fork of Firefox, focused on privacy, security, and freedom. It ships with uBlock Origin and hardened settings by default.

---

## 📁 Registry Paths

| Path | Hive | Description |
|------|------|-------------|
| `SOFTWARE\LibreWolf` | HKCU | Per-user preferences / profile path |
| `SOFTWARE\LibreWolf` | HKLM | Machine-wide policy settings |
| `SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\LibreWolf` | HKLM | Uninstall entry |
| `LibreWolfURL` | HKCR | URL handler ProgID |
| `LibreWolfHTML` | HKCR | HTML file handler ProgID |
| `SOFTWARE\RegisteredApplications` | HKLM | Registered as default browser candidate |

---

## 🔑 Keys

### HKCU\SOFTWARE\LibreWolf

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `PathToExe` | `REG_SZ` | `C:\Program Files\LibreWolf\librewolf.exe` | Path to the executable |

### HKLM\SOFTWARE\LibreWolf

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `InstallDirectory` | `REG_SZ` | `C:\Program Files\LibreWolf\` | Installation directory |

### HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\LibreWolf

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `DisplayName` | `REG_SZ` | `LibreWolf (x64 en-US)` | Display name |
| `DisplayVersion` | `REG_SZ` | `124.0-1` | Installed version |
| `Publisher` | `REG_SZ` | `LibreWolf` | Publisher |
| `InstallLocation` | `REG_SZ` | `C:\Program Files\LibreWolf\` | Install directory |
| `UninstallString` | `REG_SZ` | `"C:\Program Files\LibreWolf\uninstall.exe"` | Uninstall command |

### HKCR\LibreWolfURL

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `(Default)` | `REG_SZ` | `LibreWolf URL` | URL handler description |
| `URL Protocol` | `REG_SZ` | `` | Marks as URL protocol handler |

---

## 📝 Notes

- LibreWolf follows the same registry layout as Firefox, substituting `LibreWolf` for `Mozilla` in key names.
- Policies can be enforced via `HKLM\SOFTWARE\Policies\Mozilla\Firefox` (shared with Firefox) or via `policies.json`.
- Profile data lives in `%APPDATA%\librewolf\Profiles\` — no registry storage for user data.
- When set as the default browser, it writes handlers to `HKCU\SOFTWARE\LibreWolf\Capabilities`.

---

## 🗑️ Cleanup

```reg
Windows Registry Editor Version 5.00

[-HKEY_CURRENT_USER\SOFTWARE\LibreWolf]
[-HKEY_LOCAL_MACHINE\SOFTWARE\LibreWolf]
[-HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\LibreWolf]
[-HKEY_CLASSES_ROOT\LibreWolfURL]
[-HKEY_CLASSES_ROOT\LibreWolfHTML]
```

---

## 📦 Package Managers

| Manager | Install Command |
|---------|----------------|
| winget | `winget install LibreWolf.LibreWolf` |
| Chocolatey | `choco install librewolf` |
| Scoop | `scoop install librewolf` |
