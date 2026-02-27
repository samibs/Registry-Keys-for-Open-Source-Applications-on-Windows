# Automation Cookbook

Practical PowerShell recipes for working with this registry key collection and `windows/index.json`.

---

## 1. Query the Index

### Find all apps that write to a specific hive

```powershell
$index = Invoke-RestMethod "https://raw.githubusercontent.com/samibs/Registry-Keys-for-Open-Source-Applications-on-Windows/main/windows/index.json"

# Apps that write to HKCU
$index | Where-Object { $_.hives -contains "HKCU" } | Select-Object name, slug

# Apps that touch HKCR (file associations)
$index | Where-Object { $_.hives -contains "HKCR" } | Select-Object name, slug

# Apps that install kernel services (SYSTEM hive)
$index | Where-Object { $_.hives -contains "HKLM-SYSTEM" } | Select-Object name, slug
```

### Search by registry path prefix

```powershell
$index = Invoke-RestMethod "https://raw.githubusercontent.com/samibs/Registry-Keys-for-Open-Source-Applications-on-Windows/main/windows/index.json"

$prefix = "HKEY_LOCAL_MACHINE\SOFTWARE\Oracle"
$index | Where-Object { $_.registry_paths | Where-Object { $_ -like "$prefix*" } } |
  Select-Object name, registry_paths
```

### Check if a specific app is installed (by registry presence)

```powershell
function Test-AppInstalled {
    param([string]$Slug)
    $index = Invoke-RestMethod "https://raw.githubusercontent.com/samibs/Registry-Keys-for-Open-Source-Applications-on-Windows/main/windows/index.json"
    $entry = $index | Where-Object slug -eq $Slug
    if (-not $entry) { Write-Warning "Slug '$Slug' not in index"; return $false }

    foreach ($path in $entry.registry_paths) {
        $psDrive = $path -replace "^HKEY_LOCAL_MACHINE", "HKLM:" `
                         -replace "^HKEY_CURRENT_USER", "HKCU:" `
                         -replace "^HKEY_CLASSES_ROOT", "HKCR:"
        if (Test-Path $psDrive) { return $true }
    }
    return $false
}

Test-AppInstalled "git"        # True / False
Test-AppInstalled "vlc"
Test-AppInstalled "wireshark"
```

---

## 2. Back Up Registry Keys Before Uninstall

### Export a single app's keys to .reg files

```powershell
function Backup-AppRegistry {
    param(
        [string]$Slug,
        [string]$OutputDir = "$env:USERPROFILE\Desktop\RegBackup"
    )
    $index = Invoke-RestMethod "https://raw.githubusercontent.com/samibs/Registry-Keys-for-Open-Source-Applications-on-Windows/main/windows/index.json"
    $entry = $index | Where-Object slug -eq $Slug
    if (-not $entry) { Write-Error "Unknown slug: $Slug"; return }

    New-Item -ItemType Directory -Force -Path $OutputDir | Out-Null
    $timestamp = Get-Date -Format "yyyyMMdd-HHmmss"

    foreach ($path in $entry.registry_paths) {
        # Skip HKCR paths (can be very large)
        if ($path -like "HKEY_CLASSES_ROOT*") { continue }

        $safeName = $path -replace "[\\:]", "_"
        $outFile   = Join-Path $OutputDir "$($entry.slug)_${safeName}_${timestamp}.reg"
        reg export $path $outFile /y 2>$null
        if ($LASTEXITCODE -eq 0) {
            Write-Host "✅ Backed up: $path → $outFile"
        } else {
            Write-Host "⚠️  Key not found (not installed?): $path"
        }
    }
}

# Example
Backup-AppRegistry -Slug "putty" -OutputDir "C:\Backup\Registry"
```

### Restore from backup

```powershell
# Restore all .reg files in a folder
Get-ChildItem "C:\Backup\Registry\putty_*.reg" | ForEach-Object {
    reg import $_.FullName
    Write-Host "Imported: $($_.Name)"
}
```

---

## 3. Capture Registry Changes During Install

Use the bundled `export-reg-changes.ps1` to snapshot before and after an install:

```powershell
# Step 1 — take snapshot BEFORE installing the app
.\tools\export-reg-changes.ps1 -Step Before -App "MyNewApp"

# Step 2 — install the application now

# Step 3 — take snapshot AFTER and generate a diff report
.\tools\export-reg-changes.ps1 -Step After -App "MyNewApp"
# Outputs: windows/MyNewApp.md (ready to review and submit as a PR)
```

---

## 4. Compare Registry State Between Two Machines

Useful for auditing or migrating user settings (PuTTY sessions, WinSCP connections, etc.).

