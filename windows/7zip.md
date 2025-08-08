# 7-Zip

**Version tested:** 23.01  
**Installer type:** `.exe` from 7-zip.org

## 📁 Registry Paths

- `HKEY_CURRENT_USER\Software\7-Zip`
- `HKEY_LOCAL_MACHINE\SOFTWARE\7-Zip`

## 🔑 Keys

| Key Name           | Type        | Description                                |
|--------------------|-------------|--------------------------------------------|
| `Lang`             | `REG_SZ`    | Language setting (e.g., `en`)              |
| `FM\ShowHidden`    | `REG_DWORD` | Show hidden files in file manager (1=true) |
| `FM\SingleClick`   | `REG_DWORD` | Single-click to open files                 |
| `Path`             | `REG_SZ`    | Installation directory                     |

## 📝 Notes

- Admin installs store `Path` in `HKLM`, user settings go to `HKCU`.
- File context menu options are handled by shell extensions.
