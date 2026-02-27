---
tags:
  - pdf
  - split
  - merge
  - document
description: >-
  Windows registry keys created by PDFsam Basic — install paths, uninstall keys, HKCU and HKLM entries for sysadmin automation and cleanup.
---

# PDFsam Basic

**Version documented:** 5.2.4
**Installer type:** `.exe` (NSIS)
**Hives written:** HKCU, HKLM

---

## 📁 Registry Paths

| Path | Hive | Purpose |
|------|------|---------|
| `SOFTWARE\pdfsam` | HKCU | User preferences |
| `SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\pdfsam_is1` | HKLM | Uninstall entry |

---

## 🔑 Keys

### HKCU\SOFTWARE\pdfsam

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `locale` | REG_SZ | `en_US` | UI language locale |
| `theme` | REG_SZ | `DARK` | UI theme (DARK or LIGHT) |
| `checkForUpdates` | REG_DWORD | `1` | Enable update check on start |
| `premium` | REG_DWORD | `0` | Premium license flag |
| `analytics` | REG_DWORD | `0` | Usage analytics consent |
| `workingDirectory` | REG_SZ | `C:\Users\User\Documents` | Default output directory |

### HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\pdfsam_is1

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `DisplayName` | REG_SZ | `PDFsam Basic 5.2.4` | Display name |
| `DisplayVersion` | REG_SZ | `5.2.4` | Version |
| `Publisher` | REG_SZ | `Andrea Vacondio` | Publisher |
| `InstallLocation` | REG_SZ | `C:\Program Files\pdfsam` | Install path |
| `UninstallString` | REG_SZ | `"...\unins000.exe"` | Uninstaller |

---

## 📝 Notes

- PDFsam is a Java-based application — it requires a JRE (bundled since v4).
- No HKCR file associations are registered; PDFsam does not claim `.pdf` as a default handler.
- Analytics can be disabled before first launch by pre-setting `analytics = 0` in the registry.

```powershell
# Disable analytics and update check silently before deployment
$path = "HKCU:\SOFTWARE\pdfsam"
if (-not (Test-Path $path)) { New-Item -Path $path -Force | Out-Null }
Set-ItemProperty -Path $path -Name "analytics" -Value 0 -Type DWord
Set-ItemProperty -Path $path -Name "checkForUpdates" -Value 0 -Type DWord
```

---

## 🗑️ Cleanup

```powershell
# Remove PDFsam user preferences
Remove-Item -Path "HKCU:\SOFTWARE\pdfsam" -Recurse -ErrorAction SilentlyContinue
```

---

## 📦 Package Managers

| Manager | ID / Command |
|---------|-------------|
| winget | `winget install AndreaVacondio.PDFsamBasic` |
| Chocolatey | `choco install pdfsam` |
| Scoop | `scoop install extras/pdfsam` |
