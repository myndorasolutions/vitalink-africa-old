# Installs Gradle wrapper distribution offline for myndora-care mobile Android builds.
#
# Usage:
#   powershell -File scripts\setup-gradle-offline.ps1 -ZipPath "$env:USERPROFILE\Downloads\gradle-8.14-all.zip"
#   powershell -File scripts\setup-gradle-offline.ps1 -Download
#
# The mobile project uses a local file:// distributionUrl (no spaces in path) so Java SSL
# is not required for the wrapper bootstrap. This script copies the zip into place.

param(
    [string]$ZipPath,
    [switch]$Download,
    [string]$DistributionUrl = "https://services.gradle.org/distributions/gradle-8.14-all.zip"
)

$ErrorActionPreference = "Stop"

$repoRoot = Split-Path $PSScriptRoot -Parent
$wrapperDir = Join-Path $repoRoot "mobile\android\gradle\wrapper"
$targetZip = Join-Path $wrapperDir "gradle-8.14-all.zip"
$propertiesFile = Join-Path $wrapperDir "gradle-wrapper.properties"
$localFileUrl = "file\:///C:/dev/myndora-care/mobile/android/gradle/wrapper/gradle-8.14-all.zip"

Write-Host "Target zip: $targetZip"

New-Item -ItemType Directory -Force -Path $wrapperDir | Out-Null

if ($Download -and -not $ZipPath) {
    Write-Host "Downloading $DistributionUrl ..."
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    Invoke-WebRequest -Uri $DistributionUrl -OutFile $targetZip -UseBasicParsing
}
elseif ($ZipPath) {
    if (-not (Test-Path $ZipPath)) {
        throw "Zip not found: $ZipPath"
    }
    Copy-Item -Path $ZipPath -Destination $targetZip -Force
    Write-Host "Copied zip to $targetZip"
}
elseif (-not (Test-Path $targetZip)) {
    throw @"
No zip found at $targetZip

Download in your browser:
  $DistributionUrl

Then run:
  powershell -File scripts\setup-gradle-offline.ps1 -ZipPath `"<path-to-downloaded-zip>`"
"@
}

if (-not (Test-Path $targetZip)) {
    throw "Gradle zip missing after setup: $targetZip"
}

$properties = Get-Content $propertiesFile -Raw
if ($properties -notmatch [regex]::Escape($localFileUrl)) {
    $properties = $properties -replace 'distributionUrl=.*', "distributionUrl=$localFileUrl"
    Set-Content -Path $propertiesFile -Value $properties.TrimEnd() -NoNewline
    Add-Content -Path $propertiesFile -Value ""
    Write-Host "Updated gradle-wrapper.properties to local file distributionUrl"
}

Write-Host ""
Write-Host "Gradle offline bootstrap ready."
Write-Host "Verify with:"
Write-Host '  cd mobile\android'
Write-Host '  .\gradlew.bat --version'
