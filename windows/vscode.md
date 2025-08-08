# Visual Studio Code

**Version tested:** 1.85.1
**Installer type:** User Installer `.exe`

## 📁 Registry Paths

- `HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft VS Code`
- `HKEY_CURRENT_USER\Software\Classes\vscode`

## 🔑 Keys

| Key Name      | Type        | Description                               |
|---------------|-------------|-------------------------------------------|
| `DisplayIcon` | `REG_SZ`    | Path to the application icon.             |
| `DisplayName` | `REG_SZ`    | The display name of the application.      |
| `InstallLocation`| `REG_SZ` | The installation directory of VS Code.    |
| `Publisher`   | `REG_SZ`    | The publisher of the application.         |
| `DisplayVersion`| `REG_SZ`  | The version of the application.           |

## 📝 Notes

- This information is for the user-level installation. The system-level installation might store keys in `HKEY_LOCAL_MACHINE`.
- The registry keys listed here are for uninstallation purposes and basic application information. More configuration-related keys might be stored elsewhere.
- **This file is a placeholder and the information needs to be verified.**
