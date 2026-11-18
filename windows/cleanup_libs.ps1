# --- CONFIGURATION ---
$RootPath = "C:\Users\Admin"
$TargetFolder = "target"
#$TargetFolder = "node_modules"
$ReadOnlyMode = $true  
# ---------------------
$DeleteFolder = $args[0] # send the parameter Y or y to delete the folder, otherwise it will run in read-only mode


if ($DeleteFolder -eq "Y" -or $DeleteFolder -eq 'y') {
    $ReadOnlyMode = $false
}
Write-Host "ReadOnlyMode is $ReadOnlyMode " -ForegroundColor Red

# Find all matching directories recursively
$Matches = Get-ChildItem -Path $RootPath -Directory -Recurse -Filter $TargetFolder

if ($Matches.Count -eq 0) {
    Write-Host "No folders named '$TargetFolder' were found in '$RootPath'." -ForegroundColor Cyan
    exit
}

if ($ReadOnlyMode) {
    Write-Host "=== READ MODE ENABLED (No files will be deleted) ===" -ForegroundColor Green
    foreach ($Folder in $Matches) {
        Write-Host "[PREVIEW] Would delete: $($Folder.FullName)" -ForegroundColor Yellow
    }
    Write-Host "`nTotal folders found: $($Matches.Count)" -ForegroundColor Cyan
    Write-Host "Change `$ReadOnlyMode to `$false in the script to execute deletion." -ForegroundColor Green
}
else {
    Write-Host "=== DELETION MODE ENABLED ===" -ForegroundColor Red
    foreach ($Folder in $Matches) {
        Write-Host "[DELETING] $($Folder.FullName)" -ForegroundColor Yellow
        Remove-Item -Path $Folder.FullName -Recurse -Force
    }
    Write-Host "`nCleanup complete. Deleted $($Matches.Count) folder(s)." -ForegroundColor Cyan
}
