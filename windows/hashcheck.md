---
tags:
  - security
  - file
  - hash
  - shell-extension
---

# HashCheck Shell Extension

**Version:** 2.4.0  
**Installer:** `.exe` (setup)  
**Hives:** HKCU, HKLM, HKCR

HashCheck adds a **Checksums** tab to the Windows Explorer file Properties dialog, allowing verification of MD5, SHA-1, SHA-256, and CRC32 hashes without any separate application.

---

## 📁 Registry Paths

| Path | Hive | Description |
|------|------|-------------|
| `SOFTWARE\HashCheck` | HKCU | Per-user preferences |
| `SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\HashCheck` | HKLM | Uninstall entry |
| `CLSID\{B8F7B5E0-1A2C-4B8A-8FE3-A2D3B9C7E6F4}` | HKCR | COM class registration for the shell extension |
| `*\shellex\PropertySheetHandlers\HashCheck` | HKCR | Registers the Properties tab for all file types |

---

## 🔑 Keys

### HKCU\SOFTWARE\HashCheck

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `Checksum` | `REG_DWORD` | `2` | Default hash algorithm (0=MD5, 1=SHA1, 2=SHA256) |

### HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\HashCheck

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `DisplayName` | `REG_SZ` | `HashCheck Shell Extension` | Display name |
| `DisplayVersion` | `REG_SZ` | `2.4.0` | Installed version |
| `Publisher` | `REG_SZ` | `Christopher Gurnee` | Publisher |
| `InstallLocation` | `REG_SZ` | `C:\Program Files\HashCheck\` | Install directory |
| `UninstallString` | `REG_SZ` | `"C:\Program Files\HashCheck\uninstall.exe"` | Uninstall command |

### HKCR\*\shellex\PropertySheetHandlers\HashCheck

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `(Default)` | `REG_SZ` | `{B8F7B5E0-1A2C-4B8A-8FE3-A2D3B9C7E6F4}` | CLSID of the shell extension COM object |

---

## 📝 Notes

- HashCheck registers as a **shell property sheet handler** — it appears as a tab in the file Properties dialog for ALL file types.
- The COM object is registered in both `HKCU\SOFTWARE\Classes\CLSID\` and `HKCR\CLSID\` depending on whether it was installed per-user or machine-wide.
- To disable the Properties tab without uninstalling, rename the `HashCheck` value under `*\shellex\PropertySheetHandlers\`.
- The 64-bit build is required on 64-bit Windows to show in Explorer (32-bit shell extensions don't load in 64-bit Explorer).

---

## 🗑️ Cleanup

```reg
Windows Registry Editor Version 5.00

[-HKEY_CURRENT_USER\SOFTWARE\HashCheck]
[-HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\HashCheck]
[-HKEY_CLASSES_ROOT\*\shellex\PropertySheetHandlers\HashCheck]
```

Run the uninstaller to also remove the CLSID registration.

---

## 📦 Package Managers

| Manager | Install Command |
|---------|----------------|
| winget | `winget install gurnec.HashCheck` |
| Chocolatey | `choco install hashcheck` |
| Scoop | `scoop install hashcheck` |
