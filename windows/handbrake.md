---
tags:
  - video
  - transcoding
  - HKCU
  - HKLM
  - exe-installer
description: >-
  Windows registry keys created by HandBrake — install paths, uninstall keys, HKCU and HKLM entries for sysadmin automation and cleanup.
---

# HandBrake

**Version tested:** 1.7.3
**Installer type:** `.exe` official installer from handbrake.fr


## 📦 Package Managers

| Manager    | Install Command |
|------------|-----------------|
| winget     | `winget install HandBrake.HandBrake` |
| Chocolatey | `choco install handbrake` |
| Scoop      | `scoop install handbrake` |

## 📁 Registry Paths

- `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\HandBrake`

## 🔑 Keys

### Uninstall entry (`HKLM\...\Uninstall\HandBrake`)

| Key Name           | Type        | Description                                         |
|--------------------|-------------|-----------------------------------------------------|
| `DisplayName`      | `REG_SZ`    | `HandBrake 1.7.3`                                  |
| `DisplayVersion`   | `REG_SZ`    | Installed version (e.g., `1.7.3`)                  |
| `DisplayIcon`      | `REG_SZ`    | Path to `HandBrake.exe`                            |
| `InstallLocation`  | `REG_SZ`    | Root installation directory (e.g., `C:\Program Files\HandBrake`) |
| `Publisher`        | `REG_SZ`    | `HandBrake Team`                                   |
| `UninstallString`  | `REG_SZ`    | Path to the NSIS uninstaller                        |
| `URLInfoAbout`     | `REG_SZ`    | `https://handbrake.fr`                             |
| `NoModify`         | `REG_DWORD` | `1` — no modify option in ARP                      |
| `NoRepair`         | `REG_DWORD` | `1` — no repair option in ARP                      |

## 📝 Notes

- HandBrake has the smallest registry footprint of any app in this collection — only an uninstall entry is created.
- All user preferences (output format defaults, subtitle/audio tracks, preset library) are stored in `%AppData%\HandBrake\`, not the registry.
- The **portable version** (ZIP extract) creates no registry entries whatsoever.
- HandBrake relies on bundled codecs; it does not register any DirectShow or MFT filters in the registry.

## 🗑️ Cleanup

```powershell
Remove-Item -Path "HKCU:\Software\HandBrake"                 -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path "HKLM:\SOFTWARE\HandBrake"                 -Recurse -Force -ErrorAction SilentlyContinue
```
