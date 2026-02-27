---
tags:
  - remote-desktop
  - rdp
  - remote-access
  - sysadmin
---

# RustDesk

**Version documented:** 1.2.7
**Installer type:** `.exe` (NSIS)
**Hives written:** HKCU, HKLM, HKLM\SYSTEM

---

## 📁 Registry Paths

| Path | Hive | Purpose |
|------|------|---------|
| `SOFTWARE\RustDesk` | HKLM | Installation settings |
| `SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\RustDesk` | HKLM | Uninstall entry |
| `SYSTEM\CurrentControlSet\Services\RustDesk` | HKLM | Windows service (always-on mode) |
| `SOFTWARE\Microsoft\Windows\CurrentVersion\Run` | HKCU | Startup entry (tray mode) |

---

## 🔑 Keys

### HKLM\SOFTWARE\RustDesk

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `InstallPath` | REG_SZ | `C:\Program Files\RustDesk` | Install directory |

### HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\RustDesk

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `DisplayName` | REG_SZ | `RustDesk 1.2.7` | Display name |
| `DisplayVersion` | REG_SZ | `1.2.7` | Version |
| `Publisher` | REG_SZ | `RustDesk` | Publisher |
| `InstallLocation` | REG_SZ | `C:\Program Files\RustDesk` | Install path |
| `UninstallString` | REG_SZ | `"...\unins000.exe"` | Uninstaller |

### HKLM\SYSTEM\CurrentControlSet\Services\RustDesk

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `DisplayName` | REG_SZ | `RustDesk` | Service display name |
| `Start` | REG_DWORD | `2` | 2=Automatic, 3=Manual, 4=Disabled |
| `Type` | REG_DWORD | `16` | Service type (own process) |
| `ImagePath` | REG_EXPAND_SZ | `"C:\Program Files\RustDesk\rustdesk.exe" --service` | Service binary |
| `ObjectName` | REG_SZ | `LocalSystem` | Service account |

### HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `RustDesk` | REG_SZ | `"C:\Program Files\RustDesk\rustdesk.exe"` | Tray startup entry |

---

## 📝 Notes

- When installed in "service mode" (default for unattended access), RustDesk registers as a Windows service that starts automatically.
- Configuration and ID/password are stored in `%APPDATA%\RustDesk\config\RustDesk.toml` — not in the registry.
- To check the assigned RustDesk ID without opening the GUI, read the config TOML; there is no registry key for it.

```powershell
# Check service status
Get-Service -Name "RustDesk" -ErrorAction SilentlyContinue | Select-Object Name, Status, StartType

# Disable auto-start service
Set-Service -Name "RustDesk" -StartupType Disabled
```

---

## 🗑️ Cleanup

```powershell
# Stop and remove the service
Stop-Service -Name "RustDesk" -ErrorAction SilentlyContinue
sc.exe delete RustDesk

# Remove registry keys
Remove-Item -Path "HKLM:\SOFTWARE\RustDesk" -Recurse -ErrorAction SilentlyContinue
Remove-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Services\RustDesk" -Recurse -ErrorAction SilentlyContinue
Remove-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" `
  -Name "RustDesk" -ErrorAction SilentlyContinue
```

---

## 📦 Package Managers

| Manager | ID / Command |
|---------|-------------|
| winget | `winget install RustDesk.RustDesk` |
| Chocolatey | `choco install rustdesk` |
| Scoop | `scoop install extras/rustdesk` |
