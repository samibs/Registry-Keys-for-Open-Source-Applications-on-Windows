---
tags:
  - automation
  - scripting
  - hotkeys
  - productivity
description: >-
  Windows registry keys created by AutoHotkey — install paths, uninstall keys, HKCU and HKLM entries for sysadmin automation and cleanup.
---

# AutoHotkey

**Version documented:** 2.0.11
**Installer type:** `.exe` (NSIS)
**Hives written:** HKCU, HKLM, HKCR

---

## 📁 Registry Paths

| Path | Hive | Purpose |
|------|------|---------|
| `SOFTWARE\AutoHotkey` | HKLM | Installation metadata |
| `SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\AutoHotkey` | HKLM | Uninstall entry |
| `HKCR\.ahk` | HKCR | .ahk script file association |
| `HKCR\AutoHotkeyScript` | HKCR | ProgID — run scripts |
| `HKCR\AutoHotkeyScript\Shell\Run` | HKCR | Default "Run" verb |
| `HKCR\AutoHotkeyScript\Shell\Edit` | HKCR | "Edit" verb (opens editor) |

---

## 🔑 Keys

### HKLM\SOFTWARE\AutoHotkey

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `InstallDir` | REG_SZ | `C:\Program Files\AutoHotkey` | Installation directory |
| `Version` | REG_SZ | `2.0.11` | Installed version |

### HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\AutoHotkey

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `DisplayName` | REG_SZ | `AutoHotkey v2.0.11` | Display name |
| `DisplayVersion` | REG_SZ | `2.0.11` | Version |
| `Publisher` | REG_SZ | `AutoHotkey Foundation LLC` | Publisher |
| `InstallLocation` | REG_SZ | `C:\Program Files\AutoHotkey` | Install path |
| `UninstallString` | REG_SZ | `"...\UX\AutoHotkeyUX.exe" /uninstall` | Uninstaller |

### HKCR\.ahk

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `(Default)` | REG_SZ | `AutoHotkeyScript` | ProgID reference |

### HKCR\AutoHotkeyScript\Shell\Run\Command

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `(Default)` | REG_SZ | `"AutoHotkey64.exe" "%1" %*` | Run script verb |

### HKCR\AutoHotkeyScript\Shell\Edit\Command

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `(Default)` | REG_SZ | `"notepad.exe" "%1"` | Edit script verb (default editor) |

---

## 📝 Notes

- AHK v2 and v1 can coexist — v1 uses `AutoHotkey` ProgID, v2 uses `AutoHotkeyScript`.
- The edit verb defaults to Notepad; sysadmins often redirect it to a dedicated AHK-aware editor.
- `.ahk` scripts do not auto-start with Windows — users must place shortcuts in `shell:startup` manually.

```powershell
# Redirect the Edit verb to VS Code
$cmd = '"C:\Program Files\Microsoft VS Code\Code.exe" "%1"'
Set-ItemProperty -Path "HKCR:\AutoHotkeyScript\Shell\Edit\Command" -Name "(Default)" -Value $cmd

# Check installed version
(Get-ItemProperty "HKLM:\SOFTWARE\AutoHotkey" -ErrorAction SilentlyContinue).Version
```

---

## 🗑️ Cleanup

```powershell
# Remove AutoHotkey installation keys
Remove-Item -Path "HKLM:\SOFTWARE\AutoHotkey" -Recurse -ErrorAction SilentlyContinue

# Remove .ahk file association
Remove-Item -Path "HKCR:\AutoHotkeyScript" -Recurse -ErrorAction SilentlyContinue
Remove-ItemProperty -Path "HKCR:\.ahk" -Name "(Default)" -ErrorAction SilentlyContinue
```

---

## 📦 Package Managers

| Manager | ID / Command |
|---------|-------------|
| winget | `winget install AutoHotkey.AutoHotkey` |
| Chocolatey | `choco install autohotkey` |
| Scoop | `scoop install extras/autohotkey` |
