---
tags:
  - meta
  - stats
---

# 📊 Project Statistics

Current coverage across **90 open-source Windows applications** — updated with each release.

---

## 🗂️ Registry Coverage

| Metric | Count |
|--------|-------|
| **Total apps documented** | **90** |
| **Total registry paths documented** | **300** |
| Apps that write to **HKCU** | 68 (76%) |
| Apps that write to **HKLM** | 76 (84%) |
| Apps that write to **HKCR** (file associations / URI schemes) | 33 (37%) |
| Apps that write to all three (HKCU + HKLM + HKCR) | 20 (22%) |
| Apps with **Windows service keys** (`HKLM\SYSTEM\...\Services`) | 13 |
| Apps that write to **HKLM only** (no user-level keys) | 13 |
| Apps that write to **HKCU only** | 10 |

---

## 🔑 Hive Distribution

```
HKLM  ████████████████████████████████████████████████  84%  (76 apps)
HKCU  ██████████████████████████████████████████        76%  (68 apps)
HKCR  █████████████████████                             37%  (33 apps)
```

---

## 📦 Installer Type Breakdown

| Type | Count |
|------|-------|
| `.exe` (various) | 63 |
| `.msi` | 11 |
| Portable (no installer) | 12 |
| Built-in / OS feature | 1 |

---

## 🖥️ Apps with Windows Services

These apps install Windows services (`HKLM\SYSTEM\CurrentControlSet\Services`) — relevant for sysadmins managing startup behavior and service accounts:

| Application | Service Name |
|-------------|-------------|
| [Docker Desktop](docker-desktop.md) | `com.docker.service` |
| [Nextcloud Desktop](nextcloud.md) | `nextcloud` (VFS) |
| [OBS Studio](obs.md) | `OBSVirtualCam` |
| [OpenVPN](openvpn.md) | `OpenVPNService`, `tap0901` |
| [Process Hacker](processhacker.md) | `KProcessHacker3` (kernel driver) |
| [RustDesk](rustdesk.md) | `RustDesk` |
| [Syncthing](syncthing.md) | `SyncTrayzor` |
| [Oracle VM VirtualBox](virtualbox.md) | `VBoxDrv`, `VBoxNetFlt` |
| [Wireshark](wireshark.md) | `npcap` (packet capture driver) |
| [WSL](wsl.md) | `WslService`, `LxssManager` |
| [ZeroTier](zerotier.md) | `ZeroTierOneService` |

---

## 🔗 Apps with File Associations (HKCR)

28 apps register file type handlers or URI schemes in HKCR. Key examples:

| Application | File Types / URI Schemes |
|-------------|------------------------|
| [7-Zip](7zip.md) | `.7z`, `.zip`, `.rar`, `.tar`, `.gz`, `.bz2` |
| [AutoHotkey](autohotkey.md) | `.ahk` |
| [Calibre](calibre.md) | `.epub`, `.mobi`, `.fb2` |
| [Firefox](firefox.md) | `FirefoxHTML`, `FirefoxURL`, `mailto:` |
| [Git Extensions](git-extensions.md) | `.git` |
| [IrfanView](irfanview.md) | `.jpg`, `.png`, `.bmp`, `.webp`, `.heic` |
| [KeePassXC](keepassxc.md) | `.kdbx` |
| [MPC-HC](mpc-hc.md) | `.mkv`, `.mp4`, `.avi`, `.mov` |
| [MusicBee](musicbee.md) | `.mp3`, `.flac`, `.ogg`, `.aac` |
| [Nmap](nmap.md) | `.nmap` (Zenmap profile) |
| [Python](python.md) | `.py`, `.pyw` |
| [Signal](signal.md) | `sgnl://` |
| [Sumatra PDF](sumatrapdf.md) | `.pdf`, `.epub`, `.cbz`, `.djvu` |
| [Telegram](telegram.md) | `tg://` |
| [Thunderbird](thunderbird.md) | `mailto:`, `.eml` |
| [VLC](vlc.md) | `.mp4`, `.mkv`, `.avi`, `.mp3`, `vlc://` |
| [WinMerge](winmerge.md) | Explorer context menu (all files) |
| [Wireshark](wireshark.md) | `.pcap`, `.pcapng`, `.cap` |

---

## 🛠️ Apps with Portable / No-Install Options

These apps can run with zero registry footprint (useful for restricted environments):

| Application | Notes |
|-------------|-------|
| [Everything](everything.md) | Portable `.exe` available |
| [KeePass Password Safe](keepass.md) | Portable `.zip` available |
| [KeePassXC](keepassxc.md) | Portable `.zip` available |
| [MPC-HC](mpc-hc.md) | Portable `.zip` available |
| [Notepad2](notepad2.md) | Primarily portable |
| [Rufus](rufus.md) | Single `.exe`, no installer |
| [Sumatra PDF](sumatrapdf.md) | Portable `.exe` available |
| [Syncthing](syncthing.md) | Single `.exe`, no installer |
| [WinDirStat](windirstat.md) | Portable `.exe` available |

---

## 📈 Growth History

| Milestone | Apps |
|-----------|------|
| Initial release | 19 |
| Batch 2 (developer tools) | 29 |
| Batch 3 (productivity + dev tools) | 39 |
| Batch 4 (utilities + security) | 50 |
| Batch 5 (sysadmin + multimedia) | 60 |
| Batch 6 (media + sync + dev) | 70 |
| Batch 7 (creative + utilities) | 80 |
| Batch 8 (network + media + dev tools) | **90** |

---

## 🔄 Keeping Docs Current

Registry keys can change between major app versions. This project uses two mechanisms to stay up to date:

### Automated Staleness Detection

A [weekly GitHub Actions workflow](https://github.com/samibs/Registry-Keys-for-Open-Source-Applications-on-Windows/actions/workflows/version-check.yml) runs every Monday. It:

1. Queries **winget** for the latest version of each documented app
2. Compares it against the version recorded in each `.md` file
3. Opens a **GitHub Issue** automatically listing any docs that appear stale

You can also run the check locally:

```powershell
# Check all apps — show table of current vs. latest
pwsh -File tools/check-versions.ps1

# Show only stale apps
pwsh -File tools/check-versions.ps1 -StaleOnly

# Output GitHub issue-ready markdown
pwsh -File tools/check-versions.ps1 -OutputFormat issues
```

### `last_verified` Tracking

Every entry in `index.json` includes a `last_verified` date derived from the last git commit to that file. This makes it easy to identify docs that haven't been touched in a long time.

### How to Update a Stale Doc

1. Install the latest app version on a test system
2. Use `regedit` or `reg query` to verify current registry structure
3. Update the version number and any changed keys in `windows/<app>.md`
4. Run `pwsh -File tools/validate-docs.ps1` to verify
5. Run `pwsh -File tools/build-index.ps1` to rebuild the index
6. Submit a PR — see [CONTRIBUTING.md](https://github.com/samibs/Registry-Keys-for-Open-Source-Applications-on-Windows/blob/main/CONTRIBUTING.md)

---

*Want to add an app? See [CONTRIBUTING.md](https://github.com/samibs/Registry-Keys-for-Open-Source-Applications-on-Windows/blob/main/CONTRIBUTING.md).*
