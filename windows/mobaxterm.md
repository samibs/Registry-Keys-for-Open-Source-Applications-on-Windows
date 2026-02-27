---
tags:
  - terminal
  - ssh
  - network
  - HKCU
  - HKLM
  - exe-installer
description: >-
  Windows registry keys created by MobaXterm — install paths, uninstall keys, HKCU and HKLM entries for sysadmin automation and cleanup.
---

# MobaXterm

**Version tested:** 23.6
**Installer type:** `.msi` official installer from mobaxterm.mobatek.net

## 📦 Package Managers

| Manager    | Install Command |
|------------|-----------------|
| winget     | `winget install Mobatek.MobaXterm` |
| Chocolatey | `choco install mobaxterm` |
| Scoop      | `scoop install mobaxterm` |

## 📁 Registry Paths

- `HKEY_LOCAL_MACHINE\SOFTWARE\Mobatek\MobaXterm`
- `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{<GUID>}` *(MSI uninstall entry)*
- `HKEY_CURRENT_USER\Software\Mobatek\MobaXterm` *(user settings, created at first launch)*

## 🔑 Keys

### Installation entry (`HKLM\SOFTWARE\Mobatek\MobaXterm`)

| Key Name      | Type     | Description                                              |
|---------------|----------|----------------------------------------------------------|
| `InstallDir`  | `REG_SZ` | Root installation directory                              |
| `Version`     | `REG_SZ` | Installed version string (e.g., `23.6`)                  |

### User settings (`HKCU\Software\Mobatek\MobaXterm`)

| Key Name              | Type        | Description                                               |
|-----------------------|-------------|-----------------------------------------------------------|
| `Sessions`            | Subkey      | Parent key containing saved SSH/RDP/FTP session profiles  |
| `Sessions\<name>\Arg` | `REG_SZ`    | Encoded session parameters (host, port, user, type)       |
| `LastSession`         | `REG_SZ`    | Name of the last used session                            |
| `WindowPos`           | `REG_BINARY`| Saved main window position and size                       |

### Uninstall entry (MSI)

| Key Name          | Type        | Description                                          |
|-------------------|-------------|------------------------------------------------------|
| `DisplayName`     | `REG_SZ`    | `MobaXterm 23.6`                                     |
| `DisplayVersion`  | `REG_SZ`    | Installed version                                    |
| `Publisher`       | `REG_SZ`    | `Mobatek`                                            |
| `UninstallString` | `REG_SZ`    | `MsiExec.exe /X{<GUID>}`                             |

## 📝 Notes

- MobaXterm stores all session profiles in `HKCU\Software\Mobatek\MobaXterm\Sessions`. The `Arg` value contains Base64-encoded session parameters.
- To **migrate sessions**, export `HKCU\Software\Mobatek\MobaXterm` and import on the target machine.
- The **portable version** (ZIP download) stores all configuration in `MobaXterm.ini` alongside the executable and creates no registry entries.
- MobaXterm Home Edition is free; Professional Edition requires a license key stored in `HKCU\Software\Mobatek\MobaXterm\License`.
- MobaXterm bundles a local terminal environment (Cygwin-based) under its installation directory — these binaries do not create additional registry entries.

## 🗑️ Cleanup

```powershell
Remove-Item -Path "HKCU:\Software\Mobatek\MobaXterm"  -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path "HKLM:\SOFTWARE\Mobatek\MobaXterm"  -Recurse -Force -ErrorAction SilentlyContinue

Get-ChildItem "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall" |
  Where-Object { $_.GetValue("DisplayName") -like "MobaXterm*" } |
  ForEach-Object { Remove-Item $_.PSPath -Recurse -Force }
```
