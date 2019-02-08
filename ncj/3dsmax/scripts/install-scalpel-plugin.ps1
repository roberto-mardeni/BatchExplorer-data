$ErrorActionPreference = "Stop"

$init_file = Join-Path $env:AZ_BATCH_NODE_SHARED_DIR "init_scalpel_plugin.txt"

# If already installed, skip
If (!(Test-Path $init_file)) {
  Write-Host "Installing Scalpel Plugins"
  try {
    $plugins_path = "C:\Users\Public\Documents"
    $scalpel_path = "$plugins_path\cebas"
    $scalpel_package_path = [System.Environment]::GetEnvironmentVariable("AZ_BATCH_APP_PACKAGE_SCALPEL_3DSMAX#2019")

    # Copy the Scalpel files to the expected location
    Copy-Item -Path $scalpel_package_path -Destination $plugins_path -Recurse -Force -Verbose

    # Add the Scalpel path to the plugin.ini
    Add-Content -Path (Join-Path $env:3DSMAX_2019 "plugin.ini") -Value $scalpel_path

    "done" | Out-File $init_file
  } catch {
    Write-Error $_
  }
}

Write-Host "Scalpel Plugin Installation Completed"
