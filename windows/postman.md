---
tags:
  - api-client
  - developer-tools
  - HKCU
  - HKLM
  - HKCR
  - exe-installer
description: >-
  Windows registry keys created by Postman — install paths, uninstall keys, HKCU and HKLM entries for sysadmin automation and cleanup.
---

# Postman

**Version tested:** 10.22.13
**Installer type:** `.exe` official installer from postman.com

## 📦 Package Managers

| Manager    | Install Command |
|------------|-----------------|
| winget     | `winget install Postman.Postman` |
| Chocolatey | `choco install postman` |
| Scoop      | `scoop install postman` |

## 📁 Registry Paths

- `HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Uninstall\postman` *(user installer)*
- `HKEY_CLASSES_ROOT\postman` *(postman:// URI handler)*

## 🔑 Keys

### Uninstall entry (`HKCU\...\Uninstall\postman`)

| Key Name          | Type        | Description                                        |
|-------------------|-------------|----------------------------------------------------|
| `DisplayName`     | `REG_SZ`    | `Postman`                                          |
| `DisplayVersion`  | `REG_SZ`    | Installed version (e.g., `10.22.13`)               |
| `DisplayIcon`     | `REG_SZ`    | Path to `Postman.exe`                              |
| `InstallLocation` | `REG_SZ`    | Root installation directory                        |
| `Publisher`       | `REG_SZ`    | `Postman, Inc.`                                    |
| `UninstallString` | `REG_SZ`    | Path to the uninstaller                            |
| `NoModify`        | `REG_DWORD` | `1` — no modify button in ARP                      |

### URI handler (`HKCR\postman`)

| Key Path                              | Type     | Description                                          |
|---------------------------------------|----------|------------------------------------------------------|
| `(Default)`                           | `REG_SZ` | `URL:Postman`                                        |
| `URL Protocol`                        | `REG_SZ` | Empty string — marks key as URL protocol handler     |
| `shell\open\command\(Default)`       | `REG_SZ` | `"C:\...\Postman.exe" "%1"`                          |

## 📝 Notes

- Postman installs to `%LOCALAPPDATA%\Postman\` (user-scope). All registry entries are `HKCU` only.
- All data (collections, environments, history, team workspaces) is stored in `%APPDATA%\Postman\` and synced to Postman's cloud servers when signed in.
- The `postman://` URI scheme is used for OAuth callback flows and external tool integrations.
- The **Postman Agent** (for browser-based Postman) installs separately and may create additional entries.
- Postman uses an Electron-based auto-updater; updates are downloaded to `%LOCALAPPDATA%\Postman\Update\` and don't require registry changes.

## 🗑️ Cleanup

```powershell
Remove-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\postman" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path "HKCR:\postman"  -Recurse -Force -ErrorAction SilentlyContinue
```
