# Inkscape

**Version tested:** 1.3.2
**Installer type:** `.exe` (NSIS installer) from inkscape.org

## 📁 Registry Paths

- `HKEY_LOCAL_MACHINE\SOFTWARE\Inkscape`
- `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Inkscape`

## 🔑 Keys

### Installation entry (`HKLM\SOFTWARE\Inkscape`)

| Key Name         | Type     | Description                                              |
|------------------|----------|----------------------------------------------------------|
| `InstallLocation`| `REG_SZ` | Root installation directory (e.g., `C:\Program Files\Inkscape`) |
| `CurrentVersion` | `REG_SZ` | Installed version string (e.g., `1.3.2`)               |

### Uninstall entry (`HKLM\...\Uninstall\Inkscape`)

| Key Name           | Type        | Description                                        |
|--------------------|-------------|----------------------------------------------------|
| `DisplayName`      | `REG_SZ`    | `Inkscape 1.3.2`                                  |
| `DisplayVersion`   | `REG_SZ`    | Installed version (e.g., `1.3.2`)                 |
| `DisplayIcon`      | `REG_SZ`    | Path to `inkscape.exe`                            |
| `InstallLocation`  | `REG_SZ`    | Root installation directory                        |
| `Publisher`        | `REG_SZ`    | `Inkscape`                                        |
| `UninstallString`  | `REG_SZ`    | Path to the NSIS uninstaller                       |
| `URLInfoAbout`     | `REG_SZ`    | `https://inkscape.org`                            |
| `NoModify`         | `REG_DWORD` | `1` — no modify option in ARP                     |

## 📝 Notes

- User preferences and configuration are stored in `%APPDATA%\inkscape\` (e.g., `preferences.xml`), not the registry.
- SVG file associations (`.svg`, `.svgz`) are registered under `HKLM\SOFTWARE\Classes` during installation if the user opts in.
- On a 64-bit Windows system, Inkscape 1.x is natively 64-bit; no WOW6432Node redirect is used.
- The portable ZIP distribution does not create any registry entries.
