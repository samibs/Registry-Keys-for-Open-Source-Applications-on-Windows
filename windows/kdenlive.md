---
tags:
  - video-editor
  - multimedia
  - kde
  - production
description: >-
  Windows registry keys created by Kdenlive — install paths, uninstall keys, HKCU and HKLM entries for sysadmin automation and cleanup.
---

# Kdenlive

**Version documented:** 24.02.1
**Installer type:** `.exe` (NSIS)
**Hives written:** HKCU, HKLM

---

## 📁 Registry Paths

| Path | Hive | Purpose |
|------|------|---------|
| `SOFTWARE\kdenlive` | HKCU | User preferences |
| `SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\kdenlive` | HKLM | Uninstall entry |

---

## 🔑 Keys

### HKCU\SOFTWARE\kdenlive

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `InstallDir` | REG_SZ | `C:\Program Files\kdenlive` | Installation directory |
| `Version` | REG_SZ | `24.02.1` | Installed version |

### HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\kdenlive

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `DisplayName` | REG_SZ | `Kdenlive 24.02.1` | Display name |
| `DisplayVersion` | REG_SZ | `24.02.1` | Version |
| `Publisher` | REG_SZ | `KDE e.V.` | Publisher |
| `InstallLocation` | REG_SZ | `C:\Program Files\kdenlive` | Install path |
| `UninstallString` | REG_SZ | `"...\unins000.exe"` | Uninstaller |

---

## 📝 Notes

- Kdenlive stores all project settings and preferences in `%APPDATA%\kdenlive\` — the registry contains only install metadata.
- Kdenlive bundles MLT (Media Lovin' Toolkit) framework; no separate MLT registry keys are written.
- The `.kdenlive` project file format is XML-based; no HKCR file association is registered by default.
- FFmpeg is bundled with the Windows installer at `C:\Program Files\kdenlive\bin\`.

```powershell
# Check Kdenlive install directory
(Get-ItemProperty "HKCU:\SOFTWARE\kdenlive" -ErrorAction SilentlyContinue).InstallDir

# Find bundled FFmpeg
$kdDir = (Get-ItemProperty "HKCU:\SOFTWARE\kdenlive" -ErrorAction SilentlyContinue).InstallDir
if ($kdDir) { Get-Item "$kdDir\bin\ffmpeg.exe" -ErrorAction SilentlyContinue }
```

---

## 🗑️ Cleanup

```powershell
# Remove Kdenlive registry entries
Remove-Item -Path "HKCU:\SOFTWARE\kdenlive" -Recurse -ErrorAction SilentlyContinue
```

---

## 📦 Package Managers

| Manager | ID / Command |
|---------|-------------|
| winget | `winget install KDE.Kdenlive` |
| Chocolatey | `choco install kdenlive` |
| Scoop | `scoop install extras/kdenlive` |
