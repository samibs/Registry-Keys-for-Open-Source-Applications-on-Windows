---
tags:
  - image-editing
  - HKCU
  - HKLM
  - exe-installer
---

# GIMP

**Version tested:** 2.10.36
**Installer type:** `.exe` official installer from gimp.org


## 📦 Package Managers

| Manager    | Install Command |
|------------|-----------------|
| winget     | `winget install GIMP.GIMP` |
| Chocolatey | `choco install gimp` |
| Scoop      | `scoop install gimp` |

## 📁 Registry Paths

- `HKEY_LOCAL_MACHINE\SOFTWARE\GIMP\2.0`
- `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\GIMP-2_is1`

## 🔑 Keys

### Installation entry (`HKLM\SOFTWARE\GIMP\2.0`)

| Key Name       | Type     | Description                                        |
|----------------|----------|----------------------------------------------------|
| `InstallDir`   | `REG_SZ` | Root installation directory (e.g., `C:\Program Files\GIMP 2`) |
| `Version`      | `REG_SZ` | Installed version string (e.g., `2.10.36`)        |

### Uninstall entry (`HKLM\...\Uninstall\GIMP-2_is1`)

| Key Name           | Type        | Description                                       |
|--------------------|-------------|---------------------------------------------------|
| `DisplayName`      | `REG_SZ`    | `GIMP 2.10.36`                                   |
| `DisplayVersion`   | `REG_SZ`    | Installed version (e.g., `2.10.36`)              |
| `DisplayIcon`      | `REG_SZ`    | Path to `gimp-2.10.exe`                          |
| `InstallLocation`  | `REG_SZ`    | Root installation directory                       |
| `Publisher`        | `REG_SZ`    | `The GIMP Team`                                  |
| `UninstallString`  | `REG_SZ`    | Path to the Inno Setup uninstaller                |
| `EstimatedSize`    | `REG_DWORD` | Estimated install size in KB                     |

## 📝 Notes

- GIMP stores all user configuration in `%APPDATA%\GIMP\2.0\` (e.g., brushes, palettes, plug-in settings, `gimprc`), not the registry.
- On 64-bit Windows the keys appear under `HKLM\SOFTWARE\GIMP\2.0`; there is no WOW6432Node redirect because the official build is 64-bit.
- GIMP 3.x uses a different installer and registry path (`HKLM\SOFTWARE\GIMP\3.0`); document separately when stable.
- File associations (`.xcf`, `.psd`, etc.) are registered under `HKLM\SOFTWARE\Classes` at install time.

## 🗑️ Cleanup

```powershell
Remove-Item -Path "HKCU:\Software\GIMP"                      -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path "HKLM:\SOFTWARE\GIMP"                      -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path "HKLM:\SOFTWARE\WOW6432Node\GIMP"          -Recurse -Force -ErrorAction SilentlyContinue
```
