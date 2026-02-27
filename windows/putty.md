---
tags:
  - ssh
  - terminal
  - HKCU
  - HKLM
  - msi-installer
  - network
description: >-
  Windows registry keys created by PuTTY — install paths, uninstall keys, HKCU and HKLM entries for sysadmin automation and cleanup.
---

# PuTTY

**Version tested:** 0.80
**Installer type:** `.msi` official installer from putty.org


## 📦 Package Managers

| Manager    | Install Command |
|------------|-----------------|
| winget     | `winget install PuTTY.PuTTY` |
| Chocolatey | `choco install putty` |
| Scoop      | `scoop install putty` |

## 📁 Registry Paths

- `HKEY_CURRENT_USER\Software\SimonTatham\PuTTY`
- `HKEY_CURRENT_USER\Software\SimonTatham\PuTTY\Sessions`
- `HKEY_CURRENT_USER\Software\SimonTatham\PuTTY\SshHostKeys`
- `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\PuTTY_is1` *(MSI installer only)*

## 🔑 Keys

### Default session settings (`HKCU\Software\SimonTatham\PuTTY\Sessions\Default%20Settings`)

| Key Name           | Type        | Description                                              |
|--------------------|-------------|----------------------------------------------------------|
| `HostName`         | `REG_SZ`    | Default hostname (empty = prompt on launch)             |
| `PortNumber`       | `REG_DWORD` | Default port (typically `22`)                           |
| `Protocol`         | `REG_SZ`    | Connection protocol: `ssh`, `telnet`, `rlogin`, `raw`   |
| `FontHeight`       | `REG_DWORD` | Terminal font size in points                            |
| `FontName`         | `REG_SZ`    | Terminal font (e.g., `Courier New`)                     |
| `Colour0`          | `REG_SZ`    | Default foreground color as `R,G,B`                     |
| `Colour2`          | `REG_SZ`    | Default background color as `R,G,B`                     |
| `WinTitle`         | `REG_SZ`    | Custom window title (empty = use hostname)              |
| `ScrollbackLines`  | `REG_DWORD` | Number of lines in the scrollback buffer                |
| `ProxyMethod`      | `REG_DWORD` | `0` = None, `1` = SOCKS4, `2` = SOCKS5, `3` = HTTP     |

### Saved sessions (`HKCU\Software\SimonTatham\PuTTY\Sessions\<session-name>`)

| Key Name           | Type        | Description                                              |
|--------------------|-------------|----------------------------------------------------------|
| `HostName`         | `REG_SZ`    | Remote server hostname or IP address                     |
| `PortNumber`       | `REG_DWORD` | Remote port                                             |
| `UserName`         | `REG_SZ`    | Default username (may be empty)                         |
| `PublicKeyFile`    | `REG_SZ`    | Path to `.ppk` private key file for key-based auth      |
| `RemoteCommand`    | `REG_SZ`    | Command to run on connect (empty = interactive shell)   |

### SSH host key cache (`HKCU\Software\SimonTatham\PuTTY\SshHostKeys`)

| Key Name                        | Type     | Description                                     |
|---------------------------------|----------|-------------------------------------------------|
| `<algorithm>@<port>:<hostname>` | `REG_SZ` | Cached server public key fingerprint (base64)   |

### Uninstall entry (`HKLM\...\Uninstall\PuTTY_is1`) — MSI installer only

| Key Name           | Type     | Description                                        |
|--------------------|----------|----------------------------------------------------|
| `DisplayName`      | `REG_SZ` | `PuTTY release 0.80`                              |
| `DisplayVersion`   | `REG_SZ` | Installed version (e.g., `0.80`)                  |
| `InstallLocation`  | `REG_SZ` | Root installation directory                        |
| `Publisher`        | `REG_SZ` | `Simon Tatham`                                    |

## 📝 Notes

- PuTTY is one of the heaviest registry users in this collection — every saved session is its own subkey with 100+ values (colors, terminal settings, SSH options).
- To migrate PuTTY sessions between machines, export `HKCU\Software\SimonTatham\PuTTY` and import on the target.
- ⚠️ PuTTY does **not** store passwords in the registry. Use Pageant (the SSH agent) or private key files (`.ppk`) for passwordless authentication.
- The SSH host key cache (`SshHostKeys`) is also shared by WinSCP and FileZilla when they use PuTTY's key format.
- The **standalone `.exe` version** creates all the same `HKCU` keys but leaves no uninstall entry in ARP.
- Session names with spaces are stored URL-encoded (spaces become `%20`) as key names.

## 🗑️ Cleanup

```powershell
Remove-Item -Path "HKCU:\Software\SimonTatham\PuTTY"         -Recurse -Force -ErrorAction SilentlyContinue
```
