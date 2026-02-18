const { Resend } = require('resend');

/**
 * Send an email notification
 * @param {string} to - Recipient email
 * @param {string} subject - Email subject
 * @param {string} html - Email HTML content
 * @returns {Promise<void>}
 */
async function sendEmail({ to, subject, html }) {
    // Initialize Resend lazily to ensure process.env is loaded
    const apiKey = process.env.RESEND_API_KEY;

    if (!apiKey) {
        console.error('❌ CRITICAL: RESEND_API_KEY is NOT set in environment variables. Email sending disabled.');
        return;
    }

    const resend = new Resend(apiKey);
    const from = process.env.EMAIL_FROM || 'info@horseportal.net';

    console.log(`📧 Attempting to send email to ${to} from ${from}...`);

    try {
        const data = await resend.emails.send({
            from,
            to,
            subject,
            html
        });

        if (data.error) {
            console.error('❌ Resend API Error:', JSON.stringify(data.error, null, 2));
        } else {
            console.log(`✅ Email sent successfully to ${to}. ID: ${data.data?.id}`);
        }
    } catch (error) {
        console.error('❌ Failed to send email (Exception):', error);
    }
}

module.exports = { sendEmail };
