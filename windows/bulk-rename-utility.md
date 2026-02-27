---
tags:
  - rename
  - file-management
  - portable
---

# Bulk Rename Utility

**Version:** 3.4.4.4  
**Installer:** `.exe` (setup) / Portable  
**Hives:** HKCU, HKLM

Bulk Rename Utility is a freeware file renaming utility for Windows. It supports regex, numbering, case changes, date stamps, and dozens of other transformations — all applied to batches of files or folders.

---

## 📁 Registry Paths

| Path | Hive | Description |
|------|------|-------------|
| `SOFTWARE\TBRU` | HKCU | Per-user preferences and saved filters |
| `SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\BulkRenameUtility` | HKLM | Uninstall entry |

---

## 🔑 Keys

### HKCU\SOFTWARE\TBRU

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `LastPath` | `REG_SZ` | `C:\Users\User\Documents\` | Last-browsed directory |
| `WindowPos` | `REG_BINARY` | `(binary)` | Saved window size and position |
| `ShowHidden` | `REG_DWORD` | `0` | Show hidden files in browser |
| `RegexMode` | `REG_DWORD` | `0` | Enable regex mode by default |
| `AutoPreview` | `REG_DWORD` | `1` | Show rename preview in real time |

### HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\BulkRenameUtility

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `DisplayName` | `REG_SZ` | `Bulk Rename Utility 3.4.4.4` | Display name |
| `DisplayVersion` | `REG_SZ` | `3.4.4.4` | Installed version |
| `Publisher` | `REG_SZ` | `TGRMN Software` | Publisher |
| `InstallLocation` | `REG_SZ` | `C:\Program Files\Bulk Rename Utility\` | Install path |
| `UninstallString` | `REG_SZ` | `"C:\Program Files\Bulk Rename Utility\uninstall.exe"` | Uninstall command |
| `URLInfoAbout` | `REG_SZ` | `https://www.bulkrenameutility.co.uk` | Product URL |

---

## 📝 Notes

- Saved rename presets are stored in `%APPDATA%\TGRMN Software\Bulk Rename Utility\` as XML files, not in the registry.
- The key path `HKCU\SOFTWARE\TBRU` uses the abbreviated internal name; no TGRMN parent key is created.
- Portable mode: copy `BulkRenameUtility.exe` to any folder; HKCU settings are still written, but no HKLM uninstall entry is created.
- Bulk Rename Utility does not register file associations or shell extensions by default.

---

## 🗑️ Cleanup

```reg
Windows Registry Editor Version 5.00

[-HKEY_CURRENT_USER\SOFTWARE\TBRU]
[-HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\BulkRenameUtility]
```

---

## 📦 Package Managers

| Manager | Install Command |
|---------|----------------|
| winget | `winget install TGRMNSoftware.BulkRenameUtility` |
| Chocolatey | `choco install bulkrenameutility` |
| Scoop | `scoop install bulk-rename-utility` |
