---
tags:
  - disk
  - storage
  - analysis
  - visualization
---

# WinDirStat

**Version documented:** 2.1.0
**Installer type:** `.exe` (NSIS) / Portable
**Hives written:** HKCU, HKLM

---

## 📁 Registry Paths

| Path | Hive | Purpose |
|------|------|---------|
| `SOFTWARE\WinDirStat` | HKCU | User preferences |
| `SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\WinDirStat` | HKLM | Uninstall entry |

---

## 🔑 Keys

### HKCU\SOFTWARE\WinDirStat

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `LanguageId` | REG_DWORD | `0` | UI language (0=system default) |
| `MainWindowLeft` | REG_DWORD | `100` | Window left position |
| `MainWindowTop` | REG_DWORD | `50` | Window top position |
| `MainWindowWidth` | REG_DWORD | `1200` | Window width |
| `MainWindowHeight` | REG_DWORD | `800` | Window height |
| `ShowTimeSpent` | REG_DWORD | `0` | Show scan time in status bar |
| `TreeListColorCount` | REG_DWORD | `8` | Number of treemap colors |
| `FollowMountPoints` | REG_DWORD | `0` | Follow mount points during scan |
| `FollowJunctionPoints` | REG_DWORD | `0` | Follow junction points |
| `UseFallbackLocale` | REG_DWORD | `0` | Fallback to English locale |

### HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\WinDirStat

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `DisplayName` | REG_SZ | `WinDirStat 2.1.0` | Display name |
| `DisplayVersion` | REG_SZ | `2.1.0` | Version |
| `Publisher` | REG_SZ | `WinDirStat Team` | Publisher |
| `InstallLocation` | REG_SZ | `C:\Program Files\WinDirStat` | Install path |
| `UninstallString` | REG_SZ | `"...\unins000.exe"` | Uninstaller |

---

## 📝 Notes

- The portable version writes no registry keys.
- `FollowMountPoints` and `FollowJunctionPoints` should remain `0` to avoid infinite recursion on systems with loop mounts.
- WinDirStat 2.x is the maintained community fork of the original WinDirStat 1.x.

```powershell
# Check if WinDirStat is installed
(Get-ItemProperty "HKCU:\SOFTWARE\WinDirStat" -ErrorAction SilentlyContinue).PSPath

# Disable junction point following (safety for shared/VM drives)
Set-ItemProperty -Path "HKCU:\SOFTWARE\WinDirStat" -Name "FollowJunctionPoints" -Value 0 -Type DWord
Set-ItemProperty -Path "HKCU:\SOFTWARE\WinDirStat" -Name "FollowMountPoints" -Value 0 -Type DWord
```

---

## 🗑️ Cleanup

```powershell
# Remove WinDirStat user preferences
Remove-Item -Path "HKCU:\SOFTWARE\WinDirStat" -Recurse -ErrorAction SilentlyContinue
```

---

## 📦 Package Managers

| Manager | ID / Command |
|---------|-------------|
| winget | `winget install WinDirStat.WinDirStat` |
| Chocolatey | `choco install windirstat` |
| Scoop | `scoop install extras/windirstat` |
