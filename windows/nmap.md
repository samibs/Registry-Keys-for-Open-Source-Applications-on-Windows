---
tags:
  - network
  - security
  - scanning
  - sysadmin
description: >-
  Windows registry keys created by Nmap — install paths, uninstall keys, HKCU and HKLM entries for sysadmin automation and cleanup.
---

# Nmap

**Version documented:** 7.94
**Installer type:** `.exe` (NSIS)
**Hives written:** HKLM, HKCR

---

## 📁 Registry Paths

| Path | Hive | Purpose |
|------|------|---------|
| `SOFTWARE\Nmap` | HKLM | Installation settings |
| `SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Nmap` | HKLM | Uninstall entry |
| `HKCR\.nmap` | HKCR | .nmap file association (Zenmap profile) |
| `HKCR\.xml\OpenWithProgIds\Zenmap.xml` | HKCR | .xml open with Zenmap |

---

## 🔑 Keys

### HKLM\SOFTWARE\Nmap

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `(Default)` | REG_SZ | `C:\Program Files (x86)\Nmap` | Install path (default value) |
| `Version` | REG_SZ | `7.94` | Installed version |

### HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Nmap

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `DisplayName` | REG_SZ | `Nmap 7.94` | Display name |
| `DisplayVersion` | REG_SZ | `7.94` | Version string |
| `Publisher` | REG_SZ | `Insecure.Com LLC` | Publisher |
| `InstallLocation` | REG_SZ | `C:\Program Files (x86)\Nmap` | Install path |
| `UninstallString` | REG_SZ | `"...\uninstall.exe"` | Uninstaller |

### HKCR\.nmap

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `(Default)` | REG_SZ | `Zenmap.Profile` | ProgID reference |

---

## 📝 Notes

- Nmap installs to `C:\Program Files (x86)\Nmap` by default; the path is also added to `PATH` via `HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment`.
- Npcap (WinPcap replacement) is bundled with Nmap installer — see [Wireshark docs](wireshark.md) for Npcap service keys.
- Zenmap (GUI) registers `.nmap` file associations; command-line Nmap itself registers nothing in HKCR.

```powershell
# Verify Nmap install path
(Get-ItemProperty "HKLM:\SOFTWARE\Nmap" -ErrorAction SilentlyContinue).'(Default)'

# Check if nmap is in PATH
$env:PATH -split ';' | Where-Object { $_ -like '*Nmap*' }
```

---

## 🗑️ Cleanup

```powershell
# Remove Nmap registry entries
Remove-Item -Path "HKLM:\SOFTWARE\Nmap" -Recurse -ErrorAction SilentlyContinue
Remove-Item -Path "HKCR:\.nmap" -Recurse -ErrorAction SilentlyContinue
Remove-Item -Path "HKCR:\Zenmap.Profile" -Recurse -ErrorAction SilentlyContinue
```

---

## 📦 Package Managers

| Manager | ID / Command |
|---------|-------------|
| winget | `winget install Insecure.Nmap` |
| Chocolatey | `choco install nmap` |
| Scoop | `scoop install main/nmap` |
