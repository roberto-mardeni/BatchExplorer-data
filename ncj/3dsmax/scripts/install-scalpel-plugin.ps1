$ErrorActionPreference = "Stop"

$init_file = Join-Path $env:AZ_BATCH_NODE_SHARED_DIR "init_scalpel_plugin.txt"

# If already installed, skip
If (!(Test-Path $init_file)) {
  Write-Host "Installing Scalpel Plugins"
  try {
    $scalpel_path = [System.Environment]::GetEnvironmentVariable("AZ_BATCH_APP_PACKAGE_SCALPEL_3DSMAX#2019")
    # Add the Scalpel path to the
    Add-Content -Path (Join-Path $env:3DSMAX_2019 "plugin.ini") -Value $scalpel_path

    "done" | Out-File $init_file
  } catch {
    Write-Error $_
  }
}

Write-Host "Scalpel Plugin Installation Completed"
