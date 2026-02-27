---
tags:
  - runtime
  - developer-tools
  - HKCU
  - HKLM
  - SYSTEM-services
  - exe-installer
description: >-
  Windows registry keys created by Windows Subsystem for Linux (WSL) — install paths, uninstall keys, HKCU and HKLM entries for sysadmin automation and cleanup.
---

# Windows Subsystem for Linux (WSL)

**Version tested:** WSL 2 (kernel 5.15.x)
**Installer type:** Windows Feature via `wsl --install` (Windows 10 2004+ / Windows 11)

## 📦 Package Managers

| Manager    | Install Command |
|------------|-----------------|
| winget     | `winget install Microsoft.WSL` *(WSL store app update)* |
| Chocolatey | `choco install wsl2` |
| Scoop      | *(not available via Scoop)* |

## 📁 Registry Paths

- `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Lxss` *(WSL distribution registry — system)*
- `HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Lxss` *(per-user WSL distribution list)*
- `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WslService` *(WSL service)*
- `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LxssManager` *(Linux subsystem manager service)*

## 🔑 Keys

### Per-user distribution list (`HKCU\...\Lxss`)

| Key Name          | Type     | Description                                              |
|-------------------|----------|----------------------------------------------------------|
| `DefaultDistribution` | `REG_SZ` | GUID of the default WSL distribution               |

### Per-distribution subkey (`HKCU\...\Lxss\{GUID}`)

| Key Name          | Type        | Description                                              |
|-------------------|-------------|----------------------------------------------------------|
| `DistributionName`| `REG_SZ`    | Human-readable name (e.g., `Ubuntu-22.04`)               |
| `BasePath`        | `REG_SZ`    | Path to the distribution's VHD file on disk              |
| `State`           | `REG_DWORD` | `1` = installed and ready                                |
| `Version`         | `REG_DWORD` | `1` = WSL1, `2` = WSL2                                   |
| `Flags`           | `REG_DWORD` | Feature flags for the distribution                       |
| `DefaultUid`      | `REG_DWORD` | Linux UID of the default user (e.g., `1000`)             |
| `KernelCommandLine` | `REG_SZ` | Optional extra kernel command-line parameters            |

### WSL service (`HKLM\SYSTEM\...\Services\WslService`)

| Key Name       | Type        | Description                                            |
|----------------|-------------|--------------------------------------------------------|
| `Type`         | `REG_DWORD` | `16` — Win32 own-process service                       |
| `Start`        | `REG_DWORD` | `3` — demand start (started when WSL is used)          |
| `DisplayName`  | `REG_SZ`    | `Windows Subsystem for Linux`                          |
| `ImagePath`    | `REG_EXPAND_SZ` | Path to `wsl.exe` service binary                   |

## 📝 Notes

- Each installed WSL distribution gets its own GUID subkey under `HKCU\...\Lxss`. Listing subkeys shows all installed distributions: `Get-ChildItem "HKCU:\Software\Microsoft\Windows\CurrentVersion\Lxss"`.
- The `BasePath` value points to the directory containing `ext4.vhdx` — the virtual disk holding the Linux filesystem. Do not move this manually.
- WSL2 distributions run in a lightweight Hyper-V VM; the VM state is managed by `LxssManager` service, not user registry values.
- The `wsl.conf` file inside each distro (`/etc/wsl.conf`) overrides some distribution-level settings (default user, mount options, interop) — these take precedence over the registry.
- `HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Lxss` is used for system-wide WSL settings; per-user distros are always under `HKCU`.
- ⚠️ Deleting a distribution's registry subkey without unregistering it first (`wsl --unregister <Distro>`) can orphan the VHD file on disk.

## 🗑️ Cleanup

```powershell
# List all installed distributions first
wsl --list --verbose

# Properly unregister a distribution (removes registry key + VHD)
wsl --unregister Ubuntu-22.04

# If registry key is orphaned (no corresponding distro), remove directly
# WARNING: This will NOT clean up the VHD file — delete BasePath manually
Get-ChildItem "HKCU:\Software\Microsoft\Windows\CurrentVersion\Lxss" |
  Where-Object { $_.GetValue("DistributionName") -eq "Ubuntu-22.04" } |
  ForEach-Object { Remove-Item $_.PSPath -Recurse -Force }
```
