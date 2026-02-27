---
tags:
  - api-client
  - developer-tools
  - HKCU
  - HKLM
  - HKCR
  - exe-installer
---

# Insomnia

**Version tested:** 9.3.3
**Installer type:** `.exe` official installer from insomnia.rest

## 📦 Package Managers

| Manager    | Install Command |
|------------|-----------------|
| winget     | `winget install Kong.Insomnia` |
| Chocolatey | `choco install insomnia-rest-api-client` |
| Scoop      | `scoop install insomnia` |

## 📁 Registry Paths

- `HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Uninstall\insomnia` *(user installer)*
- `HKEY_CLASSES_ROOT\insomnia` *(insomnia:// URI handler)*

## 🔑 Keys

### Uninstall entry (`HKCU\...\Uninstall\insomnia`)

| Key Name          | Type        | Description                                        |
|-------------------|-------------|----------------------------------------------------|
| `DisplayName`     | `REG_SZ`    | `Insomnia`                                         |
| `DisplayVersion`  | `REG_SZ`    | Installed version (e.g., `9.3.3`)                 |
| `DisplayIcon`     | `REG_SZ`    | Path to `Insomnia.exe`                             |
| `InstallLocation` | `REG_SZ`    | Root installation directory                        |
| `Publisher`       | `REG_SZ`    | `Kong`                                             |
| `UninstallString` | `REG_SZ`    | Path to the uninstaller                            |

### URI handler (`HKCR\insomnia`)

| Key Path                              | Type     | Description                                          |
|---------------------------------------|----------|------------------------------------------------------|
| `(Default)`                           | `REG_SZ` | `URL:Insomnia`                                       |
| `URL Protocol`                        | `REG_SZ` | Empty string — marks key as URL protocol handler     |
| `shell\open\command\(Default)`       | `REG_SZ` | `"C:\...\Insomnia.exe" "%1"`                         |

## 📝 Notes

- Insomnia installs to `%LOCALAPPDATA%\insomnia\` (user-scope). All registry entries are `HKCU` only.
- All data (requests, collections, environments) is stored in `%APPDATA%\Insomnia\` as a local SQLite database, with optional cloud sync when signed in.
- The `insomnia://` URI scheme supports deep links for opening specific requests or collections.
- Insomnia is Electron-based and auto-updates without registry changes.
- Kong acquired Insomnia in 2019; older releases may show `Insomnia REST Client` as the publisher name.

## 🗑️ Cleanup

```powershell
Remove-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\insomnia" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path "HKCR:\insomnia"  -Recurse -Force -ErrorAction SilentlyContinue
```
