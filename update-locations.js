const fs = require('fs');
const path = require('path');

const locationsDir = path.join(__dirname, 'locations');
const files = fs.readdirSync(locationsDir).filter(f => f.endsWith('.html') && f !== 'index.html');

const dpfCleaningCard = `                <div class="location-service-card"><h3>💧 DPF Pressure Cleaning</h3><p>Stage 1 &amp; 2 chemical clean - restore your DPF without deletion. Legal &amp; MOT compliant.</p><p class="price">From <strong>£149</strong></p></div>\n`;

const searchPatterns = [
    '<div class="location-service-card"><h3>🚫 DPF Delete Remap</h3>',
    '<div class="location-service-card"><h3>🚫 DPF/EGR Delete</h3>'
];

let updated = 0;
let skipped = 0;

files.forEach(file => {
    const filePath = path.join(locationsDir, file);
    let content = fs.readFileSync(filePath, 'utf8');
    
    // Skip if already has DPF Pressure Cleaning
    if (content.includes('DPF Pressure Cleaning') || content.includes('DPF Pressure')) {
        console.log(`✓ Skipped (already has): ${file}`);
        skipped++;
        return;
    }
    
    // Try to find and replace before DPF Delete card
    let replaced = false;
    for (const pattern of searchPatterns) {
        if (content.includes(pattern)) {
            content = content.replace(pattern, dpfCleaningCard + pattern);
            fs.writeFileSync(filePath, content, 'utf8');
            console.log(`✅ Updated: ${file}`);
            updated++;
            replaced = true;
            break;
        }
    }
    
    if (!replaced) {
        console.log(`❌ Skipped (no DPF section): ${file}`);
        skipped++;
    }
});

console.log('\n========================================');
console.log(`✅ Updated: ${updated} files`);
console.log(`⏭️  Skipped: ${skipped} files`);
console.log('========================================');
