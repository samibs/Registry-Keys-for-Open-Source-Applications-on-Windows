---
tags:
  - task-manager
  - process
  - diagnostics
  - sysadmin
  - system
description: >-
  Windows registry keys created by Process Hacker (System Informer) — install paths, uninstall keys, HKCU and HKLM entries for sysadmin automation and cleanup.
---

# Process Hacker (System Informer)

**Version documented:** 3.0.7478 (System Informer) / 2.39 (Process Hacker)
**Installer type:** `.exe` (NSIS)
**Hives written:** HKCU, HKLM, HKLM\SYSTEM

---

## 📁 Registry Paths

| Path | Hive | Purpose |
|------|------|---------|
| `SOFTWARE\SystemInformer` | HKCU | User settings (System Informer 3.x) |
| `SOFTWARE\Process Hacker 2` | HKCU | User settings (Process Hacker 2.x) |
| `SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Process_Hacker2_is1` | HKLM | Uninstall entry |
| `SYSTEM\CurrentControlSet\Services\KProcessHacker3` | HKLM | Kernel driver service |

---

## 🔑 Keys

### HKCU\SOFTWARE\SystemInformer

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `InstallDir` | REG_SZ | `C:\Program Files\SystemInformer` | Installation path |
| `UpdateChannel` | REG_SZ | `stable` | Update channel |
| `Theme` | REG_SZ | `Dark` | UI theme |
| `StartMinimized` | REG_DWORD | `0` | Start minimized to tray |
| `MainWindowAlwaysOnTop` | REG_DWORD | `0` | Keep window on top |
| `EnableCycleCpuUsage` | REG_DWORD | `1` | Show cycle-based CPU usage |

### HKLM\SYSTEM\CurrentControlSet\Services\KProcessHacker3

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `DisplayName` | REG_SZ | `KProcessHacker3` | Kernel driver display name |
| `Start` | REG_DWORD | `3` | 1=Boot, 2=System, 3=Demand, 4=Disabled |
| `Type` | REG_DWORD | `1` | Kernel driver (type=1) |
| `ImagePath` | REG_EXPAND_SZ | `\??\C:\Program Files\SystemInformer\kprocesshacker.sys` | Driver path |

---

## 📝 Notes

- Process Hacker 2 is the legacy version; **System Informer** is the actively maintained fork/rename (v3.x).
- The kernel driver `KProcessHacker3` is loaded on demand (Start=3) when the app needs elevated inspection capabilities. It is not always running.
- If the driver fails to load (e.g., Secure Boot + unsigned drivers), the app still functions with limited capabilities.
- Replacing Windows Task Manager: `HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\taskmgr.exe` can be set to redirect to Process Hacker.

```powershell
# Check if kernel driver is registered
Get-Service -Name "KProcessHacker3" -ErrorAction SilentlyContinue | Select-Object Name, Status

# Replace Task Manager with System Informer
$key = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\taskmgr.exe"
New-Item -Path $key -Force | Out-Null
Set-ItemProperty -Path $key -Name "Debugger" -Value "C:\Program Files\SystemInformer\SystemInformer.exe"
```

---

## 🗑️ Cleanup

```powershell
# Remove user settings
Remove-Item -Path "HKCU:\SOFTWARE\SystemInformer" -Recurse -ErrorAction SilentlyContinue
Remove-Item -Path "HKCU:\SOFTWARE\Process Hacker 2" -Recurse -ErrorAction SilentlyContinue

# Remove kernel driver service (usually removed by uninstaller)
sc.exe delete KProcessHacker3 2>$null

# Restore Task Manager if replaced
Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\taskmgr.exe" `
  -Recurse -ErrorAction SilentlyContinue
```

---

## 📦 Package Managers

| Manager | ID / Command |
|---------|-------------|
| winget | `winget install winsiderss.systeminformer` |
| Chocolatey | `choco install processhacker` |
| Scoop | `scoop install extras/processhacker` |
