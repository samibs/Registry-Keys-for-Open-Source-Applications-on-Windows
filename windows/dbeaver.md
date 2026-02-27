---
tags:
  - database
  - HKCU
  - HKLM
  - exe-installer
  - developer-tools
---

# DBeaver Community Edition

**Version tested:** 24.0.0
**Installer type:** `.exe` official installer from dbeaver.io

## 📦 Package Managers

| Manager    | Install Command |
|------------|-----------------|
| winget     | `winget install dbeaver.dbeaver` |
| Chocolatey | `choco install dbeaver` |
| Scoop      | `scoop install dbeaver` |

## 📁 Registry Paths

- `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\DBeaver Community_is1`
- `HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Uninstall\DBeaver Community_is1` *(per-user install)*

## 🔑 Keys

### Uninstall entry (`HKLM\...\Uninstall\DBeaver Community_is1`)

| Key Name          | Type        | Description                                          |
|-------------------|-------------|------------------------------------------------------|
| `DisplayName`     | `REG_SZ`    | `DBeaver Community 24.0.0`                           |
| `DisplayVersion`  | `REG_SZ`    | Installed version (e.g., `24.0.0`)                   |
| `DisplayIcon`     | `REG_SZ`    | Path to `dbeaver.exe`                                |
| `InstallLocation` | `REG_SZ`    | Root installation directory                          |
| `Publisher`       | `REG_SZ`    | `DBeaver Corp`                                       |
| `UninstallString` | `REG_SZ`    | Path to the Inno Setup uninstaller                   |
| `NoModify`        | `REG_DWORD` | `1` — no modify button in ARP                        |

## 📝 Notes

- DBeaver is an Eclipse RCP application. Nearly **all configuration is stored in the workspace**, not the registry.
- The default workspace is at `%USERPROFILE%\AppData\Roaming\DBeaverData\workspace6\` — this contains connection profiles (encrypted), SQL scripts, ER diagrams, and Eclipse platform settings.
- Connection passwords are encrypted using a workspace-specific key stored in `%USERPROFILE%\AppData\Roaming\DBeaverData\.secret`.
- The only registry presence is the uninstall entry; DBeaver itself reads no values from the registry at runtime.
- **Admin vs per-user install**: Admin installs write to `HKLM`, per-user installs write the identical structure to `HKCU`.
- DBeaver supports 80+ database engines via JDBC drivers; drivers are downloaded on demand to `%USERPROFILE%\.dbeaver-drivers\`.

## 🗑️ Cleanup

```powershell
# System install (run as Administrator)
Get-ChildItem "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall" |
  Where-Object { $_.GetValue("DisplayName") -like "DBeaver*" } |
  ForEach-Object { Remove-Item $_.PSPath -Recurse -Force }

# Per-user install
Get-ChildItem "HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall" |
  Where-Object { $_.GetValue("DisplayName") -like "DBeaver*" } |
  ForEach-Object { Remove-Item $_.PSPath -Recurse -Force }
```
