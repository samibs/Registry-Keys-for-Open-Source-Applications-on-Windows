---
tags:
  - email
  - mozilla
  - calendar
  - communication
description: >-
  Windows registry keys created by Mozilla Thunderbird — install paths, uninstall keys, HKCU and HKLM entries for sysadmin automation and cleanup.
---

# Mozilla Thunderbird

**Version documented:** 115.8.0
**Installer type:** `.exe` (NSIS)
**Hives written:** HKCU, HKLM, HKCR

---

## 📁 Registry Paths

| Path | Hive | Purpose |
|------|------|---------|
| `SOFTWARE\Mozilla\Mozilla Thunderbird` | HKLM | Installation info |
| `SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Mozilla Thunderbird` | HKLM | Uninstall entry |
| `SOFTWARE\Clients\Mail\Mozilla Thunderbird` | HKLM | Default mail client registration |
| `HKCR\mailto` | HKCR | `mailto:` URI handler |
| `HKCR\ThunderbirdEML` | HKCR | `.eml` file type |
| `HKCR\.eml` | HKCR | .eml file association |

---

## 🔑 Keys

### HKLM\SOFTWARE\Mozilla\Mozilla Thunderbird

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `CurrentVersion` | REG_SZ | `115.8.0 (x64 en-US)` | Full version string |

### HKLM\SOFTWARE\Mozilla\Mozilla Thunderbird\115.8.0 (x64 en-US)\Main

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `Install Directory` | REG_SZ | `C:\Program Files\Mozilla Thunderbird` | Install path |
| `PathToExe` | REG_SZ | `C:\Program Files\Mozilla Thunderbird\thunderbird.exe` | Full exe path |

### HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Mozilla Thunderbird

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `DisplayName` | REG_SZ | `Mozilla Thunderbird 115.8.0 (x64 en-US)` | Display name |
| `DisplayVersion` | REG_SZ | `115.8.0` | Version |
| `Publisher` | REG_SZ | `Mozilla` | Publisher |
| `InstallLocation` | REG_SZ | `C:\Program Files\Mozilla Thunderbird` | Install path |
| `UninstallString` | REG_SZ | `"...\helper.exe" /uninstall` | Uninstaller |

### HKLM\SOFTWARE\Clients\Mail\Mozilla Thunderbird

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `(Default)` | REG_SZ | `Mozilla Thunderbird` | Display name for default mail |
| `DLLPath` | REG_SZ | `C:\Program Files\Mozilla Thunderbird\mozMapi32.dll` | MAPI DLL path |

### HKCR\mailto

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `(Default)` | REG_SZ | `URL:MailTo Protocol` | Protocol description |
| `URL Protocol` | REG_SZ | `` | Marks as URL handler |
| `shell\open\command` (Default) | REG_SZ | `"thunderbird.exe" -osint -compose "%1"` | Open command |

---

## 📝 Notes

- Setting Thunderbird as default mail client writes the `mailto:` handler to both HKCU and HKLM.
- Mail profiles, accounts, and messages are stored in `%APPDATA%\Thunderbird\Profiles\` — back up this folder to migrate.
- The MAPI DLL (`mozMapi32.dll`) enables "Send to mail" from other Windows applications.

```powershell
# Check if Thunderbird is the default mail client
(Get-ItemProperty "HKLM:\SOFTWARE\Clients\Mail" -ErrorAction SilentlyContinue).'(Default)'

# Get install path
$ver = (Get-ItemProperty "HKLM:\SOFTWARE\Mozilla\Mozilla Thunderbird").CurrentVersion
(Get-ItemProperty "HKLM:\SOFTWARE\Mozilla\Mozilla Thunderbird\$ver\Main").'Install Directory'
```

---

## 🗑️ Cleanup

```powershell
# Remove Thunderbird installation keys
Remove-Item -Path "HKLM:\SOFTWARE\Mozilla\Mozilla Thunderbird" -Recurse -ErrorAction SilentlyContinue
Remove-Item -Path "HKCR:\ThunderbirdEML" -Recurse -ErrorAction SilentlyContinue

# Remove mailto handler if Thunderbird owned it
$mapiDll = (Get-ItemProperty "HKCU:\SOFTWARE\Clients\Mail\Mozilla Thunderbird" -ErrorAction SilentlyContinue).DLLPath
if ($mapiDll -like "*Thunderbird*") {
    Remove-Item -Path "HKCU:\SOFTWARE\Clients\Mail\Mozilla Thunderbird" -Recurse -ErrorAction SilentlyContinue
}
```

---

## 📦 Package Managers

| Manager | ID / Command |
|---------|-------------|
| winget | `winget install Mozilla.Thunderbird` |
| Chocolatey | `choco install thunderbird` |
| Scoop | `scoop install extras/thunderbird` |
