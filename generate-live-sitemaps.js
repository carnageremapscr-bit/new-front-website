const fs = require('fs');
const path = require('path');

const baseUrl = 'https://www.carnageremaps.co.uk';
const rootDir = __dirname;
const locationsDir = path.join(rootDir, 'locations');
const serviceDir = path.join(locationsDir, 'services');

function xmlEscape(value) {
  return String(value)
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;')
    .replace(/'/g, '&apos;');
}

function buildUrlset(urls) {
  const entries = urls
    .map((url) => `  <url>\n    <loc>${xmlEscape(url)}</loc>\n    <lastmod>${new Date().toISOString().split('T')[0]}</lastmod>\n  </url>`)
    .join('\n');

  return `<?xml version="1.0" encoding="UTF-8"?>\n<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">\n${entries}\n</urlset>\n`;
}

function readHtmlFiles(dirPath, exclude = []) {
  if (!fs.existsSync(dirPath)) return [];

  return fs
    .readdirSync(dirPath, { withFileTypes: true })
    .filter((entry) => entry.isFile() && entry.name.endsWith('.html'))
    .map((entry) => entry.name)
    .filter((name) => !exclude.includes(name))
    .sort();
}

const rootPages = [
  '/',
  '/services.html',
  '/pricing.html',
  '/contact.html',
  '/vehicle-search.html',
  '/care-plans.html',
  '/tuning-checker.html',
  '/locations/'
];

const locationPages = readHtmlFiles(locationsDir, ['index.html'])
  .map((file) => `${baseUrl}/locations/${file}`)
  .sort();

const servicePages = readHtmlFiles(serviceDir)
  .map((file) => `${baseUrl}/locations/services/${file}`)
  .sort();

const rootSitemap = buildUrlset(
  rootPages
    .map((page) => `${baseUrl}${page === '/' ? '' : page}`)
    .concat(locationPages)
);

const serviceSitemap = buildUrlset(servicePages);

fs.writeFileSync(path.join(rootDir, 'sitemap.xml'), rootSitemap, 'utf8');
fs.writeFileSync(path.join(rootDir, 'sitemap-services.xml'), serviceSitemap, 'utf8');

console.log('Generated sitemap.xml with', rootPages.length + locationPages.length, 'entries');
console.log('Generated sitemap-services.xml with', servicePages.length, 'entries');
