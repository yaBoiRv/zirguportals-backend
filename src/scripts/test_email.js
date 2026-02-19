require('dotenv').config({ path: require('path').join(__dirname, '../../.env') });
const { sendEmail } = require('../services/emailService');

(async () => {
    console.log('Testing sendEmail...');
    console.log('API KEY:', process.env.RESEND_API_KEY ? 'Set' : 'Missing');
    // console.log('API KEY Val:', process.env.RESEND_API_KEY); // DEBUG ONLY - Remove in prod

    try {
        // Use a dummy email if needed, or specific test email
        const target = 'info@zirgu-portals.lv';
        console.log(`Sending to ${target}...`);

        const res = await sendEmail({
            to: target,
            subject: 'Test Email from Script',
            html: '<p>This is a test email sent from the backend script.</p>'
        });
        console.log('Result:', res);
    } catch (e) {
        console.error('Error sending email:', e);
    }
})();
