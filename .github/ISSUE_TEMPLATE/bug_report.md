---
name: "🐛 Incorrect / Missing Registry Key"
about: "Report a wrong key name, wrong path, or missing value in an existing app doc"
labels: ["bug", "documentation"]
assignees: []
---

## App & Version

**Application:** <!-- e.g. PuTTY -->
**Version you tested:** <!-- e.g. 0.81 -->
**Windows version:** <!-- e.g. Windows 11 23H2 -->
**Installer type:** <!-- .exe / .msi / portable / winget / choco -->

## What's wrong

**Affected doc:** `windows/<filename>.md`
**Section:** <!-- e.g. ## 🔑 Keys, ## 📁 Registry Paths -->

Describe the problem clearly:
<!-- What the doc says vs what you actually see in the registry -->

## Steps to reproduce

1. Install <!-- app name and version --> using <!-- installer type -->
2. Open `regedit.exe` and navigate to <!-- registry path -->
3. Observe <!-- what you see -->

## Expected vs actual

| | Expected (as documented) | Actual (what you see) |
|---|---|---|
| Path | `HKXX\...` | `HKXX\...` |
| Key name | `KeyName` | `KeyName` |
| Value type | `REG_XX` | `REG_XX` |

## Additional context

<!-- Screenshots from regedit, PowerShell output, or any other evidence -->
