$ErrorActionPreference = "Stop"

$init_file = Join-Path $env:AZ_BATCH_NODE_SHARED_DIR "init_scalpel_plugin.txt"

# If already installed, skip
If (!(Test-Path $init_file)) {
  Write-Host "Installing Scalpel Plugins"
  try {
    # User Settings Path = C:\Users\seel016\AppData\Local\Autodesk\3dsMax\2019 - 64bit\ENU
    $plugins_path = "C:\Users\Public\Documents\"

    # Extract and install Corona Plugin for 3ds Max 2018
    7z x -y -o"$plugins_path" "cebas.zip"
    Write-Host "Installed Scalpel Plugin"
    
    # Copy the Plugin.ini file to the 3dsMax directory
    Copy-Item -Path "Plugin.ini" -Destination "$env:3DSMAX_2019" -Force -Verbose

    "done" | Out-File $init_file
  } catch {
    Write-Error $_
  }
}

Write-Host "Scalpel Plugin Installation Completed"
