---
tags:
  - containers
  - HKLM
  - SYSTEM-services
  - exe-installer
  - developer-tools
---

# Docker Desktop

**Version tested:** 4.29.0
**Installer type:** `.exe` official installer from docker.com

## 📦 Package Managers

| Manager    | Install Command |
|------------|-----------------|
| winget     | `winget install Docker.DockerDesktop` |
| Chocolatey | `choco install docker-desktop` |
| Scoop      | `scoop install docker` |

## 📁 Registry Paths

- `HKEY_LOCAL_MACHINE\SOFTWARE\Docker Inc.\Docker Desktop`
- `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Docker Desktop`
- `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\com.docker.service` *(Docker Desktop Service)*
- `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\DockerDesktopBackend` *(WSL2 backend, if enabled)*

## 🔑 Keys

### Installation entry (`HKLM\SOFTWARE\Docker Inc.\Docker Desktop`)

| Key Name         | Type     | Description                                              |
|------------------|----------|----------------------------------------------------------|
| `InstallPath`    | `REG_SZ` | Root installation directory                              |
| `Version`        | `REG_SZ` | Installed version (e.g., `4.29.0`)                      |

### Uninstall entry (`HKLM\...\Uninstall\Docker Desktop`)

| Key Name          | Type        | Description                                          |
|-------------------|-------------|------------------------------------------------------|
| `DisplayName`     | `REG_SZ`    | `Docker Desktop`                                     |
| `DisplayVersion`  | `REG_SZ`    | Installed version (e.g., `4.29.0`)                   |
| `DisplayIcon`     | `REG_SZ`    | Path to `Docker Desktop.exe`                         |
| `InstallLocation` | `REG_SZ`    | Root installation directory                          |
| `Publisher`       | `REG_SZ`    | `Docker Inc.`                                        |
| `UninstallString` | `REG_SZ`    | Path to the uninstaller                              |

### Docker Desktop Service (`HKLM\SYSTEM\...\Services\com.docker.service`)

| Key Name       | Type            | Description                                              |
|----------------|-----------------|----------------------------------------------------------|
| `Type`         | `REG_DWORD`     | `16` — Win32 service (own process)                       |
| `Start`        | `REG_DWORD`     | `2` — automatic start                                    |
| `ErrorControl` | `REG_DWORD`     | `1` — normal error handling                              |
| `ImagePath`    | `REG_EXPAND_SZ` | `"C:\...\com.docker.service"`                            |
| `DisplayName`  | `REG_SZ`        | `Docker Desktop Service`                                 |

## 📝 Notes

- Docker Desktop requires either **WSL2** (recommended) or **Hyper-V** as its backend. The backend type affects which service keys are created.
- All container images, volumes, and configurations are stored in `%APPDATA%\Docker\` and the WSL2 VM (`docker-desktop` distro), not the registry.
- The `com.docker.service` Windows service runs as `SYSTEM` and is required for Docker to function; it manages the VM lifecycle and named pipe communication.
- Docker Desktop adds itself to the user's startup via `HKCU\Software\Microsoft\Windows\CurrentVersion\Run`.
- ⚠️ Uninstalling Docker Desktop does **not** remove container images or volumes. Use `docker system prune` before uninstalling if disk space is a concern.

## 🗑️ Cleanup

```powershell
# Installation and uninstall entries
Remove-Item -Path "HKLM:\SOFTWARE\Docker Inc."  -Recurse -Force -ErrorAction SilentlyContinue

Get-ChildItem "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall" |
  Where-Object { $_.GetValue("DisplayName") -like "Docker Desktop*" } |
  ForEach-Object { Remove-Item $_.PSPath -Recurse -Force }

# Startup entry
Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run" -Name "Docker Desktop" -ErrorAction SilentlyContinue
```
