---
tags:
  - hardware
  - benchmark
  - gpu
description: >-
  Windows registry keys created by FurMark — install paths, uninstall keys, HKCU and HKLM entries for sysadmin automation and cleanup.
---

# FurMark

**Version:** 2.3.0  
**Installer:** `.exe` (setup)  
**Hives:** HKCU, HKLM

FurMark is a lightweight but intensive OpenGL benchmark and GPU stress test tool. It is used to test GPU stability, maximum power draw, and thermal limits.

---

## 📁 Registry Paths

| Path | Hive | Description |
|------|------|-------------|
| `SOFTWARE\Geeks3D\FurMark` | HKCU | Per-user settings and benchmark scores |
| `SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\FurMark` | HKLM | Uninstall entry |

---

## 🔑 Keys

### HKCU\SOFTWARE\Geeks3D\FurMark

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `Version` | `REG_SZ` | `2.3.0` | Last-run version |
| `WindowWidth` | `REG_DWORD` | `1024` | Benchmark window width |
| `WindowHeight` | `REG_DWORD` | `640` | Benchmark window height |
| `Fullscreen` | `REG_DWORD` | `0` | Run in fullscreen mode |
| `Multisample` | `REG_DWORD` | `0` | MSAA level (0 = off) |
| `Preset` | `REG_SZ` | `720` | Last-used benchmark preset |

### HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\FurMark

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `DisplayName` | `REG_SZ` | `FurMark 2.3.0` | Display name |
| `DisplayVersion` | `REG_SZ` | `2.3.0` | Installed version |
| `Publisher` | `REG_SZ` | `Geeks3D` | Publisher |
| `InstallLocation` | `REG_SZ` | `C:\Program Files\FurMark\` | Install directory |
| `UninstallString` | `REG_SZ` | `"C:\Program Files\FurMark\uninstall.exe"` | Uninstall command |
| `URLInfoAbout` | `REG_SZ` | `https://geeks3d.com/furmark` | Product URL |

---

## 📝 Notes

- FurMark 2.x uses a different key path than FurMark 1.x (`Geeks3D\FurMark` vs `Geeks3D\FurMark2`) — check both when cleaning up after a version transition.
- Benchmark results are stored in `%APPDATA%\Geeks3D\FurMark\` as XML files.
- FurMark does not install system services or register file associations.
- Running FurMark at maximum stress may trigger GPU thermal throttling and power limits — intended behaviour for stability testing.

---

## 🗑️ Cleanup

```reg
Windows Registry Editor Version 5.00

[-HKEY_CURRENT_USER\SOFTWARE\Geeks3D\FurMark]
[-HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\FurMark]
```

---

## 📦 Package Managers

| Manager | Install Command |
|---------|----------------|
| winget | `winget install Geeks3D.FurMark` |
| Chocolatey | `choco install furmark` |
