---
tags:
  - imaging
  - usb
  - flashing
  - electron
---

# balenaEtcher

**Version documented:** 1.19.21
**Installer type:** `.exe` (NSIS, user-level)
**Hives written:** HKCU, HKLM

---

## 📁 Registry Paths

| Path | Hive | Purpose |
|------|------|---------|
| `SOFTWARE\balena\balenaEtcher` | HKCU | User preferences |
| `SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{GUID}` | HKCU | Uninstall entry (user install) |
| `SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\balenaEtcher` | HKLM | Uninstall entry (machine install) |

---

## 🔑 Keys

### HKCU\SOFTWARE\balena\balenaEtcher

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `updater.disabled` | REG_SZ | `false` | Auto-update toggle |
| `analytics.enabled` | REG_SZ | `false` | Usage analytics |
| `windowBounds` | REG_SZ | `{"x":100,"y":100,"width":800,"height":600}` | Saved window position/size |
| `lastOpenedDrive` | REG_SZ | `\\.\PHYSICALDRIVE1` | Last target drive |

### HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{GUID}

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `DisplayName` | REG_SZ | `balenaEtcher 1.19.21` | Display name |
| `DisplayVersion` | REG_SZ | `1.19.21` | Version string |
| `Publisher` | REG_SZ | `Balena` | Publisher |
| `InstallLocation` | REG_EXPAND_SZ | `%LOCALAPPDATA%\Programs\balenaEtcher` | Install path |
| `UninstallString` | REG_SZ | `"...\Uninstall balenaEtcher.exe"` | Uninstaller path |

---

## 📝 Notes

- User-level installs write uninstall entry to HKCU; machine-level write to HKLM.
- Preferences stored as JSON strings in REG_SZ values (Electron app pattern).
- No HKCR file associations — Etcher does not register `.img`/`.iso` handlers.
- To disable analytics before first launch, pre-create the `analytics.enabled` key set to `false`.

```powershell
# Disable analytics silently
$path = "HKCU:\SOFTWARE\balena\balenaEtcher"
if (-not (Test-Path $path)) { New-Item -Path $path -Force | Out-Null }
Set-ItemProperty -Path $path -Name "analytics.enabled" -Value "false"
```

---

## 🗑️ Cleanup

```powershell
# Remove balenaEtcher registry entries after uninstall
Remove-Item -Path "HKCU:\SOFTWARE\balena\balenaEtcher" -Recurse -ErrorAction SilentlyContinue
Remove-Item -Path "HKCU:\SOFTWARE\balena" -Recurse -ErrorAction SilentlyContinue

# Remove uninstall entry (user-level install)
Get-ChildItem "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall" |
  Where-Object { (Get-ItemProperty $_.PSPath).DisplayName -like "*balenaEtcher*" } |
  Remove-Item -Recurse -ErrorAction SilentlyContinue
```

---

## 📦 Package Managers

| Manager | ID / Command |
|---------|-------------|
| winget | `winget install Balena.balenaEtcher` |
| Chocolatey | `choco install etcher` |
| Scoop | `scoop install extras/balenaetcher` |
