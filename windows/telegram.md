---
tags:
  - messaging
  - HKCU
  - HKCR
  - exe-installer
description: >-
  Windows registry keys created by Telegram Desktop — install paths, uninstall keys, HKCU and HKLM entries for sysadmin automation and cleanup.
---

# Telegram Desktop

**Version tested:** 4.16.6
**Installer type:** `.exe` official installer from telegram.org

## 📦 Package Managers

| Manager    | Install Command |
|------------|-----------------|
| winget     | `winget install Telegram.TelegramDesktop` |
| Chocolatey | `choco install telegram` |
| Scoop      | `scoop install telegram` |

## 📁 Registry Paths

- `HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Uninstall\{53F49750-6209-4FBF-9CA8-7A333C87D1ED}_is1` *(user installer)*
- `HKEY_CLASSES_ROOT\tg` *(tg:// URI protocol handler)*

## 🔑 Keys

### Uninstall entry (`HKCU\...\Uninstall\..._is1`)

| Key Name          | Type        | Description                                        |
|-------------------|-------------|----------------------------------------------------|
| `DisplayName`     | `REG_SZ`    | `Telegram Desktop version 4.16.6`                 |
| `DisplayVersion`  | `REG_SZ`    | Installed version (e.g., `4.16.6`)                |
| `DisplayIcon`     | `REG_SZ`    | Path to `Telegram.exe`                            |
| `InstallLocation` | `REG_SZ`    | Root installation directory                        |
| `Publisher`       | `REG_SZ`    | `Telegram FZ-LLC`                                 |
| `UninstallString` | `REG_SZ`    | Path to the Inno Setup uninstaller                 |
| `NoModify`        | `REG_DWORD` | `1` — no modify button in ARP                     |

### URI protocol handler (`HKCR\tg`)

| Key Path                              | Type     | Description                                          |
|---------------------------------------|----------|------------------------------------------------------|
| `(Default)`                           | `REG_SZ` | `URL:Telegram Link`                                  |
| `URL Protocol`                        | `REG_SZ` | Empty string — marks key as a URL protocol handler   |
| `shell\open\command\(Default)`       | `REG_SZ` | `"C:\...\Telegram.exe" -- "%1"`                      |

## 📝 Notes

- Telegram Desktop installs to `%APPDATA%\Telegram Desktop\` by default (user-scope). All registry entries are written to `HKCU` only.
- All user data (messages are end-to-end encrypted on Telegram's servers; local cache) is in `%APPDATA%\Telegram Desktop\tdata\`.
- The GUID in the uninstall key path may differ per version; use the dynamic lookup: `Get-ChildItem "HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall" | Where-Object { $_.GetValue("DisplayName") -like "*Telegram*" }`.
- The `tg://` URI scheme is used for deep links (join group, open user, etc.) from web pages and QR codes.
- The **portable version** (`tsetup.zip`) creates no registry entries.

## 🗑️ Cleanup

```powershell
# Uninstall entry (GUID varies per version)
Get-ChildItem "HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall" |
  Where-Object { $_.GetValue("DisplayName") -like "*Telegram*" } |
  ForEach-Object { Remove-Item $_.PSPath -Recurse -Force }

# URI handler
Remove-Item -Path "HKCR:\tg"  -Recurse -Force -ErrorAction SilentlyContinue
```
