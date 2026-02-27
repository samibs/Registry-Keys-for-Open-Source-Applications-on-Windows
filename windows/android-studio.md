---
tags:
  - android
  - ide
  - development
  - java
  - kotlin
---

# Android Studio

**Version documented:** 2023.3.1 (Iguana)
**Installer type:** `.exe` (custom)
**Hives written:** HKCU, HKLM

---

## 📁 Registry Paths

| Path | Hive | Purpose |
|------|------|---------|
| `SOFTWARE\Android Studio` | HKCU | Installation reference |
| `SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Android Studio` | HKLM | Uninstall entry |
| `SOFTWARE\Microsoft\Windows\CurrentVersion\Run` | HKCU | Startup entry (if enabled) |

---

## 🔑 Keys

### HKCU\SOFTWARE\Android Studio

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `Path` | REG_SZ | `C:\Program Files\Android\Android Studio` | Installation path |
| `Version` | REG_SZ | `2023.3.1` | Installed version |

### HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Android Studio

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `DisplayName` | REG_SZ | `Android Studio` | Display name |
| `DisplayVersion` | REG_SZ | `2023.3.1.11` | Full build version |
| `Publisher` | REG_SZ | `Google LLC` | Publisher |
| `InstallLocation` | REG_SZ | `C:\Program Files\Android\Android Studio` | Install path |
| `UninstallString` | REG_SZ | `"...\uninstall.exe"` | Uninstaller |

---

## 📝 Notes

- Android Studio stores all IDE settings in `%APPDATA%\Google\AndroidStudio2023.3\` — registry footprint is minimal.
- The Android SDK is installed separately at `%LOCALAPPDATA%\Android\Sdk` by default; its location is stored in the IDE config, not the registry.
- The emulator (AVD Manager) creates virtual devices under `%USERPROFILE%\.android\avd\` — no registry entries.
- `HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run` entry may be added if "Start on boot" is enabled in IDE settings.

```powershell
# Get Android Studio install path
(Get-ItemProperty "HKCU:\SOFTWARE\Android Studio" -ErrorAction SilentlyContinue).Path

# Find Android SDK location from config file
$ideConfig = "$env:APPDATA\Google\AndroidStudio2023.3\options\jdk.table.xml"
if (Test-Path $ideConfig) { Select-String "Android SDK" $ideConfig | Select-Object -First 1 }
```

---

## 🗑️ Cleanup

```powershell
# Remove Android Studio registry entries
Remove-Item -Path "HKCU:\SOFTWARE\Android Studio" -Recurse -ErrorAction SilentlyContinue
Remove-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" `
  -Name "Android Studio" -ErrorAction SilentlyContinue
```

---

## 📦 Package Managers

| Manager | ID / Command |
|---------|-------------|
| winget | `winget install Google.AndroidStudio` |
| Chocolatey | `choco install androidstudio` |
| Scoop | `scoop install extras/android-studio` |
