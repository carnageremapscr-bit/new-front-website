# Email Configuration Setup Guide - IMPORTANT

## Current Status: ⚠️ EMAIL NOT WORKING

The quote form is currently showing an error because the `EMAIL_PASS` environment variable is not configured on your Railway deployment.

---

## The Problem

When users submit the quote form, the server tries to send an email but fails because:
- ❌ `EMAIL_PASS` environment variable is missing
- ❌ Email credentials are not set in Railway.app

---

## How to Fix It (Step-by-Step)

### Step 1: Generate Google App Password

1. Go to your Gmail account: https://myaccount.google.com/
2. Click **Security** in the left sidebar
3. Scroll down to **App passwords** (requires 2-factor authentication to be enabled)
4. Select **Mail** and **Windows Computer** (or your device)
5. Google will generate a 16-character password
6. **Copy this password** (you'll need it next)

**Example password**: `abcd efgh ijkl mnop`

### Step 2: Add to Railway Environment Variables

1. Go to your Railway project: https://railway.app/dashboard
2. Click on your **new-front-website** project
3. Go to the **Variables** tab
4. Click **Add Variable**
5. Set the following variables:

```
EMAIL_USER = carnageremaps@gmail.com
EMAIL_PASS = abcd efgh ijkl mnop
```

*Replace the `EMAIL_PASS` value with the one Google generated in Step 1*

### Step 3: Redeploy Your Website

1. After adding variables, Railway will automatically redeploy
2. Wait for deployment to complete (watch the logs)
3. Test the quote form again

---

## How the Form Works (Once Fixed)

```
User fills form → Submits → Server receives data → 
Sends email to carnageremaps@gmail.com → 
Shows success message "Quote received, we'll call within 2 hours"
```

### What You'll Receive

When a user submits the quote form, you'll get an email with:

✅ Customer name  
✅ Phone number (clickable link)  
✅ Email address (if provided)  
✅ Postcode (for location)  
✅ Vehicle make & model  
✅ Vehicle year  
✅ Service requested  
✅ Additional details/message  

---

## Testing the Form

### Before Fix (Current)
Form shows: ❌ "Sorry, there was an error. Please call us directly at 07546 371963"

### After Fix
Form shows: ✅ "Thank you! Your quote request has been received. We'll call you within 2 hours!"

---

## Troubleshooting

### If It's Still Not Working After Setup

**Check Your Gmail Security:**
1. Go to https://myaccount.google.com/security
2. Verify 2-factor authentication is ON
3. Check "App passwords" section has the password listed

**Check Railway Variables:**
1. Go to Railway dashboard
2. Click your project
3. Go to Variables tab
4. Verify `EMAIL_USER` = `carnageremaps@gmail.com`
5. Verify `EMAIL_PASS` = your 16-character password (no spaces)

**Check Deployment:**
1. In Railway, check the "Deployments" tab
2. Verify the latest deployment shows "Succeeded"
3. If not, click the failed deployment and check logs

**Manual Email Test:**
Send a test request with your phone to verify:
```
Name: John Smith
Phone: 07546 371963
Email: test@example.com
Vehicle: BMW 320d
Year: 2018
Service: Stage 1
```

---

## Email Details

**From:** carnageremaps@gmail.com  
**To:** carnageremaps@gmail.com (your business email)  
**Subject:** 🔥 NEW QUOTE REQUEST - [Vehicle Name]  
**Format:** HTML with formatted table of customer details

---

## Important Notes

⚠️ **Do NOT share your EMAIL_PASS publicly**
- Keep it secret in Railway's Variables section only
- Never put it in code or GitHub
- Use only App Passwords, not your regular Gmail password

✅ **The Email Is Configured For:**
- Gmail/Google Workspace only
- Sending to carnageremaps@gmail.com
- Quote form submissions only

---

## Railway Dashboard Quick Links

- **Project Variables**: https://railway.app/project/[project-id]/variables
- **Deployments**: https://railway.app/project/[project-id]/deployments
- **Logs**: https://railway.app/project/[project-id]/logs

---

## What's In server.js

The server.js file handles:
1. ✅ Receiving form submissions from `/send-quote` endpoint
2. ✅ Parsing form data (name, phone, email, vehicle, service, etc.)
3. ✅ Creating formatted HTML email
4. ✅ Sending via Gmail/nodemailer
5. ✅ Redirecting to success/error page

---

## Data Captured From Form

When configured, the form captures:
- Customer Name (required)
- Phone Number (required)
- Email Address (optional)
- Postcode (required)
- Vehicle Make & Model (required)
- Vehicle Year (required)
- Service Required (required)
- Additional Details (optional)

All data is formatted into a professional email and sent to you.

---

## Timeline After Fix

1. **Immediately**: Quote form will start working
2. **Upon submission**: Email sent to your inbox within seconds
3. **User sees**: Success message + call within 2 hours promise
4. **You get**: All customer data in professional formatted email

---

## Next Steps

1. ✅ Generate Google App Password (follow Step 1 above)
2. ✅ Add EMAIL_PASS to Railway Variables (follow Step 2)
3. ✅ Wait for deployment to complete
4. ✅ Test the form with a test submission
5. ✅ Check your email inbox for the quote request

**Once working, you'll receive all user submissions automatically!**

---

## Contact Support

If you need help:
- Railway Support: https://railway.app/support
- Gmail Help: https://support.google.com/accounts
- Check server logs in Railway dashboard for error messages

---

## Current Form Data (Not Being Sent)

The form IS capturing data correctly, but it's NOT being emailed because EMAIL_PASS is missing. The data is being logged to your Railway console, but you won't receive emails until the variable is set.

Check your Railway logs to see captured form submissions until email is configured.
