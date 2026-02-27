---
tags:
  - screenshot
  - HKCU
  - HKLM
  - HKCR
  - exe-installer
---

# Greenshot

**Version tested:** 1.3.274
**Installer type:** `.exe` official installer from getgreenshot.org

## 📦 Package Managers

| Manager    | Install Command |
|------------|-----------------|
| winget     | `winget install Greenshot.Greenshot` |
| Chocolatey | `choco install greenshot` |
| Scoop      | `scoop install greenshot` |

## 📁 Registry Paths

- `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Greenshot_is1`
- `HKEY_CURRENT_USER\Software\Greenshot`
- `HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run` *(startup entry)*

## 🔑 Keys

### User settings (`HKCU\Software\Greenshot`)

| Key Name                  | Type        | Description                                               |
|---------------------------|-------------|-----------------------------------------------------------|
| `OutputFilePath`          | `REG_SZ`    | Default save directory for screenshots                    |
| `OutputFileFilenamePattern` | `REG_SZ`  | Filename pattern, e.g. `screenshot_{timestamp}`           |
| `CaptureMousepointer`     | `REG_DWORD` | `1` = include mouse cursor in screenshots                 |
| `Destinations`            | `REG_SZ`    | Comma-separated list of output destinations (file, clipboard, printer, etc.) |

### Startup entry (`HKCU\...\Run`)

| Key Name     | Type     | Description                                              |
|--------------|----------|----------------------------------------------------------|
| `Greenshot`  | `REG_SZ` | Path to `Greenshot.exe` — launches at Windows logon      |

### Uninstall entry (`HKLM\...\Uninstall\Greenshot_is1`)

| Key Name          | Type     | Description                                        |
|-------------------|----------|----------------------------------------------------|
| `DisplayName`     | `REG_SZ` | `Greenshot 1.3.274`                                |
| `DisplayVersion`  | `REG_SZ` | Installed version                                  |
| `Publisher`       | `REG_SZ` | `Greenshot`                                        |
| `UninstallString` | `REG_SZ` | Path to the Inno Setup uninstaller                 |

## 📝 Notes

- Greenshot runs in the system tray and registers global hotkeys (`Print Screen` by default). Hotkey bindings are stored in `HKCU\Software\Greenshot`.
- All settings are duplicated in `%APPDATA%\Greenshot\greenshot.ini` — the INI file is the authoritative source; registry settings sync from it.
- The startup run entry (`HKCU\...\Run\Greenshot`) is added by default during install; deselect "Start Greenshot at Windows startup" in Settings to remove it.
- Greenshot supports plugins (Jira, Confluence, Imgur uploaders) which may add subkeys under `HKCU\Software\Greenshot\Plugins`.

## 🗑️ Cleanup

```powershell
Remove-Item -Path "HKCU:\Software\Greenshot"  -Recurse -Force -ErrorAction SilentlyContinue
Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run" -Name "Greenshot" -ErrorAction SilentlyContinue

Get-ChildItem "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall" |
  Where-Object { $_.GetValue("DisplayName") -like "Greenshot*" } |
  ForEach-Object { Remove-Item $_.PSPath -Recurse -Force }
```
