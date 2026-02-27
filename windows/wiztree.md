---
tags:
  - disk
  - analysis
  - portable
description: >-
  Windows registry keys created by WizTree — install paths, uninstall keys, HKCU and HKLM entries for sysadmin automation and cleanup.
---

# WizTree

**Version:** 4.18  
**Installer:** `.exe` (setup) / Portable  
**Hives:** HKCU, HKLM

WizTree is a fast disk space analyzer that reads the NTFS MFT (Master File Table) directly, making it significantly faster than traditional scanners. It shows which files and folders are using the most disk space.

---

## 📁 Registry Paths

| Path | Hive | Description |
|------|------|-------------|
| `SOFTWARE\AntibodySoftware\WizTree` | HKCU | Per-user preferences |
| `SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\WizTree` | HKLM | Uninstall entry (setup version) |

---

## 🔑 Keys

### HKCU\SOFTWARE\AntibodySoftware\WizTree

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `Version` | `REG_SZ` | `4.18` | Last-run version |
| `Language` | `REG_SZ` | `English` | UI language |
| `ScanPath` | `REG_SZ` | `C:\` | Last-scanned drive/path |
| `WindowMaximized` | `REG_DWORD` | `0` | Window state on exit |
| `ShowTreemap` | `REG_DWORD` | `1` | Show treemap visualization |
| `UpdateCheck` | `REG_DWORD` | `1` | Check for updates on launch |

### HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\WizTree

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `DisplayName` | `REG_SZ` | `WizTree 4.18` | Display name |
| `DisplayVersion` | `REG_SZ` | `4.18` | Installed version |
| `Publisher` | `REG_SZ` | `Antibody Software` | Publisher |
| `InstallLocation` | `REG_SZ` | `C:\Program Files\WizTree\` | Install path |
| `UninstallString` | `REG_SZ` | `"C:\Program Files\WizTree\uninstall.exe"` | Uninstall command |
| `URLInfoAbout` | `REG_SZ` | `https://diskanalyzer.com` | Product URL |

---

## 📝 Notes

- WizTree reads the NTFS MFT directly and requires administrator privileges for full-disk scans.
- Portable mode writes to `HKCU` regardless; no HKLM uninstall entry is created.
- A 64-bit `WizTree64.exe` is included alongside the 32-bit executable — both share the same registry key.
- WizTree does not register file associations or install system services.

---

## 🗑️ Cleanup

```reg
Windows Registry Editor Version 5.00

[-HKEY_CURRENT_USER\SOFTWARE\AntibodySoftware\WizTree]
[-HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\WizTree]
```

---

## 📦 Package Managers

| Manager | Install Command |
|---------|----------------|
| winget | `winget install AntibodySoftware.WizTree` |
| Chocolatey | `choco install wiztree` |
| Scoop | `scoop install wiztree` |
