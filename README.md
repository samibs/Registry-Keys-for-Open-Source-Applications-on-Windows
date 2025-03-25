Registry Keys for Open-Source Applications on Windows

This repository collects Windows registry keys created by various open-source applications to help system administrators, power users, and automation developers streamline installation, configuration, and scripting.

📦 Purpose

Quickly identify registry keys created during app installation

Help automate software deployment

Enable post-install configuration

Offer a community-driven knowledge base

✅ Structure

registry-keys/
├── windows/
│   ├── vlc.md
│   ├── 7zip.md
│   ├── git.md
│   ├── vscode.md
│   ├── gimp.md
│   └── ...
├── tools/
│   ├── export_reg_script.ps1
│   └── reg_compare.ps1
├── README.md
├── LICENSE
└── CONTRIBUTING.md

🧪 Verified Programs

Below is the initial list. More will be added over time:

VLC Media Player

7-Zip

Git for Windows

Visual Studio Code

GIMP

Notepad++

Audacity

FileZilla

Inkscape

KeePass

📄 Template Format (for each program)

## VLC Media Player

**Version:** 3.0.20  
**Registry Paths:**
- HKEY_CURRENT_USER\Software\VideoLAN\VLC
- HKEY_LOCAL_MACHINE\SOFTWARE\VideoLAN\VLC

### Keys
| Key                | Type         | Purpose                         |
|--------------------|--------------|---------------------------------|
| InstallDir         | REG_SZ       | Installation directory          |
| recentlyUsedMedia  | REG_MULTI_SZ | List of recently opened files   |

### Notes
- Keys may differ if using Microsoft Store version.

🤝 Contributing

Please refer to CONTRIBUTING.md for how to submit registry dumps or templates. Use export scripts provided in tools/ to capture registry changes.

📜 License

This project is licensed under the MIT License.
