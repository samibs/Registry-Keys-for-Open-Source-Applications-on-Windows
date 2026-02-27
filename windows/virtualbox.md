# Oracle VM VirtualBox

**Version tested:** 7.0.14
**Installer type:** `.exe` official installer from virtualbox.org

## 📁 Registry Paths

- `HKEY_LOCAL_MACHINE\SOFTWARE\Oracle\VirtualBox`
- `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Oracle VM VirtualBox <version>`
- `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\VBoxSup` *(kernel driver)*
- `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\VBoxNetAdp` *(host-only network adapter driver)*
- `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\VBoxNetLwf` *(lightweight network filter)*

## 🔑 Keys

### Installation entry (`HKLM\SOFTWARE\Oracle\VirtualBox`)

| Key Name         | Type     | Description                                               |
|------------------|----------|-----------------------------------------------------------|
| `InstallDir`     | `REG_SZ` | Root installation directory (e.g., `C:\Program Files\Oracle\VirtualBox`) |
| `Version`        | `REG_SZ` | Installed version string (e.g., `7.0.14`)                |

### Uninstall entry (`HKLM\...\Uninstall\Oracle VM VirtualBox <version>`)

| Key Name           | Type        | Description                                        |
|--------------------|-------------|----------------------------------------------------|
| `DisplayName`      | `REG_SZ`    | `Oracle VM VirtualBox 7.0.14`                     |
| `DisplayVersion`   | `REG_SZ`    | Installed version (e.g., `7.0.14`)                |
| `DisplayIcon`      | `REG_SZ`    | Path to `VirtualBox.exe`                          |
| `InstallLocation`  | `REG_SZ`    | Root installation directory                        |
| `Publisher`        | `REG_SZ`    | `Oracle Corporation`                              |
| `UninstallString`  | `REG_SZ`    | Path to the uninstaller                           |
| `URLInfoAbout`     | `REG_SZ`    | `https://www.virtualbox.org`                      |

### Kernel driver service (`HKLM\SYSTEM\...\Services\VBoxSup`)

| Key Name      | Type        | Description                                          |
|---------------|-------------|------------------------------------------------------|
| `Type`        | `REG_DWORD` | `1` — kernel-mode driver                            |
| `Start`       | `REG_DWORD` | `1` — loaded at system start                        |
| `ErrorControl`| `REG_DWORD` | `1` — normal error handling                         |
| `ImagePath`   | `REG_EXPAND_SZ` | Path to `VBoxSup.sys`                           |
| `DisplayName` | `REG_SZ`    | `VirtualBox Support Driver`                         |

## 📝 Notes

- All VMs, snapshots, and global settings are stored in `%USERPROFILE%\VirtualBox VMs\` and `%USERPROFILE%\.VirtualBox\VirtualBox.xml`, not the registry.
- VirtualBox installs several kernel-mode drivers (`VBoxSup`, `VBoxNetAdp`, `VBoxNetLwf`, `VBoxUSBMon`); each creates a corresponding `Services` key under `HKLM\SYSTEM\CurrentControlSet\Services`.
- The **Extension Pack** installs additional COM components but does not change the main registry path.
- Uninstalling VirtualBox does not automatically remove leftover network adapter entries in Device Manager; use VirtualBox's uninstaller or `VBoxNetAdpCtl` to clean up.
