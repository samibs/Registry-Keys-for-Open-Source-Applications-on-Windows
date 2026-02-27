---
tags:
  - meta
  - stats
---

# 📊 Project Statistics

Current coverage across **70 open-source Windows applications** — updated with each release.

---

## 🗂️ Registry Coverage

| Metric | Count |
|--------|-------|
| **Total apps documented** | **70** |
| **Total registry paths documented** | **239** |
| Apps that write to **HKCU** | 51 (73%) |
| Apps that write to **HKLM** | 61 (87%) |
| Apps that write to **HKCR** (file associations / URI schemes) | 28 (40%) |
| Apps that write to all three (HKCU + HKLM + HKCR) | 16 (23%) |
| Apps with **Windows service keys** (`HKLM\SYSTEM\...\Services`) | 11 |
| Apps that write to **HKLM only** (no user-level keys) | 11 |
| Apps that write to **HKCU only** | 5 |

---

## 🔑 Hive Distribution

```
HKLM  ████████████████████████████████████████████████  87%  (61 apps)
HKCU  ██████████████████████████████████████            73%  (51 apps)
HKCR  █████████████████████                             40%  (28 apps)
```

---

## 📦 Installer Type Breakdown

| Type | Count |
|------|-------|
| `.exe` (various) | 60 |
| `.msi` | 11 |
| Portable (no installer) | 9 |
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
| Batch 6 (media + sync + dev) | **70** |

---

*Want to add an app? See [CONTRIBUTING.md](https://github.com/samibs/Registry-Keys-for-Open-Source-Applications-on-Windows/blob/main/CONTRIBUTING.md).*
