# SEO Diversification Script
# Replaces repetitive "ECU remapping [Location]" patterns with unique geographic themes

$strategies = @{
    canterbury = "heritage vehicle tuning Canterbury|Historic city ECU tuning Canterbury. Heritage vehicle optimization, cathedral city remapping specialists."
    margate = "seaside vehicle tuning Margate|Seaside ECU tuning Margate & Thanet coast. Beachside vehicle optimization, coastal performance specialists."
    chatham = "urban express tuning Chatham|Urban express tuning Chatham & Medway Towns. Fast city ECU optimization, metropolitan vehicle specialists."
    dartford = "commuter vehicle tuning Dartford|Commuter vehicle tuning Dartford & Kent-London border. Daily driver optimization, motorway performance specialists."
    gillingham = "working vehicle specialists Gillingham|Working vehicle specialists Gillingham. Industrial estate tuning, tradesperson van optimization."
    rochester = "historic castle town tuning Rochester|Historic castle town tuning Rochester. Heritage district vehicle specialists, Dickensian city optimization."
    gravesend = "riverside vehicle tuning Gravesend|Riverside vehicle tuning Gravesend. Thames Gateway optimization specialists, waterfront district service."
    sevenoaks = "Garden of England tuning Sevenoaks|Garden of England vehicle specialists Sevenoaks. Affluent professional car tuning, upscale optimization service."
    maidstone = "county town tuning Maidstone|County town ECU tuning Maidstone. Kent capital vehicle optimization, premier professional service."
    ashford = "international rail hub tuning Ashford|International rail hub ECU tuning Ashford. HS1 commuter optimization, Eurostar community specialists."
    tonbridge = "castle town tuning Tonbridge|Castle town ECU tuning Tonbridge. Executive commuter optimization, premium Kent service."
    dover = "port city tuning Dover|Port city ECU tuning Dover. Channel crossing optimization, ferry terminal specialists, commercial vehicle experts."
    folkestone = "Channel port tuning Folkestone|Channel port ECU tuning Folkestone. Eurotunnel community optimization, cross-channel travel specialists."
    ramsgate = "marina district tuning Ramsgate|Marina district ECU tuning Ramsgate. Yachting community vehicle specialists, royal harbour service."
    broadstairs = "traditional village tuning Broadstairs|Traditional village ECU tuning Broadstairs. Dickens heritage community specialists, conservative values service."
    whitstable = "boutique vehicle tuning Whitstable|Boutique vehicle tuning Whitstable. Artisan ECU optimization, oyster festival town specialists."
    herne_bay = "leisurely pace tuning Herne Bay|Leisurely pace vehicle tuning Herne Bay. Retirement community specialists, relaxed professional service."
    faversham = "market town tuning Faversham|Market town vehicle tuning Faversham. Brewing heritage district optimization, traditional market square service."
    sittingbourne = "industrial hub tuning Sittingbourne|Industrial hub tuning Sittingbourne. Commercial vehicle optimization, logistics fleet specialists."
    deal = "coastal maritime tuning Deal|Coastal maritime ECU tuning Deal. Historic cinque port optimization, seaside heritage specialists."
    sandwich = "cinque port tuning Sandwich|Ancient cinque port ECU tuning Sandwich. Historic town optimization, medieval heritage specialists."
}

$count = 0
$locations = Get-ChildItem "c:\Users\carna\OneDrive\Desktop\new front website\locations\*.html" | Where-Object { $_.Name -ne "index.html" }

foreach ($file in $locations) {
    $location = $file.BaseName
    $content = Get-Content $file.FullName -Raw
    
    # Check if this location has a custom strategy
    if ($strategies.ContainsKey($location)) {
        $parts = $strategies[$location] -split '\|'
        $keywords = $parts[0]
        $description = $parts[1]
        
        # Replace description
        if ($content -match '<meta name="description" content="([^"]+)">') {
            $oldDesc = $matches[1]
            if ($oldDesc -like "Professional ECU remapping*") {
                $content = $content.Replace($oldDesc, $description)
                Write-Host "✓ $location - Updated description" -ForegroundColor Green
                $count++
            }
        }
        
        # Replace keywords (partial - add unique keyword at start)
        if ($content -match '<meta name="keywords" content="([^"]+)">') {
            $oldKeywords = $matches[1]
            # Keep some generic SEO keywords at end, add unique at start
            $newKeywords = "$keywords, ECU remapping specialists, DPF delete service, professional car tuning, stage 1 remap"
            $content = $content.Replace($oldKeywords, $newKeywords)
        }
        
        # Save
        $content | Out-File $file.FullName -Encoding utf8 -NoNewline
    }
}

Write-Host "`nUpdated $count locations with unique SEO keywords" -ForegroundColor Cyan
