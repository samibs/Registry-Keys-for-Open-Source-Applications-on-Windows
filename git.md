# Git for Windows

**Version tested:** 2.44.0  
**Installer type:** `.exe` official Git for Windows

## 📁 Registry Paths

- `HKEY_LOCAL_MACHINE\SOFTWARE\GitForWindows`
- `HKEY_CURRENT_USER\Software\GitForWindows`

## 🔑 Keys

| Key Name       | Type      | Description                             |
|----------------|-----------|-----------------------------------------|
| `InstallPath`  | `REG_SZ`  | Base installation directory             |
| `CurrentVersion` | `REG_SZ` | Installed version number                |

## 📝 Notes

- Git’s shell integration (e.g., Bash Here) is configured via shell extension registry entries.
- Git config (user/email/etc.) is not stored in the registry but in the `.gitconfig` file.
