---
tags:
  - terminal
  - shell
  - productivity
description: >-
  Windows registry keys created by Clink — install paths, uninstall keys, HKCU and HKLM entries for sysadmin automation and cleanup.
---

# Clink

**Version:** 1.6.19  
**Installer:** `.exe` (setup) / Portable  
**Hives:** HKCU, HKLM

Clink combines the native Windows `cmd.exe` shell with the powerful command line editing features of the GNU Readline library, providing bash-like history, tab completion, and Lua scripting for the Windows command prompt.

---

## 📁 Registry Paths

| Path | Hive | Description |
|------|------|-------------|
| `SOFTWARE\Clink` | HKCU | Per-user settings |
| `SOFTWARE\Clink` | HKLM | Machine-wide settings / install marker |
| `SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Clink` | HKLM | Uninstall entry |

---

## 🔑 Keys

### HKCU\SOFTWARE\Clink

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `autoupdates` | `REG_DWORD` | `1` | Enable automatic update checks |
| `last_run_version` | `REG_SZ` | `1.6.19` | Last version that ran |

### HKLM\SOFTWARE\Clink

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `install` | `REG_SZ` | `C:\Program Files (x86)\clink\` | Installation path |
| `version` | `REG_SZ` | `1.6.19` | Installed version |

### HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Clink

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `DisplayName` | `REG_SZ` | `Clink v1.6.19` | Display name |
| `DisplayVersion` | `REG_SZ` | `1.6.19` | Installed version |
| `Publisher` | `REG_SZ` | `Christopher Antos` | Publisher |
| `InstallLocation` | `REG_SZ` | `C:\Program Files (x86)\clink\` | Install path |
| `UninstallString` | `REG_SZ` | `"C:\Program Files (x86)\clink\uninstall.exe"` | Uninstall command |

---

## 📝 Notes

- Clink injects into `cmd.exe` processes via an autorun registry hook written to `HKCU\SOFTWARE\Microsoft\Command Processor\AutoRun`.
- Per-user Lua scripts and settings live in `%LOCALAPPDATA%\clink\`.
- The portable version can be loaded manually with `clink inject` and leaves no persistent registry entries.

---

## 🗑️ Cleanup

```reg
Windows Registry Editor Version 5.00

[-HKEY_CURRENT_USER\SOFTWARE\Clink]
[-HKEY_LOCAL_MACHINE\SOFTWARE\Clink]
[-HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Clink]
```

Also remove the AutoRun hook if set:

```reg
[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Command Processor]
"AutoRun"=""
```

---

## 📦 Package Managers

| Manager | Install Command |
|---------|----------------|
| winget | `winget install chrisant996.Clink` |
| Chocolatey | `choco install clink` |
| Scoop | `scoop install clink` |
