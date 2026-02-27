# Contributing to Registry Keys for Open-Source Windows Apps

We welcome contributions from sysadmins, developers, and power users who have hands-on experience with Windows registry behaviour. Quality over quantity — every entry should be **verified on a real machine**.

---

## Ways to Contribute

| Type | How |
|------|-----|
| ➕ **New application** | Add a new `windows/<app>.md` following the template below |
| 🔄 **Update existing doc** | Open a PR correcting version, paths, or key values |
| 🐛 **Report an error** | Open an issue — include OS version and app version |
| 💡 **Suggest an app** | Open an issue with the app name and why it's useful |

---

## Before You Start

- Verify registry keys on a **clean install** (VM snapshot recommended).
- Test with the **latest stable release** of the app.
- Use `tools/export-reg-changes.ps1` to capture before/after snapshots automatically.
- Run `tools/validate-docs.ps1` locally before opening a PR — CI will reject failures.

---

## Full Document Template

Every `windows/<app>.md` must include all sections below. Replace everything in `[brackets]`.

```markdown
---
tags:
  - [category]       # e.g. browser, text-editor, audio, network
  - [HKCU|HKLM|HKCR|HKLM-SYSTEM]   # all hives this app touches
  - [exe-installer|msi-installer|portable]
---

# [Application Name]

**Version tested:** [e.g., 1.2.3]
**Installer type:** [e.g., `.exe` official installer from example.com]

## 📦 Package Managers

| Manager    | Install Command |
|------------|-----------------|
| winget     | `winget install Publisher.AppName` |
| Chocolatey | `choco install appname` |
| Scoop      | `scoop install appname` |

## 📁 Registry Paths

- `HKEY_CURRENT_USER\Software\Vendor\AppName`
- `HKEY_LOCAL_MACHINE\SOFTWARE\Vendor\AppName`
- `HKEY_CLASSES_ROOT\.ext`  *(file association, if applicable)*

## 🔑 Keys

| Key Name       | Type        | Description                              |
|----------------|-------------|------------------------------------------|
| `KeyName`      | `REG_SZ`    | What this value controls                 |
| `AnotherKey`   | `REG_DWORD` | Numeric setting; `0` = disabled, `1` = enabled |

### Optional subsection for complex apps

| Key Name    | Type     | Description |
|-------------|----------|-------------|
| `SubKey`    | `REG_SZ` | ...         |

## 📝 Notes

- Key behaviours, caveats, or security warnings.
- ⚠️ Use this prefix for anything security-relevant.
- Differences between admin and user installs.

## 🗑️ Cleanup

```powershell
Remove-Item -Path "HKCU:\Software\Vendor\AppName"  -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path "HKLM:\SOFTWARE\Vendor\AppName"  -Recurse -Force -ErrorAction SilentlyContinue
```
```

---

## Annotated Example — `windows/keepass.md`

Here's what a complete, production-ready doc looks like (abbreviated):

```markdown
---
tags:
  - password-manager
  - security
  - HKCU
  - HKLM
  - exe-installer
---

# KeePass Password Safe

**Version tested:** 2.55
**Installer type:** `.exe` official installer from keepass.info

## 📦 Package Managers

| Manager    | Install Command |
|------------|-----------------|
| winget     | `winget install DominikReichl.KeePass` |
| Chocolatey | `choco install keepass` |
| Scoop      | `scoop install keepass` |

## 📁 Registry Paths

- `HKEY_CURRENT_USER\Software\KeePass`
- `HKEY_LOCAL_MACHINE\SOFTWARE\KeePass`

## 🔑 Keys

| Key Name         | Type     | Description                          |
|------------------|----------|--------------------------------------|
| `LastUsedFile`   | `REG_SZ` | Path to the last opened .kdbx file  |
| `StartWithWindows` | `REG_DWORD` | `1` = launch KeePass at logon   |

## 📝 Notes

- The master database (.kdbx) is **not** stored in the registry.
- ⚠️ Do not store the master password in the registry.

## 🗑️ Cleanup

```powershell
Remove-Item -Path "HKCU:\Software\KeePass"  -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path "HKLM:\SOFTWARE\KeePass"  -Recurse -Force -ErrorAction SilentlyContinue
```
```

---

## Filename Conventions

| Rule | Example |
|------|---------|
| Lowercase, no spaces | `notepadplusplus.md` ✅ |
| Hyphens for multi-word | `git-extensions.md` ✅ |
| No version numbers | `vscode.md` ✅ not `vscode-1.85.md` |

---

## After Adding a Doc

1. Run `tools/build-index.ps1` to update `windows/index.json`.
2. Run `tools/validate-docs.ps1` — all files must pass.
3. Add the new app to the `nav:` section in `mkdocs.yml` (alphabetical order).
4. Add the new app to the table in `windows/index.md`.
5. Open a PR — CI will re-run both scripts automatically.

---

## Code of Conduct

This project follows a standard contributor code of conduct. Be respectful, be accurate, and cite your sources. Registry key values you document should be verifiable by any other contributor on a clean Windows install.

