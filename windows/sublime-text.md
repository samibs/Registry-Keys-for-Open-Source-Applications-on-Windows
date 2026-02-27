---
tags:
  - text-editor
  - HKLM
  - HKCR
  - exe-installer
  - developer-tools
---

# Sublime Text

**Version tested:** 4.0 (Build 4169)
**Installer type:** `.exe` official installer from sublimetext.com

## 📦 Package Managers

| Manager    | Install Command |
|------------|-----------------|
| winget     | `winget install SublimeHQ.SublimeText.4` |
| Chocolatey | `choco install sublimetext4` |
| Scoop      | `scoop install sublime-text` |

## 📁 Registry Paths

- `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Sublime Text_is1`
- `HKEY_CLASSES_ROOT\sublime_auto_file` *(file handler ProgID)*
- `HKEY_CLASSES_ROOT\*\shell\Open with Sublime Text` *(context menu — "Open with Sublime Text")*

## 🔑 Keys

### Uninstall entry (`HKLM\...\Uninstall\Sublime Text_is1`)

| Key Name          | Type        | Description                                        |
|-------------------|-------------|----------------------------------------------------|
| `DisplayName`     | `REG_SZ`    | `Sublime Text`                                     |
| `DisplayVersion`  | `REG_SZ`    | Build number (e.g., `4169`)                        |
| `DisplayIcon`     | `REG_SZ`    | Path to `sublime_text.exe`                         |
| `InstallLocation` | `REG_SZ`    | Root installation directory                        |
| `Publisher`       | `REG_SZ`    | `Sublime HQ Pty Ltd`                              |
| `UninstallString` | `REG_SZ`    | Path to the Inno Setup uninstaller                 |

### Context menu (`HKCR\*\shell\Open with Sublime Text`)

| Key Name                              | Type     | Description                                              |
|---------------------------------------|----------|----------------------------------------------------------|
| `(Default)`                           | `REG_SZ` | Label shown in the context menu                          |
| `Icon`                                | `REG_SZ` | Path to `sublime_text.exe` for the menu icon             |
| `command\(Default)`                   | `REG_SZ` | `"C:\...\sublime_text.exe" "%1"`                         |

## 📝 Notes

- All user settings (key bindings, color schemes, packages) are in `%APPDATA%\Sublime Text\Packages\User\`, not the registry.
- Sublime Text is a **paid application** but free to evaluate indefinitely (purchase removes the nag prompt). The registry structure is identical for licensed and unlicensed installs.
- The **portable version** stores all settings in the `Data\` folder alongside the executable and creates no registry entries.
- Package Control (the third-party package manager) installs packages to `%APPDATA%\Sublime Text\Packages\` — no registry involvement.
- The context menu entry `Open with Sublime Text` is added to `HKCR\*\shell` (all file types) during installation.

## 🗑️ Cleanup

```powershell
Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Sublime Text_is1" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path "HKCR:\sublime_auto_file"                                                     -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path "HKCR:\*\shell\Open with Sublime Text"                                        -Recurse -Force -ErrorAction SilentlyContinue
```
