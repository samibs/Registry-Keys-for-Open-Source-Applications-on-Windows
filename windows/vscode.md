---
tags:
  - text-editor
  - ide
  - HKCU
  - HKCR
  - exe-installer
  - developer-tools
---

# Visual Studio Code

**Version tested:** 1.85.1
**Installer type:** User Installer `.exe`


## 📦 Package Managers

| Manager    | Install Command |
|------------|-----------------|
| winget     | `winget install Microsoft.VisualStudioCode` |
| Chocolatey | `choco install vscode` |
| Scoop      | `scoop install vscode` |

## 📁 Registry Paths

- `HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Uninstall\{771FD6B0-FA20-440A-A002-3B3BAC16DC50}_is1`
- `HKEY_CURRENT_USER\Software\Classes\vscode`
- `HKEY_CURRENT_USER\Software\Classes\vscode-insiders` *(Insiders builds only)*

## 🔑 Keys

### Uninstall entry (`HKCU\...\Uninstall\...`)

| Key Name           | Type        | Description                                           |
|--------------------|-------------|-------------------------------------------------------|
| `DisplayName`      | `REG_SZ`    | Human-readable name: `Microsoft Visual Studio Code`   |
| `DisplayVersion`   | `REG_SZ`    | Installed version (e.g., `1.85.1`)                    |
| `DisplayIcon`      | `REG_SZ`    | Full path to `Code.exe` used as the taskbar/ARP icon  |
| `InstallLocation`  | `REG_SZ`    | Root installation directory (e.g., `C:\Users\<user>\AppData\Local\Programs\Microsoft VS Code`) |
| `Publisher`        | `REG_SZ`    | `Microsoft Corporation`                               |
| `UninstallString`  | `REG_SZ`    | Path to the uninstaller executable                    |
| `NoModify`         | `REG_DWORD` | `1` — suppresses "Modify" button in Add/Remove Programs |
| `NoRepair`         | `REG_DWORD` | `1` — suppresses "Repair" button in Add/Remove Programs |

### URI handler (`HKCU\Software\Classes\vscode`)

| Key Name    | Type     | Description                                           |
|-------------|----------|-------------------------------------------------------|
| `(Default)` | `REG_SZ` | `URL:vscode` — registers the `vscode://` URI scheme   |
| `URL Protocol` | `REG_SZ` | Empty string; marks this as a URL protocol handler |

## 📝 Notes

- The user installer writes exclusively to `HKCU`. The **System Installer** (for all users) creates the same keys under `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\`.
- The uninstall GUID in the registry path (`{771FD6B0-...}`) may differ slightly between patch versions; always confirm via `Get-ChildItem HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\ | Where-Object { $_.GetValue("DisplayName") -like "*Visual Studio Code*" }`.
- VS Code stores all user settings (extensions, preferences, keybindings) in `%APPDATA%\Code\`, not the registry.
- The `vscode://` URI scheme is used by extension marketplaces and external tools to trigger commands inside VS Code directly.

## 🗑️ Cleanup

The uninstall GUID varies per version; use the dynamic lookup below:

```powershell
# User installer (HKCU)
Get-ChildItem "HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall" |
  Where-Object { $_.GetValue("DisplayName") -like "*Visual Studio Code*" } |
  ForEach-Object { Remove-Item $_.PSPath -Recurse -Force }

# URI handlers
Remove-Item -Path "HKCU:\Software\Classes\vscode"          -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path "HKCU:\Software\Classes\vscode-insiders"  -Recurse -Force -ErrorAction SilentlyContinue

# System installer (HKLM) — run as Administrator
Get-ChildItem "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall" |
  Where-Object { $_.GetValue("DisplayName") -like "*Visual Studio Code*" } |
  ForEach-Object { Remove-Item $_.PSPath -Recurse -Force }
```
