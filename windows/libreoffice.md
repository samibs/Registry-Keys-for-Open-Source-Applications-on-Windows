---
tags:
  - office
  - HKCU
  - HKLM
  - exe-installer
---

# LibreOffice

**Version tested:** 7.6.5
**Installer type:** `.msi` official installer from libreoffice.org


## 📦 Package Managers

| Manager    | Install Command |
|------------|-----------------|
| winget     | `winget install TheDocumentFoundation.LibreOffice` |
| Chocolatey | `choco install libreoffice` |
| Scoop      | `scoop install libreoffice` |

## 📁 Registry Paths

- `HKEY_LOCAL_MACHINE\SOFTWARE\LibreOffice\LibreOffice\7.6`
- `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{GUID}` *(GUID varies per build)*
- `HKEY_CURRENT_USER\Software\LibreOffice` *(created at first launch)*

## 🔑 Keys

### Installation entry (`HKLM\SOFTWARE\LibreOffice\LibreOffice\7.6`)

| Key Name      | Type     | Description                                                          |
|---------------|----------|----------------------------------------------------------------------|
| `InstallPath` | `REG_SZ` | Root installation directory (e.g., `C:\Program Files\LibreOffice`)   |
| `ProductCode` | `REG_SZ` | MSI product GUID used by the installer                               |

### Uninstall entry (`HKLM\...\Uninstall\{GUID}`)

| Key Name           | Type        | Description                                           |
|--------------------|-------------|-------------------------------------------------------|
| `DisplayName`      | `REG_SZ`    | `LibreOffice 7.6.5.2`                                |
| `DisplayVersion`   | `REG_SZ`    | Full version string (e.g., `7.6.5.2`)                |
| `DisplayIcon`      | `REG_SZ`    | Path to `soffice.exe`                                |
| `InstallLocation`  | `REG_SZ`    | Root installation directory                           |
| `Publisher`        | `REG_SZ`    | `The Document Foundation`                            |
| `UninstallString`  | `REG_SZ`    | `MsiExec.exe /X{GUID}`                               |
| `EstimatedSize`    | `REG_DWORD` | Estimated install size in KB                         |
| `Language`         | `REG_DWORD` | Language code (e.g., `1033` for English)             |

### User preferences (`HKCU\Software\LibreOffice`) — created at first launch

| Key Name      | Type     | Description                                                  |
|---------------|----------|--------------------------------------------------------------|
| *(subkeys)*   | —        | Subkeys may store MRU file lists and window geometry         |

## 📝 Notes

- The minor version key name (`7.6`) refers to the feature release series; patch releases (7.6.5, 7.6.6, …) share the same key path.
- Most user configuration is stored in `%APPDATA%\LibreOffice\4\user\` as XML files (`registrymodifications.xcu`), not the registry.
- The MSI installer creates COM server registration entries under `HKLM\SOFTWARE\Classes\CLSID\` for OLE/ActiveX embedding.
- File associations (`.odt`, `.docx`, `.xlsx`, etc.) are registered under `HKLM\SOFTWARE\Classes` during install if the user opts in.
- The **64-bit** installer uses the standard path; **32-bit** on 64-bit Windows redirects to `HKLM\SOFTWARE\WOW6432Node\LibreOffice`.

## 🗑️ Cleanup

```powershell
Remove-Item -Path "HKCU:\Software\LibreOffice"               -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path "HKLM:\SOFTWARE\LibreOffice"               -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path "HKLM:\SOFTWARE\WOW6432Node\LibreOffice"   -Recurse -Force -ErrorAction SilentlyContinue
```
