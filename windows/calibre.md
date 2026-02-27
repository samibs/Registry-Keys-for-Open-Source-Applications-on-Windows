---
tags:
  - ebook
  - library
  - reader
  - conversion
---

# Calibre

**Version documented:** 7.6.0
**Installer type:** `.msi` / `.exe`
**Hives written:** HKCU, HKLM, HKCR

---

## 📁 Registry Paths

| Path | Hive | Purpose |
|------|------|---------|
| `SOFTWARE\Kovid Goyal\calibre` | HKCU | User preferences |
| `SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\calibre` | HKLM | Uninstall entry |
| `HKCR\.epub\OpenWithProgIds\calibre.epub` | HKCR | .epub association |
| `HKCR\.mobi\OpenWithProgIds\calibre.mobi` | HKCR | .mobi association |
| `HKCR\calibre.epub` | HKCR | ProgID for epub |

---

## 🔑 Keys

### HKCU\SOFTWARE\Kovid Goyal\calibre

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `library_path` | REG_SZ | `C:\Users\User\Calibre Library` | Default library path |
| `send_to_storage_uid` | REG_SZ | `{GUID}` | Device pairing UID |
| `last_version` | REG_SZ | `7.6.0` | Last run version (update check) |

### HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\calibre

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `DisplayName` | REG_SZ | `calibre 64bit` | Display name |
| `DisplayVersion` | REG_SZ | `7.6.0` | Version string |
| `Publisher` | REG_SZ | `Kovid Goyal` | Publisher |
| `InstallLocation` | REG_SZ | `C:\Program Files\Calibre2` | Install path |
| `UninstallString` | REG_SZ | `MsiExec.exe /I{GUID}` | Uninstaller |
| `URLInfoAbout` | REG_SZ | `https://calibre-ebook.com` | Product URL |

### HKCR\calibre.epub

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `(Default)` | REG_SZ | `ePub Document` | Friendly type name |
| `shell\open\command` (Default) | REG_SZ | `"calibre.exe" "%1"` | Open command |

---

## 📝 Notes

- Calibre registers `.epub`, `.mobi`, `.fb2`, `.lit`, `.lrf`, `.pdb` file associations in HKCR.
- Library path preference is also stored in `tweaks.json` under `%APPDATA%\calibre`; the registry value is a fallback.
- 32-bit installer writes to `C:\Program Files (x86)\Calibre2`; 64-bit to `C:\Program Files\Calibre2`.

```powershell
# Read the configured library path
(Get-ItemProperty "HKCU:\SOFTWARE\Kovid Goyal\calibre" -ErrorAction SilentlyContinue).library_path
```

---

## 🗑️ Cleanup

```powershell
# Remove Calibre user preferences
Remove-Item -Path "HKCU:\SOFTWARE\Kovid Goyal\calibre" -Recurse -ErrorAction SilentlyContinue
Remove-Item -Path "HKCU:\SOFTWARE\Kovid Goyal" -Recurse -ErrorAction SilentlyContinue

# Remove HKCR file associations
foreach ($ext in @('.epub','.mobi','.fb2','.lit','.lrf','.pdb')) {
    Remove-ItemProperty -Path "HKCR:\$ext\OpenWithProgIds" -Name "calibre$ext" -ErrorAction SilentlyContinue
}
Remove-Item -Path "HKCR:\calibre.epub" -Recurse -ErrorAction SilentlyContinue
Remove-Item -Path "HKCR:\calibre.mobi" -Recurse -ErrorAction SilentlyContinue
```

---

## 📦 Package Managers

| Manager | ID / Command |
|---------|-------------|
| winget | `winget install calibre.calibre` |
| Chocolatey | `choco install calibre` |
| Scoop | `scoop install extras/calibre` |
