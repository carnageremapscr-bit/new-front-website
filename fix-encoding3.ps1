# Fix all location pages by replacing garbled banner and iframe sections
# Uses index-based string replacement to avoid regex issues with garbled encoding

$locationsDir = "c:\Users\carna\Desktop\new-front-website\locations"
$files = Get-ChildItem "$locationsDir\*.html" | Where-Object { $_.Name -ne "index.html" }

$fixed = 0

$cleanBannerBlock = @"
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

$cleanIframeBlock = @"
    <!-- Vehicle Search Widget -->
    <section class="location-vehicle-search">
        <div class="container">
            <h2>&#128269; Check Your Vehicle's Tuning Potential</h2>
            <p class="section-subtitle">Search our database for your vehicle's power gains, ECU compatibility and performance stats</p>
            <div class="search-widget-container">
                <iframe src="https://web-production-df12d.up.railway.app/embed.html?v=4&amp;color=%23e1f014&amp;bg=%231a1a1a&amp;title=%F0%9F%94%8D%20Vehicle%20Search&amp;desc=Search%20our%20database%20for%20detailed%20vehicle%20information%2C%20ECU%20compatibility%2C%20and%20performance%20gains&amp;logo=https%3A%2F%2Fweb-production-df12d.up.railway.app%2Fassets%2Fmedia%2Fuploads%2F1769466136255-carnage_remaps_logo.jpg&amp;wa=07546371963&amp;email=carnageremaps%40gmail.com&amp;showYear=1&amp;showPerf=1&amp;showStages=1" width="100%" height="550" style="border:none;border-radius:12px;max-width:100%;" title="Vehicle Search Widget" loading="lazy"></iframe>
            </div>
        </div>
    </section>
"@

foreach ($file in $files) {
    # Read raw bytes and decode as UTF-8
    $bytes = [System.IO.File]::ReadAllBytes($file.FullName)
    $content = [System.Text.Encoding]::UTF8.GetString($bytes)
    $changed = $false
    
    # === Replace banner block ===
    $bannerStart = $content.IndexOf("<!-- Rotating Deals Banner -->")
    if ($bannerStart -ge 0) {
        # Find the end: look for the closing </div> pattern after "deals-track"
        # The banner ends with 3 closing divs in sequence: </div>\n    </div>\n    </div>
        # Find "deals-track" then find the third </div> after it
        $trackIdx = $content.IndexOf("deals-track", $bannerStart)
        if ($trackIdx -ge 0) {
            # Find the closing of deals-track div (second-to-last </div> of the block)
            # Look for "</div>" occurrences after the last deal-item
            $searchFrom = $trackIdx
            $lastDealItem = $content.LastIndexOf("deal-item", $content.IndexOf("</div>", $content.IndexOf("seamless loop", $searchFrom) + 50))
            if ($lastDealItem -lt 0) { $lastDealItem = $searchFrom }
            
            # After the last deal-item, find closing sequence
            $pos = $content.IndexOf("</div>", $lastDealItem + 30) # close deal-item div
            # Now find the next two </div> that close deals-track and deals-banner
            $closeTrack = $content.IndexOf("</div>", $pos + 6)
            $closeBanner = $content.IndexOf("</div>", $closeTrack + 6)
            
            if ($closeBanner -gt 0) {
                $bannerEnd = $closeBanner + 6 # length of "</div>"
                $content = $content.Substring(0, $bannerStart) + $cleanBannerBlock + $content.Substring($bannerEnd)
                $changed = $true
            }
        }
    }
    
    # === Replace iframe block ===
    $iframeStart = $content.IndexOf("<!-- Vehicle Search Widget -->")
    if ($iframeStart -ge 0) {
        $iframeEnd = $content.IndexOf("</section>", $iframeStart)
        if ($iframeEnd -ge 0) {
            $iframeEnd = $iframeEnd + 10 # length of "</section>"
            $content = $content.Substring(0, $iframeStart) + $cleanIframeBlock + $content.Substring($iframeEnd)
            $changed = $true
        }
    }
    
    if ($changed) {
        $utf8NoBom = [System.Text.UTF8Encoding]::new($false)
        [System.IO.File]::WriteAllText($file.FullName, $content, $utf8NoBom)
        $fixed++
        Write-Host "FIXED: $($file.Name)" -ForegroundColor Green
    } else {
        Write-Host "SKIP: $($file.Name)" -ForegroundColor DarkGray
    }
}

Write-Host ""
Write-Host "Fixed $fixed files" -ForegroundColor Cyan
