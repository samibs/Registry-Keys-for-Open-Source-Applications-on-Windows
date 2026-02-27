---
tags:
  - network
  - driver
  - packet-capture
---

# Npcap

**Version:** 1.79  
**Installer:** `.exe` (NSIS setup)  
**Hives:** HKLM, SYSTEM

Npcap is the Nmap Project's packet capture library for Windows, based on WinPcap with improved performance, security, and Windows 10/11 support. It is the packet capture engine used by Wireshark, Nmap, and other tools.

---

## 📁 Registry Paths

| Path | Hive | Description |
|------|------|-------------|
| `SOFTWARE\Npcap` | HKLM | Installation settings and mode flags |
| `SYSTEM\CurrentControlSet\Services\npcap` | SYSTEM | Npcap kernel driver service |
| `SYSTEM\CurrentControlSet\Services\npcap_wifi` | SYSTEM | Raw 802.11 WiFi capture service (if enabled) |
| `SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\NpcapInst` | HKLM | Uninstall entry |

---

## 🔑 Keys

### HKLM\SOFTWARE\Npcap

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `(Default)` | `REG_SZ` | `C:\Windows\System32\Npcap\` | Installation path |
| `AdminOnly` | `REG_DWORD` | `0` | Restrict to admins only (1 = admin-only) |
| `DotDot` | `REG_DWORD` | `0` | Legacy WinPcap API compatibility mode |
| `LoopbackCapture` | `REG_DWORD` | `1` | Enable loopback traffic capture |
| `WinPcapCompatible` | `REG_DWORD` | `0` | Expose WinPcap-compatible NPF service name |
| `WifiCapture` | `REG_DWORD` | `0` | Enable raw 802.11 WiFi frame capture |

### SYSTEM\CurrentControlSet\Services\npcap

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `Type` | `REG_DWORD` | `1` | Kernel driver type |
| `Start` | `REG_DWORD` | `1` | Auto-start on boot |
| `ImagePath` | `REG_EXPAND_SZ` | `\SystemRoot\System32\drivers\npcap.sys` | Driver binary path |
| `DisplayName` | `REG_SZ` | `Npcap Packet Driver (NPCAP)` | Display name in Services |
| `Description` | `REG_SZ` | `An NDIS 6 packet capture driver` | Service description |

### HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\NpcapInst

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `DisplayName` | `REG_SZ` | `Npcap 1.79` | Display name |
| `DisplayVersion` | `REG_SZ` | `1.79` | Installed version |
| `Publisher` | `REG_SZ` | `Nmap Project` | Publisher |
| `UninstallString` | `REG_SZ` | `"C:\Program Files\Npcap\Uninstall.exe"` | Uninstall command |

---

## 📝 Notes

- `AdminOnly` mode (`REG_DWORD` = 1) restricts capture to members of the local Administrators group — recommended for shared systems.
- `WinPcapCompatible` mode exposes a `\Device\NPF_...` service name matching the old WinPcap naming, required for legacy tools.
- Npcap can coexist with WinPcap when WinPcap compatibility mode is **off** — both use different service names.
- The kernel driver is a NDIS 6 lightweight filter driver, loaded at boot when `Start = 1`.
- Npcap is bundled with Wireshark and Nmap installers — check if already installed before a standalone install.

---

## 🗑️ Cleanup

Npcap should be removed via its uninstaller. Manual registry cleanup (after uninstaller fails):

```reg
Windows Registry Editor Version 5.00

[-HKEY_LOCAL_MACHINE\SOFTWARE\Npcap]
[-HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\npcap]
[-HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\npcap_wifi]
[-HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\NpcapInst]
```

> **Warning:** Removing the service key while the driver is loaded can cause instability. Reboot after removal.

---

## 📦 Package Managers

| Manager | Install Command |
|---------|----------------|
| winget | `winget install Nmap.Npcap` |
| Chocolatey | `choco install npcap` |
