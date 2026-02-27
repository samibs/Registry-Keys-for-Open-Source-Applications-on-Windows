---
tags:
  - notes
  - markdown
  - knowledge-base
  - electron
---

# Obsidian

**Version documented:** 1.5.12
**Installer type:** `.exe` (Squirrel, user-level)
**Hives written:** HKCU

---

## 📁 Registry Paths

| Path | Hive | Purpose |
|------|------|---------|
| `SOFTWARE\obsidian` | HKCU | Application settings |
| `SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\obsidian` | HKCU | Uninstall entry |
| `SOFTWARE\Microsoft\Windows\CurrentVersion\Run` | HKCU | Startup entry (if enabled) |

---

## 🔑 Keys

### HKCU\SOFTWARE\obsidian

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `InstallLocation` | REG_SZ | `C:\Users\User\AppData\Local\Obsidian` | Install directory |
| `DisplayVersion` | REG_SZ | `1.5.12` | Installed version |

### HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\obsidian

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `DisplayName` | REG_SZ | `Obsidian` | Display name |
| `DisplayVersion` | REG_SZ | `1.5.12` | Version |
| `Publisher` | REG_SZ | `Obsidian.md` | Publisher |
| `InstallLocation` | REG_SZ | `C:\Users\User\AppData\Local\Obsidian` | Install path |
| `UninstallString` | REG_SZ | `"...\Uninstall Obsidian.exe"` | Uninstaller |

### HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run (optional)

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `Obsidian` | REG_SZ | `"...\Obsidian.exe" --startup` | Auto-start on login (if enabled) |

---

## 📝 Notes

- Obsidian uses the Squirrel installer framework (like Signal, Slack) — installs per-user to `%LOCALAPPDATA%\Obsidian`.
- Vault data and all settings are stored in `.obsidian/` inside each vault folder (not the registry).
- Updates are handled by Squirrel's automatic updater, not Windows Update or any system mechanism.
- The app registers the `obsidian://` URI scheme at `HKCU\SOFTWARE\Classes\obsidian`.

```powershell
# Check install location
(Get-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\obsidian" `
  -ErrorAction SilentlyContinue).InstallLocation

# Remove auto-start if set
Remove-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" `
  -Name "Obsidian" -ErrorAction SilentlyContinue
```

---

## 🗑️ Cleanup

```powershell
# Remove Obsidian registry entries
Remove-Item -Path "HKCU:\SOFTWARE\obsidian" -Recurse -ErrorAction SilentlyContinue
Remove-Item -Path "HKCU:\SOFTWARE\Classes\obsidian" -Recurse -ErrorAction SilentlyContinue
Remove-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" `
  -Name "Obsidian" -ErrorAction SilentlyContinue

# Remove uninstall entry
Remove-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\obsidian" `
  -Recurse -ErrorAction SilentlyContinue
```

---

## 📦 Package Managers

| Manager | ID / Command |
|---------|-------------|
| winget | `winget install Obsidian.Obsidian` |
| Chocolatey | `choco install obsidian` |
| Scoop | `scoop install extras/obsidian` |
