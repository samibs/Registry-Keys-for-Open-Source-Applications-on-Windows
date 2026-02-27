---
tags:
  - messaging
  - security
  - HKCU
  - HKCR
  - exe-installer
description: >-
  Windows registry keys created by Signal Desktop — install paths, uninstall keys, HKCU and HKLM entries for sysadmin automation and cleanup.
---

# Signal Desktop

**Version tested:** 7.7.0
**Installer type:** `.exe` official installer from signal.org

## 📦 Package Managers

| Manager    | Install Command |
|------------|-----------------|
| winget     | `winget install OpenWhisperSystems.Signal` |
| Chocolatey | `choco install signal` |
| Scoop      | `scoop install signal` |

## 📁 Registry Paths

- `HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Uninstall\signal-desktop` *(user installer)*
- `HKEY_CLASSES_ROOT\sgnl` *(sgnl:// URI handler — deep links)*
- `HKEY_CLASSES_ROOT\signalcaptcha` *(signalcaptcha:// URI handler — CAPTCHA flow)*

## 🔑 Keys

### Uninstall entry (`HKCU\...\Uninstall\signal-desktop`)

| Key Name          | Type        | Description                                          |
|-------------------|-------------|------------------------------------------------------|
| `DisplayName`     | `REG_SZ`    | `Signal`                                             |
| `DisplayVersion`  | `REG_SZ`    | Installed version (e.g., `7.7.0`)                   |
| `DisplayIcon`     | `REG_SZ`    | Path to `Signal.exe`                                |
| `InstallLocation` | `REG_SZ`    | Root installation directory                          |
| `Publisher`       | `REG_SZ`    | `Open Whisper Systems`                              |
| `UninstallString` | `REG_SZ`    | Path to the uninstaller executable                   |
| `NoModify`        | `REG_DWORD` | `1` — no modify button in ARP                       |

### URI handlers (`HKCR\sgnl`, `HKCR\signalcaptcha`)

| Key Path                              | Type     | Description                                          |
|---------------------------------------|----------|------------------------------------------------------|
| `sgnl\(Default)`                      | `REG_SZ` | `URL:Signal`                                         |
| `sgnl\URL Protocol`                   | `REG_SZ` | Empty string — marks key as a URL protocol handler   |
| `sgnl\shell\open\command\(Default)`  | `REG_SZ` | `"C:\...\Signal.exe" "%1"`                           |
| `signalcaptcha\(Default)`             | `REG_SZ` | `URL:Signal Captcha`                                 |
| `signalcaptcha\URL Protocol`          | `REG_SZ` | Empty string                                         |

## 📝 Notes

- Signal Desktop installs to `%LOCALAPPDATA%\Programs\signal-desktop\` (user-scope). All registry entries are in `HKCU` only.
- All user data (encrypted message database) is stored in `%APPDATA%\Signal\`. The encryption key is tied to the user account.
- Signal does **not** support multiple user accounts per OS user; the profile is bound to one phone number.
- The `sgnl://` URI scheme handles deep links such as `sgnl://signal.me/#p/<phone>` for easy contact addition.
- The `signalcaptcha://` URI is used during account registration to pass CAPTCHA tokens back to the app.

## 🗑️ Cleanup

```powershell
# Uninstall entry
Remove-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\signal-desktop" -Recurse -Force -ErrorAction SilentlyContinue

# URI handlers
Remove-Item -Path "HKCR:\sgnl"            -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path "HKCR:\signalcaptcha"   -Recurse -Force -ErrorAction SilentlyContinue
```
