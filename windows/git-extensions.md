---
tags:
  - git
  - version-control
  - HKCU
  - HKLM
  - HKCR
  - msi-installer
  - developer-tools
---

# Git Extensions

**Version tested:** 4.2.1
**Installer type:** `.msi` official installer from gitextensions.github.io

## 📦 Package Managers

| Manager    | Install Command |
|------------|-----------------|
| winget     | `winget install GitExtensionsTeam.GitExtensions` |
| Chocolatey | `choco install gitextensions` |
| Scoop      | `scoop install git-extensions` |

## 📁 Registry Paths

- `HKEY_LOCAL_MACHINE\SOFTWARE\GitExtensions\GitExtensions`
- `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{<GUID>}` *(MSI uninstall entry)*
- `HKEY_CURRENT_USER\Software\GitExtensions`

## 🔑 Keys

### Installation entry (`HKLM\SOFTWARE\GitExtensions\GitExtensions`)

| Key Name         | Type     | Description                                              |
|------------------|----------|----------------------------------------------------------|
| `InstallDir`     | `REG_SZ` | Root installation directory                              |

### User settings (`HKCU\Software\GitExtensions`)

| Key Name                    | Type     | Description                                               |
|-----------------------------|----------|-----------------------------------------------------------|
| `gitcommand`                | `REG_SZ` | Path to `git.exe`                                         |
| `gitbindir`                 | `REG_SZ` | Path to Git's bin directory                               |
| `gitssh`                    | `REG_SZ` | SSH client path (e.g., path to PuTTY's `plink.exe`)       |
| `mergetool`                 | `REG_SZ` | Configured merge tool name                               |
| `difftool`                  | `REG_SZ` | Configured diff tool name                                |
| `language`                  | `REG_SZ` | UI language code (e.g., `en-US`)                         |
| `RecentRepositories`        | Subkey   | Most-recently-used repository paths                      |

### Uninstall entry (MSI)

| Key Name          | Type        | Description                                          |
|-------------------|-------------|------------------------------------------------------|
| `DisplayName`     | `REG_SZ`    | `Git Extensions 4.2.1`                               |
| `DisplayVersion`  | `REG_SZ`    | Installed version (e.g., `4.2.1`)                    |
| `InstallLocation` | `REG_SZ`    | Root installation directory                          |
| `Publisher`       | `REG_SZ`    | `Git Extensions Team`                                |
| `UninstallString` | `REG_SZ`    | `MsiExec.exe /X{<GUID>}`                             |

## 📝 Notes

- Git Extensions is a Windows GUI wrapper for Git. It reads the Git executable path and configuration from `HKCU\Software\GitExtensions` at startup.
- The actual Git configuration (user name, email, aliases) is still stored in `.gitconfig` files — Git Extensions reads and writes those files, not additional registry keys.
- Git Extensions integrates with Visual Studio and Windows Explorer (shell extension); the shell extension registers under `HKCR\*\shellex\ContextMenuHandlers\GitExtensions`.
- The **SSH client** can be configured to use OpenSSH (bundled with Git) or PuTTY's `plink.exe`; the path is stored in the `gitssh` registry value.
- `RecentRepositories` subkeys are numbered and contain the path of each recently opened repository.

## 🗑️ Cleanup

```powershell
# User settings
Remove-Item -Path "HKCU:\Software\GitExtensions"  -Recurse -Force -ErrorAction SilentlyContinue

# Installation entry
Remove-Item -Path "HKLM:\SOFTWARE\GitExtensions"  -Recurse -Force -ErrorAction SilentlyContinue

# Uninstall entry (GUID varies)
Get-ChildItem "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall" |
  Where-Object { $_.GetValue("DisplayName") -like "Git Extensions*" } |
  ForEach-Object { Remove-Item $_.PSPath -Recurse -Force }

# Shell extension context menu
Remove-Item -Path "HKCR:\*\shellex\ContextMenuHandlers\GitExtensions"  -Recurse -Force -ErrorAction SilentlyContinue
```
