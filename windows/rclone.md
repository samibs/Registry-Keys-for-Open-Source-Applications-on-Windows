---
tags:
  - sync
  - cloud
  - backup
  - cli
  - storage
description: >-
  Windows registry keys created by Rclone — install paths, uninstall keys, HKCU and HKLM entries for sysadmin automation and cleanup.
---

# Rclone

**Version documented:** 1.66.0
**Installer type:** Standalone `.exe` / via `rclone-browser` GUI
**Hives written:** HKCU (GUI wrapper only)

---

## 📁 Registry Paths

| Path | Hive | Purpose |
|------|------|---------|
| `SOFTWARE\rclone-browser` | HKCU | rclone-browser GUI preferences |
| `SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\rclone-browser` | HKCU | Uninstall entry (GUI only) |

---

## 🔑 Keys

### HKCU\SOFTWARE\rclone-browser

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `rclonePath` | REG_SZ | `C:\Users\User\bin\rclone.exe` | Path to rclone binary |
| `rcloneConfig` | REG_SZ | `C:\Users\User\.config\rclone\rclone.conf` | Config file path |

---

## 📝 Notes

- **Standalone rclone** (CLI) writes zero registry keys. It is a single portable `.exe`.
- All remote configurations (Google Drive, S3, Dropbox, etc.) are stored in `%USERPROFILE%\.config\rclone\rclone.conf` — this file contains credentials.
- `rclone-browser` is a popular Windows GUI that registers minimal user-level keys.
- To mount remotes as Windows drives, rclone uses **WinFsp** as a dependency — see its own registry entries.

```powershell
# Check rclone version (standalone)
& rclone version 2>$null | Select-Object -First 1

# List configured remotes from the config file
$conf = "$env:USERPROFILE\.config\rclone\rclone.conf"
if (Test-Path $conf) { Select-String "^\[" $conf | ForEach-Object { $_.Line } }
```

---

## 🗑️ Cleanup

```powershell
# Remove rclone-browser settings (CLI leaves no registry keys)
Remove-Item -Path "HKCU:\SOFTWARE\rclone-browser" -Recurse -ErrorAction SilentlyContinue
```

---

## 📦 Package Managers

| Manager | ID / Command |
|---------|-------------|
| winget | `winget install Rclone.Rclone` |
| Chocolatey | `choco install rclone` |
| Scoop | `scoop install main/rclone` |
