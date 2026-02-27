---
tags:
  - photo
  - metadata
  - cli
  - portable
---

# ExifTool

**Version:** 12.82  
**Installer:** Portable `.exe` / Perl distribution  
**Hives:** HKCU

ExifTool is a platform-independent Perl library and command-line application for reading, writing, and editing metadata in image, audio, video, and PDF files. Widely used by photographers and digital archivists.

---

## 📁 Registry Paths

| Path | Hive | Description |
|------|------|-------------|
| `SOFTWARE\Classes\*\shell\ExifTool` | HKCU | Optional shell context menu entry |

---

## 🔑 Keys

### HKCU\SOFTWARE\Classes\*\shell\ExifTool

This key is created only when the user manually adds a Windows Explorer context menu entry for ExifTool.

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `(Default)` | `REG_SZ` | `Run ExifTool` | Menu label |

#### HKCU\SOFTWARE\Classes\*\shell\ExifTool\command

| Value Name | Type | Example Data | Description |
|------------|------|--------------|-------------|
| `(Default)` | `REG_SZ` | `"C:\tools\exiftool.exe" "%1"` | Command to execute on selected file |

---

## 📝 Notes

- ExifTool is primarily a **portable single-file executable** — it creates **no registry entries by default**.
- The `HKCU\SOFTWARE\Classes\*\shell\ExifTool` context menu entry is optional and must be created manually or via a wrapper script.
- Metadata edits are written to file headers, sidecar `.xmp` files, or backup files (`.orig`) — not to the registry.
- On Windows, rename `exiftool(-k).exe` to `exiftool.exe` for command-line use.

---

## 🗑️ Cleanup

If you added a shell context menu entry:

```reg
Windows Registry Editor Version 5.00

[-HKEY_CURRENT_USER\SOFTWARE\Classes\*\shell\ExifTool]
```

---

## 📦 Package Managers

| Manager | Install Command |
|---------|----------------|
| winget | `winget install OliverBetz.ExifTool` |
| Chocolatey | `choco install exiftool` |
| Scoop | `scoop install exiftool` |
