---
tags:
  - hardware
  - monitoring
  - diagnostics
  - sensors
description: >-
  Windows registry keys created by HWiNFO — install paths, uninstall keys, HKCU and HKLM entries for sysadmin automation and cleanup.
---

# HWiNFO

**Version documented:** 7.72
**Installer type:** `.exe` (NSIS) / Portable
**Hives written:** HKCU, HKLM

---

## 📁 Registry Paths

| Path | Hive | Purpose |
|------|------|---------|
| `SOFTWARE\HWiNFO64` | HKCU | User preferences and layout |
| `SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\HWiNFO64_is1` | HKLM | Uninstall entry |

---

## 🔑 Keys

### HKCU\SOFTWARE\HWiNFO64

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `SensorsOnly` | REG_DWORD | `0` | Start in Sensors Only mode (1=yes) |
| `SensorsSM` | REG_DWORD | `0` | Write sensor data to Shared Memory |
| `SMMemSize` | REG_DWORD | `262144` | Shared Memory size (bytes) |
| `StartMinimized` | REG_DWORD | `0` | Start minimized to tray (1=yes) |
| `MinimizeSensors` | REG_DWORD | `0` | Minimize sensors window on start |
| `AutoRun` | REG_DWORD | `0` | Start with Windows (1=yes) |
| `PollInterval` | REG_DWORD | `2000` | Sensor poll interval (ms) |
| `UpdateCheckEnabled` | REG_DWORD | `1` | Check for updates at startup |
| `MainWindowLeft` | REG_DWORD | `100` | Main window X position |
| `MainWindowTop` | REG_DWORD | `50` | Main window Y position |

### HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\HWiNFO64_is1

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `DisplayName` | REG_SZ | `HWiNFO 7.72` | Display name |
| `DisplayVersion` | REG_SZ | `7.72` | Version |
| `Publisher` | REG_SZ | `REALiX` | Publisher |
| `InstallLocation` | REG_SZ | `C:\Program Files\HWiNFO64\` | Install path |
| `UninstallString` | REG_SZ | `"...\unins000.exe"` | Uninstaller |

---

## 📝 Notes

- Portable version writes no registry keys; settings go to `HWiNFO64.INI` alongside the `.exe`.
- `SensorsSM = 1` enables Shared Memory export for integration with tools like RTSS, Rainmeter, or custom scripts.
- `AutoRun = 1` adds an entry to `HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run`.

```powershell
# Enable Shared Memory for sensor data export (e.g., Rainmeter integration)
$path = "HKCU:\SOFTWARE\HWiNFO64"
if (-not (Test-Path $path)) { New-Item -Path $path -Force | Out-Null }
Set-ItemProperty -Path $path -Name "SensorsSM" -Value 1 -Type DWord

# Enable sensors-only mode with minimized start (headless monitoring)
Set-ItemProperty -Path $path -Name "SensorsOnly" -Value 1 -Type DWord
Set-ItemProperty -Path $path -Name "StartMinimized" -Value 1 -Type DWord
```

---

## 🗑️ Cleanup

```powershell
# Remove HWiNFO user preferences
Remove-Item -Path "HKCU:\SOFTWARE\HWiNFO64" -Recurse -ErrorAction SilentlyContinue

# Remove startup entry if set
Remove-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" `
  -Name "HWiNFO64" -ErrorAction SilentlyContinue
```

---

## 📦 Package Managers

| Manager | ID / Command |
|---------|-------------|
| winget | `winget install REALiX.HWiNFO` |
| Chocolatey | `choco install hwinfo` |
| Scoop | `scoop install extras/hwinfo` |
