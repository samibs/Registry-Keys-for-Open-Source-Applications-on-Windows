---
tags:
  - screenshot
  - recording
  - HKCU
  - HKLM
  - HKCR
  - exe-installer
---

# ShareX

**Version tested:** 16.0.0
**Installer type:** `.exe` official installer from getsharex.com

## 📦 Package Managers

| Manager    | Install Command |
|------------|-----------------|
| winget     | `winget install ShareX.ShareX` |
| Chocolatey | `choco install sharex` |
| Scoop      | `scoop install sharex` |

## 📁 Registry Paths

- `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\ShareX_is1`
- `HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run` *(startup entry)*
- `HKEY_CLASSES_ROOT\sharex` *(sharex:// URI handler)*

## 🔑 Keys

### Startup entry (`HKCU\...\Run`)

| Key Name  | Type     | Description                                              |
|-----------|----------|----------------------------------------------------------|
| `ShareX`  | `REG_SZ` | Path to `ShareX.exe` — launches ShareX at Windows logon  |

### URI handler (`HKCR\sharex`)

| Key Path                              | Type     | Description                                          |
|---------------------------------------|----------|------------------------------------------------------|
| `(Default)`                           | `REG_SZ` | `URL:ShareX`                                         |
| `URL Protocol`                        | `REG_SZ` | Empty string — marks key as URL protocol handler     |
| `shell\open\command\(Default)`       | `REG_SZ` | `"C:\...\ShareX.exe" "%1"`                           |

### Uninstall entry (`HKLM\...\Uninstall\ShareX_is1`)

| Key Name          | Type     | Description                                        |
|-------------------|----------|----------------------------------------------------|
| `DisplayName`     | `REG_SZ` | `ShareX 16.0.0`                                    |
| `DisplayVersion`  | `REG_SZ` | Installed version                                  |
| `Publisher`       | `REG_SZ` | `ShareX Team`                                      |
| `InstallLocation` | `REG_SZ` | Root installation directory                        |
| `UninstallString` | `REG_SZ` | Path to the Inno Setup uninstaller                 |

## 📝 Notes

- Nearly all ShareX configuration (hotkeys, destinations, upload accounts, task settings) is stored in `%APPDATA%\ShareX\ApplicationConfig.json` — not the registry.
- ShareX registers a `sharex://` URI scheme for integration with browser extensions (ShareX browser extension triggers captures via this handler).
- The startup entry in `HKCU\...\Run` can be toggled in ShareX Settings → General → "Start ShareX when Windows starts".
- ShareX is highly extensible via custom upload destinations, OCR, and automation actions — none of these extensions use the registry.
- ShareX is fully open-source (GPL-3.0) and maintained at [github.com/ShareX/ShareX](https://github.com/ShareX/ShareX).

## 🗑️ Cleanup

```powershell
Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run" -Name "ShareX" -ErrorAction SilentlyContinue
Remove-Item -Path "HKCR:\sharex"  -Recurse -Force -ErrorAction SilentlyContinue

Get-ChildItem "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall" |
  Where-Object { $_.GetValue("DisplayName") -like "ShareX*" } |
  ForEach-Object { Remove-Item $_.PSPath -Recurse -Force }
```
