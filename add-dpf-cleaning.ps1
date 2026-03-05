# Add DPF Pressure Cleaning Service to all location pages$locationsPath = "C:\Users\cgrei\OneDrive\Desktop\new-front-website\locations\"
$files = Get-ChildItem -Path $locationsPath -Filter "*.html" | Where-Object { $_.Name -ne "index.html" }

$updatedCount = 0
$skippedCount = 0

foreach ($file in $files) {
    $content = [System.IO.File]::ReadAllText($file.FullName, [System.Text.UTF8Encoding]::new())
    
    if ($content.Contains("DPF Pressure Cleaning")) {
        Write-Host "Skipped (already has): $($file.Name)" -ForegroundColor Yellow
        $skippedCount++
        continue
    }
    
    if ($content.Contains("DPF Delete Remap")) {
        $searchText = '<div class="location-service-card"><h3>🚫 DPF Delete Remap</h3>'
        $replaceWith = '<div class="location-service-card"><h3>💧 DPF Pressure Cleaning</h3><p>Stage 1 &amp; 2 chemical clean - restore your DPF without deletion. Legal &amp; MOT compliant.</p><p class="price">From <strong>£149</strong></p></div>
                ' + $searchText
        
        $newContent = $content.Replace($searchText, $replaceWith)
        [System.IO.File]::WriteAllText($file.FullName, $newContent, [System.Text.UTF8Encoding]::new())
        Write-Host "Updated: $($file.Name)" -ForegroundColor Green
        $updatedCount++
    } else {
        Write-Host "Skipped (no DPF Delete): $($file.Name)" -ForegroundColor Red
        $skippedCount++
    }
}

Write-Host "`n========================================"
Write-Host "Updated: $updatedCount files" -ForegroundColor Green
Write-Host "Skipped: $skippedCount files" -ForegroundColor Yellow
Write-Host "========================================"
