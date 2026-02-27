# Notepad++

**Version tested:** 8.6.2
**Installer type:** `.exe` (NSIS installer) from notepad-plus-plus.org

## 📁 Registry Paths

- `HKEY_LOCAL_MACHINE\SOFTWARE\Notepad++`
- `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Notepad++`
- `HKEY_CURRENT_USER\Software\Notepad++` *(created at first launch)*

## 🔑 Keys

### Installation entry (`HKLM\SOFTWARE\Notepad++`)

| Key Name      | Type     | Description                                    |
|---------------|----------|------------------------------------------------|
| `(Default)`   | `REG_SZ` | Root installation path (e.g., `C:\Program Files\Notepad++`) |

### Uninstall entry (`HKLM\...\Uninstall\Notepad++`)

| Key Name           | Type        | Description                                     |
|--------------------|-------------|-------------------------------------------------|
| `DisplayName`      | `REG_SZ`    | `Notepad++ (32-bit x86)` or `(64-bit x64)`     |
| `DisplayVersion`   | `REG_SZ`    | Installed version (e.g., `8.6.2`)              |
| `DisplayIcon`      | `REG_SZ`    | Path to `notepad++.exe`                         |
| `InstallLocation`  | `REG_SZ`    | Root installation directory                     |
| `Publisher`        | `REG_SZ`    | `Notepad++ Team`                                |
| `UninstallString`  | `REG_SZ`    | Path to `uninstall.exe`                         |
| `NoModify`         | `REG_DWORD` | `1` — no modify option in ARP                  |
| `NoRepair`         | `REG_DWORD` | `1` — no repair option in ARP                  |

### User preferences (`HKCU\Software\Notepad++`) — created at first launch

| Key Name      | Type     | Description                                               |
|---------------|----------|-----------------------------------------------------------|
| `(Default)`   | `REG_SZ` | Typically empty; presence confirms app has been launched  |

## 📝 Notes

- All user preferences (recent files, language settings, themes, plugin config) are stored in `%APPDATA%\Notepad++\` as XML files, not in the registry.
- The 64-bit installer places keys under `HKLM\SOFTWARE\Notepad++`; 32-bit on a 64-bit Windows will use `HKLM\SOFTWARE\WOW6432Node\Notepad++`.
- Shell context menu entries ("Edit with Notepad++") are registered under `HKCU\Software\Classes\*\shell\Notepad++` (per-user) or `HKLM\SOFTWARE\Classes\*\shell\Notepad++` (system-wide), depending on install options.
