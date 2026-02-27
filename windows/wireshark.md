# Wireshark

**Version tested:** 4.2.3
**Installer type:** `.exe` official installer from wireshark.org

## 📁 Registry Paths

- `HKEY_LOCAL_MACHINE\SOFTWARE\Wireshark`
- `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Wireshark`
- `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Npcap` *(packet capture driver)*

## 🔑 Keys

### Installation entry (`HKLM\SOFTWARE\Wireshark`)

| Key Name      | Type     | Description                                               |
|---------------|----------|-----------------------------------------------------------|
| `InstallDir`  | `REG_SZ` | Root installation directory (e.g., `C:\Program Files\Wireshark`) |

### Uninstall entry (`HKLM\...\Uninstall\Wireshark`)

| Key Name           | Type        | Description                                        |
|--------------------|-------------|----------------------------------------------------|
| `DisplayName`      | `REG_SZ`    | `Wireshark 4.2.3 64-bit`                          |
| `DisplayVersion`   | `REG_SZ`    | Installed version (e.g., `4.2.3`)                 |
| `DisplayIcon`      | `REG_SZ`    | Path to `Wireshark.exe`                           |
| `InstallLocation`  | `REG_SZ`    | Root installation directory                        |
| `Publisher`        | `REG_SZ`    | `The Wireshark developer community`               |
| `UninstallString`  | `REG_SZ`    | Path to the NSIS uninstaller                       |
| `URLInfoAbout`     | `REG_SZ`    | `https://www.wireshark.org`                       |

### Npcap uninstall entry (`HKLM\...\Uninstall\Npcap`)

| Key Name           | Type     | Description                                              |
|--------------------|----------|----------------------------------------------------------|
| `DisplayName`      | `REG_SZ` | `Npcap <version>`                                       |
| `DisplayVersion`   | `REG_SZ` | Npcap version (separate from Wireshark version)         |
| `InstallLocation`  | `REG_SZ` | Npcap installation directory (typically `C:\Windows\System32\Npcap`) |
| `Publisher`        | `REG_SZ` | `Nmap Project`                                          |

## 📝 Notes

- Wireshark installs **Npcap** (formerly WinPcap) as a separate component for raw packet capture. Npcap has its own registry entries and kernel driver (`HKLM\SYSTEM\CurrentControlSet\Services\npcap`).
- All user preferences (color rules, column layouts, capture filters, display filters) are stored in `%APPDATA%\Wireshark\`, not the registry.
- The Npcap kernel driver service key (`HKLM\SYSTEM\CurrentControlSet\Services\npcap`) controls the WFP callout driver for packet capture; do not delete it manually.
- Wireshark registers `.pcap` and `.pcapng` file associations under `HKLM\SOFTWARE\Classes` during install.
- Running Wireshark **without admin rights** is possible if the user is in the `Npcap` group (Npcap installer option); no additional registry changes are needed for this.
