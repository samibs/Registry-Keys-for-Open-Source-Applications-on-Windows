---
tags:
  - password-manager
  - security
  - credentials
  - electron
description: >-
  Windows registry keys created by Bitwarden — install paths, uninstall keys, HKCU and HKLM entries for sysadmin automation and cleanup.
---

# Bitwarden

**Version documented:** 2024.2.1
**Installer type:** `.exe` (Squirrel, user-level)
**Hives written:** HKCU

---

## 📁 Registry Paths

| Path | Hive | Purpose |
|------|------|---------|
| `SOFTWARE\Bitwarden` | HKCU | Application settings |
| `SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Bitwarden` | HKCU | Uninstall entry |
| `SOFTWARE\Microsoft\Windows\CurrentVersion\Run` | HKCU | Startup entry (if enabled) |
| `SOFTWARE\Classes\bitwarden` | HKCU | `bitwarden://` URI scheme |

---

## 🔑 Keys

### HKCU\SOFTWARE\Bitwarden

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `InstallLocation` | REG_SZ | `C:\Users\User\AppData\Local\Bitwarden` | Install path |
| `DisplayVersion` | REG_SZ | `2024.2.1` | Installed version |

### HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Bitwarden

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `DisplayName` | REG_SZ | `Bitwarden` | Display name |
| `DisplayVersion` | REG_SZ | `2024.2.1` | Version |
| `Publisher` | REG_SZ | `Bitwarden Inc.` | Publisher |
| `InstallLocation` | REG_SZ | `C:\Users\User\AppData\Local\Bitwarden` | Install path |
| `UninstallString` | REG_SZ | `"...\Uninstall Bitwarden.exe"` | Uninstaller |

### HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run (optional)

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `Bitwarden` | REG_SZ | `"...\Bitwarden.exe" --startup` | Auto-start on login |

### HKCU\SOFTWARE\Classes\bitwarden

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `(Default)` | REG_SZ | `URL:Bitwarden` | URI scheme descriptor |
| `URL Protocol` | REG_SZ | `` | Marks as a URL handler |
| `shell\open\command` (Default) | REG_SZ | `"Bitwarden.exe" "%1"` | URI open command |

---

## 📝 Notes

- Bitwarden uses the Squirrel framework — installs per-user to `%LOCALAPPDATA%\Bitwarden`.
- The `bitwarden://` URI scheme enables browser extension ↔ desktop app communication.
- All vault data is encrypted and stored locally at `%APPDATA%\Bitwarden\data.json` — not in the registry.
- The browser extension (for native messaging) may add keys under `HKCU\SOFTWARE\Mozilla\NativeMessagingHosts\com.8bit.bitwarden`.

```powershell
# Disable auto-start without uninstalling
Remove-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" `
  -Name "Bitwarden" -ErrorAction SilentlyContinue

# Check if native messaging host is registered (for browser extension)
Test-Path "HKCU:\SOFTWARE\Mozilla\NativeMessagingHosts\com.8bit.bitwarden"
```

---

## 🗑️ Cleanup

```powershell
# Remove Bitwarden registry entries
Remove-Item -Path "HKCU:\SOFTWARE\Bitwarden" -Recurse -ErrorAction SilentlyContinue
Remove-Item -Path "HKCU:\SOFTWARE\Classes\bitwarden" -Recurse -ErrorAction SilentlyContinue
Remove-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" `
  -Name "Bitwarden" -ErrorAction SilentlyContinue

# Remove browser native messaging hosts
Remove-Item -Path "HKCU:\SOFTWARE\Mozilla\NativeMessagingHosts\com.8bit.bitwarden" `
  -Recurse -ErrorAction SilentlyContinue
Remove-Item -Path "HKCU:\SOFTWARE\Google\Chrome\NativeMessagingHosts\com.8bit.bitwarden" `
  -Recurse -ErrorAction SilentlyContinue
```

---

## 📦 Package Managers

| Manager | ID / Command |
|---------|-------------|
| winget | `winget install Bitwarden.Bitwarden` |
| Chocolatey | `choco install bitwarden` |
| Scoop | `scoop install extras/bitwarden` |
