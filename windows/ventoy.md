---
tags:
  - usb
  - flashing
  - bootable
  - multiboot
description: >-
  Windows registry keys created by Ventoy — install paths, uninstall keys, HKCU and HKLM entries for sysadmin automation and cleanup.
---

# Ventoy

**Version documented:** 1.0.99
**Installer type:** Portable `.zip` (runs as admin)
**Hives written:** HKCU

---

## 📁 Registry Paths

| Path | Hive | Purpose |
|------|------|---------|
| `SOFTWARE\Ventoy` | HKCU | User preferences and last-used settings |

---

## 🔑 Keys

### HKCU\SOFTWARE\Ventoy

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `DefaultLang` | REG_SZ | `en_US` | UI language |
| `LastSelectedDisk` | REG_SZ | `\\.\PHYSICALDRIVE2` | Last target disk |
| `ShowAllDrives` | REG_DWORD | `0` | Show all drives incl. fixed (1=yes) |
| `UpdatePolicy` | REG_DWORD | `0` | 0=check on start, 1=never |

---

## 📝 Notes

- Ventoy is a portable tool — it requires no installation and writes only a small HKCU preference key.
- Ventoy does not create an uninstall entry; delete the extracted folder to remove it.
- Ventoy writes a special partition structure to the target USB drive (not to Windows registry).
- Requires administrator elevation to write to physical disks.
- The `ShowAllDrives = 1` setting is a safety risk — it exposes internal fixed disks as flash targets. Leave at `0` unless you know what you're doing.

```powershell
# Check last disk used with Ventoy
(Get-ItemProperty "HKCU:\SOFTWARE\Ventoy" -ErrorAction SilentlyContinue).LastSelectedDisk

# Disable update check at startup
$path = "HKCU:\SOFTWARE\Ventoy"
if (-not (Test-Path $path)) { New-Item -Path $path -Force | Out-Null }
Set-ItemProperty -Path $path -Name "UpdatePolicy" -Value 1 -Type DWord
```

---

## 🗑️ Cleanup

```powershell
# Remove Ventoy preferences
Remove-Item -Path "HKCU:\SOFTWARE\Ventoy" -Recurse -ErrorAction SilentlyContinue
```

---

## 📦 Package Managers

| Manager | ID / Command |
|---------|-------------|
| winget | `winget install Ventoy.Ventoy` |
| Chocolatey | `choco install ventoy` |
| Scoop | `scoop install extras/ventoy` |
