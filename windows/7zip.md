---
tags:
  - archive
  - HKCU
  - HKLM
  - HKCR
  - shell-extension
  - exe-installer
---

# 7-Zip

**Version tested:** 23.01  
**Installer type:** `.exe` from 7-zip.org


## 📦 Package Managers

| Manager    | Install Command |
|------------|-----------------|
| winget     | `winget install 7zip.7zip` |
| Chocolatey | `choco install 7zip` |
| Scoop      | `scoop install 7zip` |

## 📁 Registry Paths

- `HKEY_CURRENT_USER\Software\7-Zip`
- `HKEY_LOCAL_MACHINE\SOFTWARE\7-Zip`
- `HKEY_CLASSES_ROOT\*\shellex\ContextMenuHandlers\7-Zip` *(shell context menu)*
- `HKEY_CLASSES_ROOT\7-Zip.*` *(ProgID entries for each archive format)*

## 🔑 Keys

| Key Name           | Type        | Description                                |
|--------------------|-------------|--------------------------------------------|
| `Lang`             | `REG_SZ`    | Language setting (e.g., `en`)              |
| `FM\ShowHidden`    | `REG_DWORD` | Show hidden files in file manager (1=true) |
| `FM\SingleClick`   | `REG_DWORD` | Single-click to open files                 |
| `Path`             | `REG_SZ`    | Installation directory                     |

### Shell context menu (`HKCR\*\shellex\ContextMenuHandlers\7-Zip`)

| Key Name    | Type     | Description                                                |
|-------------|----------|------------------------------------------------------------|
| `(Default)` | `REG_SZ` | CLSID of the 7-Zip shell extension (`{23170F69-40C1-278A-1000-000100020000}`) |

### Archive format ProgIDs (`HKCR\7-Zip.<ext>`)

| ProgID Key          | Description                                              |
|---------------------|----------------------------------------------------------|
| `7-Zip.7z`          | `.7z` archive handler — `(Default)` = `7-Zip 7z Archive` |
| `7-Zip.zip`         | `.zip` archive handler                                   |
| `7-Zip.rar`         | `.rar` archive handler                                   |
| `7-Zip.tar`         | `.tar` archive handler                                   |
| `7-Zip.gz`          | `.gz` / `.tgz` archive handler                           |

Each ProgID contains a `shell\open\command` subkey pointing to `7zFM.exe "%1"`.

### Shell context menu (`HKCR\*\shellex\ContextMenuHandlers\7-Zip`)

| Key Name    | Type     | Description                                                |
|-------------|----------|------------------------------------------------------------|
| `(Default)` | `REG_SZ` | CLSID of the 7-Zip shell extension (`{23170F69-40C1-278A-1000-000100020000}`) |

### Archive format ProgIDs (`HKCR\7-Zip.<ext>`)

| ProgID Key          | Description                                              |
|---------------------|----------------------------------------------------------|
| `7-Zip.7z`          | `.7z` archive handler — `(Default)` = `7-Zip 7z Archive` |
| `7-Zip.zip`         | `.zip` archive handler                                   |
| `7-Zip.rar`         | `.rar` archive handler                                   |
| `7-Zip.tar`         | `.tar` archive handler                                   |
| `7-Zip.gz`          | `.gz` / `.tgz` archive handler                           |

Each ProgID contains a `shell\open\command` subkey pointing to `7zFM.exe "%1"`.

## 📝 Notes

- Admin installs store `Path` in `HKLM`, user settings go to `HKCU`.
- File context menu options are handled by shell extensions.

## 🗑️ Cleanup

Remove all 7-Zip registry entries (run as Administrator for HKLM keys):

```powershell
Remove-Item -Path "HKCU:\Software\7-Zip"                          -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path "HKLM:\SOFTWARE\7-Zip"                          -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path "HKLM:\SOFTWARE\WOW6432Node\7-Zip"              -Recurse -Force -ErrorAction SilentlyContinue
```
