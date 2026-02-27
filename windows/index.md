---
description: >-
  Community reference of Windows registry keys for 100+ open-source applications.
  Covers HKCU, HKLM, and HKCR paths for sysadmins, automation developers, and power users.
  Includes install paths, uninstall keys, and per-user settings for tools like 7-Zip, Git, VLC, and more.
---

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

<div id="app-table-controls">
  <input id="app-filter" type="text" placeholder="Filter by name, hive (HKCU, HKLM, HKCR), or installer type…" />
  <div id="letter-nav"></div>
  <div id="pagination-bar">
    <button id="prev-page" class="pg-btn">&#8592; Prev</button>
    <span id="page-indicator"></span>
    <button id="next-page" class="pg-btn">Next &#8594;</button>
    <span id="count-indicator"></span>
    <label class="pg-size-label">Show
      <select id="page-size">
        <option value="25" selected>25</option>
        <option value="50">50</option>
        <option value="10">10</option>
        <option value="0">All</option>
      </select>
      per page
    </label>
  </div>
</div>

<script>
document.addEventListener('DOMContentLoaded', function () {
  var input       = document.getElementById('app-filter');
  var letterNav   = document.getElementById('letter-nav');
  var prevBtn     = document.getElementById('prev-page');
  var nextBtn     = document.getElementById('next-page');
  var pageInd     = document.getElementById('page-indicator');
  var countInd    = document.getElementById('count-indicator');
  var pageSizeSel = document.getElementById('page-size');
  if (!input) return;

  var tbody = document.querySelector('#app-table-controls ~ table tbody');
  if (!tbody) tbody = document.querySelector('table tbody');
  if (!tbody) return;

  /* Sort rows alphabetically by app name (first cell) */
  var allRows = Array.from(tbody.querySelectorAll('tr'));
  allRows.sort(function (a, b) {
    var na = a.cells[0].textContent.trim().toLowerCase();
    var nb = b.cells[0].textContent.trim().toLowerCase();
    return na < nb ? -1 : na > nb ? 1 : 0;
  });
  allRows.forEach(function (r) { tbody.appendChild(r); });

  var currentPage  = 1;
  var pageSize     = 25;
  var activeLetter = '';

  /* Build A–Z letter nav */
  ['All'].concat('ABCDEFGHIJKLMNOPQRSTUVWXYZ'.split('')).forEach(function (l) {
    var btn = document.createElement('button');
    btn.textContent    = l;
    btn.className      = 'letter-btn' + (l === 'All' ? ' active' : '');
    btn.dataset.letter = l === 'All' ? '' : l;
    btn.addEventListener('click', function () {
      activeLetter = this.dataset.letter;
      letterNav.querySelectorAll('.letter-btn').forEach(function (b) { b.classList.remove('active'); });
      this.classList.add('active');
      currentPage = 1;
      render();
    });
    letterNav.appendChild(btn);
  });

  function getFiltered() {
    var q = input.value.toLowerCase().trim();
    return allRows.filter(function (row) {
      var letterOk = !activeLetter || row.cells[0].textContent.trim().toUpperCase().charAt(0) === activeLetter;
      var searchOk = !q || row.textContent.toLowerCase().includes(q);
      return letterOk && searchOk;
    });
  }

  function render() {
    var filtered    = getFiltered();
    var total       = filtered.length;
    var ps          = pageSize === 0 ? Math.max(total, 1) : pageSize;
    var totalPages  = Math.max(1, Math.ceil(total / ps));
    if (currentPage > totalPages) currentPage = totalPages;
    var start = (currentPage - 1) * ps;
    var end   = Math.min(start + ps, total);

    allRows.forEach(function (r) { r.style.display = 'none'; });
    filtered.slice(start, end).forEach(function (r) { r.style.display = ''; });

    pageInd.textContent  = 'Page ' + currentPage + ' / ' + totalPages;
    countInd.textContent = (total === 0 ? 'No apps match' : 'Showing ' + (start + 1) + '–' + end + ' of ' + total + ' apps');
    prevBtn.disabled = currentPage <= 1;
    nextBtn.disabled = currentPage >= totalPages;
  }

  input.addEventListener('input', function () { currentPage = 1; render(); });
  prevBtn.addEventListener('click', function () { if (currentPage > 1) { currentPage--; render(); } });
  nextBtn.addEventListener('click', function () {
    var tp = Math.max(1, Math.ceil(getFiltered().length / (pageSize || 1)));
    if (currentPage < tp) { currentPage++; render(); }
  });
  pageSizeSel.addEventListener('change', function () {
    pageSize = parseInt(this.value, 10);
    currentPage = 1;
    render();
  });

  render();
});
</script>

