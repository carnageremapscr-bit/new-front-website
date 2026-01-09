const http = require('http');
const fs = require('fs');
const path = require('path');
const nodemailer = require('nodemailer');
const querystring = require('querystring');

const PORT = parseInt(process.env.PORT || '8080');
const HOST = '0.0.0.0'; // Listen on all interfaces for Railway

// Email configuration - only create transporter if EMAIL_PASS is set
let transporter = null;
if (process.env.EMAIL_PASS) {
  transporter = nodemailer.createTransport({
    service: 'gmail',
    auth: {
      user: process.env.EMAIL_USER || 'carnageremaps@gmail.com',
      pass: process.env.EMAIL_PASS
    }
  });
  console.log('✅ Email transporter configured');
} else {
  console.warn('⚠️ EMAIL_PASS not set - email functionality will be disabled');
}

const mimeTypes = {
  '.html': 'text/html',
  '.css': 'text/css',
  '.js': 'text/javascript',
  '.json': 'application/json',
  '.png': 'image/png',
  '.jpg': 'image/jpeg',
  '.jpeg': 'image/jpeg',
  '.gif': 'image/gif',
  '.svg': 'image/svg+xml',
  '.ico': 'image/x-icon',
  '.woff': 'font/woff',
  '.woff2': 'font/woff2',
};

// Cache durations in seconds
const cacheDurations = {
  '.html': 3600,        // 1 hour for HTML
  '.css': 604800,       // 7 days for CSS
  '.js': 604800,        // 7 days for JS
  '.png': 2592000,      // 30 days for images
  '.jpg': 2592000,
  '.jpeg': 2592000,
  '.gif': 2592000,
  '.svg': 2592000,
  '.ico': 2592000,
  '.woff': 2592000,     // 30 days for fonts
  '.woff2': 2592000,
};

