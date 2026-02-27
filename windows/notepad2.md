---
tags:
  - text-editor
  - HKLM
  - HKCR
  - exe-installer
description: >-
  Windows registry keys created by Notepad2 — install paths, uninstall keys, HKCU and HKLM entries for sysadmin automation and cleanup.
---

# Notepad2

**Version tested:** 4.23.04
**Installer type:** `.exe` unofficial installer / portable ZIP from notepad2.com (by Florian Balmer)

## 📦 Package Managers

| Manager    | Install Command |
|------------|-----------------|
| winget     | `winget install FlorianBalmer.Notepad2` |
| Chocolatey | `choco install notepad2` |
| Scoop      | `scoop install notepad2` |

## 📁 Registry Paths

- `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Notepad2` *(installer only)*
- `HKEY_CLASSES_ROOT\*\shell\Open with Notepad2` *(context menu, if registered)*

## 🔑 Keys

### Uninstall entry (`HKLM\...\Uninstall\Notepad2`) — installer only

| Key Name          | Type     | Description                                        |
|-------------------|----------|----------------------------------------------------|
| `DisplayName`     | `REG_SZ` | `Notepad2`                                         |
| `DisplayVersion`  | `REG_SZ` | Installed version (e.g., `4.23.04`)               |
| `InstallLocation` | `REG_SZ` | Root installation directory                        |
| `Publisher`       | `REG_SZ` | `Florian Balmer`                                   |
| `UninstallString` | `REG_SZ` | Path to the uninstaller                            |

### Context menu (`HKCR\*\shell\Open with Notepad2`) — if registered

| Key Path                              | Type     | Description                                              |
|---------------------------------------|----------|----------------------------------------------------------|
| `(Default)`                           | `REG_SZ` | Label shown in the context menu                          |
| `Icon`                                | `REG_SZ` | Path to `Notepad2.exe`                                   |
| `command\(Default)`                   | `REG_SZ` | `"C:\...\Notepad2.exe" "%1"`                             |

## 📝 Notes

- Notepad2 is designed to be a lightweight drop-in replacement for Windows Notepad. It can optionally **replace** the system `notepad.exe` via a registry redirect — this writes to `HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\notepad.exe`.
- All user preferences (syntax highlighting, font settings) are stored in `Notepad2.ini` alongside the executable — **no registry use for settings**.
- The **portable version** creates zero registry entries; settings are stored entirely in the INI file.
- **Notepad2-mod** (a popular fork) follows the same registry pattern.
- ⚠️ If Notepad2 replaces system Notepad via the Image File Execution Options redirect, standard `notepad.exe` invocations will launch Notepad2 instead. Revert with `Remove-Item "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\notepad.exe"`.

## 🗑️ Cleanup

```powershell
# Uninstall entry
Get-ChildItem "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall" |
  Where-Object { $_.GetValue("DisplayName") -like "Notepad2*" } |
  ForEach-Object { Remove-Item $_.PSPath -Recurse -Force }

# Context menu
Remove-Item -Path "HKCR:\*\shell\Open with Notepad2"  -Recurse -Force -ErrorAction SilentlyContinue

# Notepad.exe redirect (only if set)
Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\notepad.exe" -ErrorAction SilentlyContinue
```
