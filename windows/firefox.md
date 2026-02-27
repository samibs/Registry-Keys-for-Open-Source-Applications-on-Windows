---
tags:
  - browser
  - HKCU
  - HKLM
  - HKCR
  - exe-installer
description: >-
  Windows registry keys created by Mozilla Firefox — install paths, uninstall keys, HKCU and HKLM entries for sysadmin automation and cleanup.
---

# Mozilla Firefox

**Version tested:** 123.0
**Installer type:** `.exe` official full installer from mozilla.org


## 📦 Package Managers

| Manager    | Install Command |
|------------|-----------------|
| winget     | `winget install Mozilla.Firefox` |
| Chocolatey | `choco install firefox` |
| Scoop      | `scoop install firefox` |

## 📁 Registry Paths

- `HKEY_LOCAL_MACHINE\SOFTWARE\Mozilla\Mozilla Firefox`
- `HKEY_LOCAL_MACHINE\SOFTWARE\Mozilla\Mozilla Firefox\<version> (x64 en-US)\Main`
- `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Mozilla Firefox <version> (x64 en-US)`
- `HKEY_CURRENT_USER\Software\Mozilla\Mozilla Firefox` *(created at first launch)*
- `HKEY_CLASSES_ROOT\FirefoxHTML-<hash>` *(HTML file handler ProgID)*
- `HKEY_CLASSES_ROOT\FirefoxURL-<hash>` *(http/https URL handler ProgID)*

## 🔑 Keys

### Application root (`HKLM\SOFTWARE\Mozilla\Mozilla Firefox`)

| Key Name         | Type     | Description                                           |
|------------------|----------|-------------------------------------------------------|
| `CurrentVersion` | `REG_SZ` | Installed version string (e.g., `123.0 (x64 en-US)`) |

### Version/Main subkey (`HKLM\SOFTWARE\Mozilla\Mozilla Firefox\<version>\Main`)

| Key Name              | Type     | Description                                              |
|-----------------------|----------|----------------------------------------------------------|
| `Install Directory`   | `REG_SZ` | Root installation path (e.g., `C:\Program Files\Mozilla Firefox`) |
| `PathToExe`           | `REG_SZ` | Full path to `firefox.exe`                              |

### Uninstall entry (`HKLM\...\Uninstall\Mozilla Firefox <version> (x64 en-US)`)

| Key Name           | Type        | Description                                         |
|--------------------|-------------|-----------------------------------------------------|
| `DisplayName`      | `REG_SZ`    | `Mozilla Firefox 123.0 (x64 en-US)`               |
| `DisplayVersion`   | `REG_SZ`    | Installed version (e.g., `123.0`)                  |
| `DisplayIcon`      | `REG_SZ`    | Path to `firefox.exe`                              |
| `InstallLocation`  | `REG_SZ`    | Root installation directory                         |
| `Publisher`        | `REG_SZ`    | `Mozilla`                                          |
| `UninstallString`  | `REG_SZ`    | Path to the uninstaller with `/S` for silent mode  |
| `URLInfoAbout`     | `REG_SZ`    | `https://www.mozilla.org`                          |

## 📝 Notes

- All user data (bookmarks, history, extensions, preferences) is stored in the Firefox profile at `%APPDATA%\Mozilla\Firefox\Profiles\`, not the registry.
- The version-specific subkey path changes with every update (e.g., `123.0 (x64 en-US)` → `124.0 (x64 en-US)`); query `CurrentVersion` to find the active path.
- Enterprise policy settings can be pushed via `HKLM\SOFTWARE\Policies\Mozilla\Firefox` — see [Firefox Enterprise Policies](https://github.com/mozilla/policy-templates).
- The 32-bit installer on 64-bit Windows places keys under `HKLM\SOFTWARE\WOW6432Node\Mozilla`.
- The **MSI** enterprise installer uses the same registry structure but allows per-machine deployment via Group Policy.
- The `FirefoxHTML-<hash>` and `FirefoxURL-<hash>` ProgIDs are unique per installation (hash is derived from the install path) to support multiple Firefox installs side-by-side.

## 🌐 HKCR — URL & File Handlers

### HTML file handler (`HKCR\FirefoxHTML-<hash>`)

| Key Path                                         | Type     | Description                                         |
|--------------------------------------------------|----------|-----------------------------------------------------|
| `(Default)`                                      | `REG_SZ` | `Firefox HTML Document`                             |
| `shell\open\command\(Default)`                  | `REG_SZ` | `"C:\...\firefox.exe" -osint -url "%1"`             |

### URL protocol handler (`HKCR\FirefoxURL-<hash>`)

| Key Path                                         | Type     | Description                                          |
|--------------------------------------------------|----------|------------------------------------------------------|
| `(Default)`                                      | `REG_SZ` | `Firefox URL`                                        |
| `URL Protocol`                                   | `REG_SZ` | Empty string — marks key as a URL protocol handler   |
| `shell\open\command\(Default)`                  | `REG_SZ` | `"C:\...\firefox.exe" -osint -url "%1"`              |

To find the exact hash on a given machine:

```powershell
Get-ChildItem "HKCR:\" | Where-Object { $_.Name -match "FirefoxHTML|FirefoxURL" }
```

## 🗑️ Cleanup

```powershell
Remove-Item -Path "HKCU:\Software\Mozilla\Firefox"           -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path "HKLM:\SOFTWARE\Mozilla\Mozilla Firefox"   -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path "HKLM:\SOFTWARE\WOW6432Node\Mozilla"       -Recurse -Force -ErrorAction SilentlyContinue
```
