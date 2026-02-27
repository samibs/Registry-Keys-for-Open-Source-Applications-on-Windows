---
tags:
  - sync
  - file-sync
  - backup
  - networking
---

# Syncthing

**Version documented:** 1.27.6
**Installer type:** Standalone `.exe` / via `SyncTrayzor` wrapper
**Hives written:** HKCU, HKLM\SYSTEM (when run as service)

---

## 📁 Registry Paths

| Path | Hive | Purpose |
|------|------|---------|
| `SOFTWARE\Microsoft\Windows\CurrentVersion\Run` | HKCU | Startup entry (tray/user mode) |
| `SOFTWARE\SyncTrayzor` | HKCU | SyncTrayzor wrapper preferences |
| `SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\SyncTrayzor` | HKLM | Uninstall entry (SyncTrayzor) |
| `SYSTEM\CurrentControlSet\Services\SyncTrayzor` | HKLM | Service (if installed as a service) |

---

## 🔑 Keys

### HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `SyncTrayzor` | REG_SZ | `"C:\Program Files\SyncTrayzor\SyncTrayzor.exe" -minimized` | Auto-start SyncTrayzor tray app |

### HKCU\SOFTWARE\SyncTrayzor

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `ShowTrayIconOnlyOnClose` | REG_DWORD | `0` | Minimize to tray only on close |
| `StartMinimized` | REG_DWORD | `1` | Start minimized on login |
| `StartOnLogon` | REG_DWORD | `1` | Start with Windows |

### HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\SyncTrayzor

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `DisplayName` | REG_SZ | `SyncTrayzor` | Display name |
| `DisplayVersion` | REG_SZ | `1.1.29` | Version |
| `Publisher` | REG_SZ | `SyncTrayzor` | Publisher |
| `InstallLocation` | REG_SZ | `C:\Program Files\SyncTrayzor` | Install path |

### HKLM\SYSTEM\CurrentControlSet\Services\SyncTrayzor (service mode only)

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `DisplayName` | REG_SZ | `SyncTrayzor` | Service name |
| `Start` | REG_DWORD | `2` | 2=Automatic |
| `ImagePath` | REG_EXPAND_SZ | `"C:\Program Files\SyncTrayzor\SyncTrayzor.exe" --service` | Service binary |

---

## 📝 Notes

- **Standalone Syncthing** (no installer) writes no registry keys — it is a portable binary; config lives in `%LOCALAPPDATA%\Syncthing\`.
- **SyncTrayzor** is the popular Windows GUI wrapper that adds a tray icon, auto-start, and browser-based config.
- Syncthing's web UI runs at `http://127.0.0.1:8384` by default — no registry key stores the port (it's in `config.xml`).
- For headless/service installs, use NSSM or the official Windows service wrapper.

```powershell
# Disable SyncTrayzor auto-start without uninstalling
Remove-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" `
  -Name "SyncTrayzor" -ErrorAction SilentlyContinue

# Check if running as a service
Get-Service -Name "SyncTrayzor" -ErrorAction SilentlyContinue | Select-Object Name, Status
```

---

## 🗑️ Cleanup

```powershell
# Remove SyncTrayzor startup and preferences
Remove-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" `
  -Name "SyncTrayzor" -ErrorAction SilentlyContinue
Remove-Item -Path "HKCU:\SOFTWARE\SyncTrayzor" -Recurse -ErrorAction SilentlyContinue

# Stop and remove service if installed
Stop-Service -Name "SyncTrayzor" -ErrorAction SilentlyContinue
sc.exe delete SyncTrayzor 2>$null
```

---

## 📦 Package Managers

| Manager | ID / Command |
|---------|-------------|
| winget | `winget install Syncthing.Syncthing` |
| Chocolatey | `choco install syncthing` |
| Scoop | `scoop install main/syncthing` |
