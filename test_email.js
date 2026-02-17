const path = require("path");
require('dotenv').config({ path: path.join(__dirname, '.env') });
const { sendEmail } = require('./src/services/emailService');

// Usually run from root c:\zirguportals-backend
// If emailService.js expects RESEND_API_KEY it will try to send.

async function test() {
    console.log('Sending test email...');
    try {
        const res = await sendEmail({
            to: 'janis@horseportal.lv', // Placeholder? Or ask user email? 
            // I'll use a placeholder and verify log output.
            subject: 'Test Notification',
            html: '<p>This is a test email from Zirgu Portals Backend.</p>'
        });
        console.log('Done.');
    } catch (e) {
        console.error('Test failed:', e);
    }
}

test();
