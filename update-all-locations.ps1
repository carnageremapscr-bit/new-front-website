# Update ALL location pages:
# 1. Add rotating deals banner after nav
# 2. Add vehicle search iframe after hero
# 3. Fix broken/basic pages with proper enhanced structure

$locationsDir = "c:\Users\carna\Desktop\new-front-website\locations"
$files = Get-ChildItem "$locationsDir\*.html" | Where-Object { $_.Name -ne "index.html" }

$totalFiles = $files.Count
$updated = 0
$skipped = 0
$enhanced = 0

# ---- Rotating deals banner HTML ----
$dealsBanner = @'
    <!-- Rotating Deals Banner -->
    <div class="deals-banner">
        <div class="deals-track">
            <div class="deal-item"><span class="deal-icon">⚡</span> Stage 1 Remap <span class="deal-price">From £249</span></div>
            <div class="deal-item"><span class="deal-icon">🚀</span> Stage 2 Remap <span class="deal-price">From £349</span></div>
            <div class="deal-item"><span class="deal-icon">🏁</span> Stage 3 Custom <span class="deal-price">From £649</span></div>
            <div class="deal-item"><span class="deal-icon">🔧</span> DPF Cleaning <span class="deal-price">From £149</span> <span class="deal-badge">Popular</span></div>
            <div class="deal-item"><span class="deal-icon">🚫</span> DPF Delete <span class="deal-price">From £179</span></div>
            <div class="deal-item"><span class="deal-icon">💧</span> AdBlue Delete <span class="deal-price">From £179</span></div>
            <div class="deal-item"><span class="deal-icon">⚙️</span> Gearbox Remap <span class="deal-price">From £199</span></div>
            <div class="deal-item"><span class="deal-icon">📱</span> Mobile Service <span class="deal-badge">Free</span></div>
            <div class="deal-item"><span class="deal-icon">⭐</span> 5-Star Rated <span class="deal-badge">Trusted</span></div>
            <div class="deal-item"><span class="deal-icon">🏷️</span> 10% Off First Remap <span class="deal-badge">New Customer</span></div>
            <!-- Duplicate for seamless loop -->
            <div class="deal-item"><span class="deal-icon">⚡</span> Stage 1 Remap <span class="deal-price">From £249</span></div>
            <div class="deal-item"><span class="deal-icon">🚀</span> Stage 2 Remap <span class="deal-price">From £349</span></div>
            <div class="deal-item"><span class="deal-icon">🏁</span> Stage 3 Custom <span class="deal-price">From £649</span></div>
            <div class="deal-item"><span class="deal-icon">🔧</span> DPF Cleaning <span class="deal-price">From £149</span> <span class="deal-badge">Popular</span></div>
            <div class="deal-item"><span class="deal-icon">🚫</span> DPF Delete <span class="deal-price">From £179</span></div>
            <div class="deal-item"><span class="deal-icon">💧</span> AdBlue Delete <span class="deal-price">From £179</span></div>
            <div class="deal-item"><span class="deal-icon">⚙️</span> Gearbox Remap <span class="deal-price">From £199</span></div>
            <div class="deal-item"><span class="deal-icon">📱</span> Mobile Service <span class="deal-badge">Free</span></div>
            <div class="deal-item"><span class="deal-icon">⭐</span> 5-Star Rated <span class="deal-badge">Trusted</span></div>
            <div class="deal-item"><span class="deal-icon">🏷️</span> 10% Off First Remap <span class="deal-badge">New Customer</span></div>
        </div>
    </div>
'@