```powershell
function Compare-RemoteRegistry {
    param(
        [string]$RemoteComputer,
        [string]$RegistryPath,   # e.g. "HKCU:\Software\SimonTatham\PuTTY\Sessions"
        [PSCredential]$Credential
    )

    # Local values
    $local = Get-ChildItem $RegistryPath -ErrorAction SilentlyContinue |
             ForEach-Object { $_.Name }

    # Remote values (requires WinRM / PSRemoting enabled on target)
    $remote = Invoke-Command -ComputerName $RemoteComputer -Credential $Credential -ScriptBlock {
        param($p)
        Get-ChildItem $p -ErrorAction SilentlyContinue | ForEach-Object { $_.Name }
    } -ArgumentList $RegistryPath

    $diff = Compare-Object $local $remote
    $diff | ForEach-Object {
        $symbol = if ($_.SideIndicator -eq "<=") { "LOCAL ONLY" } else { "REMOTE ONLY" }
        Write-Host "$symbol : $($_.InputObject)"
    }
}

# Compare PuTTY saved sessions between this machine and a remote one
Compare-RemoteRegistry -RemoteComputer "WORKSTATION02" `
                       -RegistryPath   "HKCU:\Software\SimonTatham\PuTTY\Sessions"
```

---

## 5. Migrate App Settings to a New Machine

### Export and import PuTTY sessions

```powershell
# Export all PuTTY sessions from current machine
reg export "HKCU\Software\SimonTatham\PuTTY" "$env:USERPROFILE\putty-backup.reg" /y
Write-Host "Exported to $env:USERPROFILE\putty-backup.reg"

# On the new machine, import:
# reg import "$env:USERPROFILE\putty-backup.reg"
```

### Export and import WinSCP sessions

```powershell
reg export "HKCU\Software\Martin Prikryl\WinSCP 2" "$env:USERPROFILE\winscp-backup.reg" /y
Write-Host "Exported to $env:USERPROFILE\winscp-backup.reg"
```

### Export all HKCU app keys at once

```powershell
$index = Invoke-RestMethod "https://raw.githubusercontent.com/samibs/Registry-Keys-for-Open-Source-Applications-on-Windows/main/windows/index.json"
$outputDir = "$env:USERPROFILE\AppRegistryBackup_$(Get-Date -Format yyyyMMdd)"
New-Item -ItemType Directory -Force -Path $outputDir | Out-Null

$index | ForEach-Object {
    $slug = $_.slug
    $_.registry_paths | Where-Object { $_ -like "HKEY_CURRENT_USER*" } | ForEach-Object {
        $safeName = $_ -replace "[\\:]", "_"
        $outFile  = Join-Path $outputDir "$slug`_$safeName.reg"
        reg export $_ $outFile /y 2>$null
        if ($LASTEXITCODE -eq 0) { Write-Host "✅ $slug → $_" }
    }
}
Write-Host "`nAll exports saved to: $outputDir"
```

---

## 6. Audit Installed Apps via Registry

Check which documented apps are currently installed on a machine:

```powershell
$index = Invoke-RestMethod "https://raw.githubusercontent.com/samibs/Registry-Keys-for-Open-Source-Applications-on-Windows/main/windows/index.json"

$results = foreach ($entry in $index) {
    $found = $false
    foreach ($path in $entry.registry_paths) {
        if ($path -like "HKEY_CLASSES_ROOT*") { continue }
        $psDrive = $path -replace "^HKEY_LOCAL_MACHINE", "HKLM:" `
                         -replace "^HKEY_CURRENT_USER", "HKCU:"
        if (Test-Path $psDrive) { $found = $true; break }
    }
    [PSCustomObject]@{
        App       = $entry.name
        Slug      = $entry.slug
        Installed = $found
    }
}

$results | Sort-Object App | Format-Table -AutoSize

# Summary
$installed = ($results | Where-Object Installed).Count
Write-Host "$installed of $($results.Count) documented apps detected on this machine."
```

---

## 7. Clean All Registry Keys for an App

Uses the cleanup commands documented in each app's `## 🗑️ Cleanup` section. Example for bulk cleanup of multiple apps:

```powershell
# Example: remove PuTTY and WinSCP registry entries
$cleanupMap = @{
    putty  = @("HKCU:\Software\SimonTatham\PuTTY")
    winscp = @("HKCU:\Software\Martin Prikryl\WinSCP 2", "HKLM:\SOFTWARE\Martin Prikryl\WinSCP 2")
}

foreach ($app in $cleanupMap.Keys) {
    foreach ($path in $cleanupMap[$app]) {
        if (Test-Path $path) {
            Remove-Item $path -Recurse -Force
            Write-Host "✅ Removed: $path"
        } else {
            Write-Host "⚠️  Not found: $path"
        }
    }
}
```

> **Tip:** See each app's documentation page for the exact paths to include in `$cleanupMap`.
