param(
  [string]$fairSaasUsername,
  [string]$fairSaasPassword
)
$ErrorActionPreference = "Stop"

$init_file = Join-Path $env:AZ_BATCH_NODE_SHARED_DIR, "init_corona_plugin.txt"

# If already installed, skip
If (!(Test-Path $init_file)) {
  Write-Host "Installing Corona Plugins"
  try {
    # Extract and install Corona Plugin for 3ds Max 2018
    7z x -y -o"$env:3DSMAX_2018" "3dsmax-corona-2018-plugin.zip"
    Write-Host "Installed Corona 2018 Plugin"
    
    # Extract and install Corona Plugin for 3ds Max 2019
    7z x -y -o"$env:3DSMAX_2019" "3dsmax-corona-2019-plugin.zip"
    Write-Host "Installed Corona 2019 Plugin"
    
    $corona_activation_path = Join-Path $env:LOCALAPPDATA, "CoronaRenderer"
    New-Item $corona_activation_path -ItemType Directory -ErrorAction Ignore -Verbose
    Set-Content -Path (Join-Path $corona_activation_path, "CoronaActivation.txt") -Value "${$fairSaasUsername}:${$fairSaasPassword}"
    Write-Host "Created Corona License Activation File"

    "done" | Out-File $init_file
  } catch {
    Write-Error $_
  }
}

Write-Host "Corona Plugin Installation Completed"
