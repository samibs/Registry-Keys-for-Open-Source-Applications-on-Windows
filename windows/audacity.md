# Audacity

**Version tested:** 3.4.2
**Installer type:** `.exe` official installer from audacityteam.org

## 📁 Registry Paths

- `HKEY_LOCAL_MACHINE\SOFTWARE\Audacity`
- `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Audacity`

## 🔑 Keys

### Installation entry (`HKLM\SOFTWARE\Audacity`)

| Key Name         | Type     | Description                                              |
|------------------|----------|----------------------------------------------------------|
| `InstallPath`    | `REG_SZ` | Root installation directory (e.g., `C:\Program Files\Audacity`) |
| `Version`        | `REG_SZ` | Installed version string (e.g., `3.4.2`)                |

### Uninstall entry (`HKLM\...\Uninstall\Audacity`)

| Key Name           | Type        | Description                                         |
|--------------------|-------------|-----------------------------------------------------|
| `DisplayName`      | `REG_SZ`    | `Audacity 3.4.2`                                   |
| `DisplayVersion`   | `REG_SZ`    | Installed version (e.g., `3.4.2`)                  |
| `DisplayIcon`      | `REG_SZ`    | Path to `audacity.exe`                             |
| `InstallLocation`  | `REG_SZ`    | Root installation directory                         |
| `Publisher`        | `REG_SZ`    | `Audacity Team`                                    |
| `UninstallString`  | `REG_SZ`    | Path to the uninstaller                            |
| `URLInfoAbout`     | `REG_SZ`    | `https://www.audacityteam.org`                     |
| `NoModify`         | `REG_DWORD` | `1` — no modify option in ARP                      |

## 📝 Notes

- All user preferences (sample rate, recording device, effect settings) are stored in `%APPDATA%\audacity\audacity.cfg`, not the registry.
- Audacity 3.x switched from the legacy `audacity.cfg` ini format to a SQLite-based project format (`.aup3`).
- On 32-bit Windows or older 32-bit builds, the key may appear under `HKLM\SOFTWARE\WOW6432Node\Audacity`.
- Audacity does not register file associations by default; `.aup3` association is optional during install.
