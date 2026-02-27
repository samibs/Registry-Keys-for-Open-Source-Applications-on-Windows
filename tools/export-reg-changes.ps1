<#
.SYNOPSIS
    A script to capture registry changes made by an application installer.

.DESCRIPTION
    This script takes a "before" and "after" snapshot of the Windows Registry
    to identify and report on changes, typically made during a software installation.
    It's designed to help automate the documentation of registry keys for the
    open-source applications registry project.

.NOTES
    Author: Jules
    Version: 1.0
    Best run in a clean virtual machine to minimize system "noise" in the snapshot.

.EXAMPLE
    PS C:\path\to\tools> .\export-reg-changes.ps1

    This command starts the interactive process. The script will first take a
    snapshot of the registry. It will then pause and prompt you to install the
    target application. After you've installed the application, pressing Enter
    will cause the script to take a second snapshot, compare it to the first,
    and generate a Markdown file with the detected changes.

.LINK
    # Add a link to the project's GitHub repository here.
#>

# Strict mode helps catch common scripting errors
Set-StrictMode -Version Latest

function Take-RegistrySnapshot {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$SnapshotFile
    )

    Write-Host "Taking registry snapshot. This may take a few moments..." -ForegroundColor Cyan

    # Define the registry keys we want to export.
    # Focusing on Software keys to reduce noise from other system areas.
    $registryKeys = @(
        "HKCU\Software",
        "HKLM\SOFTWARE"
    )

    # Ensure the snapshot file is clean before we start
    if (Test-Path $SnapshotFile) {
        Remove-Item $SnapshotFile
    }
    New-Item -Path $SnapshotFile -ItemType File | Out-Null

    # Export each key and append its content to the single snapshot file
    foreach ($key in $registryKeys) {
        # Create a unique temporary file for the export
        $tempFile = Join-Path $env:TEMP "tmp_reg_export_$($key -replace '[\\:]', '_').reg"

        try {
            Write-Host "Exporting $key..."
            # Use the legacy reg.exe for reliable export of entire trees.
            # The /y switch ensures we overwrite any old temp file.
            & reg.exe export "$key" "$tempFile" /y

            # Append the content of the temp file to our main snapshot file
            Get-Content -Path $tempFile | Add-Content -Path $SnapshotFile

            # Clean up the temporary file
            Remove-Item $tempFile
        }
        catch {
            Write-Warning "Failed to export key: $key. Error: $_"
        }
    }

    if (Test-Path $SnapshotFile) {
        Write-Host "Snapshot successfully created at: $SnapshotFile" -ForegroundColor Green
    }
    else {
        Write-Error "Failed to create snapshot file."
    }
}

function Compare-RegistrySnapshots {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$BeforeSnapshot,

        [Parameter(Mandatory=$true)]
        [string]$AfterSnapshot
    )

    Write-Host "Comparing registry snapshots to find differences..." -ForegroundColor Cyan

    if (-not (Test-Path $BeforeSnapshot) -or -not (Test-Path $AfterSnapshot)) {
        Write-Error "One or both snapshot files are missing."
        return
    }

    # Compare the two snapshot files using their content.
    $diff = Compare-Object -ReferenceObject (Get-Content $BeforeSnapshot) -DifferenceObject (Get-Content $AfterSnapshot)

    # We are interested in lines that were added or changed, which will appear in the "after" snapshot.
    # These will have a SideIndicator of '=>'.
    $addedOrChangedLines = $diff | Where-Object { $_.SideIndicator -eq '=>' } | Select-Object -ExpandProperty InputObject

    Write-Host "Found $($addedOrChangedLines.Count) new or modified registry lines." -ForegroundColor Green

    return $addedOrChangedLines
}

function Format-ChangesToMarkdown {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string[]]$DifferenceLines,

        [Parameter(Mandatory=$true)]
        [string]$AppName,

        [Parameter(Mandatory=$true)]
        [string]$AppVersion,

        [string]$InstallerType = ".exe"
    )

    Write-Host "Parsing and formatting registry changes into Markdown..." -ForegroundColor Cyan

    $registryData = [ordered]@{}
    $currentKeyPath = ""

    foreach ($line in $DifferenceLines) {
        # Skip empty lines or the REGEDIT4 header
        if ([string]::IsNullOrWhiteSpace($line) -or $line.StartsWith("Windows Registry Editor")) {
            continue
        }

        # The .reg file format uses square brackets to denote a new key path.
        if ($line.StartsWith("[")) {
            $currentKeyPath = $line.Trim("[]")
            # Initialize an array for this key path if it's the first time we've seen it.
            if (-not $registryData.ContainsKey($currentKeyPath)) {
                $registryData[$currentKeyPath] = [System.Collections.ArrayList]::new()
            }
            continue
        }

        # If we are inside a key path context, attempt to parse the line as a value.
        if ($currentKeyPath) {
            # This regex is designed to capture the most common key-value formats in .reg files.
            # It handles standard string values ("Key"="Value") and the default key value (@="Value").
            if ($line -match '^"(.*)"=(.*)$') {
                $keyName = $Matches[1]
                $rawValue = $Matches[2]
            } elseif ($line -match '^@=(.*)$') {
                $keyName = "@ (Default)"
                $rawValue = $Matches[1]
            } else {
                continue
            }
            $keyType = "REG_SZ" # Default type
            $keyValue = $rawValue.Trim('"')

            # Basic type detection based on .reg file format
            if ($rawValue.StartsWith("dword:")) {
                $keyType = "REG_DWORD"
                $keyValue = "0x" + $rawValue.Substring(6)
            } elseif ($rawValue.StartsWith("hex:")) {
                $keyType = "REG_BINARY"
                $keyValue = $rawValue.Substring(4).Replace(",", " ")
            } elseif ($rawValue.StartsWith("hex(2):")) {
                $keyType = "REG_EXPAND_SZ"
                $keyValue = $rawValue.Substring(7).Replace(",", " ")
            } elseif ($rawValue.StartsWith("hex(7):")) {
                $keyType = "REG_MULTI_SZ"
                $keyValue = $rawValue.Substring(7).Replace(",", " ")
            }

            $valueObject = @{
                Name  = $keyName
                Type  = $keyType
                Value = $keyValue
            }
            [void]$registryData[$currentKeyPath].Add($valueObject)
        }
    }

    # Now, build the Markdown output string
    $md = @"
