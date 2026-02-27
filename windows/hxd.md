---
tags:
  - hex-editor
  - developer
  - portable
---

# HxD Hex Editor

**Version:** 2.5.0.0  
**Installer:** `.exe` (setup) / Portable  
**Hives:** HKCU, HKLM

HxD is a freeware hex editor that can handle files of any size, main memory (RAM), and raw disk/partition access. Widely used for low-level data analysis and forensics.

---

## 📁 Registry Paths

| Path | Hive | Description |
|------|------|-------------|
| `SOFTWARE\Maël Hörz\HxD` | HKCU | Per-user preferences and settings |
| `SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\HxD` | HKLM | Uninstall entry (setup version) |

---

## 🔑 Keys

### HKCU\SOFTWARE\Maël Hörz\HxD

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `Language` | `REG_SZ` | `English` | UI language |
| `ShowStatusBar` | `REG_DWORD` | `1` | Show status bar |
| `ColumnWidth` | `REG_DWORD` | `16` | Bytes per row in hex display |
| `DataInspectorVisible` | `REG_DWORD` | `1` | Show data inspector panel |
| `RecentFiles` | `REG_MULTI_SZ` | `(list)` | Recently opened files |

### HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\HxD

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `DisplayName` | `REG_SZ` | `HxD Hex Editor version 2.5.0.0` | Display name |
| `DisplayVersion` | `REG_SZ` | `2.5.0.0` | Installed version |
| `Publisher` | `REG_SZ` | `Maël Hörz` | Publisher |
| `InstallLocation` | `REG_SZ` | `C:\Program Files\HxD\` | Install directory |
| `UninstallString` | `REG_SZ` | `"C:\Program Files\HxD\HxDSetup.exe" /uninstall` | Uninstall command |

---

## 📝 Notes

- HxD can open raw disks and partitions (`\\.\PhysicalDrive0`, `\\.\C:`) — administrator elevation required.
- When editing main memory (RAM), HxD uses `OpenProcess` APIs — no special service or driver is installed.
- Portable version writes settings to the registry the same way as the setup version (HKCU only).
- The publisher name `Maël Hörz` contains a non-ASCII character — use exact spelling when querying the registry.

---

## 🗑️ Cleanup

```reg
Windows Registry Editor Version 5.00

[-HKEY_CURRENT_USER\SOFTWARE\Maël Hörz\HxD]
[-HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\HxD]
```

---

## 📦 Package Managers

| Manager | Install Command |
|---------|----------------|
| winget | `winget install MaelHoerz.HxD` |
| Chocolatey | `choco install hxd` |
| Scoop | `scoop install hxd` |
