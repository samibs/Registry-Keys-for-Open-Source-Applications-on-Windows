# Registry Keys for Open-Source Windows Apps

A community-driven reference of Windows registry keys created by popular open-source applications — for sysadmins, power users, and automation developers.

---

## What is this?

When open-source applications are installed on Windows, they write entries to the Windows Registry for installation paths, uninstall information, user preferences, and more. This site documents those keys so you can:

- **Automate deployments** — know exactly which keys to check or set in Chocolatey, Intune, or PowerShell scripts
- **Audit installations** — verify what an app wrote to your registry
- **Clean up** — remove leftover keys after uninstalling an app
- **Migrate settings** — export the right keys to move a user's config to a new machine

---

## Verified Applications

| Application | Version | Installer | Hives |
|-------------|---------|-----------|-------|
| [7-Zip](7zip.md) | 23.01 | `.exe` | HKCU, HKLM |
| [Audacity](audacity.md) | 3.4.2 | `.exe` | HKLM |
| [FileZilla](filezilla.md) | 3.66.5 | `.exe` | HKLM |
| [Mozilla Firefox](firefox.md) | 123.0 | `.exe` | HKCU, HKLM |
| [GIMP](gimp.md) | 2.10.36 | `.exe` | HKLM |
| [Git for Windows](git.md) | 2.44.0 | `.exe` | HKCU, HKLM |
| [HandBrake](handbrake.md) | 1.7.3 | `.exe` | HKLM |
| [Inkscape](inkscape.md) | 1.3.2 | `.exe` | HKLM |
| [KeePass Password Safe](keepass.md) | 2.55 | `.exe` | HKLM |
| [LibreOffice](libreoffice.md) | 7.6.5 | `.msi` | HKCU, HKLM |
| [Notepad++](notepadplusplus.md) | 8.6.2 | `.exe` | HKCU, HKLM |
| [OBS Studio](obs.md) | 30.0.2 | `.exe` | HKLM |
| [PuTTY](putty.md) | 0.80 | `.msi` | HKCU, HKLM |
| [qBittorrent](qbittorrent.md) | 4.6.3 | `.exe` | HKCU, HKLM |
| [Oracle VM VirtualBox](virtualbox.md) | 7.0.14 | `.exe` | HKLM |
| [VLC Media Player](vlc.md) | 3.0.20 | `.exe` | HKCU, HKLM |
| [Visual Studio Code](vscode.md) | 1.85.1 | User `.exe` | HKCU |
| [WinSCP](winscp.md) | 6.3.3 | `.exe` | HKCU, HKLM |
| [Wireshark](wireshark.md) | 4.2.3 | `.exe` | HKLM |

---

## Machine-Readable Index

All entries are also available as [`index.json`](https://github.com/samibs/Registry-Keys-for-Open-Source-Applications-on-Windows/blob/main/windows/index.json) for use in scripts and tooling.

```powershell
# Example: find all apps that write to HKCU
$index = Invoke-RestMethod "https://raw.githubusercontent.com/samibs/Registry-Keys-for-Open-Source-Applications-on-Windows/main/windows/index.json"
$index | Where-Object { $_.hives -contains "HKCU" } | Select-Object name, slug
```

---

## Contributing

Want to add an app? See [CONTRIBUTING.md](https://github.com/samibs/Registry-Keys-for-Open-Source-Applications-on-Windows/blob/main/CONTRIBUTING.md) and use the capture script:

```powershell
git clone https://github.com/samibs/Registry-Keys-for-Open-Source-Applications-on-Windows
cd Registry-Keys-for-Open-Source-Applications-on-Windows
.\tools\export-reg-changes.ps1   # follow prompts to capture before/after install
```
