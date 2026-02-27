---
tags:
  - diff
  - merge
  - development
  - version-control
description: >-
  Windows registry keys created by WinMerge — install paths, uninstall keys, HKCU and HKLM entries for sysadmin automation and cleanup.
---

# WinMerge

**Version documented:** 2.16.38
**Installer type:** `.exe` (NSIS)
**Hives written:** HKCU, HKLM, HKCR

---

## 📁 Registry Paths

| Path | Hive | Purpose |
|------|------|---------|
| `SOFTWARE\Thingamahoochie\WinMerge` | HKCU | User preferences |
| `SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\WinMerge_is1` | HKLM | Uninstall entry |
| `HKCR\*\shell\WinMerge` | HKCR | "Compare with WinMerge" context menu |
| `HKCR\Directory\shell\WinMerge` | HKCR | Folder context menu integration |

---

## 🔑 Keys

### HKCU\SOFTWARE\Thingamahoochie\WinMerge

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `WinLeft` | REG_DWORD | `100` | Main window left position |
| `WinTop` | REG_DWORD | `50` | Main window top position |
| `WinWidth` | REG_DWORD | `1200` | Main window width |
| `WinHeight` | REG_DWORD | `800` | Main window height |
| `TabSize` | REG_DWORD | `4` | Tab size for diff view |
| `Language` | REG_DWORD | `0` | UI language (0=system default) |
| `ShowUniqueLeft` | REG_DWORD | `1` | Show files unique to left |
| `ShowUniqueRight` | REG_DWORD | `1` | Show files unique to right |
| `ShowDifferent` | REG_DWORD | `1` | Show differing files |
| `ShowIdentical` | REG_DWORD | `0` | Show identical files |
| `LineFilterEnabled` | REG_DWORD | `0` | Enable line filter |

### HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\WinMerge_is1

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `DisplayName` | REG_SZ | `WinMerge 2.16.38` | Display name |
| `DisplayVersion` | REG_SZ | `2.16.38` | Version |
| `Publisher` | REG_SZ | `Thingamahoochie Software` | Publisher |
| `InstallLocation` | REG_SZ | `C:\Program Files\WinMerge\` | Install path |
| `UninstallString` | REG_SZ | `"...\unins000.exe"` | Uninstaller |

### HKCR\*\shell\WinMerge

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `(Default)` | REG_SZ | `Compare with &WinMerge` | Context menu label |
| `command` (Default) | REG_SZ | `"WinMergeU.exe" "%1"` | Shell command |

---

## 📝 Notes

- WinMerge adds a "Compare with WinMerge" context menu entry for files and folders in Windows Explorer.
- The `HKCU\SOFTWARE\Thingamahoochie\WinMerge` key stores all display and comparison preferences.
- WinMerge can be used as a Git diff/merge tool by configuring `git config --global merge.tool winmerge`.

```powershell
# Configure WinMerge as Git diff tool
git config --global diff.tool winmerge
git config --global difftool.winmerge.cmd '"C:\Program Files\WinMerge\WinMergeU.exe" -e -u "$LOCAL" "$REMOTE"'

# Export WinMerge preferences for migration
reg export "HKCU\SOFTWARE\Thingamahoochie\WinMerge" "$env:USERPROFILE\winmerge-settings.reg"
```

---

## 🗑️ Cleanup

```powershell
# Remove WinMerge user preferences
Remove-Item -Path "HKCU:\SOFTWARE\Thingamahoochie\WinMerge" -Recurse -ErrorAction SilentlyContinue
Remove-Item -Path "HKCU:\SOFTWARE\Thingamahoochie" -Recurse -ErrorAction SilentlyContinue

# Remove Explorer context menu entries
Remove-Item -Path "HKCR:\*\shell\WinMerge" -Recurse -ErrorAction SilentlyContinue
Remove-Item -Path "HKCR:\Directory\shell\WinMerge" -Recurse -ErrorAction SilentlyContinue
```

---

## 📦 Package Managers

| Manager | ID / Command |
|---------|-------------|
| winget | `winget install Thingamahoochie.WinMerge` |
| Chocolatey | `choco install winmerge` |
| Scoop | `scoop install extras/winmerge` |
