# Replace vehicle search iframe with VRM/reg lookup iframe on all location pages

$locationsDir = "c:\Users\carna\Desktop\new-front-website\locations"
$files = Get-ChildItem "$locationsDir\*.html" | Where-Object { $_.Name -ne "index.html" }

$fixed = 0
$oldIframeSrc = "https://web-production-df12d.up.railway.app/embed.html"
$newIframe = '<iframe src="https://secure-file-portal-portal-pro.up.railway.app/embed/vehicle-lookup.html?key=emb_7cb1ad248952aeabe4f8ad8952c8dee8c2f26b4dcd8fa220" width="100%" height="900" frameborder="0" allow="top-navigation-by-user-activation" style="border:none; border-radius:12px; max-width:100%;" title="VRM Reg Lookup" referrerpolicy="no-referrer" loading="lazy"></iframe>'

$newSection = @"
    <!-- VRM Reg Lookup Widget -->
    <section class="location-vehicle-search">
        <div class="container">
            <h2>&#128269; Check Your Vehicle's Tuning Potential</h2>
            <p class="section-subtitle">Enter your reg number to instantly see your vehicle's power gains and tuning options</p>
            <div class="search-widget-container">
                $newIframe
            </div>
        </div>
    </section>
"@

foreach ($file in $files) {
    $bytes = [System.IO.File]::ReadAllBytes($file.FullName)
    $content = [System.Text.Encoding]::UTF8.GetString($bytes)
    $originalContent = $content
    
    if ($content.Contains("location-vehicle-search")) {
        # Find and replace the entire vehicle search section
        $sectionStart = $content.IndexOf("<!-- Vehicle Search Widget -->")
        if ($sectionStart -lt 0) {
            $sectionStart = $content.IndexOf("<!-- VRM Reg Lookup Widget -->")
        }
        if ($sectionStart -ge 0) {
            $sectionEnd = $content.IndexOf("</section>", $sectionStart)
            if ($sectionEnd -ge 0) {
                $sectionEnd += "</section>".Length
                $content = $content.Substring(0, $sectionStart) + $newSection + $content.Substring($sectionEnd)
            }
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
