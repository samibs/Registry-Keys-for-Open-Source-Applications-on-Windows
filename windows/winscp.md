# WinSCP

**Version tested:** 6.3.3
**Installer type:** `.exe` official installer from winscp.net

## 📁 Registry Paths

- `HKEY_CURRENT_USER\Software\Martin Prikryl\WinSCP 2`
- `HKEY_CURRENT_USER\Software\Martin Prikryl\WinSCP 2\Configuration`
- `HKEY_CURRENT_USER\Software\Martin Prikryl\WinSCP 2\Sessions`
- `HKEY_LOCAL_MACHINE\SOFTWARE\Martin Prikryl\WinSCP 2`
- `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\winscp3_is1`

## 🔑 Keys

### Installation entry (`HKLM\SOFTWARE\Martin Prikryl\WinSCP 2`)

| Key Name      | Type     | Description                                           |
|---------------|----------|-------------------------------------------------------|
| `InstallDir`  | `REG_SZ` | Root installation directory                           |

### Global configuration (`HKCU\Software\Martin Prikryl\WinSCP 2\Configuration`)

| Key Name               | Type        | Description                                           |
|------------------------|-------------|-------------------------------------------------------|
| `Version`              | `REG_SZ`    | Last-used version of WinSCP                          |
| `DefaultTransferMode`  | `REG_DWORD` | `0` = Binary, `1` = Text, `2` = Automatic            |
| `Interface\Theme`      | `REG_DWORD` | UI theme selection                                    |
| `Interface\LocalPanel` | `REG_DWORD` | `1` = show local panel (Commander interface)         |

### Saved sessions (`HKCU\Software\Martin Prikryl\WinSCP 2\Sessions\<session-name>`)

| Key Name         | Type        | Description                                              |
|------------------|-------------|----------------------------------------------------------|
| `HostName`       | `REG_SZ`    | Remote server hostname or IP address                     |
| `UserName`       | `REG_SZ`    | Login username                                           |
| `Password`       | `REG_SZ`    | Obfuscated (NOT encrypted) stored password               |
| `PortNumber`     | `REG_DWORD` | Remote port (default: `22` for SSH/SFTP)                |
| `FSProtocol`     | `REG_DWORD` | `0` = SFTP, `2` = SCP, `5` = FTP, `6` = WebDAV         |
| `RemoteDirectory`| `REG_SZ`    | Default remote path after login                         |
| `Color`          | `REG_DWORD` | Session tab color for visual identification             |

### Uninstall entry (`HKLM\...\Uninstall\winscp3_is1`)

| Key Name           | Type        | Description                                        |
|--------------------|-------------|----------------------------------------------------|
| `DisplayName`      | `REG_SZ`    | `WinSCP 6.3.3`                                    |
| `DisplayVersion`   | `REG_SZ`    | Installed version (e.g., `6.3.3`)                 |
| `InstallLocation`  | `REG_SZ`    | Root installation directory                        |
| `Publisher`        | `REG_SZ`    | `Martin Prikryl`                                  |
| `UninstallString`  | `REG_SZ`    | Path to the Inno Setup uninstaller                 |

## 📝 Notes

- ⚠️ **Security warning**: The `Password` value under each session is **obfuscated, not encrypted**. Anyone with read access to `HKCU` can recover stored passwords. Export or backup this key with caution.
- WinSCP uses the registry as its primary config store (unlike most apps in this collection); exporting `HKCU\Software\Martin Prikryl\WinSCP 2` is the standard way to migrate settings between machines.
- The **portable version** stores all configuration in `WinSCP.ini` alongside the executable and does not create any registry entries.
- SSH host key fingerprints are stored under `HKCU\Software\SimonTatham\PuTTY\SshHostKeys` if PuTTY is installed; otherwise WinSCP creates its own subkey for host key storage.
