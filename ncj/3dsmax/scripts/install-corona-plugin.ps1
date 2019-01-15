param(
  [string]$fairSaasUsername,
  [string]$fairSaasPassword
)

$current_path = Split-Path -Parent -Path $MyInvocation.MyCommand.Definition
Start-Transcript -Path (Join-Path $current_path "install-corona-plugin.log")

$init_file = Join-Path $env:AZ_BATCH_NODE_SHARED_DIR, "init_corona_plugin.txt"

# If already installed, skip
If (!Test-Path $init_file) {
  try {
    # Extract and install Corona Plugin for 3ds Max 2018
    7z x -y -o"$env:3DSMAX_2018" "3dsmax-corona-2018-plugin.zip"
    
    # Extract and install Corona Plugin for 3ds Max 2019
    7z x -y -o"$env:3DSMAX_2019" "3dsmax-corona-2019-plugin.zip"
    
    $corona_activation_path = Join-Path $env:LOCALAPPDATA, "CoronaRenderer"
    New-Item $corona_activation_path -ItemType Directory -ErrorAction Ignore
    Set-Content -Path (Join-Path $corona_activation_path, "CoronaActivation.txt") -Value "${$fairSaasUsername}:${$fairSaasPassword}"

    "done" | Out-File $init_file
  } catch {
    Write-Error $_
  }
}

Stop-Transcript
