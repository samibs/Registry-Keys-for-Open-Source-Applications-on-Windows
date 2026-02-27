Registry Keys for Open-Source Applications on Windows

[![Documentation Site](https://img.shields.io/badge/docs-live%20site-blue?logo=materialformkdocs)](https://samibs.github.io/Registry-Keys-for-Open-Source-Applications-on-Windows/)
[![Validate Docs](https://github.com/samibs/Registry-Keys-for-Open-Source-Applications-on-Windows/actions/workflows/validate.yml/badge.svg)](https://github.com/samibs/Registry-Keys-for-Open-Source-Applications-on-Windows/actions/workflows/validate.yml)
[![Deploy Pages](https://github.com/samibs/Registry-Keys-for-Open-Source-Applications-on-Windows/actions/workflows/deploy-pages.yml/badge.svg)](https://github.com/samibs/Registry-Keys-for-Open-Source-Applications-on-Windows/actions/workflows/deploy-pages.yml)

This repository collects Windows registry keys created by various open-source applications to help system administrators, power users, and automation developers streamline installation, configuration, and scripting.

📦 Purpose

Quickly identify registry keys created during app installation

Help automate software deployment

Enable post-install configuration

Offer a community-driven knowledge base

✅ Structure

.
├── windows/
│   ├── 7zip.md
│   ├── audacity.md
│   ├── filezilla.md
│   ├── firefox.md
│   ├── gimp.md
│   ├── git.md
│   ├── handbrake.md
│   ├── inkscape.md
│   ├── keepass.md
│   ├── libreoffice.md
│   ├── notepadplusplus.md
│   ├── obs.md
│   ├── putty.md
│   ├── qbittorrent.md
│   ├── virtualbox.md
│   ├── vlc.md
│   ├── vscode.md
│   ├── winscp.md
│   └── wireshark.md
├── tools/
│   ├── export-reg-changes.ps1   # Capture registry diff during install
│   └── validate-docs.ps1        # Validate doc structure (used by CI)
├── CONTRIBUTING.md
├── LICENSE
└── README.md

🧪 Verified Programs

| Application | Version Tested | Installer Type |
|-------------|---------------|----------------|
| [7-Zip](./windows/7zip.md) | 23.01 | `.exe` |
| [Audacity](./windows/audacity.md) | 3.4.2 | `.exe` |
| [Brave Browser](./windows/brave.md) | 1.63.169 | `.exe` |
| [DBeaver](./windows/dbeaver.md) | 24.0.0 | `.exe` |
| [Docker Desktop](./windows/docker-desktop.md) | 4.29.0 | `.exe` |
| [FileZilla](./windows/filezilla.md) | 3.66.5 | `.exe` |
| [Mozilla Firefox](./windows/firefox.md) | 123.0 | `.exe` |
| [GIMP](./windows/gimp.md) | 2.10.36 | `.exe` |
| [Git Extensions](./windows/git-extensions.md) | 4.2.1 | `.msi` |
| [Git for Windows](./windows/git.md) | 2.44.0 | `.exe` |
| [HandBrake](./windows/handbrake.md) | 1.7.3 | `.exe` |
| [HeidiSQL](./windows/heidisql.md) | 12.6.0 | `.exe` |
| [Inkscape](./windows/inkscape.md) | 1.3.2 | `.exe` |
| [KeePass Password Safe](./windows/keepass.md) | 2.55 | `.exe` |
| [LibreOffice](./windows/libreoffice.md) | 7.6.5 | `.msi` |
| [Node.js](./windows/nodejs.md) | 20.11.1 | `.msi` |
| [Notepad++](./windows/notepadplusplus.md) | 8.6.2 | `.exe` |
| [OBS Studio](./windows/obs.md) | 30.0.2 | `.exe` |
| [PuTTY](./windows/putty.md) | 0.80 | `.msi` |
| [Python](./windows/python.md) | 3.12.2 | `.exe` |
| [qBittorrent](./windows/qbittorrent.md) | 4.6.3 | `.exe` |
| [Signal Desktop](./windows/signal.md) | 7.7.0 | `.exe` |
| [Sublime Text](./windows/sublime-text.md) | 4169 | `.exe` |
| [Telegram Desktop](./windows/telegram.md) | 4.16.6 | `.exe` |
| [Oracle VM VirtualBox](./windows/virtualbox.md) | 7.0.14 | `.exe` |
| [VLC Media Player](./windows/vlc.md) | 3.0.20 | `.exe` |
| [Visual Studio Code](./windows/vscode.md) | 1.85.1 | User `.exe` |
| [WinSCP](./windows/winscp.md) | 6.3.3 | `.exe` |
| [Wireshark](./windows/wireshark.md) | 4.2.3 | `.exe` |

📄 Template Format

Please see the `CONTRIBUTING.md` file for the template to use when adding a new application.

🛠️ Tools

### Capture Registry Changes

Use `tools/export-reg-changes.ps1` to take a before/after snapshot of the registry during an application install. It automatically generates a Markdown file ready for contribution.

```powershell
# Run from the tools/ directory — follow the on-screen prompts
.\tools\export-reg-changes.ps1
```

### Validate Documentation

Use `tools/validate-docs.ps1` to verify that all files in `windows/` conform to the required template before submitting a pull request.

```powershell
.\tools\validate-docs.ps1
```

This script also runs automatically via GitHub Actions on every push or pull request that touches `windows/` or `tools/`.

### Machine-Readable Index

`windows/index.json` is a structured index of all documented applications — useful for scripting, automation, and tooling integration.

```json
// windows/index.json  (excerpt)
[
  {
    "name": "7-Zip",
    "slug": "7zip",
    "file": "windows/7zip.md",
    "version_tested": "23.01",
    "installer_type": ".exe",
    "hives": ["HKCU", "HKLM"],
    "registry_paths": [
      "HKEY_CURRENT_USER\\Software\\7-Zip",
      "HKEY_LOCAL_MACHINE\\SOFTWARE\\7-Zip"
    ]
  }
]
```

Use `tools/build-index.ps1` to regenerate `index.json` after adding or updating a doc:

```powershell
.\tools\build-index.ps1          # regenerate
.\tools\build-index.ps1 -DryRun  # check if stale without writing
```

The CI workflow enforces that `index.json` is always in sync with the markdown files.

🤝 Contributing

Please refer to CONTRIBUTING.md for how to submit registry dumps or templates. Use the export script provided in `tools/` to capture registry changes.

📜 License

This project is licensed under the MIT License.
