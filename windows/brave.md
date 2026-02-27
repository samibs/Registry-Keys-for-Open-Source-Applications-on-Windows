---
tags:
  - browser
  - HKCU
  - HKLM
  - HKCR
  - exe-installer
  - chromium
---

# Brave Browser

**Version tested:** 1.63.169
**Installer type:** `.exe` official installer from brave.com

## 📦 Package Managers

| Manager    | Install Command |
|------------|-----------------|
| winget     | `winget install Brave.Brave` |
| Chocolatey | `choco install brave` |
| Scoop      | `scoop install brave` |

## 📁 Registry Paths

- `HKEY_LOCAL_MACHINE\SOFTWARE\BraveSoftware\Brave-Browser`
- `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\BraveSoftware Brave Browser`
- `HKEY_CURRENT_USER\Software\BraveSoftware\Brave-Browser`
- `HKEY_CLASSES_ROOT\BraveHTML` *(HTML file handler ProgID)*
- `HKEY_CLASSES_ROOT\brave` *(brave:// URI scheme handler)*

## 🔑 Keys

### Installation entry (`HKLM\SOFTWARE\BraveSoftware\Brave-Browser`)

| Key Name       | Type     | Description                                        |
|----------------|----------|----------------------------------------------------|
| `pv`           | `REG_SZ` | Installed version string (e.g., `1.63.169`)        |
| `name`         | `REG_SZ` | `Brave`                                            |
| `install_path` | `REG_SZ` | Full path to `brave.exe`                           |

### Uninstall entry (`HKLM\...\Uninstall\BraveSoftware Brave Browser`)

| Key Name          | Type     | Description                                        |
|-------------------|----------|----------------------------------------------------|
| `DisplayName`     | `REG_SZ` | `Brave`                                            |
| `DisplayVersion`  | `REG_SZ` | Installed version (e.g., `1.63.169`)               |
| `InstallLocation` | `REG_SZ` | Root installation directory                        |
| `Publisher`       | `REG_SZ` | `Brave Software Inc`                               |
| `UninstallString` | `REG_SZ` | Path to the uninstaller                            |

### HTML file handler (`HKCR\BraveHTML`)

| Key Path                              | Type     | Description                                     |
|---------------------------------------|----------|-------------------------------------------------|
| `(Default)`                           | `REG_SZ` | `Brave HTML Document`                           |
| `shell\open\command\(Default)`       | `REG_SZ` | `"C:\...\brave.exe" -- "%1"`                    |

## 📝 Notes

- Brave is Chromium-based; its registry structure closely mirrors Google Chrome (`BraveSoftware` replaces `Google`).
- All user data (bookmarks, extensions, settings) is stored in `%LOCALAPPDATA%\BraveSoftware\Brave-Browser\User Data\`, not the registry.
- The **System installer** (for all users) writes to `HKLM`; the **User installer** writes the same keys to `HKCU`.
- Enterprise policies can be pushed via `HKLM\SOFTWARE\Policies\BraveSoftware\Brave` — structure mirrors Chrome's managed policy schema.
- Brave's built-in ad blocker and Shields configuration are stored in the profile's `Preferences` JSON file, not the registry.

## 🗑️ Cleanup

```powershell
Remove-Item -Path "HKCU:\Software\BraveSoftware"                       -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path "HKLM:\SOFTWARE\BraveSoftware"                       -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path "HKCR:\BraveHTML"                                    -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path "HKCR:\brave"                                        -Recurse -Force -ErrorAction SilentlyContinue
```
