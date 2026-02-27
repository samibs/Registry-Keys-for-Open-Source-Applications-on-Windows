---
tags:
  - network
  - scanner
  - portable
---

# Angry IP Scanner

**Version:** 3.9.1  
**Installer:** `.exe` (setup) / Portable `.exe`  
**Hives:** HKCU, HKLM

Angry IP Scanner is a fast, open-source network scanner that pings IP addresses and scans ports. Used by sysadmins for host discovery and network inventory.

---

## 📁 Registry Paths

| Path | Hive | Description |
|------|------|-------------|
| `SOFTWARE\Angry IP Scanner` | HKCU | Per-user preferences |
| `SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Angry IP Scanner` | HKLM | Uninstall entry |

---

## 🔑 Keys

### HKCU\SOFTWARE\Angry IP Scanner

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `version` | `REG_SZ` | `3.9.1` | Last-run version |
| `lastip` | `REG_SZ` | `192.168.1.1-254` | Last scanned IP range |
| `fetchers` | `REG_SZ` | `Hostname,Ping,Ports` | Active column fetchers |
| `outputFormat` | `REG_SZ` | `txt` | Default export format |
| `theme` | `REG_SZ` | `default` | UI theme |

### HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Angry IP Scanner

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `DisplayName` | `REG_SZ` | `Angry IP Scanner 3.9.1` | Display name |
| `DisplayVersion` | `REG_SZ` | `3.9.1` | Installed version |
| `Publisher` | `REG_SZ` | `Angry IP Scanner` | Publisher |
| `InstallLocation` | `REG_SZ` | `C:\Program Files\Angry IP Scanner\` | Install directory |
| `UninstallString` | `REG_SZ` | `"C:\Program Files\Angry IP Scanner\uninstall.exe"` | Uninstall command |

---

## 📝 Notes

- Requires Java (JRE) — may also create registry entries related to the Java launcher association.
- Portable mode creates no registry entries.
- Scan profiles and custom fetchers are stored in `%APPDATA%\ipscan\` as XML files, not in the registry.

---

## 🗑️ Cleanup

```reg
Windows Registry Editor Version 5.00

[-HKEY_CURRENT_USER\SOFTWARE\Angry IP Scanner]
[-HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Angry IP Scanner]
```

---

## 📦 Package Managers

| Manager | Install Command |
|---------|----------------|
| winget | `winget install angryziber.AngryIPScanner` |
| Chocolatey | `choco install angryip` |
| Scoop | `scoop install angry-ip-scanner` |
