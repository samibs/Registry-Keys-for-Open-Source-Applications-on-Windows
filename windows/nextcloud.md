---
tags:
  - sync
  - cloud
  - backup
  - nextcloud
---

# Nextcloud Desktop

**Version documented:** 3.12.3
**Installer type:** `.msi`
**Hives written:** HKCU, HKLM, HKLM\SYSTEM

---

## 📁 Registry Paths

| Path | Hive | Purpose |
|------|------|---------|
| `SOFTWARE\Nextcloud GmbH\Nextcloud` | HKCU | User settings and sync config |
| `SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Nextcloud` | HKLM | Uninstall entry |
| `SOFTWARE\Microsoft\Windows\CurrentVersion\Run` | HKCU | Startup entry |
| `SYSTEM\CurrentControlSet\Services\nextcloud` | HKLM | VFS service (Virtual File System) |

---

## 🔑 Keys

### HKCU\SOFTWARE\Nextcloud GmbH\Nextcloud

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `installPath` | REG_SZ | `C:\Program Files\Nextcloud` | Install path |
| `version` | REG_SZ | `3.12.3` | Installed version |
| `updateChannel` | REG_SZ | `stable` | Update channel |

### HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `Nextcloud` | REG_SZ | `"C:\Program Files\Nextcloud\nextcloud.exe" --background` | Auto-start in background |

### HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Nextcloud

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `DisplayName` | REG_SZ | `Nextcloud` | Display name |
| `DisplayVersion` | REG_SZ | `3.12.3` | Version |
| `Publisher` | REG_SZ | `Nextcloud GmbH` | Publisher |
| `InstallLocation` | REG_SZ | `C:\Program Files\Nextcloud` | Install path |
| `UninstallString` | REG_SZ | `MsiExec.exe /X{GUID}` | Uninstaller |

### HKLM\SYSTEM\CurrentControlSet\Services\nextcloud

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `DisplayName` | REG_SZ | `Nextcloud` | Service display name |
| `Start` | REG_DWORD | `2` | 2=Automatic |
| `ImagePath` | REG_EXPAND_SZ | `"C:\Program Files\Nextcloud\nextcloud.exe" --service` | Service binary |
| `ObjectName` | REG_SZ | `LocalSystem` | Service account |

---

## 📝 Notes

- The Windows VFS (Virtual File System) feature uses the `nextcloud` service to present files as on-demand stubs without downloading them — only file metadata is synced until you open a file.
- Account credentials and sync folder mappings are stored in `%APPDATA%\Nextcloud\nextcloud.cfg` — back this up to migrate sync config.
- Shell extension overlays (sync status icons in Explorer) are registered under `HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\ShellIconOverlayIdentifiers`.

```powershell
# Check service status (VFS mode)
Get-Service -Name "nextcloud" -ErrorAction SilentlyContinue | Select-Object Name, Status, StartType

# Disable auto-start tray without uninstalling
Remove-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" `
  -Name "Nextcloud" -ErrorAction SilentlyContinue
```

---

## 🗑️ Cleanup

```powershell
# Stop VFS service
Stop-Service -Name "nextcloud" -ErrorAction SilentlyContinue
sc.exe delete nextcloud 2>$null

# Remove user settings and startup entry
Remove-Item -Path "HKCU:\SOFTWARE\Nextcloud GmbH" -Recurse -ErrorAction SilentlyContinue
Remove-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" `
  -Name "Nextcloud" -ErrorAction SilentlyContinue
```

---

## 📦 Package Managers

| Manager | ID / Command |
|---------|-------------|
| winget | `winget install Nextcloud.NextcloudDesktop` |
| Chocolatey | `choco install nextcloud-client` |
| Scoop | `scoop install extras/nextcloud` |
