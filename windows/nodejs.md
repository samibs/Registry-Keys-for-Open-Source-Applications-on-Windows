---
tags:
  - javascript
  - runtime
  - HKLM
  - msi-installer
  - developer-tools
---

# Node.js

**Version tested:** 20.11.1 LTS
**Installer type:** `.msi` official installer from nodejs.org

## 📦 Package Managers

| Manager    | Install Command |
|------------|-----------------|
| winget     | `winget install OpenJS.NodeJS.LTS` |
| Chocolatey | `choco install nodejs-lts` |
| Scoop      | `scoop install nodejs-lts` |

## 📁 Registry Paths

- `HKEY_LOCAL_MACHINE\SOFTWARE\Node.js`
- `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{<GUID>}` *(MSI uninstall entry)*

## 🔑 Keys

### Installation entry (`HKLM\SOFTWARE\Node.js`)

| Key Name        | Type     | Description                                              |
|-----------------|----------|----------------------------------------------------------|
| `(Default)`     | `REG_SZ` | Root installation directory (e.g., `C:\Program Files\nodejs`) |
| `Version`       | `REG_SZ` | Installed version string (e.g., `20.11.1`)              |

### Uninstall entry (`HKLM\...\Uninstall\{<GUID>}`)

| Key Name          | Type        | Description                                          |
|-------------------|-------------|------------------------------------------------------|
| `DisplayName`     | `REG_SZ`    | `Node.js`                                            |
| `DisplayVersion`  | `REG_SZ`    | Installed version (e.g., `20.11.1`)                  |
| `InstallLocation` | `REG_SZ`    | Root installation directory                          |
| `Publisher`       | `REG_SZ`    | `Node.js Foundation`                                 |
| `UninstallString` | `REG_SZ`    | `MsiExec.exe /I{<GUID>}`                             |

## 📝 Notes

- The Node.js MSI installer adds `C:\Program Files\nodejs\` to the system `PATH` via `HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment\Path`.
- npm is bundled with Node.js; global npm packages installed via `npm install -g` go to `%APPDATA%\npm\` and that directory is also added to `PATH`.
- **nvm-windows** (Node Version Manager for Windows) is a popular alternative; it stores per-version Node installs in `%APPDATA%\nvm\` and writes its own `HKCU` keys.
- The MSI installer creates a Windows Installer product entry; use `msiexec /x {GUID}` or Add/Remove Programs for clean uninstall.
- No file type associations are created by the installer; `.js` files are typically associated with Windows Script Host (`wscript.exe`) unless changed.

## 🗑️ Cleanup

```powershell
# Installation entry
Remove-Item -Path "HKLM:\SOFTWARE\Node.js"  -Recurse -Force -ErrorAction SilentlyContinue

# Uninstall entry (GUID varies — use dynamic lookup)
Get-ChildItem "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall" |
  Where-Object { $_.GetValue("DisplayName") -like "Node.js*" } |
  ForEach-Object { Remove-Item $_.PSPath -Recurse -Force }
```
