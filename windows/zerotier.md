---
tags:
  - vpn
  - networking
  - mesh
  - sdn
description: >-
  Windows registry keys created by ZeroTier — install paths, uninstall keys, HKCU and HKLM entries for sysadmin automation and cleanup.
---

# ZeroTier

**Version documented:** 1.14.0
**Installer type:** `.msi`
**Hives written:** HKLM, HKLM\SYSTEM, HKCU

---

## 📁 Registry Paths

| Path | Hive | Purpose |
|------|------|---------|
| `SOFTWARE\ZeroTier, Inc.\ZeroTier One` | HKLM | Installation settings |
| `SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\ZeroTier One` | HKLM | Uninstall entry |
| `SYSTEM\CurrentControlSet\Services\ZeroTierOneService` | HKLM | Windows service |
| `SOFTWARE\Microsoft\Windows\CurrentVersion\Run` | HKCU | Tray icon startup entry |

---

## 🔑 Keys

### HKLM\SOFTWARE\ZeroTier, Inc.\ZeroTier One

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `InstallDir` | REG_SZ | `C:\Program Files (x86)\ZeroTier` | Installation directory |
| `Version` | REG_SZ | `1.14.0` | Installed version |

### HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\ZeroTier One

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `DisplayName` | REG_SZ | `ZeroTier One` | Display name |
| `DisplayVersion` | REG_SZ | `1.14.0` | Version |
| `Publisher` | REG_SZ | `ZeroTier, Inc.` | Publisher |
| `InstallLocation` | REG_SZ | `C:\Program Files (x86)\ZeroTier` | Install path |
| `UninstallString` | REG_SZ | `MsiExec.exe /X{GUID}` | Uninstaller |

### HKLM\SYSTEM\CurrentControlSet\Services\ZeroTierOneService

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `DisplayName` | REG_SZ | `ZeroTier One` | Service display name |
| `Start` | REG_DWORD | `2` | 2=Automatic (starts at boot) |
| `Type` | REG_DWORD | `16` | Own-process service |
| `ImagePath` | REG_EXPAND_SZ | `"C:\Program Files (x86)\ZeroTier\ZeroTier One.exe" -U` | Service binary |
| `ObjectName` | REG_SZ | `LocalSystem` | Service account |

### HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `ZeroTier One` | REG_SZ | `"C:\Program Files (x86)\ZeroTier\ZeroTier One.exe"` | Tray icon auto-start |

---

## 📝 Notes

- ZeroTier runs as a system service (`ZeroTierOneService`) that starts at boot — the tray icon is a separate UI process.
- The node identity (public/private key + node ID) is stored in `C:\ProgramData\ZeroTier\One\identity.public` and `identity.secret` — **never share `identity.secret`**.
- Network join configuration is in `C:\ProgramData\ZeroTier\One\networks.d\`.
- ZeroTier installs a virtual network adapter visible in Device Manager and `Get-NetAdapter`.

```powershell
# Check service status
Get-Service -Name "ZeroTierOneService" | Select-Object Name, Status, StartType

# List ZeroTier virtual adapters
Get-NetAdapter | Where-Object { $_.InterfaceDescription -like "*ZeroTier*" }

# Read node ID (first 10 chars of identity.public)
$id = Get-Content "C:\ProgramData\ZeroTier\One\identity.public" -ErrorAction SilentlyContinue
if ($id) { $id.Split(':')[0] }
```

---

## 🗑️ Cleanup

```powershell
# Stop and remove the service
Stop-Service -Name "ZeroTierOneService" -ErrorAction SilentlyContinue
sc.exe delete ZeroTierOneService 2>$null

# Remove registry keys
Remove-Item -Path "HKLM:\SOFTWARE\ZeroTier, Inc.\ZeroTier One" -Recurse -ErrorAction SilentlyContinue
Remove-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Services\ZeroTierOneService" -Recurse -ErrorAction SilentlyContinue
Remove-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" `
  -Name "ZeroTier One" -ErrorAction SilentlyContinue
```

---

## 📦 Package Managers

| Manager | ID / Command |
|---------|-------------|
| winget | `winget install ZeroTier.ZeroTierOne` |
| Chocolatey | `choco install zerotier-one` |
| Scoop | `scoop install extras/zerotier-one` |
