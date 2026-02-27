# OBS Studio

**Version tested:** 30.0.2
**Installer type:** `.exe` official installer from obsproject.com

## 📁 Registry Paths

- `HKEY_LOCAL_MACHINE\SOFTWARE\OBS Studio`
- `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\OBS Studio`

## 🔑 Keys

### Installation entry (`HKLM\SOFTWARE\OBS Studio`)

| Key Name      | Type     | Description                                               |
|---------------|----------|-----------------------------------------------------------|
| `(Default)`   | `REG_SZ` | Root installation directory (e.g., `C:\Program Files\obs-studio`) |

### Uninstall entry (`HKLM\...\Uninstall\OBS Studio`)

| Key Name           | Type        | Description                                         |
|--------------------|-------------|-----------------------------------------------------|
| `DisplayName`      | `REG_SZ`    | `OBS Studio`                                       |
| `DisplayVersion`   | `REG_SZ`    | Installed version (e.g., `30.0.2`)                 |
| `DisplayIcon`      | `REG_SZ`    | Path to `obs64.exe`                                |
| `InstallLocation`  | `REG_SZ`    | Root installation directory                         |
| `Publisher`        | `REG_SZ`    | `OBS Project`                                      |
| `UninstallString`  | `REG_SZ`    | Path to the NSIS uninstaller                        |
| `URLInfoAbout`     | `REG_SZ`    | `https://obsproject.com`                           |
| `NoModify`         | `REG_DWORD` | `1` — no modify option in ARP                      |
| `NoRepair`         | `REG_DWORD` | `1` — no repair option in ARP                      |

## 📝 Notes

- OBS Studio has a very small registry footprint. All user configuration (scenes, sources, audio/video settings, profiles, stream keys) is stored in `%APPDATA%\obs-studio\`, not the registry.
- The **portable mode** (extracting the ZIP release) creates no registry entries at all.
- Virtual Camera driver (`OBS-Camera`) registers a DirectShow filter under `HKLM\SOFTWARE\Classes\CLSID\` and a kernel driver under `HKLM\SYSTEM\CurrentControlSet\Services\OBSVirtualCam` when the Virtual Camera feature is installed.
- Browser source (CEF) and other plugins do not add additional top-level registry keys.
