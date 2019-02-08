$ErrorActionPreference = "Stop"

$init_file = Join-Path $env:AZ_BATCH_NODE_SHARED_DIR "init_scalpel_plugin.txt"

# If already installed, skip
If (!(Test-Path $init_file)) {
  Write-Host "Installing Scalpel Plugins"
  try {
    $scalpel_package_path = [System.Environment]::GetEnvironmentVariable("AZ_BATCH_APP_PACKAGE_SCALPEL_3DSMAX#2019")

    # Copy the Scalpel files to the 3dsMax Plugins directory
    Copy-Item -Path "$scalpel_package_path\cebas" -Destination "$env:3DSMAX_2019\Plugins" -Recurse -Force -Verbose

    "done" | Out-File $init_file
  } catch {
    Write-Error $_
  }
}

Write-Host "Scalpel Plugin Installation Completed"
