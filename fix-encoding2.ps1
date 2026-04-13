# Fix encoding issues in all location pages
# Replace garbled banner with clean HTML entity version

$locationsDir = "c:\Users\carna\Desktop\new-front-website\locations"
$files = Get-ChildItem "$locationsDir\*.html" | Where-Object { $_.Name -ne "index.html" }

$fixed = 0

$cleanBanner = @"
    <!-- Rotating Deals Banner -->
    <div class="deals-banner">
        <div class="deals-track">
            <div class="deal-item"><span class="deal-icon">&#9889;</span> Stage 1 Remap <span class="deal-price">From &#163;249</span></div>
            <div class="deal-item"><span class="deal-icon">&#128640;</span> Stage 2 Remap <span class="deal-price">From &#163;349</span></div>
            <div class="deal-item"><span class="deal-icon">&#127937;</span> Stage 3 Custom <span class="deal-price">From &#163;649</span></div>
            <div class="deal-item"><span class="deal-icon">&#128295;</span> DPF Cleaning <span class="deal-price">From &#163;149</span> <span class="deal-badge">Popular</span></div>
            <div class="deal-item"><span class="deal-icon">&#128683;</span> DPF Delete <span class="deal-price">From &#163;179</span></div>
            <div class="deal-item"><span class="deal-icon">&#128167;</span> AdBlue Delete <span class="deal-price">From &#163;179</span></div>
            <div class="deal-item"><span class="deal-icon">&#9881;</span> Gearbox Remap <span class="deal-price">From &#163;199</span></div>
            <div class="deal-item"><span class="deal-icon">&#128241;</span> Mobile Service <span class="deal-badge">Free</span></div>
            <div class="deal-item"><span class="deal-icon">&#11088;</span> 5-Star Rated <span class="deal-badge">Trusted</span></div>
            <div class="deal-item"><span class="deal-icon">&#127991;</span> 10% Off First Remap <span class="deal-badge">New Customer</span></div>
            <!-- Duplicate for seamless loop -->
            <div class="deal-item"><span class="deal-icon">&#9889;</span> Stage 1 Remap <span class="deal-price">From &#163;249</span></div>
            <div class="deal-item"><span class="deal-icon">&#128640;</span> Stage 2 Remap <span class="deal-price">From &#163;349</span></div>
            <div class="deal-item"><span class="deal-icon">&#127937;</span> Stage 3 Custom <span class="deal-price">From &#163;649</span></div>
            <div class="deal-item"><span class="deal-icon">&#128295;</span> DPF Cleaning <span class="deal-price">From &#163;149</span> <span class="deal-badge">Popular</span></div>
            <div class="deal-item"><span class="deal-icon">&#128683;</span> DPF Delete <span class="deal-price">From &#163;179</span></div>
            <div class="deal-item"><span class="deal-icon">&#128167;</span> AdBlue Delete <span class="deal-price">From &#163;179</span></div>
            <div class="deal-item"><span class="deal-icon">&#9881;</span> Gearbox Remap <span class="deal-price">From &#163;199</span></div>
            <div class="deal-item"><span class="deal-icon">&#128241;</span> Mobile Service <span class="deal-badge">Free</span></div>
            <div class="deal-item"><span class="deal-icon">&#11088;</span> 5-Star Rated <span class="deal-badge">Trusted</span></div>
            <div class="deal-item"><span class="deal-icon">&#127991;</span> 10% Off First Remap <span class="deal-badge">New Customer</span></div>
        </div>
    </div>
"@

$cleanIframe = @"
    <!-- Vehicle Search Widget -->
    <section class="location-vehicle-search">
        <div class="container">
            <h2>&#128269; Check Your Vehicle's Tuning Potential</h2>
            <p class="section-subtitle">Search our database for your vehicle's power gains, ECU compatibility &amp; performance stats</p>
            <div class="search-widget-container">
                <iframe src="https://web-production-df12d.up.railway.app/embed.html?v=4&amp;color=%23e1f014&amp;bg=%231a1a1a&amp;title=%F0%9F%94%8D%20Vehicle%20Search&amp;desc=Search%20our%20database%20for%20detailed%20vehicle%20information%2C%20ECU%20compatibility%2C%20and%20performance%20gains&amp;logo=https%3A%2F%2Fweb-production-df12d.up.railway.app%2Fassets%2Fmedia%2Fuploads%2F1769466136255-carnage_remaps_logo.jpg&amp;wa=07546371963&amp;email=carnageremaps%40gmail.com&amp;showYear=1&amp;showPerf=1&amp;showStages=1" width="100%" height="550" style="border:none;border-radius:12px;max-width:100%;" title="Vehicle Search Widget" loading="lazy"></iframe>
            </div>
        </div>
    </section>
"@

foreach ($file in $files) {
    $bytes = [System.IO.File]::ReadAllBytes($file.FullName)
    $content = [System.Text.Encoding]::UTF8.GetString($bytes)
    
    $originalContent = $content
    
    # Replace the entire old banner block with clean version
    if ($content -match '<!-- Rotating Deals Banner -->') {
        $pattern = '(?s)    <!-- Rotating Deals Banner -->.*?</div>\r?\n    </div>\r?\n    </div>'
        $content = [regex]::Replace($content, $pattern, $cleanBanner)
    }
    
    # Replace the vehicle search section with clean version  
    if ($content -match '<!-- Vehicle Search Widget -->') {
        $pattern = '(?s)    <!-- Vehicle Search Widget -->.*?</section>'
        $matches2 = [regex]::Match($content, $pattern)
        if ($matches2.Success) {
            $content = $content.Substring(0, $matches2.Index) + $cleanIframe + $content.Substring($matches2.Index + $matches2.Length)
        }
    }
    
    if ($content -ne $originalContent) {
        $utf8NoBom = [System.Text.UTF8Encoding]::new($false)
        [System.IO.File]::WriteAllText($file.FullName, $content, $utf8NoBom)
        $fixed++
        Write-Host "FIXED: $($file.Name)" -ForegroundColor Green
    }
}

Write-Host ""
Write-Host "Fixed $fixed files" -ForegroundColor Cyan
