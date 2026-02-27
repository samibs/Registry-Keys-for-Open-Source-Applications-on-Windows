---
tags:
  - diagramming
  - flowchart
  - design
  - electron
description: >-
  Windows registry keys created by draw.io (diagrams.net) — install paths, uninstall keys, HKCU and HKLM entries for sysadmin automation and cleanup.
---

# draw.io (diagrams.net)

**Version documented:** 24.2.5
**Installer type:** `.exe` (NSIS, user-level)
**Hives written:** HKCU

---

## 📁 Registry Paths

| Path | Hive | Purpose |
|------|------|---------|
| `SOFTWARE\draw.io` | HKCU | Application settings |
| `SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\draw.io` | HKCU | Uninstall entry |
| `SOFTWARE\Classes\drawio` | HKCU | `drawio://` URI scheme |

---

## 🔑 Keys

### HKCU\SOFTWARE\draw.io

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `InstallLocation` | REG_SZ | `C:\Users\User\AppData\Local\draw.io` | Install path |
| `DisplayVersion` | REG_SZ | `24.2.5` | Installed version |

### HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\draw.io

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `DisplayName` | REG_SZ | `draw.io 24.2.5` | Display name |
| `DisplayVersion` | REG_SZ | `24.2.5` | Version |
| `Publisher` | REG_SZ | `JGraph Ltd` | Publisher |
| `InstallLocation` | REG_SZ | `C:\Users\User\AppData\Local\draw.io` | Install path |
| `UninstallString` | REG_SZ | `"...\Uninstall draw.io.exe"` | Uninstaller |

### HKCU\SOFTWARE\Classes\drawio

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `(Default)` | REG_SZ | `URL:drawio` | URI scheme descriptor |
| `URL Protocol` | REG_SZ | `` | Marks as a URL handler |
| `shell\open\command` (Default) | REG_SZ | `"draw.io.exe" "%1"` | Open command |

---

## 📝 Notes

- draw.io uses the Electron/NSIS user-level install pattern — no HKLM writes.
- Diagram files (`.drawio`, `.xml`) are opened directly without file association registration.
- All application preferences are stored in `%APPDATA%\draw.io\` as JSON.
- The desktop app can open `.drawio` and `.xml` files via the `drawio://` URI scheme.

```powershell
# Check install location
(Get-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\draw.io" `
  -ErrorAction SilentlyContinue).InstallLocation

# Disable auto-start if set
Remove-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" `
  -Name "draw.io" -ErrorAction SilentlyContinue
```

---

## 🗑️ Cleanup

```powershell
# Remove draw.io registry entries
Remove-Item -Path "HKCU:\SOFTWARE\draw.io" -Recurse -ErrorAction SilentlyContinue
Remove-Item -Path "HKCU:\SOFTWARE\Classes\drawio" -Recurse -ErrorAction SilentlyContinue
Remove-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\draw.io" `
  -Recurse -ErrorAction SilentlyContinue
```

---

## 📦 Package Managers

| Manager | ID / Command |
|---------|-------------|
| winget | `winget install JGraph.drawio` |
| Chocolatey | `choco install drawio` |
| Scoop | `scoop install extras/drawio` |
