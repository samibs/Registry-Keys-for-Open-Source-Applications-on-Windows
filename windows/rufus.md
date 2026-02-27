---
tags:
  - usb
  - flashing
  - imaging
  - bootable
---

# Rufus

**Version documented:** 4.4
**Installer type:** Standalone `.exe` (no installer) / Portable
**Hives written:** HKCU

---

## 📁 Registry Paths

| Path | Hive | Purpose |
|------|------|---------|
| `SOFTWARE\Akeo\Rufus` | HKCU | User preferences and last-used settings |

---

## 🔑 Keys

### HKCU\SOFTWARE\Akeo\Rufus

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `version` | REG_DWORD | `0x00040004` | Last-run version (hex encoded) |
| `last_drive` | REG_SZ | `\\.\PHYSICALDRIVE1` | Last target drive path |
| `last_partition_type` | REG_DWORD | `0` | 0=MBR, 1=GPT |
| `last_target_system` | REG_DWORD | `0` | 0=BIOS/MBR, 1=UEFI, 2=UEFI (no CSM) |
| `last_filesystem` | REG_DWORD | `0` | 0=FAT32, 1=NTFS, 2=UDF, 3=exFAT |
| `last_image` | REG_SZ | `C:\ISOs\ubuntu-22.04.iso` | Last opened ISO path |
| `check_updates` | REG_DWORD | `1` | Check for updates at startup |
| `verbose_mode` | REG_DWORD | `0` | Verbose log output |

---

## 📝 Notes

- Rufus writes no registry keys on first launch until you change settings or run a flash operation.
- The app does **not** create an uninstall entry — it is a single portable executable that you delete to remove.
- Rufus requires elevation (UAC) to access physical drives; it does not register a service.
- The `last_image` value remembers your last ISO across sessions — useful for auditing what was imaged.

```powershell
# Check what ISO was last used with Rufus
(Get-ItemProperty "HKCU:\SOFTWARE\Akeo\Rufus" -ErrorAction SilentlyContinue).last_image

# Check last partition scheme used
$scheme = (Get-ItemProperty "HKCU:\SOFTWARE\Akeo\Rufus" -ErrorAction SilentlyContinue).last_partition_type
@('MBR', 'GPT')[$scheme]

# Disable update checks (for offline environments)
Set-ItemProperty -Path "HKCU:\SOFTWARE\Akeo\Rufus" -Name "check_updates" -Value 0 -Type DWord
```

---

## 🗑️ Cleanup

```powershell
# Remove all Rufus registry preferences
Remove-Item -Path "HKCU:\SOFTWARE\Akeo\Rufus" -Recurse -ErrorAction SilentlyContinue
Remove-Item -Path "HKCU:\SOFTWARE\Akeo" -Recurse -ErrorAction SilentlyContinue
```

---

## 📦 Package Managers

| Manager | ID / Command |
|---------|-------------|
| winget | `winget install Rufus.Rufus` |
| Chocolatey | `choco install rufus` |
| Scoop | `scoop install extras/rufus` |
