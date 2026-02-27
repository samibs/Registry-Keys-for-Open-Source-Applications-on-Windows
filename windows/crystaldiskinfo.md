---
tags:
  - disk
  - health
  - monitoring
  - diagnostics
---

# CrystalDiskInfo

**Version documented:** 9.3.0
**Installer type:** `.exe` (NSIS)
**Hives written:** HKLM

---

## 📁 Registry Paths

| Path | Hive | Purpose |
|------|------|---------|
| `SOFTWARE\CrystalDewWorld\CrystalDiskInfo` | HKLM | Application settings |
| `SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\CrystalDiskInfo_is1` | HKLM | Uninstall entry |

---

## 🔑 Keys

### HKLM\SOFTWARE\CrystalDewWorld\CrystalDiskInfo

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `InstallPath` | REG_SZ | `C:\Program Files\CrystalDiskInfo` | Installation path |
| `Language` | REG_SZ | `English` | UI language |
| `AutoStartup` | REG_DWORD | `0` | Start with Windows (0=off, 1=on) |
| `HealthStatus_Threshold` | REG_DWORD | `1` | Alert threshold level |
| `DiskSort` | REG_DWORD | `0` | Disk sort order |

### HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\CrystalDiskInfo_is1

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `DisplayName` | REG_SZ | `CrystalDiskInfo 9.3.0` | Display name |
| `DisplayVersion` | REG_SZ | `9.3.0` | Version string |
| `Publisher` | REG_SZ | `Crystal Dew World` | Publisher |
| `InstallLocation` | REG_SZ | `C:\Program Files\CrystalDiskInfo\` | Install path |
| `UninstallString` | REG_SZ | `"...\unins000.exe"` | Uninstaller path |

---

## 📝 Notes

- Portable version writes no registry keys at all.
- The `AutoStartup` key controls whether CrystalDiskInfo registers a startup entry in `HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run`.
- On 64-bit Windows, settings may appear under `HKLM\SOFTWARE\WOW6432Node\CrystalDewWorld\CrystalDiskInfo`.

```powershell
# Check install path
(Get-ItemProperty "HKLM:\SOFTWARE\CrystalDewWorld\CrystalDiskInfo" -ErrorAction SilentlyContinue).InstallPath

# Disable auto-startup
Set-ItemProperty -Path "HKLM:\SOFTWARE\CrystalDewWorld\CrystalDiskInfo" -Name "AutoStartup" -Value 0 -Type DWord
```

---

## 🗑️ Cleanup

```powershell
# Remove CrystalDiskInfo settings
Remove-Item -Path "HKLM:\SOFTWARE\CrystalDewWorld\CrystalDiskInfo" -Recurse -ErrorAction SilentlyContinue
Remove-Item -Path "HKLM:\SOFTWARE\CrystalDewWorld" -Recurse -ErrorAction SilentlyContinue
Remove-Item -Path "HKLM:\SOFTWARE\WOW6432Node\CrystalDewWorld" -Recurse -ErrorAction SilentlyContinue

# Remove startup entry if set
Remove-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" -Name "CrystalDiskInfo" -ErrorAction SilentlyContinue
```

---

## 📦 Package Managers

| Manager | ID / Command |
|---------|-------------|
| winget | `winget install CrystalDewWorld.CrystalDiskInfo` |
| Chocolatey | `choco install crystaldiskinfo` |
| Scoop | `scoop install extras/crystaldiskinfo` |