# ---- Vehicle search iframe HTML ----
$vehicleSearchIframe = @'
    <!-- Vehicle Search Widget -->
    <section class="location-vehicle-search">
        <div class="container">
            <h2>🔍 Check Your Vehicle's Tuning Potential</h2>
            <p class="section-subtitle">Search our database for your vehicle's power gains, ECU compatibility & performance stats</p>
            <div class="search-widget-container">
                <iframe src="https://web-production-df12d.up.railway.app/embed.html?v=4&color=%23e1f014&bg=%231a1a1a&title=%F0%9F%94%8D%20Vehicle%20Search&desc=Search%20our%20database%20for%20detailed%20vehicle%20information%2C%20ECU%20compatibility%2C%20and%20performance%20gains&logo=https%3A%2F%2Fweb-production-df12d.up.railway.app%2Fassets%2Fmedia%2Fuploads%2F1769466136255-carnage_remaps_logo.jpg&wa=07546371963&email=carnageremaps%40gmail.com&showYear=1&showPerf=1&showStages=1" width="100%" height="550" style="border:none;border-radius:12px;max-width:100%;" title="Vehicle Search Widget" loading="lazy"></iframe>
            </div>
        </div>
    </section>
'@

# Standard enhanced nav for broken pages missing it
$standardNav = @'
    <nav class="navbar">
        <div class="nav-container">
            <a href="../index.html" class="nav-brand">
                <img src="../assets/images/carnage-remaps-logo.jpg" alt="Carnage Remaps Logo" class="nav-logo" loading="eager" width="45" height="40">
                <span>Carnage Remaps</span>
            </a>
            <div class="hamburger" id="hamburger"><span></span><span></span><span></span></div>
            <ul class="nav-menu" id="navMenu">
                <li><a href="../index.html" class="nav-link">Home</a></li>
                <li><a href="../services.html" class="nav-link">Services</a></li>
                <li><a href="../pricing.html" class="nav-link">Pricing</a></li>
                <li><a href="../vehicle-search.html" class="nav-link">Vehicle Search</a></li>
                <li><a href="../contact.html" class="nav-link">Contact</a></li>
                <li><a href="https://web-production-df12d.up.railway.app" class="nav-link portal-link" target="_blank">Portal</a></li>
            </ul>
        </div>
    </nav>
'@

foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    $fileName = $file.Name
    $changed = $false
    
    # Skip if already has deals banner
    if ($content -match 'deals-banner') {
        $skipped++
        Write-Host "SKIP (already updated): $fileName" -ForegroundColor DarkGray
        continue
    }
    
    # Extract location name from <title> tag
    $locationName = ""
    if ($content -match '<title>.*?(?:ECU Remapping|Horsepower|Power Tuning|DPF Cleaning|AdBlue)\s+(.+?)\s*[\|<]') {
        $locationName = $matches[1] -replace '\s*\|.*$', '' -replace '\s*Kent\s*$', '' -replace '\s*Canterbury\s*$', ''
    }
    if (-not $locationName -and $content -match '<h1>.*?in\s+(.+?)(?:<|$)') {
        $locationName = $matches[1] -replace ',.*$', '' -replace '\s*&.*$', ''
    }
    if (-not $locationName) {
        $locationName = $fileName -replace '\.html$', '' -replace '-', ' '
        $locationName = (Get-Culture).TextInfo.ToTitleCase($locationName)
    }
    
    # ===== STEP 1: Inject deals banner after </nav> =====
    if ($content -match '</nav>') {
        $content = $content -replace '(</nav>)', "`$1`n$dealsBanner"
        $changed = $true
    }
    
    # ===== STEP 2: Inject vehicle search iframe =====
    # Place it right after the hero section (before services)
    # Try various hero closing patterns
    $iframeInserted = $false
    
    # Pattern 1: After location-hero section
    if ($content -match '(</section>\s*\n\s*<section class="location-services")') {
        $content = $content -replace '(</section>)(\s*\n\s*<section class="location-services")', "`$1`n$vehicleSearchIframe`$2"
        $iframeInserted = $true
    }
    
    # Pattern 2: After hero section with inline style (broken pages)
    if (-not $iframeInserted -and $content -match '</section>\s*\n\s*<section class="container"') {
        $content = $content -replace '(<section class="hero"[^>]*>.*?</section>)', "`$1`n$vehicleSearchIframe", 1
        # PowerShell regex doesn't support . matching newline by default, use different approach
    }
    
    # Pattern 3: After any hero section - find end of first section after nav+banner
    if (-not $iframeInserted) {
        # Find the first </section> after the hero content
        $navEnd = $content.IndexOf('</nav>')
        if ($navEnd -gt 0) {
            $bannerEnd = $content.IndexOf('</div>', $navEnd + 100) # skip past the deals banner we just added
            $afterBanner = $content.IndexOf('deals-banner')
            if ($afterBanner -gt 0) {
                # Find the closing of the deals banner div
                $bannerClose = $content.IndexOf('</div>', $afterBanner)
                $bannerClose = $content.IndexOf('</div>', $bannerClose + 6)
                # Find first </section> after banner
                $firstSectionEnd = $content.IndexOf('</section>', $bannerClose)
                if ($firstSectionEnd -gt 0) {
                    $insertPos = $firstSectionEnd + '</section>'.Length
                    $content = $content.Substring(0, $insertPos) + "`n$vehicleSearchIframe" + $content.Substring($insertPos)
                    $iframeInserted = $true
                }
            }
        }
    }
    
    # ===== STEP 3: Fix broken pages - upgrade nav to full nav =====
    # Check if nav is missing Pricing link
    if ($content -notmatch 'pricing\.html') {
        $content = $content -replace '<li><a href="../services\.html" class="nav-link">Services</a></li>\s*<li><a href="../vehicle-search\.html"', '<li><a href="../services.html" class="nav-link">Services</a></li>
                <li><a href="../pricing.html" class="nav-link">Pricing</a></li>
                <li><a href="../vehicle-search.html"'
    }
    
    # Check if missing Portal link
    if ($content -notmatch 'portal-link') {
        $content = $content -replace '(<li><a href="../contact\.html" class="nav-link">Contact</a></li>)\s*</ul>', '$1
                <li><a href="https://web-production-df12d.up.railway.app" class="nav-link portal-link" target="_blank">Portal</a></li>
            </ul>'
    }
    
    # ===== STEP 4: Fix broken pages - minimal footer to proper footer =====
    if ($content -match '<footer class="footer">\s*<div class="container">\s*<p>&copy;') {
        $footerReplace = @"
    <footer class="location-footer">
        <div class="container">
            <div class="footer-nav">
                <a href="../index.html" class="footer-link">← Back to Home</a>
                <a href="../locations/" class="footer-link">All Locations →</a>
            </div>
            <p class="footer-text">Carnage Remaps © 2026 | Professional ECU Remapping Services | <a href="../contact.html">Contact</a></p>
        </div>
    </footer>
"@
        $content = $content -replace '<footer class="footer">\s*<div class="container">\s*<p>&copy;.*?</footer>', $footerReplace
        $enhanced++
    }
    
    # ===== STEP 5: Add script.js if missing =====
    if ($content -notmatch 'script\.js') {
        $content = $content -replace '</body>', "    <script src=`"../script.js`"></script>`n</body>"
    }
    
    # ===== STEP 6: Add quote-message div if missing =====
    if ($content -notmatch 'quote-message') {
        $content = $content -replace '<body>', "<body>`n    <div id=`"quote-message`" class=`"alert-message`"></div>"
    }
    
    if ($changed -or $iframeInserted) {
        # Write with UTF8 encoding
        [System.IO.File]::WriteAllText($file.FullName, $content, [System.Text.UTF8Encoding]::new($false))
        $updated++
        Write-Host "UPDATED: $fileName" -ForegroundColor Green
    } else {
        $skipped++
        Write-Host "PROBLEM: $fileName - could not find injection points" -ForegroundColor Red
    }
}

Write-Host "`n===== SUMMARY =====" -ForegroundColor Cyan
Write-Host "Total files: $totalFiles"
Write-Host "Updated: $updated" -ForegroundColor Green
Write-Host "Enhanced (footer fix): $enhanced" -ForegroundColor Yellow
Write-Host "Skipped: $skipped" -ForegroundColor DarkGray
