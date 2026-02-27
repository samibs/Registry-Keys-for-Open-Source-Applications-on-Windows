---
tags:
  - display
  - color-temperature
  - blue-light
  - productivity
---

# f.lux

**Version documented:** 4.120
**Installer type:** `.exe` (user-level)
**Hives written:** HKCU

---

## 📁 Registry Paths

| Path | Hive | Purpose |
|------|------|---------|
| `SOFTWARE\Michael Herf\f.lux` | HKCU | Application settings and preferences |
| `SOFTWARE\Microsoft\Windows\CurrentVersion\Run` | HKCU | Startup entry |
| `SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\flux` | HKCU | Uninstall entry |

---

## 🔑 Keys

### HKCU\SOFTWARE\Michael Herf\f.lux

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `dayK` | REG_DWORD | `6500` | Daytime color temperature (Kelvin) |
| `lateafternoonK` | REG_DWORD | `5000` | Late afternoon color temp |
| `eveningK` | REG_DWORD | `3400` | Evening color temp |
| `nightK` | REG_DWORD | `2700` | Nighttime color temp (default warm) |
| `lat` | REG_SZ | `40.7128` | Latitude for sunrise/sunset calc |
| `lon` | REG_SZ | `-74.0060` | Longitude for sunrise/sunset calc |
| `location` | REG_SZ | `New York, NY` | Human-readable location |
| `dimOnBattery` | REG_DWORD | `1` | Dim extra when on battery |
| `transitionSpeed` | REG_DWORD | `3` | Color transition speed |

### HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `f.lux` | REG_SZ | `"C:\Users\User\AppData\Local\FluxSoftware\Flux\flux.exe" /noshow` | Auto-start entry |

### HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\flux

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `DisplayName` | REG_SZ | `f.lux` | Display name |
| `DisplayVersion` | REG_SZ | `4.120` | Version string |
| `Publisher` | REG_SZ | `Michael & Lorna Herf` | Publisher |
| `InstallLocation` | REG_EXPAND_SZ | `%LOCALAPPDATA%\FluxSoftware\Flux` | Install path |

---

## 📝 Notes

- f.lux stores location and temperature preferences in `HKCU\SOFTWARE\Michael Herf\f.lux`.
- Color temperature values are in Kelvin: 6500K = daylight, 2700K = warm/candlelight.
- The `/noshow` flag in the startup entry suppresses the splash on login.

```powershell
# Export f.lux settings for migration
reg export "HKCU\SOFTWARE\Michael Herf\f.lux" "$env:USERPROFILE\flux-settings.reg"

# Set location coordinates for automatic sunrise/sunset
$path = "HKCU:\SOFTWARE\Michael Herf\f.lux"
Set-ItemProperty -Path $path -Name "lat" -Value "51.5074"
Set-ItemProperty -Path $path -Name "lon" -Value "-0.1278"
Set-ItemProperty -Path $path -Name "location" -Value "London, UK"
```

---

## 🗑️ Cleanup

```powershell
# Remove f.lux settings and startup entry
Remove-Item -Path "HKCU:\SOFTWARE\Michael Herf\f.lux" -Recurse -ErrorAction SilentlyContinue
Remove-Item -Path "HKCU:\SOFTWARE\Michael Herf" -Recurse -ErrorAction SilentlyContinue
Remove-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" `
  -Name "f.lux" -ErrorAction SilentlyContinue
```

---

## 📦 Package Managers

| Manager | ID / Command |
|---------|-------------|
| winget | `winget install flux.flux` |
| Chocolatey | `choco install flux` |
| Scoop | `scoop install extras/flux` |
