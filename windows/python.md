---
tags:
  - runtime
  - HKCU
  - HKLM
  - HKCR
  - exe-installer
  - developer-tools
---

# Python

**Version tested:** 3.12.2
**Installer type:** `.exe` official installer from python.org

## 📦 Package Managers

| Manager    | Install Command |
|------------|-----------------|
| winget     | `winget install Python.Python.3.12` |
| Chocolatey | `choco install python` |
| Scoop      | `scoop install python` |

## 📁 Registry Paths

- `HKEY_LOCAL_MACHINE\SOFTWARE\Python\PythonCore\3.12` *(system install)*
- `HKEY_CURRENT_USER\Software\Python\PythonCore\3.12` *(per-user install)*
- `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{<GUID>}` *(MSI uninstall entry)*
- `HKEY_CLASSES_ROOT\.py` *(file extension → ProgID)*
- `HKEY_CLASSES_ROOT\Python.File` *(ProgID for .py files)*
- `HKEY_CLASSES_ROOT\Python.CompiledFile` *(ProgID for .pyc files)*

## 🔑 Keys

### Python core installation (`HKLM\SOFTWARE\Python\PythonCore\3.12`)

| Key Name                     | Type     | Description                                                    |
|------------------------------|----------|----------------------------------------------------------------|
| `InstallPath\(Default)`      | `REG_SZ` | Root Python installation directory (e.g., `C:\Python312\`)     |
| `InstallPath\ExecutablePath` | `REG_SZ` | Full path to `python.exe`                                      |
| `InstallPath\WindowedExecutablePath` | `REG_SZ` | Full path to `pythonw.exe` (no console window)         |
| `PythonPath\(Default)`       | `REG_SZ` | Default `sys.path` entries (semicolon-separated)               |

> For per-user installs, the same structure appears under `HKCU\Software\Python\PythonCore\3.12`.

### File association ProgID (`HKCR\Python.File`)

| Key Path                              | Type     | Description                                           |
|---------------------------------------|----------|-------------------------------------------------------|
| `(Default)`                           | `REG_SZ` | `Python File`                                         |
| `shell\open\command\(Default)`       | `REG_SZ` | `"C:\Python312\python.exe" "%L" %*`                   |
| `shell\Edit with IDLE\command\(Default)` | `REG_SZ` | `"C:\Python312\pythonw.exe" "...\idle.pyw" -e "%L"` |

## 📝 Notes

- Multiple Python versions can coexist on the same machine; each registers under its own `PythonCore\<major.minor>` key (e.g., `3.11`, `3.12`).
- The **Python Launcher for Windows** (`py.exe`) reads the `PythonCore` keys to find installed interpreters. It is installed to `%SystemRoot%` and adds its own uninstall entry.
- The `Add Python to PATH` option in the installer modifies the system or user `PATH` environment variable — this is stored in the registry at `HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment\Path`.
- Per-user installs (default for non-admin) write to `HKCU`; admin installs write to `HKLM`.
- Virtual environments (`venv`) do not create registry entries.

## 🗑️ Cleanup

```powershell
# Per-user install
Remove-Item -Path "HKCU:\Software\Python\PythonCore\3.12"  -Recurse -Force -ErrorAction SilentlyContinue

# System install (run as Administrator)
Remove-Item -Path "HKLM:\SOFTWARE\Python\PythonCore\3.12"  -Recurse -Force -ErrorAction SilentlyContinue

# File associations
Remove-Item -Path "HKCR:\Python.File"          -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path "HKCR:\Python.CompiledFile"  -Recurse -Force -ErrorAction SilentlyContinue

# Uninstall entry (GUID varies — use dynamic lookup)
Get-ChildItem "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall" |
  Where-Object { $_.GetValue("DisplayName") -like "Python 3.12*" } |
  ForEach-Object { Remove-Item $_.PSPath -Recurse -Force }
```