# $AppName

**Version tested:** $AppVersion
**Installer type:** $InstallerType

## 📁 Registry Paths
"@

    foreach ($path in $registryData.Keys) {
        $md += "`n- ``$path``"
    }

    $md += @"

## 🔑 Keys
| Key Name | Type | Value | Purpose |
|----------|------|-------|---------|
"@

    foreach ($path in $registryData.Keys) {
        # Add a comment line to indicate which path the following keys belong to
        $md += "`n| **[$($path.Split('\')[-1])]** | | | |"
        foreach ($value in $registryData[$path]) {
            # Escape pipe characters in values to not break the markdown table
            $escapedName = $value.Name.Replace("|", "\|")
            $escapedValue = $value.Value.Replace("|", "\|")
            $md += "`n| ``$escapedName`` | ``$($value.Type)`` | ``$escapedValue`` | |"
        }
    }

    $md += @"

## 📝 Notes

- These registry keys were automatically generated by the script.
- Please review for accuracy and add descriptions for each key's purpose.
- Some values, especially binary ones, may be truncated or need further interpretation.
"@

    return $md
}

# --- Main script body ---
Write-Host "Registry Change Capture Script" -ForegroundColor Yellow

# Define snapshot file paths in the user's temporary directory
$tempDir = $env:TEMP
$beforeSnapshot = Join-Path $tempDir "RegistrySnapshot_Before.reg"
$afterSnapshot = Join-Path $tempDir "RegistrySnapshot_After.reg"

# --- Script Execution ---
# 1. Take the "before" snapshot
Take-RegistrySnapshot -SnapshotFile $beforeSnapshot

# 2. Prompt user to install the application
Write-Host "SUCCESS: 'Before' snapshot created at `"$beforeSnapshot`"." -ForegroundColor Green
Write-Host "-----------------------------------------------------------------" -ForegroundColor Yellow
Write-Host "ACTION REQUIRED: Please install the application now." -ForegroundColor Yellow
Write-Host "When the installation is complete, return to this window." -ForegroundColor Yellow
Write-Host "-----------------------------------------------------------------" -ForegroundColor Yellow
Read-Host -Prompt "Press ENTER to continue and take the 'after' snapshot"

# 3. Take the "after" snapshot
Take-RegistrySnapshot -SnapshotFile $afterSnapshot
Write-Host "SUCCESS: 'After' snapshot created at `"$afterSnapshot`"." -ForegroundColor Green

# 4. Compare the snapshots to find the differences
$differences = Compare-RegistrySnapshots -BeforeSnapshot $beforeSnapshot -AfterSnapshot $afterSnapshot

# Placeholder for the next step: formatting the output
if ($differences) {
    # 4a. Get application details from the user
    Write-Host "-----------------------------------------------------------------" -ForegroundColor Yellow
    $appName = Read-Host -Prompt "Enter the application name (e.g., VLC Media Player)"
    $appVersion = Read-Host -Prompt "Enter the application version tested (e.g., 3.0.20)"
    $installerType = Read-Host -Prompt "Enter the installer type (e.g., .exe, .msi)"
    Write-Host "-----------------------------------------------------------------" -ForegroundColor Yellow

    # 4b. Format the differences into Markdown
    $markdownOutput = Format-ChangesToMarkdown -DifferenceLines $differences -AppName $appName -AppVersion $appVersion -InstallerType $installerType

    # 4c. Save the Markdown to a file
    $outputFileName = "$($appName.Replace(' ', ''))_RegistryKeys.md"
    $markdownOutput | Out-File -FilePath $outputFileName -Encoding utf8

    Write-Host "SUCCESS: Registry documentation has been saved to:" -ForegroundColor Green
    Write-Host (Join-Path $PWD $outputFileName) -ForegroundColor White
    Write-Host "Please review the file for accuracy and add descriptions for each key's purpose." -ForegroundColor Cyan

} else {
    Write-Host "No differences found between snapshots."
}

# 5. Clean up snapshot files
Write-Host "Cleaning up temporary snapshot files..."
Remove-Item $beforeSnapshot -ErrorAction SilentlyContinue
Remove-Item $afterSnapshot -ErrorAction SilentlyContinue

Write-Host "Script finished." -ForegroundColor Green
