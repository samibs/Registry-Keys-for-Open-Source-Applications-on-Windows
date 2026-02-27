---
tags:
  - pdf
  - viewer
  - reader
  - lightweight
description: >-
  Windows registry keys created by Sumatra PDF — install paths, uninstall keys, HKCU and HKLM entries for sysadmin automation and cleanup.
---

# Sumatra PDF

**Version documented:** 3.5.2
**Installer type:** `.exe` (NSIS) / Portable
**Hives written:** HKCU, HKLM, HKCR

---

## 📁 Registry Paths

| Path | Hive | Purpose |
|------|------|---------|
| `SOFTWARE\SumatraPDF` | HKCU | User preferences and state |
| `SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\SumatraPDF` | HKLM | Uninstall entry |
| `HKCR\.pdf\OpenWithProgIds\SumatraPDF` | HKCR | .pdf file association |
| `HKCR\SumatraPDF` | HKCR | ProgID definition |
| `HKCR\.epub\OpenWithProgIds\SumatraPDF` | HKCR | .epub association |
| `HKCR\.cbz\OpenWithProgIds\SumatraPDF` | HKCR | .cbz (comic book) association |

---

## 🔑 Keys

### HKCU\SOFTWARE\SumatraPDF

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `Window_DX` | REG_DWORD | `1200` | Window width in pixels |
| `Window_DY` | REG_DWORD | `900` | Window height in pixels |
| `Window_X` | REG_DWORD | `100` | Window left position |
| `Window_Y` | REG_DWORD | `50` | Window top position |
| `ShowToolbar` | REG_DWORD | `1` | Toolbar visible (1=yes) |
| `DefaultDisplayMode` | REG_SZ | `single page` | Display mode |
| `DefaultZoom` | REG_SZ | `fit page` | Default zoom level |
| `RememberStatePerDocument` | REG_DWORD | `1` | Remember per-file zoom/page |
| `CheckForUpdates` | REG_DWORD | `1` | Auto-update check |

### HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\SumatraPDF

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `DisplayName` | REG_SZ | `SumatraPDF` | Display name |
| `DisplayVersion` | REG_SZ | `3.5.2` | Version |
| `Publisher` | REG_SZ | `Krzysztof Kowalczyk` | Publisher |
| `InstallLocation` | REG_SZ | `C:\Program Files\SumatraPDF` | Install path |
| `UninstallString` | REG_SZ | `"...\uninstall.exe"` | Uninstaller |

### HKCR\SumatraPDF

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `(Default)` | REG_SZ | `PDF Document` | Friendly type name |
| `shell\open\command` (Default) | REG_SZ | `"SumatraPDF.exe" "%1"` | Open command |

---

## 📝 Notes

- Sumatra PDF registers associations for: `.pdf`, `.epub`, `.mobi`, `.cbz`, `.cbr`, `.djvu`, `.xps`, `.oxps`.
- The portable version writes no registry keys; preferences are stored in `SumatraPDF-settings.txt` alongside the `.exe`.
- The `-set-color-range` and other CLI flags can set preferences without writing to the registry.

```powershell
# Check if SumatraPDF is the default PDF handler
(Get-ItemProperty "HKCR:\.pdf" -ErrorAction SilentlyContinue).'(Default)'

# Export window/zoom preferences for migration
reg export "HKCU\SOFTWARE\SumatraPDF" "$env:USERPROFILE\sumatrapdf-settings.reg"
```

---

## 🗑️ Cleanup

```powershell
# Remove SumatraPDF user preferences
Remove-Item -Path "HKCU:\SOFTWARE\SumatraPDF" -Recurse -ErrorAction SilentlyContinue

# Remove file associations
foreach ($ext in @('.pdf','.epub','.mobi','.cbz','.cbr','.djvu','.xps')) {
    Remove-ItemProperty "HKCR:\$ext\OpenWithProgIds" -Name "SumatraPDF" -ErrorAction SilentlyContinue
}
Remove-Item -Path "HKCR:\SumatraPDF" -Recurse -ErrorAction SilentlyContinue
```

---

## 📦 Package Managers

| Manager | ID / Command |
|---------|-------------|
| winget | `winget install SumatraPDF.SumatraPDF` |
| Chocolatey | `choco install sumatrapdf` |
| Scoop | `scoop install extras/sumatrapdf` |
