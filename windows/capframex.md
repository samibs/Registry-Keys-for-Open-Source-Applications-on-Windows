---
tags:
  - gaming
  - benchmark
  - performance
description: >-
  Windows registry keys created by CapFrameX — install paths, uninstall keys, HKCU and HKLM entries for sysadmin automation and cleanup.
---

# CapFrameX

**Version:** 1.8.1  
**Installer:** `.exe` (setup)  
**Hives:** HKCU, HKLM

CapFrameX is an open-source frame capture and analysis tool for Windows. It records per-frame timing data (using PresentMon under the hood) and provides advanced statistical analysis of frame times, stutters, and FPS percentiles. Popular in PC gaming hardware reviews.

---

## 📁 Registry Paths

| Path | Hive | Description |
|------|------|-------------|
| `SOFTWARE\CXCommunity\CapFrameX` | HKCU | Per-user settings and analysis preferences |
| `SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\CapFrameX` | HKLM | Uninstall entry |

---

## 🔑 Keys

### HKCU\SOFTWARE\CXCommunity\CapFrameX

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `CaptureHotkey` | `REG_SZ` | `F12` | Global hotkey to start/stop capture |
| `CaptureTime` | `REG_DWORD` | `20` | Default capture duration in seconds (0 = manual stop) |
| `StoragePath` | `REG_SZ` | `C:\Users\User\Documents\CapFrameX\Captures\` | Directory for saved capture files |
| `Theme` | `REG_SZ` | `Dark` | UI theme |
| `ObservedDirectory` | `REG_SZ` | `C:\Users\User\Documents\CapFrameX\Captures\` | Directory watched for new capture files |

### HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\CapFrameX

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `DisplayName` | `REG_SZ` | `CapFrameX 1.8.1` | Display name |
| `DisplayVersion` | `REG_SZ` | `1.8.1` | Installed version |
| `Publisher` | `REG_SZ` | `CX Community` | Publisher |
| `InstallLocation` | `REG_SZ` | `C:\Program Files\CapFrameX\` | Install directory |
| `UninstallString` | `REG_SZ` | `"C:\Program Files\CapFrameX\uninstall.exe"` | Uninstall command |
| `URLInfoAbout` | `REG_SZ` | `https://www.capframex.com` | Product URL |

---

## 📝 Notes

- CapFrameX uses **PresentMon** (a Microsoft tool) internally — PresentMon itself may create a kernel ETW session but adds no registry keys.
- Capture files are saved as `.csv` in the configured `StoragePath`.
- The global capture hotkey is registered via a low-level keyboard hook, not via `RegisterHotKey` — so it does not create a registry entry.
- CapFrameX requires elevated privileges (Run as Administrator) for kernel-level ETW frame capture.
- Source code is available at [github.com/DevTechProfile/CapFrameX](https://github.com/DevTechProfile/CapFrameX).

---

## 🗑️ Cleanup

```reg
Windows Registry Editor Version 5.00

[-HKEY_CURRENT_USER\SOFTWARE\CXCommunity\CapFrameX]
[-HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\CapFrameX]
```

---

## 📦 Package Managers

| Manager | Install Command |
|---------|----------------|
| winget | `winget install CXCommunity.CapFrameX` |
| Chocolatey | `choco install capframex` |
