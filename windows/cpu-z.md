---
tags:
  - hardware
  - monitoring
  - portable
  - freeware
description: >-
  Windows registry keys created by CPU-Z — install paths, uninstall keys, HKCU and HKLM entries for sysadmin automation and cleanup.
---

# CPU-Z

**Version:** 2.09.1  
**Installer:** `.exe` (setup) / Portable `.exe`  
**Hives:** HKCU, HKLM

CPU-Z is a freeware system information utility that provides detailed data about CPU, cache, mainboard, memory, and GPU. Widely used by sysadmins and power users for hardware auditing.

---

## 📁 Registry Paths

| Path | Hive | Description |
|------|------|-------------|
| `SOFTWARE\CPUID\CPU-Z` | HKCU | Per-user preferences and settings |
| `SOFTWARE\CPUID\CPU-Z` | HKLM | Machine-wide install marker |
| `SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\CPU-Z` | HKLM | Uninstall entry (setup version only) |

---

## 🔑 Keys

### HKCU\SOFTWARE\CPUID\CPU-Z

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `language` | `REG_SZ` | `English` | UI language |
| `startTab` | `REG_DWORD` | `0` | Default tab on launch (0 = CPU) |
| `checkUpdate` | `REG_DWORD` | `1` | Auto-check for updates (1 = enabled) |
| `theme` | `REG_SZ` | `default` | UI theme name |

### HKLM\SOFTWARE\CPUID\CPU-Z

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `InstallPath` | `REG_SZ` | `C:\Program Files\CPUID\CPU-Z\` | Installation directory |
| `Version` | `REG_SZ` | `2.09.1` | Installed version string |

### HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\CPU-Z

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `DisplayName` | `REG_SZ` | `CPU-Z 2.09.1` | Display name in Programs list |
| `DisplayVersion` | `REG_SZ` | `2.09.1` | Version shown in Apps & Features |
| `Publisher` | `REG_SZ` | `CPUID` | Publisher name |
| `InstallLocation` | `REG_SZ` | `C:\Program Files\CPUID\CPU-Z\` | Install directory |
| `UninstallString` | `REG_SZ` | `"C:\Program Files\CPUID\CPU-Z\unins000.exe"` | Uninstall command |
| `URLInfoAbout` | `REG_SZ` | `https://www.cpuid.com/softwares/cpu-z.html` | Product URL |

---

## 📝 Notes

- The **portable version** writes nothing to the registry at all — zero footprint.
- The setup version creates the `HKLM\...\Uninstall` entry; portable does not.
- `HKCU` settings persist across updates and portable upgrades (if the same profile is reused).
- CPU-Z does **not** register file associations or shell extensions.
- On 64-bit Windows with a 32-bit installer, paths may appear under `SOFTWARE\WOW6432Node\CPUID\CPU-Z`.

---

## 🗑️ Cleanup

To fully remove CPU-Z registry entries after uninstallation:

```reg
Windows Registry Editor Version 5.00

[-HKEY_CURRENT_USER\SOFTWARE\CPUID\CPU-Z]
[-HKEY_LOCAL_MACHINE\SOFTWARE\CPUID\CPU-Z]
[-HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\CPU-Z]
```

> **Note:** The portable version leaves no registry entries to clean up.

---

## 📦 Package Managers

| Manager | Install Command |
|---------|----------------|
| winget | `winget install CPUID.CPU-Z` |
| Chocolatey | `choco install cpu-z` |
| Scoop | `scoop install cpu-z` |
