---
tags:
  - media-player
  - video
  - audio
  - lightweight
  - cli
---

# mpv

**Version documented:** 0.37.0
**Installer type:** Portable `.7z` / via `mpv.net` GUI wrapper
**Hives written:** HKCU

---

## 📁 Registry Paths

| Path | Hive | Purpose |
|------|------|---------|
| `SOFTWARE\mpv` | HKCU | mpv.net wrapper settings |
| `SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\mpv-net` | HKCU | Uninstall entry (mpv.net) |

---

## 🔑 Keys

### HKCU\SOFTWARE\mpv

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `InstallDir` | REG_SZ | `C:\Users\User\AppData\Local\mpv.net` | mpv.net install path |
| `Version` | REG_SZ | `6.0.3.0` | mpv.net version |

### HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\mpv-net

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `DisplayName` | REG_SZ | `mpv.net` | Display name |
| `DisplayVersion` | REG_SZ | `6.0.3.0` | Version |
| `Publisher` | REG_SZ | `mpv.net` | Publisher |
| `InstallLocation` | REG_SZ | `C:\Users\User\AppData\Local\mpv.net` | Install path |
| `UninstallString` | REG_SZ | `"...\setup.exe" --uninstall` | Uninstaller |

---

## 📝 Notes

- **Standalone mpv** (portable) writes zero registry keys — it is a single `.exe` or portable package. All config lives in `mpv.conf` and `input.conf` in the `portable_config/` or `%APPDATA%\mpv\` directory.
- **mpv.net** is the most popular Windows GUI wrapper for mpv and does write registry keys (per-user install).
- mpv.net can optionally register file associations via its Settings dialog — this creates additional `HKCU\SOFTWARE\Classes` entries for video/audio formats.

```powershell
# Find mpv.net install location
(Get-ItemProperty "HKCU:\SOFTWARE\mpv" -ErrorAction SilentlyContinue).InstallDir

# Check if mpv is in PATH (standalone)
Get-Command mpv -ErrorAction SilentlyContinue | Select-Object Source
```

---

## 🗑️ Cleanup

```powershell
# Remove mpv.net registry entries
Remove-Item -Path "HKCU:\SOFTWARE\mpv" -Recurse -ErrorAction SilentlyContinue
Remove-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\mpv-net" `
  -Recurse -ErrorAction SilentlyContinue
```

---

## 📦 Package Managers

| Manager | ID / Command |
|---------|-------------|
| winget | `winget install mpv.net` |
| Chocolatey | `choco install mpv` |
| Scoop | `scoop install extras/mpv` |
