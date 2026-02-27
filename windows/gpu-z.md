---
tags:
  - hardware
  - gpu
  - monitoring
  - portable
description: >-
  Windows registry keys created by GPU-Z — install paths, uninstall keys, HKCU and HKLM entries for sysadmin automation and cleanup.
---

# GPU-Z

**Version:** 2.59.0  
**Installer:** Portable `.exe`  
**Hives:** HKCU

GPU-Z is a lightweight system utility designed to provide information about your video card and GPU. It displays GPU specifications, clock speeds, temperatures, voltages, and fan speeds in real time.

---

## 📁 Registry Paths

| Path | Hive | Description |
|------|------|-------------|
| `SOFTWARE\techpowerup\GPU-Z` | HKCU | Per-user preferences and window state |

---

## 🔑 Keys

### HKCU\SOFTWARE\techpowerup\GPU-Z

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `WindowPos` | `REG_BINARY` | `(binary)` | Saved window position and size |
| `Adapter` | `REG_DWORD` | `0` | Last-selected GPU adapter index |
| `UpdateCheck` | `REG_DWORD` | `1` | Enable update checks on launch |
| `StartMinimized` | `REG_DWORD` | `0` | Start in system tray (1 = minimized) |
| `LastVersion` | `REG_SZ` | `2.59.0` | Last-run version |

---

## 📝 Notes

- GPU-Z is fully portable — most users run it directly without an installer.
- When run as portable, the `HKCU\SOFTWARE\techpowerup\GPU-Z` key is still created on first launch to store window state.
- A setup installer variant exists but is not commonly used; it adds an uninstall entry to HKLM.
- GPU-Z does not register file associations or system services.
- Sensor logging writes to a `.txt` or `.csv` file in the same directory as the executable.

---

## 🗑️ Cleanup

```reg
Windows Registry Editor Version 5.00

[-HKEY_CURRENT_USER\SOFTWARE\techpowerup\GPU-Z]
```

---

## 📦 Package Managers

| Manager | Install Command |
|---------|----------------|
| winget | `winget install TechPowerUp.GPU-Z` |
| Chocolatey | `choco install gpu-z` |
| Scoop | `scoop install gpu-z` |
