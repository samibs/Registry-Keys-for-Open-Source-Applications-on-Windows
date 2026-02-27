---
tags:
  - privacy
  - cleaning
  - maintenance
  - system
---

# BleachBit

**Version documented:** 4.6.2
**Installer type:** `.exe` (NSIS) / Portable
**Hives written:** HKCU, HKLM

---

## 📁 Registry Paths

| Path | Hive | Purpose |
|------|------|---------|
| `SOFTWARE\BleachBit` | HKLM | Installation metadata |
| `SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\BleachBit` | HKLM | Uninstall entry |
| `SOFTWARE\Microsoft\Windows\CurrentVersion\Run` | HKCU | Startup entry (if scheduled) |

---

## 🔑 Keys

### HKLM\SOFTWARE\BleachBit

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `InstallDir` | REG_SZ | `C:\Program Files (x86)\BleachBit` | Installation directory |
| `Version` | REG_SZ | `4.6.2` | Installed version |

### HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\BleachBit

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `DisplayName` | REG_SZ | `BleachBit 4.6.2` | Display name |
| `DisplayVersion` | REG_SZ | `4.6.2` | Version |
| `Publisher` | REG_SZ | `Andrew Ziem` | Publisher |
| `InstallLocation` | REG_SZ | `C:\Program Files (x86)\BleachBit` | Install path |
| `UninstallString` | REG_SZ | `"...\unins000.exe"` | Uninstaller |

---

## 📝 Notes

- BleachBit's own settings are stored in `%APPDATA%\BleachBit\bleachbit.ini` — not in the registry.
- The portable version writes no registry keys.
- BleachBit **removes** registry entries from other applications as part of its cleaning function — running it will modify `HKCU` and `HKLM` keys belonging to other software.
- The "wipe free space" feature requires administrator elevation.

```powershell
# Run BleachBit silently with a preset (useful in MDM scripts)
& "C:\Program Files (x86)\BleachBit\bleachbit_console.exe" --clean system.tmp system.recycle_bin
```

---

## 🗑️ Cleanup

```powershell
# Remove BleachBit installation registry entry
Remove-Item -Path "HKLM:\SOFTWARE\BleachBit" -Recurse -ErrorAction SilentlyContinue
Remove-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" `
  -Name "BleachBit" -ErrorAction SilentlyContinue
```

---

## 📦 Package Managers

| Manager | ID / Command |
|---------|-------------|
| winget | `winget install BleachBit.BleachBit` |
| Chocolatey | `choco install bleachbit` |
| Scoop | `scoop install extras/bleachbit` |
