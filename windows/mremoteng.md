---
tags:
  - remote-desktop
  - rdp
  - ssh
  - sysadmin
  - multi-protocol
description: >-
  Windows registry keys created by mRemoteNG — install paths, uninstall keys, HKCU and HKLM entries for sysadmin automation and cleanup.
---

# mRemoteNG

**Version documented:** 1.77.3
**Installer type:** `.msi`
**Hives written:** HKCU, HKLM

---

## 📁 Registry Paths

| Path | Hive | Purpose |
|------|------|---------|
| `SOFTWARE\mRemoteNG` | HKCU | User preferences |
| `SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{GUID}` | HKLM | Uninstall entry (MSI) |

---

## 🔑 Keys

### HKCU\SOFTWARE\mRemoteNG

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `ConfDir` | REG_SZ | `C:\Users\User\AppData\Roaming\mRemoteNG` | Connections config directory |
| `StartupConnectionFileName` | REG_SZ | `confCons.xml` | Default connections file name |
| `Theme` | REG_SZ | `Dark` | UI theme |
| `Language` | REG_SZ | `en-US` | Interface language |
| `CheckForUpdatesOnStartup` | REG_DWORD | `1` | Auto update check |
| `AutoSaveEveryMinutes` | REG_DWORD | `5` | Auto-save interval |
| `EncryptionEngine` | REG_SZ | `AES` | Encryption engine for saved passwords |

### HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{GUID}

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `DisplayName` | REG_SZ | `mRemoteNG 1.77.3` | Display name |
| `DisplayVersion` | REG_SZ | `1.77.3` | Version |
| `Publisher` | REG_SZ | `mRemoteNG Team` | Publisher |
| `InstallLocation` | REG_SZ | `C:\Program Files\mRemoteNG` | Install path |
| `UninstallString` | REG_SZ | `MsiExec.exe /X{GUID}` | Uninstaller |

---

## 📝 Notes

- All connection definitions (hostnames, credentials, protocols) are stored in `confCons.xml` at `%APPDATA%\mRemoteNG` — back up this file to migrate connections.
- Passwords in the XML are encrypted with AES using a master password (or the default key if no master password is set).
- mRemoteNG supports RDP, VNC, SSH, Telnet, HTTP/S, Rlogin, Raw, and ICA protocols.

```powershell
# Find the connections config file location
(Get-ItemProperty "HKCU:\SOFTWARE\mRemoteNG" -ErrorAction SilentlyContinue).ConfDir

# Backup connections config
$confDir = (Get-ItemProperty "HKCU:\SOFTWARE\mRemoteNG").ConfDir
Copy-Item "$confDir\confCons.xml" "$env:USERPROFILE\mremoteng-backup-$(Get-Date -Format yyyyMMdd).xml"
```

---

## 🗑️ Cleanup

```powershell
# Remove mRemoteNG user preferences
Remove-Item -Path "HKCU:\SOFTWARE\mRemoteNG" -Recurse -ErrorAction SilentlyContinue
```

---

## 📦 Package Managers

| Manager | ID / Command |
|---------|-------------|
| winget | `winget install mRemoteNG.mRemoteNG` |
| Chocolatey | `choco install mremoteng` |
| Scoop | `scoop install extras/mremoteng` |
