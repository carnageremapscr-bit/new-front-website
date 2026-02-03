# SEO Keyword Diversification Script - Geographic Clustering Strategy
# Purpose: Replace repetitive keywords across 188 location pages with unique geographic themes

$keywordStrategies = @{
    # Canterbury Cluster - Heritage/Historic angle
    'canterbury' = @{ theme = 'heritage vehicle tuning Canterbury'; desc = 'Historic city ECU tuning Canterbury. Heritage vehicle optimization, cathedral city remapping specialists.' }
    'fordwich' = @{ theme = 'ancient borough tuning Fordwich'; desc = 'Ancient borough ECU tuning Fordwich. Englands smallest town vehicle optimization, historic charm.' }
    'littlebourne' = @{ theme = 'Canterbury village tuning Littlebourne'; desc = 'Canterbury village ECU tuning Littlebourne. Rural heritage optimization, traditional service values.' }
    'wickhambreaux' = @{ theme = 'Canterbury valley tuning Wickhambreaux'; desc = 'Stour valley ECU tuning Wickhambreaux. Scenic village vehicle optimization, countryside specialists.' }
    'bekesbourne' = @{ theme = 'Canterbury suburb tuning Bekesbourne'; desc = 'Canterbury suburb ECU tuning Bekesbourne. Commuter village optimization, heritage district service.' }
    'bridge' = @{ theme = 'Canterbury heritage tuning Bridge'; desc = 'Heritage village ECU tuning Bridge. Historic Canterbury district optimization, traditional values.' }
    'patrixbourne' = @{ theme = 'Canterbury countryside tuning Patrixbourne'; desc = 'Canterbury countryside ECU tuning Patrixbourne. Rural heritage optimization, village specialists.' }
    'bishopsbourne' = @{ theme = 'Canterbury downs tuning Bishopsbourne'; desc = 'Canterbury downs ECU tuning Bishopsbourne. Heritage village optimization, scenic countryside service.' }
    
    # Thanet Coast - Seaside/Resort angle
    'margate' = @{ theme = 'seaside vehicle tuning Margate'; desc = 'Seaside ECU tuning Margate & Thanet coast. Beachside vehicle optimization, coastal performance specialists.' }
    'ramsgate' = @{ theme = 'marina district tuning Ramsgate'; desc = 'Marina district ECU tuning Ramsgate. Yachting community vehicle specialists, royal harbour service.' }
    'broadstairs' = @{ theme = 'traditional village tuning Broadstairs'; desc = 'Traditional village ECU tuning Broadstairs. Dickens heritage community specialists, conservative values service.' }
    'cliftonville' = @{ theme = 'clifftop community tuning Cliftonville'; desc = 'Clifftop community ECU tuning Cliftonville. Seaside district optimization, coastal Margate specialists.' }
    'westgate-on-sea' = @{ theme = 'coastal resort tuning Westgate'; desc = 'Coastal resort ECU tuning Westgate-on-Sea. Retirement seaside optimization, genteel resort service.' }
    'birchington' = @{ theme = 'Thanet village tuning Birchington'; desc = 'Thanet village ECU tuning Birchington. Coastal community optimization, seaside living specialists.' }
    'garlinge' = @{ theme = 'Thanet estate tuning Garlinge'; desc = 'Thanet estate ECU tuning Garlinge. Residential community optimization, family-friendly service.' }
    'st-peters' = @{ theme = 'Thanet suburb tuning St Peters'; desc = 'Thanet suburb ECU tuning St Peters. Central Thanet optimization, broadstairs service area.' }
    'minster' = @{ theme = 'Thanet village tuning Minster'; desc = 'Thanet village ECU tuning Minster. Ancient settlement optimization, island heritage service.' }
    'monkton' = @{ theme = 'Thanet countryside tuning Monkton'; desc = 'Thanet countryside ECU tuning Monkton. Rural island optimization, village specialists.' }
    'pegwell' = @{ theme = 'coastal inlet tuning Pegwell'; desc = 'Coastal inlet ECU tuning Pegwell. Ramsgate hoverport area optimization, maritime heritage service.' }
    'preston' = @{ theme = 'Canterbury suburb tuning Preston'; desc = 'Canterbury suburb ECU tuning Preston. Residential district optimization, family neighbourhood service.' }
    
    # Medway Towns - Urban/Metropolitan express
    'chatham' = @{ theme = 'urban express tuning Chatham'; desc = 'Urban express tuning Chatham & Medway Towns. Fast city ECU optimization, metropolitan vehicle specialists.' }
    'gillingham' = @{ theme = 'working vehicle specialists Gillingham'; desc = 'Working vehicle specialists Gillingham. Industrial estate tuning, tradesperson van optimization.' }
    'rochester' = @{ theme = 'historic castle town tuning Rochester'; desc = 'Historic castle town tuning Rochester. Heritage district vehicle specialists, Dickensian city optimization.' }
    'rainham' = @{ theme = 'Medway commuter tuning Rainham'; desc = 'Medway commuter ECU tuning Rainham. Working town optimization, Gillingham area specialists.' }
    'grain' = @{ theme = 'Isle of Grain specialist tuning'; desc = 'Isle of Grain specialist ECU tuning. Peninsula community optimization, port workers service.' }
    'strood' = @{ theme = 'Medway gateway tuning Strood'; desc = 'Medway gateway ECU tuning Strood. Rochester crossing optimization, commuter route specialists.' }
    'hempstead' = @{ theme = 'Medway estate tuning Hempstead'; desc = 'Medway estate ECU tuning Hempstead. Gillingham district optimization, residential area service.' }
    
    # North Kent - Commuter/Daily driver
    'dartford' = @{ theme = 'commuter vehicle tuning Dartford'; desc = 'Commuter vehicle tuning Dartford & Kent-London border. Daily driver optimization, motorway performance specialists.' }
    'gravesend' = @{ theme = 'riverside vehicle tuning Gravesend'; desc = 'Riverside vehicle tuning Gravesend. Thames Gateway optimization specialists, waterfront district service.' }
    'northfleet' = @{ theme = 'Thames-side tuning Northfleet'; desc = 'Thames-side ECU tuning Northfleet. Gravesend district optimization, riverside community specialists.' }
    'swanscombe' = @{ theme = 'Thames Gateway tuning Swanscombe'; desc = 'Thames Gateway ECU tuning Swanscombe. Dartford area optimization, Ebbsfleet district service.' }
    'ebbsfleet' = @{ theme = 'international station tuning Ebbsfleet'; desc = 'International station ECU tuning Ebbsfleet. High-speed rail commuter optimization, European travel specialists.' }
    'stone' = @{ theme = 'Thames marshes tuning Stone'; desc = 'Thames marshes ECU tuning Stone. Dartford rural optimization, marsh villages specialists.' }
    'greenhithe' = @{ theme = 'Thames crossing tuning Greenhithe'; desc = 'Thames crossing ECU tuning Greenhithe. Dartford bridge community optimization, riverside specialists.' }
    'longfield' = @{ theme = 'North Kent village tuning Longfield'; desc = 'North Kent village ECU tuning Longfield. Gravesend rural optimization, commuter village specialists.' }
    'meopham' = @{ theme = 'North Downs tuning Meopham'; desc = 'North Downs ECU tuning Meopham. Rural North Kent optimization, village green specialists.' }
    'cobham' = @{ theme = 'North Kent heritage tuning Cobham'; desc = 'North Kent heritage ECU tuning Cobham. Historic village optimization, Gravesend area specialists.' }
    'higham' = @{ theme = 'Thames estuary tuning Higham'; desc = 'Thames estuary ECU tuning Higham. Gravesend marsh optimization, Dickens countryside specialists.' }
    
    # Channel Ports - Port/Commercial/European
    'dover' = @{ theme = 'port city tuning Dover'; desc = 'Port city ECU tuning Dover. Channel crossing optimization, ferry terminal specialists, commercial vehicle experts.' }
    'folkestone' = @{ theme = 'Channel port tuning Folkestone'; desc = 'Channel port ECU tuning Folkestone. Eurotunnel community optimization, cross-channel travel specialists.' }
    'deal' = @{ theme = 'coastal maritime tuning Deal'; desc = 'Coastal maritime ECU tuning Deal. Historic cinque port optimization, seaside heritage specialists.' }
    'sandwich' = @{ theme = 'cinque port tuning Sandwich'; desc = 'Ancient cinque port ECU tuning Sandwich. Historic town optimization, medieval heritage specialists.' }
    'walmer' = @{ theme = 'Dover coast tuning Walmer'; desc = 'Dover coast ECU tuning Walmer. Castle community optimization, seafront residential specialists.' }
    'kingsdown' = @{ theme = 'coastal clifftop tuning Kingsdown'; desc = 'Coastal clifftop ECU tuning Kingsdown. Dover beaches optimization, seaside village specialists.' }
    'capel-le-ferne' = @{ theme = 'Battle of Britain tuning Capel'; desc = 'Battle of Britain ECU tuning Capel-le-Ferne. White cliffs optimization, memorial village specialists.' }
    'hawkinge' = @{ theme = 'airfield heritage tuning Hawkinge'; desc = 'Airfield heritage ECU tuning Hawkinge. Folkestone hills optimization, aviation community specialists.' }
    'cheriton' = @{ theme = 'Eurotunnel district tuning Cheriton'; desc = 'Eurotunnel district ECU tuning Cheriton. Terminal community optimization, Folkestone suburb specialists.' }
    'sandgate' = @{ theme = 'Folkestone seafront tuning Sandgate'; desc = 'Folkestone seafront ECU tuning Sandgate. Coastal village optimization, seaside community specialists.' }
    'hythe' = @{ theme = 'cinque port tuning Hythe'; desc = 'Historic cinque port ECU tuning Hythe. Romney canal optimization, waterside heritage specialists.' }
    'saltwood' = @{ theme = 'Hythe heritage tuning Saltwood'; desc = 'Hythe heritage ECU tuning Saltwood. Castle village optimization, historic Folkestone area specialists.' }
    
    # Maidstone Region - County town/Premier professional
    'maidstone' = @{ theme = 'county town tuning Maidstone'; desc = 'County town ECU tuning Maidstone. Kent capital vehicle optimization, premier professional service.' }
    'bearsted' = @{ theme = 'affluent Maidstone tuning Bearsted'; desc = 'Affluent Maidstone ECU tuning Bearsted. Upscale village optimization, discerning residents service.' }
    'parkwood' = @{ theme = 'Maidstone estate tuning Parkwood'; desc = 'Maidstone estate ECU tuning Parkwood. Residential district optimization, community-focused service.' }
    'loose' = @{ theme = 'Maidstone village tuning Loose'; desc = 'Maidstone village ECU tuning Loose. Historic stream village optimization, charming suburb specialists.' }
    'barming' = @{ theme = 'Maidstone valley tuning Barming'; desc = 'Medway valley ECU tuning Barming. Maidstone suburb optimization, riverside village specialists.' }
    'east-farleigh' = @{ theme = 'Medway villages tuning East Farleigh'; desc = 'Medway villages ECU tuning East Farleigh. Rural Maidstone optimization, hop garden specialists.' }
    'wateringbury' = @{ theme = 'Medway valley tuning Wateringbury'; desc = 'Medway valley ECU tuning Wateringbury. Rural Kent optimization, fruit farming community specialists.' }
    'yalding' = @{ theme = 'three rivers tuning Yalding'; desc = 'Three rivers ECU tuning Yalding. Medway confluence optimization, scenic village specialists.' }
    'marden' = @{ theme = 'rural Maidstone tuning Marden'; desc = 'Rural Maidstone ECU tuning Marden. Orchard villages optimization, farming community specialists.' }
    'staplehurst' = @{ theme = 'Weald village tuning Staplehurst'; desc = 'Weald village ECU tuning Staplehurst. Rural rail hub optimization, countryside specialists.' }
    'headcorn' = @{ theme = 'Weald airfield tuning Headcorn'; desc = 'Weald airfield ECU tuning Headcorn. Aviation village optimization, rural Kent specialists.' }
    'sutton-valence' = @{ theme = 'Weald hilltop tuning Sutton Valence'; desc = 'Weald hilltop ECU tuning Sutton Valence. Scenic village optimization, Maidstone views specialists.' }
    'hollingbourne' = @{ theme = 'North Downs tuning Hollingbourne'; desc = 'North Downs ECU tuning Hollingbourne. AONB village optimization, scenic Kent specialists.' }
    'harrietsham' = @{ theme = 'North Downs village tuning Harrietsham'; desc = 'North Downs village ECU tuning Harrietsham. Lenham district optimization, rural Kent specialists.' }
    'lenham' = @{ theme = 'North Downs square tuning Lenham'; desc = 'North Downs square ECU tuning Lenham. Market village optimization, rural Maidstone specialists.' }
    'leeds' = @{ theme = 'castle village tuning Leeds'; desc = 'Castle village ECU tuning Leeds. Maidstone heritage optimization, scenic Kent specialists.' }
    
    # Ashford Region - Rail hub/International commuter
    'ashford' = @{ theme = 'international rail hub tuning Ashford'; desc = 'International rail hub ECU tuning Ashford. HS1 commuter optimization, Eurostar community specialists.' }
    'kingsnorth' = @{ theme = 'Ashford district tuning Kingsnorth'; desc = 'Ashford district ECU tuning Kingsnorth. Southern suburb optimization, residential estate specialists.' }
    'kennington' = @{ theme = 'Ashford suburb tuning Kennington'; desc = 'Ashford suburb ECU tuning Kennington. Commuter village optimization, railway town specialists.' }
    'willesborough' = @{ theme = 'Ashford residential tuning Willesborough'; desc = 'Ashford residential ECU tuning Willesborough. Town outskirts optimization, community service specialists.' }
    'wye' = @{ theme = 'Kent Downs tuning Wye'; desc = 'Kent Downs ECU tuning Wye. Agricultural college village optimization, AONB specialists.' }
    'challock' = @{ theme = 'Kent Downs village tuning Challock'; desc = 'Kent Downs village ECU tuning Challock. Rural Ashford optimization, scenic countryside specialists.' }
    'charing' = @{ theme = 'North Downs village tuning Charing'; desc = 'North Downs village ECU tuning Charing. Historic market village optimization, rural Kent specialists.' }
    'bethersden' = @{ theme = 'Weald village tuning Bethersden'; desc = 'Weald village ECU tuning Bethersden. Rural Ashford optimization, farming community specialists.' }
    'hamstreet' = @{ theme = 'Romney plain tuning Hamstreet'; desc = 'Romney plain ECU tuning Hamstreet. Rural railway village optimization, marsh area specialists.' }
    'mersham' = @{ theme = 'Ashford villages tuning Mersham'; desc = 'Ashford villages ECU tuning Mersham. Rural Kent optimization, heritage village specialists.' }
    'brabourne' = @{ theme = 'North Downs village tuning Brabourne'; desc = 'North Downs village ECU tuning Brabourne. Rural Ashford optimization, scenic heritage specialists.' }
    'aldington' = @{ theme = 'Romney escarpment tuning Aldington'; desc = 'Romney escarpment ECU tuning Aldington. Hillside village optimization, marsh views specialists.' }
    'brookland' = @{ theme = 'Romney Marsh tuning Brookland'; desc = 'Romney Marsh ECU tuning Brookland. Ancient church village optimization, marshland specialists.' }
    
    # Tonbridge/Tunbridge Wells - Executive/Premium
    'royal-tunbridge-wells' = @{ theme = 'spa town tuning Royal Tunbridge Wells'; desc = 'Royal spa town ECU tuning Tunbridge Wells. Executive vehicle optimization, affluent professionals service.' }
    'tonbridge' = @{ theme = 'castle town tuning Tonbridge'; desc = 'Castle town ECU tuning Tonbridge. Executive commuter optimization, premium Kent service.' }
    'southborough' = @{ theme = 'Tunbridge Wells suburb tuning Southborough'; desc = 'Tunbridge Wells suburb ECU tuning Southborough. Residential optimization, family community specialists.' }
    'pembury' = @{ theme = 'Tunbridge Wells village tuning Pembury'; desc = 'Tunbridge Wells village ECU tuning Pembury. Hospital community optimization, affluent suburb specialists.' }
    'paddock-wood' = @{ theme = 'garden town tuning Paddock Wood'; desc = 'Garden town ECU tuning Paddock Wood. Rail commuter optimization, expanding community specialists.' }
    'hildenborough' = @{ theme = 'commuter village tuning Hildenborough'; desc = 'Commuter village ECU tuning Hildenborough. Tonbridge suburb optimization, residential specialists.' }
    'bidborough' = @{ theme = 'Wealden village tuning Bidborough'; desc = 'Wealden village ECU tuning Bidborough. Tunbridge Wells rural optimization, exclusive community specialists.' }
    'lamberhurst' = @{ theme = 'Weald village tuning Lamberhurst'; desc = 'Weald village ECU tuning Lamberhurst. Vineyard community optimization, scenic Kent specialists.' }
    'cranbrook' = @{ theme = 'Wealden capital tuning Cranbrook'; desc = 'Wealden capital ECU tuning Cranbrook. Historic cloth town optimization, heritage specialists.' }
    'hawkhurst' = @{ theme = 'Weald village tuning Hawkhurst'; desc = 'Weald village ECU tuning Hawkhurst. High Weald optimization, rural Sussex border specialists.' }
    
    # Sevenoaks Region - Garden of England/Affluent
    'sevenoaks' = @{ theme = 'Garden of England tuning Sevenoaks'; desc = 'Garden of England vehicle specialists Sevenoaks. Affluent professional car tuning, upscale optimization service.' }
    'westerham' = @{ theme = 'Chartwell area tuning Westerham'; desc = 'Chartwell area ECU tuning Westerham. Historic market town optimization, Surrey border specialists.' }
    'edenbridge' = @{ theme = 'Kent-Surrey border tuning Edenbridge'; desc = 'Kent-Surrey border ECU tuning Edenbridge. Eden valley optimization, cross-county specialists.' }
    'hever' = @{ theme = 'castle village tuning Hever'; desc = 'Castle village ECU tuning Hever. Heritage tourism optimization, Boleyn country specialists.' }
    'penshurst' = @{ theme = 'historic estate tuning Penshurst'; desc = 'Historic estate ECU tuning Penshurst. Heritage village optimization, Medway valley specialists.' }
    'leigh' = @{ theme = 'Tonbridge village tuning Leigh'; desc = 'Tonbridge village ECU tuning Leigh. Rural commuter optimization, scenic Kent specialists.' }
    'riverhead' = @{ theme = 'Sevenoaks suburb tuning Riverhead'; desc = 'Sevenoaks suburb ECU tuning Riverhead. Darent valley optimization, residential district specialists.' }
    'kemsing' = @{ theme = 'North Downs village tuning Kemsing'; desc = 'North Downs village ECU tuning Kemsing. Scenic village optimization, Sevenoaks area specialists.' }
    'otford' = @{ theme = 'Darent valley tuning Otford'; desc = 'Darent valley ECU tuning Otford. Historic village optimization, commuter village specialists.' }
    'shoreham' = @{ theme = 'Darent valley village tuning Shoreham'; desc = 'Darent valley village ECU tuning Shoreham. Artists village optimization, scenic Kent specialists.' }
    'eynsford' = @{ theme = 'Darent valley heritage tuning Eynsford'; desc = 'Darent valley heritage ECU tuning Eynsford. Medieval ford optimization, viaduct village specialists.' }
    'swanley' = @{ theme = 'London border tuning Swanley'; desc = 'London border ECU tuning Swanley. Commuter town optimization, Kent-Greater London specialists.' }
    'farningham' = @{ theme = 'Darent valley village tuning Farningham'; desc = 'Darent valley village ECU tuning Farningham. Rural heritage optimization, scenic route specialists.' }
    'hextable' = @{ theme = 'Swanley suburb tuning Hextable'; desc = 'Swanley suburb ECU tuning Hextable. Residential district optimization, London commuter specialists.' }
    'west-kingsdown' = @{ theme = 'circuit village tuning West Kingsdown'; desc = 'Circuit village ECU tuning West Kingsdown. Racing heritage optimization, performance enthusiasts service.' }
    'dunton-green' = @{ theme = 'Sevenoaks suburb tuning Dunton Green'; desc = 'Sevenoaks suburb ECU tuning Dunton Green. Commuter village optimization, residential specialists.' }
    
    # Orpington/Bromley - London border/Metropolitan
    'orpington' = @{ theme = 'Greater London border tuning Orpington'; desc = 'Greater London border ECU tuning Orpington. Metropolitan commuter optimization, Bromley specialists.' }
    'bromley' = @{ theme = 'London borough tuning Bromley'; desc = 'London borough ECU tuning Bromley. Metropolitan Kent optimization, capital suburb specialists.' }
    'petts-wood' = @{ theme = 'Bromley suburb tuning Petts Wood'; desc = 'Bromley suburb ECU tuning Petts Wood. Residential estate optimization, London commuter specialists.' }
    'st-marys-cray' = @{ theme = 'Cray valley tuning St Marys Cray'; desc = 'Cray valley ECU tuning St Marys Cray. Industrial heritage optimization, Orpington district specialists.' }
    
    # Whitstable/Herne Bay - North Coast
    'whitstable' = @{ theme = 'boutique vehicle tuning Whitstable'; desc = 'Boutique vehicle tuning Whitstable. Artisan ECU optimization, oyster festival town specialists.' }
    'herne-bay' = @{ theme = 'leisurely pace tuning Herne Bay'; desc = 'Leisurely pace vehicle tuning Herne Bay. Retirement community specialists, relaxed professional service.' }
    'tankerton' = @{ theme = 'Whitstable seafront tuning Tankerton'; desc = 'Whitstable seafront ECU tuning Tankerton. Coastal slopes optimization, beach community specialists.' }
    'seasalter' = @{ theme = 'coastal village tuning Seasalter'; desc = 'Coastal village ECU tuning Seasalter. Whitstable outskirts optimization, seaside living specialists.' }
    'blean' = @{ theme = 'Canterbury forest tuning Blean'; desc = 'Canterbury forest ECU tuning Blean. Woodland village optimization, nature reserve specialists.' }
    'boughton' = @{ theme = 'Canterbury suburb tuning Boughton'; desc = 'Canterbury suburb ECU tuning Boughton. Street village optimization, A2 corridor specialists.' }
    'dunkirk' = @{ theme = 'Canterbury suburb tuning Dunkirk'; desc = 'Canterbury suburb ECU tuning Dunkirk. University district optimization, student community specialists.' }
    'tyler-hill' = @{ theme = 'Canterbury hilltop tuning Tyler Hill'; desc = 'Canterbury hilltop ECU tuning Tyler Hill. Blean woods optimization, university village specialists.' }
    'rough-common' = @{ theme = 'Canterbury suburb tuning Rough Common'; desc = 'Canterbury suburb ECU tuning Rough Common. Residential district optimization, modern estate specialists.' }
    
    # Sittingbourne/Swale - Industrial corridor
    'sittingbourne' = @{ theme = 'industrial hub tuning Sittingbourne'; desc = 'Industrial hub tuning Sittingbourne. Commercial vehicle optimization, logistics fleet specialists.' }
    'faversham' = @{ theme = 'market town tuning Faversham'; desc = 'Market town vehicle tuning Faversham. Brewing heritage district optimization, traditional market square service.' }
    'sheerness' = @{ theme = 'island port tuning Sheerness'; desc = 'Island port ECU tuning Sheerness. Sheppey docklands optimization, maritime community specialists.' }
    'minster-on-sea' = @{ theme = 'Sheppey seaside tuning Minster'; desc = 'Sheppey seaside ECU tuning Minster. Island resort optimization, coastal retirement specialists.' }
    'queenborough' = @{ theme = 'historic port tuning Queenborough'; desc = 'Historic port ECU tuning Queenborough. Island heritage optimization, maritime village specialists.' }
    'leysdown-on-sea' = @{ theme = 'Sheppey coast tuning Leysdown'; desc = 'Sheppey coast ECU tuning Leysdown. Beach resort optimization, holiday park specialists.' }
    'eastchurch' = @{ theme = 'aviation heritage tuning Eastchurch'; desc = 'Aviation heritage ECU tuning Eastchurch. Island airfield optimization, flying history specialists.' }
    'milton-regis' = @{ theme = 'Sittingbourne suburb tuning Milton Regis'; desc = 'Sittingbourne suburb ECU tuning Milton Regis. Historic district optimization, industrial area specialists.' }
    'teynham' = @{ theme = 'A2 corridor tuning Teynham'; desc = 'A2 corridor ECU tuning Teynham. Fruit growing village optimization, agricultural community specialists.' }
    'newington' = @{ theme = 'Swale village tuning Newington'; desc = 'Swale village ECU tuning Newington. M2 corridor optimization, commuter village specialists.' }
    'borden' = @{ theme = 'Swale village tuning Borden'; desc = 'Swale village ECU tuning Borden. Sittingbourne outskirts optimization, residential village specialists.' }
    'bobbing' = @{ theme = 'Swale industrial tuning Bobbing'; desc = 'Swale industrial ECU tuning Bobbing. Business park optimization, commercial estate specialists.' }
    'iwade' = @{ theme = 'Swale expansion tuning Iwade'; desc = 'Swale expansion ECU tuning Iwade. New community optimization, modern estate specialists.' }
    
    # Romney Marsh - Coastal marsh/Unique landscape
    'new-romney' = @{ theme = 'Romney Marsh capital tuning New Romney'; desc = 'Romney Marsh capital ECU tuning New Romney. Ancient cinque port optimization, marshland specialists.' }
    'lydd' = @{ theme = 'airport village tuning Lydd'; desc = 'Airport village ECU tuning Lydd. Romney Marsh aviation optimization, coastal community specialists.' }
    'dymchurch' = @{ theme = 'seawall village tuning Dymchurch'; desc = 'Seawall village ECU tuning Dymchurch. Holiday resort optimization, Romney beach specialists.' }
    'st-marys-bay' = @{ theme = 'Romney coast tuning St Marys Bay'; desc = 'Romney coast ECU tuning St Marys Bay. Beach holiday optimization, coastal village specialists.' }
    'littlestone-on-sea' = @{ theme = 'Romney seafront tuning Littlestone'; desc = 'Romney seafront ECU tuning Littlestone. Golf coast optimization, residential seaside specialists.' }
    'greatstone-on-sea' = @{ theme = 'Romney beach tuning Greatstone'; desc = 'Romney beach ECU tuning Greatstone. Shingle coast optimization, seaside living specialists.' }
    'ivychurch' = @{ theme = 'Romney Marsh village tuning Ivychurch'; desc = 'Romney Marsh village ECU tuning Ivychurch. Marshland optimization, rural isolation specialists.' }
    'old-romney' = @{ theme = 'ancient Romney tuning Old Romney'; desc = 'Ancient Romney ECU tuning Old Romney. Historic marsh village optimization, medieval heritage specialists.' }
    'burmarsh' = @{ theme = 'Romney levels tuning Burmarsh'; desc = 'Romney levels ECU tuning Burmarsh. Marshland agriculture optimization, sheep farming specialists.' }
    'newchurch' = @{ theme = 'Romney central tuning Newchurch'; desc = 'Romney central ECU tuning Newchurch. Marsh crossroads optimization, rural community specialists.' }
    'st-mary-in-the-marsh' = @{ theme = 'Romney literary tuning St Mary'; desc = 'Romney literary ECU tuning St Mary-in-the-Marsh. E. Nesbit village optimization, heritage specialists.' }
    'snave' = @{ theme = 'Romney Marsh hamlet tuning Snave'; desc = 'Romney Marsh hamlet ECU tuning Snave. Remote marshland optimization, rural isolation specialists.' }
    'brenzett' = @{ theme = 'Romney Marsh village tuning Brenzett'; desc = 'Romney Marsh village ECU tuning Brenzett. Aeronautical museum area optimization, marsh specialists.' }
    'appledore' = @{ theme = 'marsh heritage tuning Appledore'; desc = 'Marsh heritage ECU tuning Appledore. Ancient port optimization, canal village specialists.' }
    'stone-in-oxney' = @{ theme = 'Isle of Oxney tuning Stone'; desc = 'Isle of Oxney ECU tuning Stone. Marsh island optimization, elevated village specialists.' }
    'wittersham' = @{ theme = 'Isle of Oxney village tuning Wittersham'; desc = 'Isle of Oxney village ECU tuning Wittersham. Marsh views optimization, rural specialists.' }
    'rolvenden' = @{ theme = 'Wealden edge tuning Rolvenden'; desc = 'Wealden edge ECU tuning Rolvenden. High Weald optimization, heritage village specialists.' }
    'tenterden' = @{ theme = 'Wealden town tuning Tenterden'; desc = 'Wealden town ECU tuning Tenterden. Garden of England optimization, historic market town specialists.' }
    'smallhythe' = @{ theme = 'theatrical heritage tuning Smallhythe'; desc = 'Theatrical heritage ECU tuning Smallhythe. Historic port optimization, Ellen Terry village specialists.' }
    'high-halden' = @{ theme = 'Weald village tuning High Halden'; desc = 'Weald village ECU tuning High Halden. Rural Kent optimization, agricultural community specialists.' }
    'shadoxhurst' = @{ theme = 'Weald village tuning Shadoxhurst'; desc = 'Weald village ECU tuning Shadoxhurst. Rural Ashford optimization, farming village specialists.' }
    'woodchurch' = @{ theme = 'Weald hilltop tuning Woodchurch'; desc = 'Weald hilltop ECU tuning Woodchurch. Marsh views optimization, elevated village specialists.' }
    'hamstreet' = @{ theme = 'Romney plain tuning Hamstreet'; desc = 'Romney plain ECU tuning Hamstreet. Rural railway village optimization, marsh area specialists.' }
    
    # Dover Coast - White cliffs/Heritage coast
    'st-margarets-at-cliffe' = @{ theme = 'white cliffs tuning St Margarets'; desc = 'White cliffs ECU tuning St Margarets-at-Cliffe. Channel views optimization, clifftop village specialists.' }
    'ringwould' = @{ theme = 'Dover clifftop tuning Ringwould'; desc = 'Dover clifftop ECU tuning Ringwould. Coastal village optimization, heritage downs specialists.' }
    'martin' = @{ theme = 'Dover downland tuning Martin'; desc = 'Dover downland ECU tuning Martin. Rural coast optimization, chalk hills specialists.' }
    'guston' = @{ theme = 'Dover heights tuning Guston'; desc = 'Dover heights ECU tuning Guston. Western Heights optimization, hillside village specialists.' }
    'whitfield' = @{ theme = 'Dover suburb tuning Whitfield'; desc = 'Dover suburb ECU tuning Whitfield. Valley community optimization, residential district specialists.' }
    'kearsney' = @{ theme = 'Dover valley tuning Kearsney'; desc = 'Dover valley ECU tuning Kearsney. River park optimization, scenic village specialists.' }
    'river' = @{ theme = 'Dover industrial tuning River'; desc = 'Dover industrial ECU tuning River. Port district optimization, logistics community specialists.' }
    'temple-ewell' = @{ theme = 'Dover valley village tuning Temple Ewell'; desc = 'Dover valley village ECU tuning Temple Ewell. Dour river optimization, rural suburb specialists.' }
    
    # Canterbury Coast - Coastal villages between Canterbury & Thanet
    'herne' = @{ theme = 'Canterbury coast tuning Herne'; desc = 'Canterbury coast ECU tuning Herne. Village community optimization, coastal Canterbury specialists.' }
    'hoath' = @{ theme = 'Canterbury marshes tuning Hoath'; desc = 'Canterbury marshes ECU tuning Hoath. Rural village optimization, Stour marshland specialists.' }
    'chislet' = @{ theme = 'Canterbury marshland tuning Chislet'; desc = 'Canterbury marshland ECU tuning Chislet. Coal mining heritage optimization, marsh village specialists.' }
    'upstreet' = @{ theme = 'Canterbury valley tuning Upstreet'; desc = 'Canterbury valley ECU tuning Upstreet. Stour valley optimization, canalside village specialists.' }
    'grove-ferry' = @{ theme = 'Wantsum channel tuning Grove Ferry'; desc = 'Wantsum channel ECU tuning Grove Ferry. Historic waterway optimization, riverside specialists.' }
    'preston' = @{ theme = 'Canterbury suburb tuning Preston'; desc = 'Canterbury suburb ECU tuning Preston. Residential optimization, family neighbourhood service.' }
    'sturry' = @{ theme = 'Canterbury valley tuning Sturry'; desc = 'Canterbury valley ECU tuning Sturry. River suburb optimization, Stour valley specialists.' }
    'westbere' = @{ theme = 'Canterbury marshes tuning Westbere'; desc = 'Canterbury marshes ECU tuning Westbere. Stour valley optimization, railway village specialists.' }
    'hersden' = @{ theme = 'Canterbury colliery tuning Hersden'; desc = 'Canterbury colliery ECU tuning Hersden. Mining heritage optimization, industrial village specialists.' }
    'wickhambreaux' = @{ theme = 'Canterbury valley tuning Wickhambreaux'; desc = 'Stour valley ECU tuning Wickhambreaux. Scenic village vehicle optimization, countryside specialists.' }
    
    # Deal/Sandwich Coast - Heritage coast between Dover & Thanet
    'sholden' = @{ theme = 'Deal suburb tuning Sholden'; desc = 'Deal suburb ECU tuning Sholden. Colliery heritage optimization, residential district specialists.' }
    'ripple' = @{ theme = 'Deal countryside tuning Ripple'; desc = 'Deal countryside ECU tuning Ripple. Rural coast optimization, agricultural village specialists.' }
    'worth' = @{ theme = 'Sandwich suburb tuning Worth'; desc = 'Sandwich suburb ECU tuning Worth. Colliery village optimization, mining heritage specialists.' }
    'northbourne' = @{ theme = 'Deal downland tuning Northbourne'; desc = 'Deal downland ECU tuning Northbourne. Rural coast optimization, estate village specialists.' }
    'tilmanstone' = @{ theme = 'Deal colliery tuning Tilmanstone'; desc = 'Deal colliery ECU tuning Tilmanstone. Mining heritage optimization, industrial village specialists.' }
    'eastry' = @{ theme = 'Sandwich hinterland tuning Eastry'; desc = 'Sandwich hinterland ECU tuning Eastry. Rural heritage optimization, estate village specialists.' }
    'ash' = @{ theme = 'Sandwich suburb tuning Ash'; desc = 'Sandwich suburb ECU tuning Ash. Residential district optimization, village community specialists.' }
    'wingham' = @{ theme = 'Canterbury heritage tuning Wingham'; desc = 'Canterbury heritage ECU tuning Wingham. Historic market village optimization, rural specialists.' }
    'preston-by-wingham' = @{ theme = 'Wingham area tuning Preston'; desc = 'Wingham area ECU tuning Preston-by-Wingham. Rural Canterbury optimization, farming village specialists.' }
    'staple' = @{ theme = 'Sandwich rural tuning Staple'; desc = 'Sandwich rural ECU tuning Staple. Heritage village optimization, agricultural specialists.' }
    'goodnestone' = @{ theme = 'Sandwich estate tuning Goodnestone'; desc = 'Sandwich estate ECU tuning Goodnestone. Jane Austen village optimization, heritage specialists.' }
    'nonington' = @{ theme = 'Dover rural tuning Nonington'; desc = 'Dover rural ECU tuning Nonington. Downland village optimization, countryside specialists.' }
    'barfrestone' = @{ theme = 'Dover heritage tuning Barfrestone'; desc = 'Dover heritage ECU tuning Barfrestone. Norman church village optimization, rural specialists.' }
    'shepherdswell' = @{ theme = 'Dover valley tuning Shepherdswell'; desc = 'Dover valley ECU tuning Shepherdswell. Rail village optimization, colliery heritage specialists.' }
    'eythorne' = @{ theme = 'Dover valley tuning Eythorne'; desc = 'Dover valley ECU tuning Eythorne. Mining heritage optimization, residential village specialists.' }
    'elvington' = @{ theme = 'Dover rural tuning Elvington'; desc = 'Dover rural ECU tuning Elvington. Downland village optimization, countryside specialists.' }
    'denton' = @{ theme = 'Dover valley tuning Denton'; desc = 'Dover valley ECU tuning Denton. Nailbourne valley optimization, rural village specialists.' }
    'wootton' = @{ theme = 'Dover downland tuning Wootton'; desc = 'Dover downland ECU tuning Wootton. Rural heritage optimization, Canterbury-Dover specialists.' }
    'adisham' = @{ theme = 'Canterbury downland tuning Adisham'; desc = 'Canterbury downland ECU tuning Adisham. Scenic village optimization, heritage specialists.' }
    'aylesham' = @{ theme = 'colliery town tuning Aylesham'; desc = 'Colliery town ECU tuning Aylesham. Mining heritage optimization, planned village specialists.' }
    'snowdown' = @{ theme = 'colliery village tuning Snowdown'; desc = 'Colliery village ECU tuning Snowdown. Mining heritage optimization, industrial village specialists.' }
    'nonington' = @{ theme = 'Dover rural tuning Nonington'; desc = 'Dover rural ECU tuning Nonington. Downland village optimization, countryside specialists.' }
    
    # Canterbury South - Villages south of Canterbury
    'chartham' = @{ theme = 'Canterbury valley tuning Chartham'; desc = 'Great Stour valley ECU tuning Chartham. Paper mills heritage optimization, railway village specialists.' }
    'chartham-hatch' = @{ theme = 'Canterbury heights tuning Chartham Hatch'; desc = 'Canterbury heights ECU tuning Chartham Hatch. Hilltop village optimization, residential specialists.' }
    'chilham' = @{ theme = 'heritage village tuning Chilham'; desc = 'Heritage village ECU tuning Chilham. Medieval square optimization, Stour valley castle village specialists.' }
    'godmersham' = @{ theme = 'Stour valley tuning Godmersham'; desc = 'Stour valley ECU tuning Godmersham. Jane Austen heritage optimization, estate village specialists.' }
    'crundale' = @{ theme = 'Canterbury downland tuning Crundale'; desc = 'Canterbury downland ECU tuning Crundale. Rural hills optimization, scenic village specialists.' }
    'petham' = @{ theme = 'Canterbury downs tuning Petham'; desc = 'Canterbury downs ECU tuning Petham. North Downs village optimization, scenic heritage specialists.' }
    'lyminge' = @{ theme = 'North Downs heritage tuning Lyminge'; desc = 'North Downs heritage ECU tuning Lyminge. Anglo-Saxon royal optimization, historic village specialists.' }
    'elham' = @{ theme = 'Elham valley tuning Elham'; desc = 'Elham valley ECU tuning Elham. Scenic village optimization, North Downs heritage specialists.' }
    'barham' = @{ theme = 'Canterbury valley tuning Barham'; desc = 'Canterbury valley ECU tuning Barham. Nailbourne valley optimization, rural village specialists.' }
    'kingston' = @{ theme = 'Canterbury valley tuning Kingston'; desc = 'Canterbury valley ECU tuning Kingston. Barham valley optimization, farming village specialists.' }
    'bishopsbourne' = @{ theme = 'Canterbury downs tuning Bishopsbourne'; desc = 'Canterbury downs ECU tuning Bishopsbourne. Heritage village optimization, scenic countryside service.' }
    'ickham' = @{ theme = 'Canterbury valley tuning Ickham'; desc = 'Canterbury valley ECU tuning Ickham. Little Stour optimization, heritage village specialists.' }
    'wickhambreaux' = @{ theme = 'Stour valley tuning Wickhambreaux'; desc = 'Stour valley ECU tuning Wickhambreaux. Scenic village vehicle optimization, countryside specialists.' }
    
    # Essex Coast - Southend/Basildon/Chelmsford
    'southend' = @{ theme = 'Thames estuary resort tuning Southend'; desc = 'Thames estuary resort ECU tuning Southend-on-Sea. Pier city optimization, Essex coast specialists.' }
    'leigh-on-sea' = @{ theme = 'fishing village tuning Leigh-on-Sea'; desc = 'Fishing village ECU tuning Leigh-on-Sea. Old town cockle sheds optimization, artistic community specialists.' }
    'westcliff-on-sea' = @{ theme = 'Southend clifftop tuning Westcliff'; desc = 'Southend clifftop ECU tuning Westcliff-on-Sea. Residential district optimization, coastal living specialists.' }
    'prittlewell' = @{ theme = 'Southend suburb tuning Prittlewell'; desc = 'Southend suburb ECU tuning Prittlewell. Saxon heritage optimization, historic village specialists.' }
    'shoeburyness' = @{ theme = 'military heritage tuning Shoeburyness'; desc = 'Military heritage ECU tuning Shoeburyness. Garrison town optimization, Thames estuary specialists.' }
    'basildon' = @{ theme = 'new town tuning Basildon'; desc = 'New town ECU tuning Basildon. Planned community optimization, Essex commercial hub specialists.' }
    'laindon' = @{ theme = 'Basildon district tuning Laindon'; desc = 'Basildon district ECU tuning Laindon. Plotlands heritage optimization, residential community specialists.' }
    'pitsea' = @{ theme = 'Basildon district tuning Pitsea'; desc = 'Basildon district ECU tuning Pitsea. New town optimization, commercial district specialists.' }
    'benfleet' = @{ theme = 'Castle Point tuning Benfleet'; desc = 'Castle Point ECU tuning Benfleet. Saddle community optimization, South Benfleet specialists.' }
    'canvey-island' = @{ theme = 'island community tuning Canvey'; desc = 'Island community ECU tuning Canvey Island. Thames estuary optimization, unique island specialists.' }
    'chelmsford' = @{ theme = 'Essex city tuning Chelmsford'; desc = 'Essex city ECU tuning Chelmsford. Cathedral city optimization, county town specialists.' }
    'galleywood' = @{ theme = 'Chelmsford suburb tuning Galleywood'; desc = 'Chelmsford suburb ECU tuning Galleywood. Village community optimization, residential specialists.' }
    'springfield' = @{ theme = 'Chelmsford suburb tuning Springfield'; desc = 'Chelmsford suburb ECU tuning Springfield. Residential district optimization, prison town specialists.' }
    'runwell' = @{ theme = 'Chelmsford village tuning Runwell'; desc = 'Chelmsford village ECU tuning Runwell. Rural Essex optimization, countryside specialists.' }
    'brentwood' = @{ theme = 'Essex commuter tuning Brentwood'; desc = 'Essex commuter town ECU tuning Brentwood. London border optimization, affluent suburb specialists.' }
    'wickford' = @{ theme = 'Essex town tuning Wickford'; desc = 'Essex town ECU tuning Wickford. Basildon area optimization, residential community specialists.' }
    'rayleigh' = @{ theme = 'Essex heritage town tuning Rayleigh'; desc = 'Essex heritage town ECU tuning Rayleigh. Castle mound optimization, historic Essex specialists.' }
    'rochford' = @{ theme = 'Essex market town tuning Rochford'; desc = 'Essex market town ECU tuning Rochford. Historic square optimization, Southend hinterland specialists.' }
    'hockley' = @{ theme = 'Essex village tuning Hockley'; desc = 'Essex village ECU tuning Hockley. Spa heritage optimization, rural Rochford specialists.' }
    'hadleigh' = @{ theme = 'castle village tuning Hadleigh'; desc = 'Castle village ECU tuning Hadleigh. Thames estuary views optimization, heritage Essex specialists.' }
    'thundersley' = @{ theme = 'Castle Point suburb tuning Thundersley'; desc = 'Castle Point suburb ECU tuning Thundersley. Residential community optimization, Benfleet area specialists.' }
    'south-woodham-ferrers' = @{ theme = 'new town tuning South Woodham Ferrers'; desc = 'New town ECU tuning South Woodham Ferrers. Riverside development optimization, Chelmsford district specialists.' }
}

