# Installs Android SDK command-line tools into %LOCALAPPDATA%\Android\Sdk\cmdline-tools\latest
# and sets ANDROID_HOME for the current user.
#
# Usage:
#   powershell -File scripts\setup-android-cmdline-tools.ps1
#   powershell -File scripts\setup-android-cmdline-tools.ps1 -ZipPath "$env:USERPROFILE\Downloads\commandlinetools-win-*.zip"

param(
    [string]$ZipPath,
    [string]$DownloadUrl = "https://dl.google.com/android/repository/commandlinetools-win-13114758_latest.zip"
)

$ErrorActionPreference = "Stop"

$sdkRoot = Join-Path $env:LOCALAPPDATA "Android\Sdk"
$cmdlineRoot = Join-Path $sdkRoot "cmdline-tools\latest"
$sdkmanager = Join-Path $cmdlineRoot "bin\sdkmanager.bat"

New-Item -ItemType Directory -Force -Path $sdkRoot | Out-Null

if (-not (Test-Path $sdkmanager)) {
    $tempZip = if ($ZipPath) { $ZipPath } else { Join-Path $env:TEMP "commandlinetools-win.zip" }

    if (-not $ZipPath) {
        Write-Host "Downloading Android command-line tools ..."
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        Invoke-WebRequest -Uri $DownloadUrl -OutFile $tempZip -UseBasicParsing
    }
    elseif (-not (Test-Path $ZipPath)) {
        throw "Zip not found: $ZipPath"
    }

    $extractRoot = Join-Path $env:TEMP "android-cmdline-tools"
    if (Test-Path $extractRoot) { Remove-Item $extractRoot -Recurse -Force }
    Expand-Archive -Path $tempZip -DestinationPath $extractRoot -Force

    New-Item -ItemType Directory -Force -Path (Split-Path $cmdlineRoot -Parent) | Out-Null
    if (Test-Path $cmdlineRoot) { Remove-Item $cmdlineRoot -Recurse -Force }
    Move-Item (Join-Path $extractRoot "cmdline-tools") $cmdlineRoot
    Write-Host "Installed cmdline-tools to $cmdlineRoot"
}

[Environment]::SetEnvironmentVariable("ANDROID_HOME", $sdkRoot, "User")
[Environment]::SetEnvironmentVariable("ANDROID_SDK_ROOT", $sdkRoot, "User")

$userPath = [Environment]::GetEnvironmentVariable("Path", "User")
$entries = @(
    (Join-Path $sdkRoot "platform-tools"),
    (Join-Path $cmdlineRoot "bin")
)
foreach ($entry in $entries) {
    if ($userPath -notlike "*$entry*") {
        $userPath = if ($userPath) { "$userPath;$entry" } else { $entry }
    }
}
[Environment]::SetEnvironmentVariable("Path", $userPath, "User")

$env:ANDROID_HOME = $sdkRoot
$env:ANDROID_SDK_ROOT = $sdkRoot
$env:Path = "$env:Path;$($entries -join ';')"

Write-Host "Accepting SDK licenses ..."
cmd /c "echo y| `"$sdkmanager`" --licenses" | Out-Null

Write-Host "Installing platform packages ..."
& $sdkmanager "platform-tools" "platforms;android-35" "build-tools;35.0.0"

Write-Host ""
Write-Host "Android SDK ready at $sdkRoot"
Write-Host "Verify with: flutter doctor -v"
