# Final cleanup - remove leftover garbled deal-items between banner and hero
# The previous fix left orphaned garbled content after the clean banner

$locationsDir = "c:\Users\carna\Desktop\new-front-website\locations"
$files = Get-ChildItem "$locationsDir\*.html" | Where-Object { $_.Name -ne "index.html" }

$fixed = 0

foreach ($file in $files) {
    $bytes = [System.IO.File]::ReadAllBytes($file.FullName)
    $content = [System.Text.Encoding]::UTF8.GetString($bytes)
    $originalLen = $content.Length
    
    # Find the end of the clean banner (last &#127991; to closing divs)
    $cleanEnd = $content.IndexOf("New Customer</span></div>`n        </div>`n    </div>")
    if ($cleanEnd -lt 0) {
        # Try with just the clean end marker
        $cleanEnd = $content.IndexOf("</div>`n    </div>`n")
    }
    
    # Strategy: find the clean banner closing, then find the next <section
    # and remove everything in between that's garbled deal-items
    
    # Look for pattern: after "New Customer</span></div>" (the last clean deal item)
    # find the </div></div> closings, then remove any garbled content before next <section
    
    # Find first occurrence of the end of clean banner block
    $marker = "10% Off First Remap"
    $markerPositions = @()
    $searchStart = 0
    while ($true) {
        $pos = $content.IndexOf($marker, $searchStart)
        if ($pos -lt 0) { break }
        $markerPositions += $pos
        $searchStart = $pos + 1
    }
    
    if ($markerPositions.Count -ge 3) {
        # The second occurrence is the end of the clean duplicated section
        # Find the closing divs after the second occurrence (clean banner end)
        $secondMarker = $markerPositions[1]
        $closingSpan = $content.IndexOf("</span></div>", $secondMarker)
        $afterCleanBanner = $closingSpan + "</span></div>".Length
        
        # Now find next </div> (closes deals-track)
        $closeTrack = $content.IndexOf("</div>", $afterCleanBanner)
        $afterTrack = $closeTrack + "</div>".Length
        
        # Now find next </div> (closes deals-banner)
        $closeBanner = $content.IndexOf("</div>", $afterTrack)
        $afterBanner = $closeBanner + "</div>".Length
        
        # Now find the next <section or <main
        $nextSection = $content.IndexOf("<section", $afterBanner)
        $nextMain = $content.IndexOf("<main", $afterBanner)
        $nextElement = -1
        if ($nextSection -ge 0 -and $nextMain -ge 0) {
            $nextElement = [Math]::Min($nextSection, $nextMain)
        } elseif ($nextSection -ge 0) {
            $nextElement = $nextSection
        } elseif ($nextMain -ge 0) {
            $nextElement = $nextMain
        }
        
        if ($nextElement -gt 0) {
            # Check if there's garbled content between banner end and next section
            $between = $content.Substring($afterBanner, $nextElement - $afterBanner)
            if ($between.Contains("deal-item") -or $between.Contains("deal-icon")) {
                # Remove the garbled content
                $content = $content.Substring(0, $afterBanner) + "`n`n    " + $content.Substring($nextElement)
                $fixed++
                Write-Host "CLEANED: $($file.Name) (removed $($originalLen - $content.Length) chars of garbled content)" -ForegroundColor Green
            }
        }
    } elseif ($markerPositions.Count -eq 2) {
        # Normal case - clean banner only, check for leftover after banner closing
        # Nothing to do - banner is clean
    }
    
    # Also clean up between iframe and services section
    # Remove any garbled leftovers after the clean iframe section
    $iframeEnd = $content.IndexOf("</section>", $content.IndexOf("location-vehicle-search"))
    if ($iframeEnd -gt 0) {
        $afterIframe = $iframeEnd + "</section>".Length
        $nextSection2 = $content.IndexOf("<section", $afterIframe)
        if ($nextSection2 -gt 0) {
            $between2 = $content.Substring($afterIframe, $nextSection2 - $afterIframe)
            if ($between2.Contains("deal-icon") -or $between2.Contains("search-widget-container")) {
                # Has old garbled iframe leftovers
                # Actually this shouldn't happen
            }
        }
    }
    
    if ($content.Length -ne $originalLen) {
        $utf8NoBom = [System.Text.UTF8Encoding]::new($false)
        [System.IO.File]::WriteAllText($file.FullName, $content, $utf8NoBom)
    }
}

Write-Host ""
Write-Host "Cleaned $fixed files" -ForegroundColor Cyan
