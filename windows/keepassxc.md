---
tags:
  - password-manager
  - security
  - credentials
  - open-source
description: >-
  Windows registry keys created by KeePassXC — install paths, uninstall keys, HKCU and HKLM entries for sysadmin automation and cleanup.
---

# KeePassXC

**Version documented:** 2.7.7
**Installer type:** `.msi` / `.exe`
**Hives written:** HKCU, HKLM, HKCR

---

## 📁 Registry Paths

| Path | Hive | Purpose |
|------|------|---------|
| `SOFTWARE\KeePassXC Team\KeePassXC` | HKCU | User preferences |
| `SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\KeePassXC` | HKLM | Uninstall entry |
| `HKCR\.kdbx` | HKCR | .kdbx file association |
| `HKCR\KeePassXC.Database` | HKCR | ProgID for .kdbx |

---

## 🔑 Keys

### HKCU\SOFTWARE\KeePassXC Team\KeePassXC

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `LastDatabase` | REG_SZ | `C:\Users\User\Documents\passwords.kdbx` | Last opened database path |
| `AutoOpenLastDatabase` | REG_DWORD | `1` | Reopen last DB on launch |
| `MinimizeOnStartup` | REG_DWORD | `0` | Start minimized to tray |
| `RememberLastDatabase` | REG_DWORD | `1` | Remember last database path |
| `AutoSaveAfterEveryChange` | REG_DWORD | `1` | Auto-save on change |
| `UpdateCheckEnabled` | REG_DWORD | `1` | Enable update check |

### HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\KeePassXC

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `DisplayName` | REG_SZ | `KeePassXC 2.7.7` | Display name |
| `DisplayVersion` | REG_SZ | `2.7.7` | Version |
| `Publisher` | REG_SZ | `KeePassXC Team` | Publisher |
| `InstallLocation` | REG_SZ | `C:\Program Files\KeePassXC` | Install path |
| `UninstallString` | REG_SZ | `MsiExec.exe /X{GUID}` | Uninstaller |

### HKCR\.kdbx

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `(Default)` | REG_SZ | `KeePassXC.Database` | ProgID reference |

### HKCR\KeePassXC.Database

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `(Default)` | REG_SZ | `KeePass Database` | Friendly type name |
| `shell\open\command` (Default) | REG_SZ | `"KeePassXC.exe" "%1"` | Open command |

---

## 📝 Notes

- KeePassXC stores all substantive settings in INI files at `%APPDATA%\KeePassXC\` — the registry is used primarily for installation metadata and file associations.
- The `.kdbx` format is also used by KeePass 2; both apps may compete for the file association.
- The browser integration (KeePassXC-Browser) extension communicates via a named pipe; no additional registry keys needed.

```powershell
# Check which database KeePassXC will open on next launch
(Get-ItemProperty "HKCU:\SOFTWARE\KeePassXC Team\KeePassXC" -ErrorAction SilentlyContinue).LastDatabase
```

---

## 🗑️ Cleanup

```powershell
# Remove KeePassXC user preferences
Remove-Item -Path "HKCU:\SOFTWARE\KeePassXC Team\KeePassXC" -Recurse -ErrorAction SilentlyContinue
Remove-Item -Path "HKCU:\SOFTWARE\KeePassXC Team" -Recurse -ErrorAction SilentlyContinue

# Remove .kdbx file association
Remove-Item -Path "HKCR:\KeePassXC.Database" -Recurse -ErrorAction SilentlyContinue
Remove-ItemProperty -Path "HKCR:\.kdbx" -Name "(Default)" -ErrorAction SilentlyContinue
```

---

## 📦 Package Managers

| Manager | ID / Command |
|---------|-------------|
| winget | `winget install KeePassXCTeam.KeePassXC` |
| Chocolatey | `choco install keepassxc` |
| Scoop | `scoop install extras/keepassxc` |
