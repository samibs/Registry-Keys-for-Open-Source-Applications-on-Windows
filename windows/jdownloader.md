---
tags:
  - download
  - manager
  - java
description: >-
  Windows registry keys created by JDownloader 2 — install paths, uninstall keys, HKCU and HKLM entries for sysadmin automation and cleanup.
---

# JDownloader 2

**Version:** 2.0 (rolling release)  
**Installer:** `.exe` (setup)  
**Hives:** HKCU, HKLM

JDownloader 2 is a free, open-source download management tool with support for one-click hosters, premium accounts, captcha solving, and parallel downloads. Written in Java.

---

## 📁 Registry Paths

| Path | Hive | Description |
|------|------|-------------|
| `SOFTWARE\AppDataLow\Software\JDownloader 2.0` | HKCU | Per-user settings |
| `SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\JDownloader 2` | HKLM | Uninstall entry |

---

## 🔑 Keys

### HKCU\SOFTWARE\AppDataLow\Software\JDownloader 2.0

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `InstallPath` | `REG_SZ` | `C:\Users\User\AppData\Local\JDownloader 2.0\` | Installation directory |

### HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\JDownloader 2

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `DisplayName` | `REG_SZ` | `JDownloader 2` | Display name |
| `Publisher` | `REG_SZ` | `AppWork GmbH` | Publisher |
| `InstallLocation` | `REG_SZ` | `C:\Users\User\AppData\Local\JDownloader 2.0\` | Install location |
| `UninstallString` | `REG_SZ` | `"C:\Users\User\AppData\Local\JDownloader 2.0\uninstall.exe"` | Uninstall command |
| `URLInfoAbout` | `REG_SZ` | `https://jdownloader.org` | Product URL |

---

## 📝 Notes

- JDownloader installs to `%LOCALAPPDATA%` by default (per-user), not `Program Files`.
- All configuration, accounts, link lists, and plugins are stored in the install directory as JSON/XML files — not in the registry.
- The HKCU path uses the unusual `AppDataLow` subtree, which is associated with low-integrity processes.
- JDownloader does not register file associations.

---

## 🗑️ Cleanup

```reg
Windows Registry Editor Version 5.00

[-HKEY_CURRENT_USER\SOFTWARE\AppDataLow\Software\JDownloader 2.0]
[-HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\JDownloader 2]
```

---

## 📦 Package Managers

| Manager | Install Command |
|---------|----------------|
| winget | `winget install AppWork.JDownloader` |
| Chocolatey | `choco install jdownloader` |
