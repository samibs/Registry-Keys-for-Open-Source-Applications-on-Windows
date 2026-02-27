---
description: >-
  Machine-readable JSON API for the Windows registry keys dataset — schema reference,
  field descriptions, and example queries in PowerShell, curl/jq, and Python.
tags:
  - meta
  - api
  - reference
---

# index.json — Machine-Readable API

The `windows/index.json` file is a machine-readable index of all documented applications. It is automatically rebuilt on every commit and is suitable for scripting, tooling, and integration.

**URL:**
```
https://raw.githubusercontent.com/samibs/Registry-Keys-for-Open-Source-Applications-on-Windows/main/windows/index.json
```

---

## Schema

Each entry in the JSON array has the following fields:

| Field | Type | Description |
|-------|------|-------------|
| `name` | `string` | Human-readable application name |
| `slug` | `string` | Filename without extension (unique identifier) |
| `file` | `string` | Relative path to the Markdown doc (`windows/<slug>.md`) |
| `version_tested` | `string` | Version documented (may be empty for older entries) |
| `installer_type` | `string` | Installer format (`.exe`, `.msi`, `Portable`, etc.) |
| `hives` | `string[]` | Registry hives used: `HKCU`, `HKLM`, `HKCR`, `HKU`, `SYSTEM` |
| `registry_paths` | `string[]` | All documented registry paths (abbreviated, e.g. `HKCU\SOFTWARE\Foo`) |
| `last_verified` | `string` | Date of last commit to this doc file (`YYYY-MM-DD`) |

### Example entry

```json
{
  "name": "7-Zip",
  "slug": "7zip",
  "file": "windows/7zip.md",
  "version_tested": "23.01",
  "installer_type": ".exe / .msi",
  "hives": ["HKCU", "HKLM"],
  "registry_paths": [
    "HKCU\\SOFTWARE\\7-Zip",
    "HKLM\\SOFTWARE\\7-Zip",
    "HKLM\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\7-Zip"
  ],
  "last_verified": "2026-02-14"
}
```

---

## Example Queries

### PowerShell

```powershell
# Download and parse
$index = Invoke-RestMethod "https://raw.githubusercontent.com/samibs/Registry-Keys-for-Open-Source-Applications-on-Windows/main/windows/index.json"

# All apps that write to HKLM
$index | Where-Object { $_.hives -contains "HKLM" } | Select-Object name, slug

# Apps with HKCR (file associations)
$index | Where-Object { $_.hives -contains "HKCR" } | Select-Object name

# Find a specific registry path
$index | Where-Object { $_.registry_paths -match "Uninstall" } | Select-Object name, registry_paths

# Apps not verified in the last 180 days
$cutoff = (Get-Date).AddDays(-180).ToString("yyyy-MM-dd")
$index | Where-Object { $_.last_verified -lt $cutoff } | Select-Object name, last_verified

# Count total documented paths
($index | ForEach-Object { $_.registry_paths.Count } | Measure-Object -Sum).Sum
```

### curl + jq (bash / WSL)

```bash
URL="https://raw.githubusercontent.com/samibs/Registry-Keys-for-Open-Source-Applications-on-Windows/main/windows/index.json"

# All app names
curl -s $URL | jq '.[].name'

# Apps with HKCR hive
curl -s $URL | jq '[.[] | select(.hives | contains(["HKCR"])) | .name]'

# Total registry path count
curl -s $URL | jq '[.[].registry_paths | length] | add'

# Apps sorted by last_verified (oldest first)
curl -s $URL | jq 'sort_by(.last_verified) | .[] | {name, last_verified}'
```

### Python

```python
import urllib.request, json

url = "https://raw.githubusercontent.com/samibs/Registry-Keys-for-Open-Source-Applications-on-Windows/main/windows/index.json"
with urllib.request.urlopen(url) as r:
    index = json.load(r)

# Apps that use all three hives
all_three = [a for a in index if {"HKCU","HKLM","HKCR"}.issubset(set(a["hives"]))]
print([a["name"] for a in all_three])

# Hive distribution
from collections import Counter
hive_counts = Counter(h for a in index for h in a["hives"])
print(hive_counts)

# Find apps with a specific registry path pattern
matches = [a for a in index if any("Uninstall" in p for p in a["registry_paths"])]
print(len(matches), "apps have uninstall registry entries")
```

---

## Rebuilding the Index

If you add or edit app docs, regenerate `index.json` locally:

```powershell
pwsh -File tools/build-index.ps1
```

The CI pipeline automatically validates that the committed `index.json` matches the generated output on every pull request.

---

## Notes

- `hives` contains only hives that have at least one documented path — an app may use additional hives not listed here.
- `registry_paths` are documentation samples, not exhaustive lists — apps may write to additional keys.
- `last_verified` reflects the last commit to the doc file, not a live version check. For current version drift, see [Project Statistics](stats.md).
