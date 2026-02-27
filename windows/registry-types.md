---
description: >-
  Reference guide to Windows registry value types — REG_SZ, REG_DWORD, REG_BINARY,
  REG_MULTI_SZ, REG_EXPAND_SZ, and more — with descriptions and usage examples.
---

# Windows Registry Value Types Reference

A quick reference for the registry value types (`REG_*`) you'll encounter in this documentation.

---

## Type Overview

| Type | Numeric ID | Size | Typical Use |
|------|-----------|------|-------------|
| [`REG_SZ`](#reg_sz) | `1` | Variable | Plain text string |
| [`REG_EXPAND_SZ`](#reg_expand_sz) | `2` | Variable | String with environment variable references |
| [`REG_BINARY`](#reg_binary) | `3` | Variable | Raw binary data |
| [`REG_DWORD`](#reg_dword) | `4` | 4 bytes | 32-bit integer (flags, booleans, ports) |
| [`REG_MULTI_SZ`](#reg_multi_sz) | `7` | Variable | Array of null-separated strings |
| [`REG_QWORD`](#reg_qword) | `11` | 8 bytes | 64-bit integer (large counters, timestamps) |

---

## REG_SZ

**Plain null-terminated Unicode string.** The most common type — used for paths, names, version strings, and any human-readable value.

```powershell
# Read
(Get-ItemProperty "HKLM:\SOFTWARE\GitForWindows").InstallPath

# Write
Set-ItemProperty "HKLM:\SOFTWARE\MyApp" -Name "Version" -Value "1.2.3" -Type String
```

**Examples in this collection:**

| App | Key | Value |
|-----|-----|-------|
| Git for Windows | `InstallPath` | `C:\Program Files\Git` |
| PuTTY | `HostName` | `myserver.example.com` |
| WinSCP | `HostName` | `192.168.1.10` |

---

## REG_EXPAND_SZ

**String with unexpanded environment variable references.** Windows expands `%VARIABLE%` tokens at read time. Used for paths that should be portable across user accounts or system drives.

```powershell
# Read (returns raw string with %VARIABLE%)
(Get-Item "HKLM:\SYSTEM\CurrentControlSet\Services\npcap").GetValue("ImagePath", $null, "DoNotExpandEnvironmentNames")

# Read (returns expanded path)
(Get-Item "HKLM:\SYSTEM\CurrentControlSet\Services\npcap").GetValue("ImagePath")

# Write
Set-ItemProperty "HKLM:\SOFTWARE\MyApp" -Name "LogPath" -Value "%APPDATA%\MyApp\logs" -Type ExpandString
```

**Common patterns:**

| Pattern | Expands to |
|---------|-----------|
| `%SystemRoot%` | `C:\Windows` |
| `%ProgramFiles%` | `C:\Program Files` |
| `%APPDATA%` | `C:\Users\<user>\AppData\Roaming` |
| `%LOCALAPPDATA%` | `C:\Users\<user>\AppData\Local` |

**Examples in this collection:**

| App | Key | Value |
|-----|-----|-------|
| VirtualBox (VBoxSup service) | `ImagePath` | `\SystemRoot\System32\drivers\VBoxSup.sys` |
| Npcap service | `ImagePath` | `\SystemRoot\System32\drivers\npcap.sys` |

---

## REG_BINARY

**Raw binary data stored as a sequence of bytes.** Used for hardware configuration, cryptographic material, security descriptors, and any data that doesn't fit a string or integer.

```powershell
# Read (returns byte array)
$bytes = (Get-Item "HKLM:\SOFTWARE\MyApp").GetValue("Config")

# Write
$bytes = [byte[]](0x01, 0x00, 0xFF, 0xAB)
Set-ItemProperty "HKLM:\SOFTWARE\MyApp" -Name "Config" -Value $bytes -Type Binary
```

**Common uses in open-source apps:**

- License keys (encoded)
- Window/layout state blobs
- Security identifiers (SIDs)
- Cached certificate data

---

## REG_DWORD

**32-bit unsigned integer (little-endian).** The second most common type — used for boolean flags (`0`/`1`), port numbers, enum values, and any numeric setting that fits in 32 bits.

```powershell
# Read
(Get-ItemProperty "HKCU:\Software\7-Zip").("FM\ShowHidden")

# Write
Set-ItemProperty "HKCU:\Software\7-Zip" -Name "FM\ShowHidden" -Value 1 -Type DWord
```

**Boolean pattern (very common):**

| Value | Meaning |
|-------|---------|
| `0x00000000` (`0`) | Disabled / False / Off |
| `0x00000001` (`1`) | Enabled / True / On |

**Examples in this collection:**

| App | Key | Values |
|-----|-----|--------|
| 7-Zip | `FM\ShowHidden` | `0` = hide, `1` = show |
| PuTTY | `PortNumber` | `22` (SSH default) |
| qBittorrent | `NoModify` | `1` = no modify button in ARP |
| WinSCP | `FSProtocol` | `0`=SFTP, `2`=SCP, `5`=FTP, `6`=WebDAV |

---

## REG_MULTI_SZ

**Array of null-terminated strings, terminated by a double null.** Used for lists of paths, search paths, service dependencies, and any ordered or unordered string collection.

```powershell
# Read (returns string array)
(Get-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Services\npcap").DependOnService

# Write
Set-ItemProperty "HKLM:\SOFTWARE\MyApp" -Name "SearchPaths" -Value @("C:\path1", "C:\path2") -Type MultiString
```

**Common uses:**

- Service dependencies (`DependOnService`)
- File extension lists
- Server hostname lists
- MRU (most-recently-used) lists

---

## REG_QWORD

**64-bit unsigned integer (little-endian).** Used for large counters, file sizes, and Windows FILETIME timestamps (100-nanosecond intervals since January 1, 1601).

```powershell
# Read
(Get-ItemProperty "HKLM:\SOFTWARE\MyApp").LastRunTime

# Write
Set-ItemProperty "HKLM:\SOFTWARE\MyApp" -Name "InstallTime" -Value ([long]::MaxValue) -Type QWord
```

**FILETIME conversion:**

```powershell
# Convert REG_QWORD FILETIME to a readable DateTime
$ft = (Get-ItemProperty "HKLM:\SOFTWARE\MyApp").LastRunTime
[DateTime]::FromFileTime($ft)
```

---

## PowerShell Type Name Mapping

When using `Set-ItemProperty`, use these `-Type` parameter values:

| Registry Type | PowerShell `-Type` |
|---------------|--------------------|
| `REG_SZ` | `String` |
| `REG_EXPAND_SZ` | `ExpandString` |
| `REG_BINARY` | `Binary` |
| `REG_DWORD` | `DWord` |
| `REG_MULTI_SZ` | `MultiString` |
| `REG_QWORD` | `QWord` |

---

## Read Any Value Without Knowing Its Type

```powershell
function Get-RegValue {
    param([string]$Path, [string]$Name)
    $key = Get-Item -LiteralPath $Path -ErrorAction SilentlyContinue
    if (-not $key) { return $null }
    $val   = $key.GetValue($Name)
    $vkind = $key.GetValueKind($Name)
    [PSCustomObject]@{ Name = $Name; Type = $vkind; Value = $val }
}

Get-RegValue "HKLM:\SOFTWARE\GitForWindows" "InstallPath"
```
