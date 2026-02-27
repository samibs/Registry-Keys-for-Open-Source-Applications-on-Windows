---
tags:
  - ftp
  - sftp
  - HKCU
  - HKLM
  - exe-installer
  - network
---

# FileZilla

**Version tested:** 3.66.5
**Installer type:** `.exe` official installer from filezilla-project.org


## 📦 Package Managers

| Manager    | Install Command |
|------------|-----------------|
| winget     | `winget install TimKosse.FileZilla.Client` |
| Chocolatey | `choco install filezilla` |
| Scoop      | `scoop install filezilla` |

## 📁 Registry Paths

- `HKEY_LOCAL_MACHINE\SOFTWARE\FileZilla Client`
- `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\FileZilla Client`

## 🔑 Keys

### Installation entry (`HKLM\SOFTWARE\FileZilla Client`)

| Key Name         | Type     | Description                                                    |
|------------------|----------|----------------------------------------------------------------|
| `(Default)`      | `REG_SZ` | Root installation path (e.g., `C:\Program Files\FileZilla FTP Client`) |
| `Version`        | `REG_SZ` | Installed version string (e.g., `3.66.5`)                     |

### Uninstall entry (`HKLM\...\Uninstall\FileZilla Client`)

| Key Name           | Type        | Description                                        |
|--------------------|-------------|----------------------------------------------------|
| `DisplayName`      | `REG_SZ`    | `FileZilla Client 3.66.5`                         |
| `DisplayVersion`   | `REG_SZ`    | Installed version (e.g., `3.66.5`)                |
| `DisplayIcon`      | `REG_SZ`    | Path to `filezilla.exe`                           |
| `InstallLocation`  | `REG_SZ`    | Root installation directory                        |
| `Publisher`        | `REG_SZ`    | `Tim Kosse`                                       |
| `UninstallString`  | `REG_SZ`    | Path to the uninstaller                           |
| `URLInfoAbout`     | `REG_SZ`    | `https://filezilla-project.org`                   |
| `NoModify`         | `REG_DWORD` | `1` — no modify option in ARP                     |
| `NoRepair`         | `REG_DWORD` | `1` — no repair option in ARP                     |

## 📝 Notes

- All user data (site manager, recent connections, transfer queue) is stored in `%APPDATA%\FileZilla\` as XML files (`sitemanager.xml`, `filezilla.xml`), not the registry.
- On 64-bit Windows the installer places a 64-bit binary; the registry path is `HKLM\SOFTWARE\FileZilla Client` without WOW6432Node.
- FileZilla does not store passwords in the registry; credentials in `sitemanager.xml` are obfuscated but **not encrypted** — treat that file as sensitive.
- The portable version of FileZilla does not create any registry entries.

## 🗑️ Cleanup

```powershell
Remove-Item -Path "HKCU:\Software\FileZilla3"                -Recurse -Force -ErrorAction SilentlyContinue
```
