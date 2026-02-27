---
tags:
  - audio
  - music-production
  - daw
  - midi
---

# LMMS (Linux MultiMedia Studio)

**Version documented:** 1.2.2
**Installer type:** `.exe` (NSIS)
**Hives written:** HKCU, HKLM

---

## 📁 Registry Paths

| Path | Hive | Purpose |
|------|------|---------|
| `SOFTWARE\LMMS` | HKCU | User preferences |
| `SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\LMMS_is1` | HKLM | Uninstall entry |

---

## 🔑 Keys

### HKCU\SOFTWARE\LMMS

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `DataDir` | REG_SZ | `C:\Program Files\LMMS\data` | Application data directory |
| `WorkingDir` | REG_SZ | `C:\Users\User\Documents\lmms` | User projects directory |
| `Version` | REG_SZ | `1.2.2` | Installed version |

### HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\LMMS_is1

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `DisplayName` | REG_SZ | `LMMS 1.2.2` | Display name |
| `DisplayVersion` | REG_SZ | `1.2.2` | Version |
| `Publisher` | REG_SZ | `LMMS Developers` | Publisher |
| `InstallLocation` | REG_SZ | `C:\Program Files\LMMS\` | Install path |
| `UninstallString` | REG_SZ | `"...\unins000.exe"` | Uninstaller |

---

## 📝 Notes

- LMMS stores project files (`.mmp`), samples, and plugin configs in `%USERPROFILE%\Documents\lmms\` — the registry only tracks install and working directory paths.
- VST plugin directories are configured within the app's Settings dialog and stored in the LMMS config file (`%APPDATA%\lmms\lmmsrc.xml`), not the registry.
- 32-bit installer writes to `HKLM\SOFTWARE\WOW6432Node\LMMS` on 64-bit Windows.

```powershell
# Check user working directory
(Get-ItemProperty "HKCU:\SOFTWARE\LMMS" -ErrorAction SilentlyContinue).WorkingDir

# Check data directory for samples/presets
(Get-ItemProperty "HKCU:\SOFTWARE\LMMS" -ErrorAction SilentlyContinue).DataDir
```

---

## 🗑️ Cleanup

```powershell
# Remove LMMS registry entries
Remove-Item -Path "HKCU:\SOFTWARE\LMMS" -Recurse -ErrorAction SilentlyContinue
Remove-Item -Path "HKLM:\SOFTWARE\WOW6432Node\LMMS" -Recurse -ErrorAction SilentlyContinue
```

---

## 📦 Package Managers

| Manager | ID / Command |
|---------|-------------|
| winget | `winget install LMMS.LMMS` |
| Chocolatey | `choco install lmms` |
| Scoop | `scoop install extras/lmms` |
