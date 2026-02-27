---
tags:
  - utilities
  - productivity
  - HKCU
  - HKLM
  - HKCR
  - exe-installer
description: >-
  Windows registry keys created by Microsoft PowerToys — install paths, uninstall keys, HKCU and HKLM entries for sysadmin automation and cleanup.
---

# Microsoft PowerToys

**Version tested:** 0.79.0
**Installer type:** `.exe` official installer from github.com/microsoft/PowerToys

## 📦 Package Managers

| Manager    | Install Command |
|------------|-----------------|
| winget     | `winget install Microsoft.PowerToys` |
| Chocolatey | `choco install powertoys` |
| Scoop      | `scoop install powertoys` |

## 📁 Registry Paths

- `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PowerToys` *(system install)*
- `HKEY_CURRENT_USER\Software\Microsoft\PowerToys` *(per-user install)*
- `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft PowerToys - x64`
- `HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run` *(startup entry)*

## 🔑 Keys

### Installation entry (`HKLM\SOFTWARE\Microsoft\PowerToys`)

| Key Name         | Type     | Description                                              |
|------------------|----------|----------------------------------------------------------|
| `InstallationDir`| `REG_SZ` | Root installation directory                              |
| `Version`        | `REG_SZ` | Installed version (e.g., `0.79.0`)                      |

### Startup entry (`HKCU\...\Run`)

| Key Name      | Type     | Description                                                    |
|---------------|----------|----------------------------------------------------------------|
| `PowerToys`   | `REG_SZ` | Path to `PowerToys.exe` — launches in system tray at logon    |

### Uninstall entry

| Key Name          | Type        | Description                                          |
|-------------------|-------------|------------------------------------------------------|
| `DisplayName`     | `REG_SZ`    | `Microsoft PowerToys - x64`                          |
| `DisplayVersion`  | `REG_SZ`    | Installed version (e.g., `0.79.0`)                   |
| `Publisher`       | `REG_SZ`    | `Microsoft Corporation`                              |
| `InstallLocation` | `REG_SZ`    | Root installation directory                          |
| `UninstallString` | `REG_SZ`    | Path to the uninstaller                              |

## 📝 Notes

- PowerToys is a collection of utilities (FancyZones, PowerRename, Color Picker, File Locksmith, etc.). Each utility stores its settings in `%LOCALAPPDATA%\Microsoft\PowerToys\<UtilityName>\settings.json`.
- **FancyZones** layout templates are stored in `%LOCALAPPDATA%\Microsoft\PowerToys\FancyZones\zones-settings.json` — not the registry.
- The startup run entry (`HKCU\...\Run\PowerToys`) can be toggled in PowerToys Settings → General → "Launch at startup".
- PowerToys may register low-level keyboard hooks and shell extensions; these use COM registration under `HKCR\CLSID\{...}` with CLSIDs specific to the installed version.
- **Per-user vs system install**: admin installs write to `HKLM`; per-user installs (default for non-admin) write to `HKCU`.

## 🗑️ Cleanup

```powershell
# Startup entry
Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run" -Name "PowerToys" -ErrorAction SilentlyContinue

# Installation entries
Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\PowerToys"  -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path "HKCU:\Software\Microsoft\PowerToys"  -Recurse -Force -ErrorAction SilentlyContinue

# Uninstall entry
Get-ChildItem "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall" |
  Where-Object { $_.GetValue("DisplayName") -like "Microsoft PowerToys*" } |
  ForEach-Object { Remove-Item $_.PSPath -Recurse -Force }
```