| Application | Version | Installer | Hives |
|-------------|---------|-----------|-------|
| [7-Zip](7zip.md) | 23.01 | `.exe` | HKCU, HKLM, HKCR |
| [Audacity](audacity.md) | 3.4.2 | `.exe` | HKCU, HKLM |
| [Brave Browser](brave.md) | 1.63.169 | `.exe` | HKCU, HKLM, HKCR |
| [Bruno](bruno.md) | 1.21.0 | `.exe` | HKCU, HKLM |
| [Bulk Rename Utility](bulk-rename-utility.md) | 3.4.4.4 | `.exe` / Portable | HKCU, HKLM |
| [DBeaver](dbeaver.md) | 24.0.0 | `.exe` | HKLM |
| [Docker Desktop](docker-desktop.md) | 4.29.0 | `.exe` | HKLM, SYSTEM |
| [FileZilla](filezilla.md) | 3.66.5 | `.exe` | HKCU, HKLM |
| [Flameshot](flameshot.md) | 12.1.0 | `.exe` / `.msi` | HKCU, HKLM |
| [Mozilla Firefox](firefox.md) | 123.0 | `.exe` | HKCU, HKLM, HKCR |
| [GIMP](gimp.md) | 2.10.36 | `.exe` | HKCU, HKLM |
| [Git Extensions](git-extensions.md) | 4.2.1 | `.msi` | HKCU, HKLM, HKCR |
| [Git for Windows](git.md) | 2.44.0 | `.exe` | HKCU, HKLM |
| [GPU-Z](gpu-z.md) | 2.59.0 | Portable | HKCU |
| [HandBrake](handbrake.md) | 1.7.3 | `.exe` | HKCU, HKLM |
| [HashCheck Shell Extension](hashcheck.md) | 2.4.0 | `.exe` | HKCU, HKLM, HKCR |
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
| [WizTree](wiztree.md) | 4.18 | `.exe` / Portable | HKCU, HKLM |
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
| [balenaEtcher](balenaetcher.md) | 1.19.21 | `.exe` | HKCU, HKLM |
| [Calibre](calibre.md) | 7.6.0 | `.msi`/`.exe` | HKCU, HKLM, HKCR |
| [CapFrameX](capframex.md) | 1.8.1 | `.exe` | HKCU, HKLM |
| [CrystalDiskInfo](crystaldiskinfo.md) | 9.3.0 | `.exe` | HKLM |
| [Espanso](espanso.md) | 2.2.1 | `.exe` | HKCU, HKLM |
| [f.lux](flux.md) | 4.120 | `.exe` | HKCU |
| [KeePassXC](keepassxc.md) | 2.7.7 | `.msi`/`.exe` | HKCU, HKLM, HKCR |
| [MusicBee](musicbee.md) | 3.5.8698 | `.exe` | HKCU, HKLM, HKCR |
| [Nmap](nmap.md) | 7.94 | `.exe` | HKLM, HKCR |
| [Obsidian](obsidian.md) | 1.5.12 | `.exe` | HKCU |
| [RustDesk](rustdesk.md) | 1.2.7 | `.exe` | HKCU, HKLM, SYSTEM |
| [Sumatra PDF](sumatrapdf.md) | 3.5.2 | `.exe` | HKCU, HKLM, HKCR |
| [AutoHotkey](autohotkey.md) | 2.0.11 | `.exe` | HKCU, HKLM, HKCR |
| [Bitwarden](bitwarden.md) | 2024.2.1 | `.exe` | HKCU |
| [HWiNFO](hwinfo.md) | 7.72 | `.exe` | HKCU, HKLM |
| [HxD Hex Editor](hxd.md) | 2.5.0.0 | `.exe` / Portable | HKCU, HKLM |
| [IrfanView](irfanview.md) | 4.66 | `.exe` | HKCU, HKLM, HKCR |
| [mRemoteNG](mremoteng.md) | 1.77.3 | `.msi` | HKCU, HKLM |
| [OpenVPN](openvpn.md) | 2.6.9 | `.msi` | HKCU, HKLM, SYSTEM |
| [Process Hacker](processhacker.md) | 3.0.7478 | `.exe` | HKCU, HKLM, SYSTEM |
| [Rufus](rufus.md) | 4.4 | Portable | HKCU |
| [Syncthing](syncthing.md) | 1.27.6 | `.exe` | HKCU, HKLM |
| [WinMerge](winmerge.md) | 2.16.38 | `.exe` | HKCU, HKLM, HKCR |
| [FreeCAD](freecad.md) | 0.21.2 | `.exe` | HKCU, HKLM, HKCR |
| [FurMark](furmark.md) | 2.3.0 | `.exe` | HKCU, HKLM |
| [LMMS](lmms.md) | 1.2.2 | `.exe` | HKCU, HKLM |
| [MediaInfo](mediainfo.md) | 24.01 | `.exe` | HKLM, HKCR |
| [MPC-HC](mpc-hc.md) | 2.3.0 | `.exe` | HKCU, HKLM, HKCR |
| [Nextcloud Desktop](nextcloud.md) | 3.12.3 | `.msi` | HKCU, HKLM, SYSTEM |
| [PDFsam Basic](pdfsam.md) | 5.2.4 | `.exe` | HKCU, HKLM |
| [ScreenToGif](screentogif.md) | 2.41 | `.exe` | HKCU, HKLM |
| [Mozilla Thunderbird](thunderbird.md) | 115.8.0 | `.exe` | HKCU, HKLM, HKCR |
| [WinDirStat](windirstat.md) | 2.1.0 | `.exe` | HKCU, HKLM |
| [ZeroTier](zerotier.md) | 1.14.0 | `.msi` | HKCU, HKLM, SYSTEM |
| [Android Studio](android-studio.md) | 2023.3.1 | `.exe` | HKCU, HKLM |
| [BleachBit](bleachbit.md) | 4.6.2 | `.exe` | HKCU, HKLM |
| [draw.io](drawio.md) | 24.2.5 | `.exe` | HKCU |
| [Duplicati](duplicati.md) | 2.0.8.1 | `.exe` / `.msi` | HKCU, HKLM, SYSTEM |
| [Kdenlive](kdenlive.md) | 24.02.1 | `.exe` | HKCU, HKLM |
| [mpv](mpv.md) | 0.37.0 | Portable | HKCU |
| [PeaZip](peazip.md) | 9.7.0 | `.exe` | HKCU, HKLM, HKCR |
| [Rclone](rclone.md) | 1.66.0 | Portable | HKCU |
| [Ventoy](ventoy.md) | 1.0.99 | Portable | HKCU |
| [XnView MP](xnviewmp.md) | 1.7.2 | `.exe` | HKCU, HKLM, HKCR |
| [CPU-Z](cpu-z.md) | 2.09.1 | `.exe` / Portable | HKCU, HKLM |
| [Angry IP Scanner](angry-ip-scanner.md) | 3.9.1 | `.exe` / Portable | HKCU, HKLM |
| [Clementine](clementine.md) | 1.4.0 | `.exe` | HKCU, HKLM, HKCR |
| [Clink](clink.md) | 1.6.19 | `.exe` / Portable | HKCU, HKLM |
| [ExifTool](exiftool.md) | 12.82 | Portable | HKCU |
| [JDownloader 2](jdownloader.md) | 2.0 | `.exe` | HKCU, HKLM |
| [Jellyfin](jellyfin.md) | 10.9.7 | `.exe` | HKLM, SYSTEM |
| [Krita](krita.md) | 5.2.3 | `.exe` / Portable | HKCU, HKLM, HKCR |
| [LibreWolf](librewolf.md) | 124.0-1 | `.exe` / Portable | HKCU, HKLM, HKCR |
| [Npcap](npcap.md) | 1.79 | `.exe` | HKLM, SYSTEM |
| [Windows Terminal](windows-terminal.md) | 1.19 | MSIX / winget | HKCU, HKLM |

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
