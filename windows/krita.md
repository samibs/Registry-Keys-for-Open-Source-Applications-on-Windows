---
tags:
  - graphics
  - painting
  - creative
  - raster
---

# Krita

**Version:** 5.2.3  
**Installer:** `.exe` (setup) / Portable `.zip`  
**Hives:** HKCU, HKLM, HKCR

Krita is a free and open-source raster graphics editor designed primarily for digital painting and 2D animation. Popular among concept artists, illustrators, and comic creators.

---

## 📁 Registry Paths

| Path | Hive | Description |
|------|------|-------------|
| `SOFTWARE\KDE\Krita` | HKCU | Per-user preferences |
| `SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\krita` | HKLM | Uninstall entry |
| `.kra` | HKCR | Krita document file association |
| `.krz` | HKCR | Krita bundle file association |

---

## 🔑 Keys

### HKCU\SOFTWARE\KDE\Krita

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `InstallLocation` | `REG_SZ` | `C:\Program Files\Krita (x64)\` | Installation directory |
| `Version` | `REG_SZ` | `5.2.3` | Installed version |

### HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\krita

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `DisplayName` | `REG_SZ` | `Krita (x64) 5.2.3` | Display name |
| `DisplayVersion` | `REG_SZ` | `5.2.3` | Installed version |
| `Publisher` | `REG_SZ` | `Krita Foundation` | Publisher |
| `InstallLocation` | `REG_SZ` | `C:\Program Files\Krita (x64)\` | Install directory |
| `UninstallString` | `REG_SZ` | `"C:\Program Files\Krita (x64)\uninstall.exe"` | Uninstall command |
| `URLInfoAbout` | `REG_SZ` | `https://krita.org` | Product URL |

### HKCR\.kra

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `(Default)` | `REG_SZ` | `KritaDocument` | ProgID for Krita documents |

### HKCR\.krz

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `(Default)` | `REG_SZ` | `KritaBundle` | ProgID for Krita bundles |

---

## 📝 Notes

- Krita stores most settings in `%APPDATA%\krita\` (kritarc, brushes, resources) — not in the registry.
- The `HKCU\SOFTWARE\KDE\Krita` key is minimal, mainly holding the install path.
- Portable versions do not create registry entries (no file association, no uninstall entry).
- On 64-bit Windows, the path is `Krita (x64)`; a 32-bit build would use `Krita (x32)`.

---

## 🗑️ Cleanup

```reg
Windows Registry Editor Version 5.00

[-HKEY_CURRENT_USER\SOFTWARE\KDE\Krita]
[-HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\krita]
[-HKEY_CLASSES_ROOT\.kra]
[-HKEY_CLASSES_ROOT\.krz]
[-HKEY_CLASSES_ROOT\KritaDocument]
[-HKEY_CLASSES_ROOT\KritaBundle]
```

---

## 📦 Package Managers

| Manager | Install Command |
|---------|----------------|
| winget | `winget install KDE.Krita` |
| Chocolatey | `choco install krita` |
| Scoop | `scoop install krita` |
