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
| [7-Zip](7zip.md) | 23.01 | `.exe` | HKCU, HKLM, HKCR |
| [Audacity](audacity.md) | 3.4.2 | `.exe` | HKCU, HKLM |
| [Brave Browser](brave.md) | 1.63.169 | `.exe` | HKCU, HKLM, HKCR |
| [DBeaver](dbeaver.md) | 24.0.0 | `.exe` | HKLM |
| [Docker Desktop](docker-desktop.md) | 4.29.0 | `.exe` | HKLM, SYSTEM |
| [FileZilla](filezilla.md) | 3.66.5 | `.exe` | HKCU, HKLM |
| [Mozilla Firefox](firefox.md) | 123.0 | `.exe` | HKCU, HKLM, HKCR |
| [GIMP](gimp.md) | 2.10.36 | `.exe` | HKCU, HKLM |
| [Git Extensions](git-extensions.md) | 4.2.1 | `.msi` | HKCU, HKLM, HKCR |
| [Git for Windows](git.md) | 2.44.0 | `.exe` | HKCU, HKLM |
| [HandBrake](handbrake.md) | 1.7.3 | `.exe` | HKCU, HKLM |
| [HeidiSQL](heidisql.md) | 12.6.0 | `.exe` | HKCU, HKLM |
| [Inkscape](inkscape.md) | 1.3.2 | `.exe` | HKCU, HKLM |
| [KeePass Password Safe](keepass.md) | 2.55 | `.exe` | HKCU, HKLM |
| [LibreOffice](libreoffice.md) | 7.6.5 | `.msi` | HKCU, HKLM |
| [Node.js](nodejs.md) | 20.11.1 | `.msi` | HKLM |
| [Notepad++](notepadplusplus.md) | 8.6.2 | `.exe` | HKLM |
| [OBS Studio](obs.md) | 30.0.2 | `.exe` | HKCU, HKLM |
| [PuTTY](putty.md) | 0.80 | `.msi` | HKCU, HKLM |
| [Python](python.md) | 3.12.2 | `.exe` | HKCU, HKLM, HKCR |
| [qBittorrent](qbittorrent.md) | 4.6.3 | `.exe` | HKCU, HKLM, HKCR |
| [Signal Desktop](signal.md) | 7.7.0 | `.exe` | HKCU, HKCR |
| [Sublime Text](sublime-text.md) | 4169 | `.exe` | HKLM, HKCR |
| [Telegram Desktop](telegram.md) | 4.16.6 | `.exe` | HKCU, HKCR |
| [Oracle VM VirtualBox](virtualbox.md) | 7.0.14 | `.exe` | HKLM, SYSTEM |
| [VLC Media Player](vlc.md) | 3.0.20 | `.exe` | HKCU, HKLM, HKCR |
| [Visual Studio Code](vscode.md) | 1.85.1 | User `.exe` | HKCU, HKCR |
| [WinSCP](winscp.md) | 6.3.3 | `.exe` | HKCU, HKLM |
| [Wireshark](wireshark.md) | 4.2.3 | `.exe` | HKLM, HKCR, SYSTEM |
| [Everything](everything.md) | 1.4.1.1024 | `.exe` | HKLM, HKCU |
| [foobar2000](foobar2000.md) | 2.1.5 | `.exe` | HKLM, HKCU |
| [Greenshot](greenshot.md) | 1.3.274 | `.exe` | HKLM, HKCU |
| [Insomnia](insomnia.md) | 9.3.3 | `.exe` | HKLM |
| [MobaXterm](mobaxterm.md) | 23.6 | `.exe` | HKLM, HKCU |
| [Notepad2](notepad2.md) | 4.23.04 | `.exe` | HKLM |
| [Postman](postman.md) | 10.22.13 | `.exe` | HKLM, HKCU |
| [PowerToys](powertoys.md) | 0.79.0 | `.exe` | HKLM, HKCU |
| [ShareX](sharex.md) | 16.0.0 | `.exe` | HKLM |
| [WSL](wsl.md) | 2.x | Built-in | HKLM, HKCU |

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
