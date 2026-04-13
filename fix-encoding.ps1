# Fix encoding issues in all location pages
# Replace garbled emoji sequences with proper HTML entities

$locationsDir = "c:\Users\carna\Desktop\new-front-website\locations"
$files = Get-ChildItem "$locationsDir\*.html" | Where-Object { $_.Name -ne "index.html" }

$fixed = 0

foreach ($file in $files) {
    $bytes = [System.IO.File]::ReadAllBytes($file.FullName)
    $content = [System.Text.Encoding]::UTF8.GetString($bytes)
    
    $originalContent = $content
    
    # Replace the garbled deal banner content with clean HTML entity version
    # First check if it has the garbled content
    if ($content -match 'deals-banner') {
        # Replace the entire deals-track div content with clean version
        $cleanBanner = @'
    <!-- Rotating Deals Banner -->
    <div class="deals-banner">
        <div class="deals-track">
            <div class="deal-item"><span class="deal-icon">&#9889;</span> Stage 1 Remap <span class="deal-price">From &pound;249</span></div>
            <div class="deal-item"><span class="deal-icon">&#128640;</span> Stage 2 Remap <span class="deal-price">From &pound;349</span></div>
            <div class="deal-item"><span class="deal-icon">&#127937;</span> Stage 3 Custom <span class="deal-price">From &pound;649</span></div>
            <div class="deal-item"><span class="deal-icon">&#128295;</span> DPF Cleaning <span class="deal-price">From &pound;149</span> <span class="deal-badge">Popular</span></div>
            <div class="deal-item"><span class="deal-icon">&#128683;</span> DPF Delete <span class="deal-price">From &pound;179</span></div>
            <div class="deal-item"><span class="deal-icon">&#128167;</span> AdBlue Delete <span class="deal-price">From &pound;179</span></div>
            <div class="deal-item"><span class="deal-icon">&#9881;</span> Gearbox Remap <span class="deal-price">From &pound;199</span></div>
            <div class="deal-item"><span class="deal-icon">&#128241;</span> Mobile Service <span class="deal-badge">Free</span></div>
            <div class="deal-item"><span class="deal-icon">&#11088;</span> 5-Star Rated <span class="deal-badge">Trusted</span></div>
            <div class="deal-item"><span class="deal-icon">&#127991;</span> 10% Off First Remap <span class="deal-badge">New Customer</span></div>
            <!-- Duplicate for seamless loop -->
            <div class="deal-item"><span class="deal-icon">&#9889;</span> Stage 1 Remap <span class="deal-price">From &pound;249</span></div>
            <div class="deal-item"><span class="deal-icon">&#128640;</span> Stage 2 Remap <span class="deal-price">From &pound;349</span></div>
            <div class="deal-item"><span class="deal-icon">&#127937;</span> Stage 3 Custom <span class="deal-price">From &pound;649</span></div>
            <div class="deal-item"><span class="deal-icon">&#128295;</span> DPF Cleaning <span class="deal-price">From &pound;149</span> <span class="deal-badge">Popular</span></div>
            <div class="deal-item"><span class="deal-icon">&#128683;</span> DPF Delete <span class="deal-price">From &pound;179</span></div>
            <div class="deal-item"><span class="deal-icon">&#128167;</span> AdBlue Delete <span class="deal-price">From &pound;179</span></div>
            <div class="deal-item"><span class="deal-icon">&#9881;</span> Gearbox Remap <span class="deal-price">From &pound;199</span></div>
            <div class="deal-item"><span class="deal-icon">&#128241;</span> Mobile Service <span class="deal-badge">Free</span></div>
            <div class="deal-item"><span class="deal-icon">&#11088;</span> 5-Star Rated <span class="deal-badge">Trusted</span></div>
            <div class="deal-item"><span class="deal-icon">&#127991;</span> 10% Off First Remap <span class="deal-badge">New Customer</span></div>
        </div>
    </div>
'@
        # Remove old banner and replace
        $content = [regex]::Replace($content, '(?s)    <!-- Rotating Deals Banner -->.*?</div>\s*</div>\s*</div>', $cleanBanner)
    }
    
    # Fix the vehicle search heading emoji
    if ($content -match 'location-vehicle-search') {
        $content = $content -replace '<h2>[^<]*Check Your Vehicle', '<h2>&#128269; Check Your Vehicle'
        # Also fix pound signs in iframe description
        $content = $content -replace 'From Â£', 'From &pound;'
    }
    
    # Fix any remaining garbled pound signs from the banner
    $content = $content -replace 'Â£', '&pound;'
    
    if ($content -ne $originalContent) {
        $utf8NoBom = [System.Text.UTF8Encoding]::new($false)
        [System.IO.File]::WriteAllText($file.FullName, $content, $utf8NoBom)
        $fixed++
        Write-Host "FIXED: $($file.Name)" -ForegroundColor Green
    }
}

Write-Host "`nFixed $fixed files" -ForegroundColor Cyan
