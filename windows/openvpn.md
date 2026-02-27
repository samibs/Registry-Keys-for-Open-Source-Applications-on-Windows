---
tags:
  - vpn
  - networking
  - security
  - privacy
description: >-
  Windows registry keys created by OpenVPN — install paths, uninstall keys, HKCU and HKLM entries for sysadmin automation and cleanup.
---

# OpenVPN

**Version documented:** 2.6.9
**Installer type:** `.msi`
**Hives written:** HKLM, HKLM\SYSTEM, HKCU

---

## 📁 Registry Paths

| Path | Hive | Purpose |
|------|------|---------|
| `SOFTWARE\OpenVPN` | HKLM | Installation settings |
| `SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\OpenVPN` | HKLM | Uninstall entry |
| `SYSTEM\CurrentControlSet\Services\OpenVPNService` | HKLM | Windows service (interactive service helper) |
| `SYSTEM\CurrentControlSet\Services\tap0901` | HKLM | TAP virtual network adapter driver |
| `SOFTWARE\OpenVPN-GUI` | HKCU | GUI preferences |

---

## 🔑 Keys

### HKLM\SOFTWARE\OpenVPN

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `(Default)` | REG_SZ | `C:\Program Files\OpenVPN` | Install directory |
| `config_dir` | REG_SZ | `C:\Program Files\OpenVPN\config` | System-wide config directory |
| `config_ext` | REG_SZ | `ovpn` | VPN config file extension |
| `log_dir` | REG_SZ | `C:\Program Files\OpenVPN\log` | Log directory |
| `log_append` | REG_SZ | `false` | Append to log vs. overwrite |

### HKCU\SOFTWARE\OpenVPN-GUI

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `config_dir` | REG_SZ | `C:\Users\User\OpenVPN\config` | User config directory |
| `log_dir` | REG_SZ | `C:\Users\User\OpenVPN\log` | User log directory |
| `silent_connection` | REG_DWORD | `0` | Connect silently (no dialog) |
| `show_balloon` | REG_DWORD | `1` | Show tray balloon on connect |
| `StartOnLogon` | REG_DWORD | `0` | Auto-connect on logon |

### HKLM\SYSTEM\CurrentControlSet\Services\OpenVPNService

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `DisplayName` | REG_SZ | `OpenVPN Service` | Service display name |
| `Start` | REG_DWORD | `3` | 2=Auto, 3=Manual, 4=Disabled |
| `ImagePath` | REG_EXPAND_SZ | `"C:\Program Files\OpenVPN\bin\openvpnserv.exe"` | Service binary |

### HKLM\SYSTEM\CurrentControlSet\Services\tap0901

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `DisplayName` | REG_SZ | `TAP-Windows Adapter V9` | Driver name |
| `ImagePath` | REG_EXPAND_SZ | `system32\DRIVERS\tap0901.sys` | Driver binary |
| `Start` | REG_DWORD | `3` | Start type |

---

## 📝 Notes

- OpenVPN installs the TAP-Windows virtual network adapter driver (`tap0901.sys`) — this registers a network adapter in Device Manager and HKLM\SYSTEM\CurrentControlSet\Services.
- User `.ovpn` config files go in `%USERPROFILE%\OpenVPN\config\`; system-wide configs in `C:\Program Files\OpenVPN\config\`.
- The `OpenVPNService` service runs with elevated privileges to allow non-admin users to connect.

```powershell
# Check service status
Get-Service -Name "OpenVPNService" -ErrorAction SilentlyContinue | Select-Object Name, Status, StartType

# List active TAP adapters
Get-NetAdapter | Where-Object { $_.InterfaceDescription -like "*TAP*" }

# Read system config directory
(Get-ItemProperty "HKLM:\SOFTWARE\OpenVPN" -ErrorAction SilentlyContinue).config_dir
```

---

## 🗑️ Cleanup

```powershell
# Stop service before cleanup
Stop-Service -Name "OpenVPNService" -ErrorAction SilentlyContinue

# Remove OpenVPN registry keys
Remove-Item -Path "HKLM:\SOFTWARE\OpenVPN" -Recurse -ErrorAction SilentlyContinue
Remove-Item -Path "HKCU:\SOFTWARE\OpenVPN-GUI" -Recurse -ErrorAction SilentlyContinue
# Note: SYSTEM\Services\tap0901 and OpenVPNService are removed by the MSI uninstaller
```

---

## 📦 Package Managers

| Manager | ID / Command |
|---------|-------------|
| winget | `winget install OpenVPNTechnologies.OpenVPN` |
| Chocolatey | `choco install openvpn` |
| Scoop | `scoop install extras/openvpn` |
