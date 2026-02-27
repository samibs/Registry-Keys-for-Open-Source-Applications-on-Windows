---
tags:
  - music
  - audio
  - HKCU
  - HKLM
  - HKCR
  - exe-installer
---

# foobar2000

**Version tested:** 2.1.5
**Installer type:** `.exe` official installer from foobar2000.org

## 📦 Package Managers

| Manager    | Install Command |
|------------|-----------------|
| winget     | `winget install PeterPawlowski.foobar2000` |
| Chocolatey | `choco install foobar2000` |
| Scoop      | `scoop install foobar2000` |

## 📁 Registry Paths

- `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\foobar2000`
- `HKEY_CLASSES_ROOT\foobar2000` *(foobar2000:// URI handler)*
- `HKEY_CLASSES_ROOT\.mp3`, `.flac`, `.ogg` *(file associations when set as default)*

## 🔑 Keys

### Uninstall entry (`HKLM\...\Uninstall\foobar2000`)

| Key Name          | Type        | Description                                          |
|-------------------|-------------|------------------------------------------------------|
| `DisplayName`     | `REG_SZ`    | `foobar2000 v2.1.5`                                  |
| `DisplayVersion`  | `REG_SZ`    | Installed version (e.g., `2.1.5`)                    |
| `DisplayIcon`     | `REG_SZ`    | Path to `foobar2000.exe`                             |
| `InstallLocation` | `REG_SZ`    | Root installation directory                          |
| `Publisher`       | `REG_SZ`    | `Peter Pawlowski`                                    |
| `UninstallString` | `REG_SZ`    | Path to the NSIS uninstaller                         |
| `NoModify`        | `REG_DWORD` | `1` — no modify button in ARP                        |

### URI handler (`HKCR\foobar2000`)

| Key Path                              | Type     | Description                                          |
|---------------------------------------|----------|------------------------------------------------------|
| `(Default)`                           | `REG_SZ` | `URL:foobar2000 media player`                        |
| `URL Protocol`                        | `REG_SZ` | Empty string — marks key as URL protocol handler     |
| `shell\open\command\(Default)`       | `REG_SZ` | `"C:\...\foobar2000.exe" "%1"`                       |

### Audio file associations (`HKCR\.flac`, `.mp3`, etc.)

| Key Path               | Type     | Description                                          |
|------------------------|----------|------------------------------------------------------|
| `HKCR\.flac\(Default)` | `REG_SZ` | ProgID pointer (e.g., `foobar2000.flac`) when foobar2000 is set as default |
| `HKCR\foobar2000.flac\shell\open\command\(Default)` | `REG_SZ` | `"C:\...\foobar2000.exe" "%1"` |

Common registered extensions when set as default player: `.mp3`, `.flac`, `.ogg`, `.opus`, `.aac`, `.m4a`, `.wav`, `.ape`, `.wv`, `.mpc`.

## 📝 Notes

- foobar2000 stores all user configuration (library, playlists, component settings, DSP chain) in `%APPDATA%\foobar2000-v2\` (or `%APPDATA%\foobar2000\` for older versions).
- The **portable version** stores all configuration in the installation directory and creates **no registry entries at all** — not even the uninstall entry.
- foobar2000's component system (third-party audio codecs, DSP plugins) installs DLLs to `%APPDATA%\foobar2000-v2\user-components\` — no registry per component.
- File associations are only registered when foobar2000 is explicitly set as the default player during installation or via Preferences → Shell Integration.

## 🗑️ Cleanup

```powershell
Get-ChildItem "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall" |
  Where-Object { $_.GetValue("DisplayName") -like "foobar2000*" } |
  ForEach-Object { Remove-Item $_.PSPath -Recurse -Force }

Remove-Item -Path "HKCR:\foobar2000"  -Recurse -Force -ErrorAction SilentlyContinue
```
