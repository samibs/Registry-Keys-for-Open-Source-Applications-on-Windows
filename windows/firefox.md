# Mozilla Firefox

**Version tested:** 123.0
**Installer type:** `.exe` official full installer from mozilla.org

## 📁 Registry Paths

- `HKEY_LOCAL_MACHINE\SOFTWARE\Mozilla\Mozilla Firefox`
- `HKEY_LOCAL_MACHINE\SOFTWARE\Mozilla\Mozilla Firefox\<version> (x64 en-US)\Main`
- `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Mozilla Firefox <version> (x64 en-US)`
- `HKEY_CURRENT_USER\Software\Mozilla\Mozilla Firefox` *(created at first launch)*

## 🔑 Keys

### Application root (`HKLM\SOFTWARE\Mozilla\Mozilla Firefox`)

| Key Name         | Type     | Description                                           |
|------------------|----------|-------------------------------------------------------|
| `CurrentVersion` | `REG_SZ` | Installed version string (e.g., `123.0 (x64 en-US)`) |

### Version/Main subkey (`HKLM\SOFTWARE\Mozilla\Mozilla Firefox\<version>\Main`)

| Key Name              | Type     | Description                                              |
|-----------------------|----------|----------------------------------------------------------|
| `Install Directory`   | `REG_SZ` | Root installation path (e.g., `C:\Program Files\Mozilla Firefox`) |
| `PathToExe`           | `REG_SZ` | Full path to `firefox.exe`                              |

### Uninstall entry (`HKLM\...\Uninstall\Mozilla Firefox <version> (x64 en-US)`)

| Key Name           | Type        | Description                                         |
|--------------------|-------------|-----------------------------------------------------|
| `DisplayName`      | `REG_SZ`    | `Mozilla Firefox 123.0 (x64 en-US)`               |
| `DisplayVersion`   | `REG_SZ`    | Installed version (e.g., `123.0`)                  |
| `DisplayIcon`      | `REG_SZ`    | Path to `firefox.exe`                              |
| `InstallLocation`  | `REG_SZ`    | Root installation directory                         |
| `Publisher`        | `REG_SZ`    | `Mozilla`                                          |
| `UninstallString`  | `REG_SZ`    | Path to the uninstaller with `/S` for silent mode  |
| `URLInfoAbout`     | `REG_SZ`    | `https://www.mozilla.org`                          |

## 📝 Notes

- All user data (bookmarks, history, extensions, preferences) is stored in the Firefox profile at `%APPDATA%\Mozilla\Firefox\Profiles\`, not the registry.
- The version-specific subkey path changes with every update (e.g., `123.0 (x64 en-US)` → `124.0 (x64 en-US)`); query `CurrentVersion` to find the active path.
- Enterprise policy settings can be pushed via `HKLM\SOFTWARE\Policies\Mozilla\Firefox` — see [Firefox Enterprise Policies](https://github.com/mozilla/policy-templates).
- The 32-bit installer on 64-bit Windows places keys under `HKLM\SOFTWARE\WOW6432Node\Mozilla`.
- The **MSI** enterprise installer uses the same registry structure but allows per-machine deployment via Group Policy.