const server = http.createServer((req, res) => {
  // Redirect old URL patterns: /remapping-{city}/ → /locations/{city}.html
  // Handle both simple and malformed double-path patterns
  let urlPath = req.url;
  
  // Fix malformed URLs like /remapping-city/%2Fremapping-city
  urlPath = urlPath.replace(/%2F/gi, '/');
  
  const oldLocationPattern = /^\/remapping-([a-z-]+)(\/remapping-[a-z-]+)?\/?$/i;
  const match = urlPath.match(oldLocationPattern);
  if (match) {
    const city = match[1];
    res.writeHead(301, { 'Location': `/locations/${city}.html` });
    res.end();
    return;
  }
  
  // Handle CORS preflight
  if (req.method === 'OPTIONS') {
    res.writeHead(200, {
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Methods': 'POST, GET, OPTIONS',
      'Access-Control-Allow-Headers': 'Content-Type'
    });
    res.end();
    return;
  }

  // Handle form submissions
  if (req.method === 'POST' && req.url === '/send-email') {
    let body = '';
    
    req.on('data', chunk => {
      body += chunk.toString();
    });
    
    req.on('end', () => {
      try {
        const data = JSON.parse(body);
        
        console.log('Received form submission:', data.name, data.email);
        
        const mailOptions = {
          from: process.env.EMAIL_USER || 'carnageremaps@gmail.com',
          to: 'carnageremaps@gmail.com',
          replyTo: data.email,
          subject: `New Enquiry from ${data.name} - Carnage Remaps`,
          html: `
            <h2>New Enquiry from Contact Form</h2>
            <p><strong>Name:</strong> ${data.name}</p>
            <p><strong>Email:</strong> ${data.email}</p>
            <p><strong>Phone:</strong> ${data.phone || 'Not provided'}</p>
            <p><strong>Subject:</strong> ${data.subject || 'Not provided'}</p>
            <p><strong>Message:</strong></p>
            <p>${data.message.replace(/\n/g, '<br>')}</p>
            <hr>
            <p><em>Reply-to: ${data.email}</em></p>
          `
        };
        
        // Check if email is configured
        if (!transporter) {
          console.error('EMAIL_PASS not set in environment variables');
          res.writeHead(500, { 
            'Content-Type': 'application/json',
            'Access-Control-Allow-Origin': '*'
          });
          res.end(JSON.stringify({ success: false, message: 'Email not configured' }));
          return;
        }
        
        transporter.sendMail(mailOptions, (error, info) => {
          if (error) {
            console.error('Email error:', error);
            res.writeHead(500, { 
              'Content-Type': 'application/json',
              'Access-Control-Allow-Origin': '*'
            });
            res.end(JSON.stringify({ success: false, message: 'Failed to send email: ' + error.message }));
          } else {
            console.log('Email sent:', info.response);
            res.writeHead(200, { 
              'Content-Type': 'application/json',
              'Access-Control-Allow-Origin': '*'
            });
            res.end(JSON.stringify({ success: true, message: 'Email sent successfully' }));
          }
        });
      } catch (error) {
        console.error('Error processing form:', error);
        res.writeHead(400, { 
          'Content-Type': 'application/json',
          'Access-Control-Allow-Origin': '*'
        });
        res.end(JSON.stringify({ success: false, message: 'Invalid request' }));
      }
    });
    return;
  }

  // Handle quote form submissions
  if (req.method === 'POST' && req.url === '/send-quote') {
    let body = '';
    
    req.on('data', chunk => {
      body += chunk.toString();
    });
    
    req.on('end', () => {
      try {
        const formData = querystring.parse(body);
        
        console.log('=== QUOTE FORM SUBMISSION ===');
        console.log('Name:', formData.name);
        console.log('Phone:', formData.phone);
        console.log('Email:', formData.email || 'Not provided');
        console.log('Postcode:', formData.postcode);
        console.log('Vehicle:', formData.vehicle);
        console.log('Year:', formData.year);
        console.log('Service:', formData.service);
        console.log('EMAIL_PASS configured:', !!transporter);
        console.log('============================');
        
        // Check if email is configured
        if (!transporter) {
          console.error('⚠️ EMAIL_PASS not set in environment variables!');
          console.log('To fix: Set EMAIL_PASS environment variable in Railway dashboard');
          res.writeHead(302, { 
            'Location': '/?quote=error',
            'Access-Control-Allow-Origin': '*'
          });
          res.end();
          return;
        }

        function getServiceName(serviceCode) {
          const services = {
            'stage1': '⚡ Stage 1 ECU Remap (£249+)',
            'stage2': '🚀 Stage 2 ECU Remap (£349+)',
            'stage3': '🏁 Stage 3 Custom Tuning (£649+)',
            'dpf': '🚫 DPF Delete (£179+)',
            'egr': '🚫 EGR Delete (£179+)',
            'adblue': '💨 AdBlue Delete (£179+)',
            'gearbox': '⚙️ Gearbox Remapping (£199+)',
            'diagnostics': '🔧 Full Diagnostics (£49)',
            'popbang': '💥 Pop & Bang / Burbles (£99+)',
            'other': '❓ Other / Multiple Services'
          };
          return services[serviceCode] || serviceCode;
        }

        const mailOptions = {
          from: 'carnageremaps@gmail.com',
          to: 'carnageremaps@gmail.com',
          subject: `🔥 NEW QUOTE REQUEST - ${formData.vehicle || 'Unknown Vehicle'}`,
          html: `
            <div style="font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto; padding: 20px; background-color: #f5f5f5;">
              <div style="background-color: #1a1a1a; color: #F5C400; padding: 20px; text-align: center;">
                <h1 style="margin: 0;">⚡ NEW QUOTE REQUEST</h1>
              </div>
              
              <div style="background-color: white; padding: 30px; margin-top: 20px;">
                <h2 style="color: #1a1a1a; border-bottom: 2px solid #F5C400; padding-bottom: 10px;">Customer Details</h2>
                <table style="width: 100%; margin: 20px 0;">
                  <tr>
                    <td style="padding: 10px; background-color: #f9f9f9; font-weight: bold; width: 150px;">Name:</td>
                    <td style="padding: 10px;">${formData.name}</td>
                  </tr>
                  <tr>
                    <td style="padding: 10px; background-color: #f9f9f9; font-weight: bold;">Phone:</td>
                    <td style="padding: 10px;"><a href="tel:${formData.phone}" style="color: #F5C400; text-decoration: none; font-size: 18px; font-weight: bold;">${formData.phone}</a></td>
                  </tr>
                  ${formData.email ? `
                  <tr>
                    <td style="padding: 10px; background-color: #f9f9f9; font-weight: bold;">Email:</td>
                    <td style="padding: 10px;"><a href="mailto:${formData.email}" style="color: #F5C400; text-decoration: none;">${formData.email}</a></td>
                  </tr>
                  ` : ''}
                  <tr>
                    <td style="padding: 10px; background-color: #f9f9f9; font-weight: bold;">Postcode:</td>
                    <td style="padding: 10px; font-size: 16px; font-weight: bold; color: #1a1a1a;">${formData.postcode}</td>
                  </tr>
                </table>

                <h2 style="color: #1a1a1a; border-bottom: 2px solid #F5C400; padding-bottom: 10px; margin-top: 30px;">Vehicle Information</h2>
                <table style="width: 100%; margin: 20px 0;">
                  <tr>
                    <td style="padding: 10px; background-color: #f9f9f9; font-weight: bold; width: 150px;">Vehicle:</td>
                    <td style="padding: 10px; font-size: 16px; font-weight: bold;">${formData.vehicle}</td>
                  </tr>
                  <tr>
                    <td style="padding: 10px; background-color: #f9f9f9; font-weight: bold;">Year:</td>
                    <td style="padding: 10px;">${formData.year || 'Not specified'}</td>
                  </tr>
                  <tr>
                    <td style="padding: 10px; background-color: #f9f9f9; font-weight: bold;">Service:</td>
                    <td style="padding: 10px; color: #F5C400; font-weight: bold;">${getServiceName(formData.service)}</td>
                  </tr>
                </table>

                ${formData.message ? `
                <h2 style="color: #1a1a1a; border-bottom: 2px solid #F5C400; padding-bottom: 10px; margin-top: 30px;">Additional Details</h2>
                <div style="padding: 15px; background-color: #f9f9f9; margin: 20px 0; border-left: 4px solid #F5C400;">
                  ${formData.message.replace(/\n/g, '<br>')}
                </div>
                ` : ''}

                <div style="margin-top: 30px; padding: 20px; background-color: #F5C400; text-align: center;">
                  <p style="margin: 0; color: #1a1a1a; font-size: 14px;">
                    <strong>🚨 RESPOND WITHIN 2 HOURS FOR BEST CONVERSION RATE</strong>
                  </p>
                </div>
              </div>

              <div style="text-align: center; padding: 20px; color: #666; font-size: 12px;">
                <p>Submitted from: carnageremaps.com quote form</p>
              </div>
            </div>
          `
        };
        
        transporter.sendMail(mailOptions, (error, info) => {
          if (error) {
            console.error('Email error:', error);
            res.writeHead(302, { 
              'Location': '/?quote=error',
              'Access-Control-Allow-Origin': '*'
            });
            res.end();
          } else {
            console.log('Quote email sent:', info.response);
            res.writeHead(302, { 
              'Location': '/?quote=success',
              'Access-Control-Allow-Origin': '*'
            });
            res.end();
          }
        });
      } catch (error) {
        console.error('Error processing quote form:', error);
        res.writeHead(302, { 
          'Location': '/?quote=error',
          'Access-Control-Allow-Origin': '*'
        });
        res.end();
      }
    });
    return;
  }

  // Normalize URL
  urlPath = req.url.split('?')[0]; // Remove query params
  
  // Handle root
  if (urlPath === '/') {
    urlPath = '/index.html';
  }

  let filePath = path.join(__dirname, urlPath);

  // Security: prevent directory traversal
  if (!filePath.startsWith(__dirname)) {
    res.writeHead(403, { 'Content-Type': 'text/plain' });
    res.end('Forbidden');
    return;
  }

  // Check if file exists
  fs.stat(filePath, (err, stats) => {
    if (err || !stats.isFile()) {
      // If not found, serve index.html (for SPA-like routing)
      filePath = path.join(__dirname, 'index.html');
    }

    fs.readFile(filePath, (err, data) => {
      if (err) {
        res.writeHead(404, { 'Content-Type': 'text/html' });
        res.end('<h1>404 Not Found</h1>');
        console.error(`404: ${req.url}`);
        return;
      }

      const ext = path.extname(filePath).toLowerCase();
      const contentType = mimeTypes[ext] || 'application/octet-stream';

      // Set appropriate headers
      const headers = {
        'Content-Type': contentType,
        'Access-Control-Allow-Origin': '*',
      };

      // Cache static assets with Expires headers
      if (['.css', '.js', '.png', '.jpg', '.jpeg', '.gif', '.svg', '.woff', '.woff2', '.ico'].includes(ext)) {
        const maxAge = 2592000; // 30 days in seconds
        headers['Cache-Control'] = `public, max-age=${maxAge}`;
        // Add Expires header (30 days from now)
        const expiryDate = new Date(Date.now() + maxAge * 1000);
        headers['Expires'] = expiryDate.toUTCString();
      } else {
        const maxAge = 3600; // 1 hour in seconds
        headers['Cache-Control'] = `public, max-age=${maxAge}`;
        // Add Expires header (1 hour from now)
        const expiryDate = new Date(Date.now() + maxAge * 1000);
        headers['Expires'] = expiryDate.toUTCString();
      }

      res.writeHead(200, headers);
      res.end(data);
    });
  });
});

server.on('error', (err) => {
  console.error('Server error:', err);
  process.exit(1);
});

server.listen(PORT, HOST, () => {
  console.log(`✅ Carnage Remaps website running`);
  console.log(`🔥 Listening on ${HOST}:${PORT}`);
  console.log(`📍 http://localhost:${PORT}`);
});

// Graceful shutdown
process.on('SIGTERM', () => {
  console.log('SIGTERM received, shutting down gracefully...');
  server.close(() => {
    console.log('Server closed');
    process.exit(0);
  });
});