# Process each location file
Get-ChildItem "c:\Users\carna\OneDrive\Desktop\new front website\locations\*.html" | Where-Object { $_.Name -ne "index.html" } | ForEach-Object {
    $location = $_.BaseName
    $filePath = $_.FullName
    
    # Get strategy if exists, otherwise use generic update
    if ($keywordStrategies.ContainsKey($location)) {
        $strategy = $keywordStrategies[$location]
        $content = Get-Content $filePath -Raw
        
        # Find and replace meta description
        if ($content -match '<meta name="description" content="([^"]+)">') {
            $oldDesc = $matches[1]
            if ($oldDesc -match "^Professional ECU remapping") {
                $content = $content -replace [regex]::Escape($oldDesc), $strategy.desc
                Write-Host "✓ Updated $location - $($strategy.theme)" -ForegroundColor Green
            }
        }
        
        # Find and replace keywords (preserving stage 1 remap, gearbox tuning etc at end)
        if ($content -match '<meta name="keywords" content="([^"]+)">') {
            $oldKeywords = $matches[1]
            # Extract the common ending keywords
            $preserveKeywords = @()
            if ($oldKeywords -match "stage 1 remap") { $preserveKeywords += "stage 1 remap $location" }
            if ($oldKeywords -match "professional") { $preserveKeywords += "professional vehicle tuning" }
            if ($oldKeywords -match "gearbox tuning") { $preserveKeywords += "gearbox tuning" }
            
            # Build new keywords
            $newKeywords = $strategy.theme + ", " + ($preserveKeywords -join ", ")
            $content = $content -replace [regex]::Escape($oldKeywords), $newKeywords
        }
        
        # Save file
        $content | Set-Content $filePath -NoNewline
    }
}

Write-Host "`n✓ Completed SEO diversification across all locations" -ForegroundColor Cyan
