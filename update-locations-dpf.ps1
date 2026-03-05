# PowerShell script to add DPF Pressure Cleaning to all location pages

$locationsPath = "C:\Users\cgrei\OneDrive\Desktop\new-front-website\locations\"
$files = Get-ChildItem -Path $locationsPath -Filter "*.html" | Where-Object { $_.Name -ne "index.html" }

$updatedCount = 0
$skippedCount = 0

foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    
    # Check if DPF Pressure Cleaning already exists
    if ($content -match "DPF Pressure Cleaning") {
        Write-Host "Skipped (already has DPF cleaning): $($file.Name)" -ForegroundColor Yellow
        $skippedCount++
        continue
    }
    
    # Check if it has the DPF Delete card to insert before
    if ($content -match 'DPF Delete Remap') {
        # Use simple replace with full card text
        $oldText = '<div class="location-service-card"><h3>🚫 DPF Delete Remap</h3>'
        $newDPFCard = '<div class="location-service-card"><h3>💧 DPF Pressure Cleaning</h3><p>Stage 1 &amp; 2 chemical clean - restore your DPF without deletion. Legal &amp; MOT compliant.</p><p class="price">From <strong>£149</strong></p></div>
                <div class="location-service-card"><h3>🚫 DPF Delete Remap</h3>'
        
        $newContent = $content -replace [regex]::Escape($oldText), $newDPFCard
        Set-Content -Path $file.FullName -Value $newContent -Encoding UTF8 -NoNewline
        Write-Host "Updated: $($file.Name)" -ForegroundColor Green
        $updatedCount++
    } else {
        Write-Host "Skipped (no DPF Delete section found): $($file.Name)" -ForegroundColor Red
        $skippedCount++
    }
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Update Complete!" -ForegroundColor Cyan
Write-Host "Updated: $updatedCount files" -ForegroundColor Green
Write-Host "Skipped: $skippedCount files" -ForegroundColor Yellow
Write-Host "========================================" -ForegroundColor Cyan
