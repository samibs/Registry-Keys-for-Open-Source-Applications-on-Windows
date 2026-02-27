---
tags:
  - terminal
  - ssh
  - remote
  - tabbed
description: >-
  Windows registry keys created by Windows Terminal — install paths, uninstall keys, HKCU and HKLM entries for sysadmin automation and cleanup.
---

# Windows Terminal

**Version:** 1.19.11213.0  
**Installer:** MSIX (Microsoft Store) / winget  
**Hives:** HKCU, HKLM

Windows Terminal is a modern, open-source terminal application from Microsoft for command-line tools including PowerShell, Command Prompt, WSL, and SSH. Features tabs, panes, GPU-accelerated text rendering, and full Unicode support.

---

## 📁 Registry Paths

| Path | Hive | Description |
|------|------|-------------|
| `SOFTWARE\Microsoft\Windows Terminal` | HKCU | Per-user settings root |
| `SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\wt.exe` | HKLM | `wt.exe` launch path for Run dialog |
| `SOFTWARE\Classes\Directory\shell\Open with Windows Terminal` | HKLM | Explorer context menu: "Open in Windows Terminal" |
| `SOFTWARE\Classes\Directory\Background\shell\Open with Windows Terminal` | HKLM | Explorer background context menu |

---

## 🔑 Keys

### HKCU\SOFTWARE\Microsoft\Windows Terminal

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `DefaultProfile` | `REG_SZ` | `{61c54bbd-c2c6-5271-96e7-009a87ff44bf}` | GUID of the default profile |
| `Theme` | `REG_SZ` | `dark` | UI theme (`dark`, `light`, `system`) |
| `LaunchMode` | `REG_SZ` | `default` | Window launch mode (`default`, `maximized`, `fullscreen`) |
| `CopyOnSelect` | `REG_DWORD` | `0` | Auto-copy selection to clipboard |
| `WordDelimiters` | `REG_SZ` | ` /\()"'-:,.;<>~!@#$%^&*|+=[]{}~?│` | Characters treated as word delimiters |

### HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\wt.exe

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `(Default)` | `REG_SZ` | `C:\Program Files\WindowsApps\Microsoft.WindowsTerminal_...\wt.exe` | Executable path |

---

## 📝 Notes

- The primary configuration file is `%LOCALAPPDATA%\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json` — registry keys are supplementary.
- When installed via the Microsoft Store (MSIX), paths are versioned and located under `WindowsApps\`.
- The context menu shell extension (`Open with Windows Terminal`) can be toggled under Settings → Default terminal application.
- `wt.exe` in `App Paths` allows launching from Win+R without specifying the full path.
- Profiles (PowerShell, CMD, WSL distros) are stored exclusively in `settings.json`, not the registry.

---

## 🗑️ Cleanup

For Store/MSIX installations, use `winget uninstall` or Apps & Features. For manual registry cleanup:

```reg
Windows Registry Editor Version 5.00

[-HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows Terminal]
[-HKEY_LOCAL_MACHINE\SOFTWARE\Classes\Directory\shell\Open with Windows Terminal]
[-HKEY_LOCAL_MACHINE\SOFTWARE\Classes\Directory\Background\shell\Open with Windows Terminal]
```

---

## 📦 Package Managers

| Manager | Install Command |
|---------|----------------|
| winget | `winget install Microsoft.WindowsTerminal` |
| Chocolatey | `choco install microsoft-windows-terminal` |
| Scoop | `scoop install windows-terminal` |
