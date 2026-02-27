---
tags:
  - screenshot
  - annotation
  - linux-port
---

# Flameshot

**Version:** 12.1.0  
**Installer:** `.exe` (setup) / `.msi`  
**Hives:** HKCU, HKLM

Flameshot is a powerful, open-source screenshot tool with an integrated annotation editor. Originally developed for Linux, it is now available for Windows with full support for region capture, drawing tools, and upload integrations.

---

## 📁 Registry Paths

| Path | Hive | Description |
|------|------|-------------|
| `SOFTWARE\flameshot-org\flameshot` | HKCU | Per-user configuration |
| `SOFTWARE\Microsoft\Windows\CurrentVersion\Run` | HKCU | Startup entry (if enabled) |
| `SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{GUID}` | HKLM | Uninstall entry (GUID varies by version) |

---

## 🔑 Keys

### HKCU\SOFTWARE\flameshot-org\flameshot

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `savePath` | `REG_SZ` | `C:\Users\User\Pictures\Screenshots` | Default save directory |
| `saveAsFileExtension` | `REG_SZ` | `png` | Default image format |
| `showTrayIcon` | `REG_DWORD` | `1` | Show system tray icon |
| `startupLaunch` | `REG_DWORD` | `0` | Launch at Windows startup |
| `uiColor` | `REG_SZ` | `#FF0000` | Annotation tool colour |
| `buttons` | `REG_SZ` | `(json-encoded list)` | Enabled toolbar buttons |

### HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `flameshot` | `REG_SZ` | `"C:\Program Files\flameshot\bin\flameshot.exe"` | Launch at Windows startup |

---

## 📝 Notes

- Flameshot uses Qt's QSettings which maps to `HKCU\SOFTWARE\flameshot-org\flameshot` on Windows.
- The startup entry is only created when "Launch at startup" is enabled in preferences.
- The HKLM uninstall GUID is generated at install time and varies between versions — query `HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\` to find the current entry by `DisplayName`.
- Flameshot does not register file associations.

---

## 🗑️ Cleanup

```reg
Windows Registry Editor Version 5.00

[-HKEY_CURRENT_USER\SOFTWARE\flameshot-org\flameshot]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Run]
"flameshot"=-
```

Remove the uninstall entry by running the official uninstaller or via Apps & Features.

---

## 📦 Package Managers

| Manager | Install Command |
|---------|----------------|
| winget | `winget install flameshot-org.flameshot` |
| Chocolatey | `choco install flameshot` |
| Scoop | `scoop install flameshot` |
