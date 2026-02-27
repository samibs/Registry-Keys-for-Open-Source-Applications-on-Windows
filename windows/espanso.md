---
tags:
  - text-expander
  - automation
  - productivity
  - snippets
---

# Espanso

**Version documented:** 2.2.1
**Installer type:** `.exe` (NSIS)
**Hives written:** HKCU, HKLM

---

## 📁 Registry Paths

| Path | Hive | Purpose |
|------|------|---------|
| `SOFTWARE\espanso` | HKCU | User-level configuration reference |
| `SOFTWARE\Microsoft\Windows\CurrentVersion\Run` | HKCU | Startup entry |
| `SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Espanso` | HKLM | Uninstall entry |

---

## 🔑 Keys

### HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `espanso` | REG_SZ | `"C:\Users\User\AppData\Local\espanso\espanso.exe" daemon` | Auto-start daemon |

### HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Espanso

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `DisplayName` | REG_SZ | `Espanso` | Display name |
| `DisplayVersion` | REG_SZ | `2.2.1` | Version string |
| `Publisher` | REG_SZ | `Federico Terzi` | Publisher |
| `InstallLocation` | REG_SZ | `C:\Users\User\AppData\Local\espanso` | Install path |
| `UninstallString` | REG_SZ | `"...\unins000.exe"` | Uninstaller path |

---

## 📝 Notes

- Espanso is primarily config-file driven (`%CONFIG%\espanso\`) — the registry footprint is minimal.
- The daemon startup entry in `HKCU\Run` is added during install; removing it prevents Espanso from starting with Windows without uninstalling.
- Configuration lives at `%APPDATA%\espanso\` — back this up to migrate settings.

```powershell
# Disable Espanso auto-start without uninstalling
Remove-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" `
  -Name "espanso" -ErrorAction SilentlyContinue

# Re-enable auto-start
$exe = "$env:LOCALAPPDATA\espanso\espanso.exe"
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" `
  -Name "espanso" -Value "`"$exe`" daemon"
```

---

## 🗑️ Cleanup

```powershell
# Remove Espanso auto-start
Remove-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" `
  -Name "espanso" -ErrorAction SilentlyContinue

# Remove user settings key
Remove-Item -Path "HKCU:\SOFTWARE\espanso" -Recurse -ErrorAction SilentlyContinue
```

---

## 📦 Package Managers

| Manager | ID / Command |
|---------|-------------|
| winget | `winget install Espanso.Espanso` |
| Chocolatey | `choco install espanso` |
| Scoop | `scoop install extras/espanso` |
