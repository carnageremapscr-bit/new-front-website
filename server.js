const http = require('http');
const fs = require('fs');
const path = require('path');
const nodemailer = require('nodemailer');
const querystring = require('querystring');

const PORT = parseInt(process.env.PORT || '8080');
const HOST = '0.0.0.0'; // Listen on all interfaces for Railway

// Email configuration
const transporter = nodemailer.createTransport({
  service: 'gmail',
  auth: {
    user: process.env.EMAIL_USER || 'carnageremaps@gmail.com',
    pass: process.env.EMAIL_PASS || '' // Use app-specific password
  }
});

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

const server = http.createServer((req, res) => {
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
          to: process.env.EMAIL_USER || 'carnageremaps@gmail.com',
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
        if (!process.env.EMAIL_PASS) {
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

  // Normalize URL
  let urlPath = req.url.split('?')[0]; // Remove query params
  
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

      // Cache static assets
      if (['.css', '.js', '.png', '.jpg', '.jpeg', '.gif', '.svg', '.woff', '.woff2', '.ico'].includes(ext)) {
        headers['Cache-Control'] = 'public, max-age=86400'; // 24 hours
      } else {
        headers['Cache-Control'] = 'public, max-age=3600'; // 1 hour
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

