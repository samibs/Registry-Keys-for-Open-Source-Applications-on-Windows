---
tags:
  - password-manager
  - security
  - HKCU
  - HKLM
  - exe-installer
description: >-
  Windows registry keys created by KeePass Password Safe — install paths, uninstall keys, HKCU and HKLM entries for sysadmin automation and cleanup.
---

# KeePass Password Safe

**Version tested:** 2.55 (KeePass 2.x)
**Installer type:** `.exe` official installer from keepass.info


## 📦 Package Managers

| Manager    | Install Command |
|------------|-----------------|
| winget     | `winget install DominikReichl.KeePass` |
| Chocolatey | `choco install keepass` |
| Scoop      | `scoop install keepass` |

## 📁 Registry Paths

- `HKEY_LOCAL_MACHINE\SOFTWARE\KeePass Password Safe 2`
- `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\KeePassPasswordSafe2_is1`

## 🔑 Keys

### Installation entry (`HKLM\SOFTWARE\KeePass Password Safe 2`)

| Key Name         | Type     | Description                                                        |
|------------------|----------|--------------------------------------------------------------------|
| `InstallDir`     | `REG_SZ` | Root installation directory (e.g., `C:\Program Files\KeePass Password Safe 2`) |

### Uninstall entry (`HKLM\...\Uninstall\KeePassPasswordSafe2_is1`)

| Key Name           | Type        | Description                                              |
|--------------------|-------------|----------------------------------------------------------|
| `DisplayName`      | `REG_SZ`    | `KeePass Password Safe 2.55`                            |
| `DisplayVersion`   | `REG_SZ`    | Installed version (e.g., `2.55`)                        |
| `DisplayIcon`      | `REG_SZ`    | Path to `KeePass.exe`                                   |
| `InstallLocation`  | `REG_SZ`    | Root installation directory                              |
| `Publisher`        | `REG_SZ`    | `Dominik Reichl`                                        |
| `UninstallString`  | `REG_SZ`    | Path to the Inno Setup uninstaller                       |
| `URLInfoAbout`     | `REG_SZ`    | `https://keepass.info`                                  |
| `EstimatedSize`    | `REG_DWORD` | Estimated install size in KB                            |
| `NoModify`         | `REG_DWORD` | `1` — no modify option in ARP                           |

## 📝 Notes

- KeePass stores all user configuration in `%APPDATA%\KeePass\KeePass.config.xml`, not the registry.
- The `.kdbx` database files are **not** stored in the registry; they reside wherever the user chooses to save them.
- KeePass 1.x uses a completely separate registry path (`HKLM\SOFTWARE\Password Safe`); document separately.
- The portable version does not create any registry entries and stores `KeePass.config.xml` alongside the executable.
- Auto-Type global hotkey and other integration settings are configured inside the application and stored in the XML config, not the registry.

## 🗑️ Cleanup

```powershell
Remove-Item -Path "HKCU:\Software\KeePass"                   -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path "HKLM:\SOFTWARE\KeePass"                   -Recurse -Force -ErrorAction SilentlyContinue
```
