# --- CONFIGURATION ---
$RootPath = "C:\Users\test"
$TargetFolder = "target"
#$TargetFolder = "node_modules"
$ReadOnlyMode = $true  # Set to $false when you are ready to permanently delete
# ---------------------

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
