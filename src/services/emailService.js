const { Resend } = require('resend');

let resend = null;
if (process.env.RESEND_API_KEY) {
    resend = new Resend(process.env.RESEND_API_KEY);
} else {
    console.warn('RESEND_API_KEY is not set. Email sending disabled.');
}

/**
 * Send an email notification
 * @param {string} to - Recipient email
 * @param {string} subject - Email subject
 * @param {string} html - Email HTML content
 * @returns {Promise<void>}
 */
async function sendEmail({ to, subject, html }) {
    if (!resend) return;

    try {
        const from = process.env.EMAIL_FROM || 'Horse Portal <info@horseportal.lv>';
        // If using 'onboarding@resend.dev', 'to' must be the verified email.
        // Assuming user has valid domain or understands limitations.

        // Fallback for dev: if no verified domain, maybe log only? 
        // But user asked to implement.

        const data = await resend.emails.send({
            from,
            to,
            subject,
            html
        });

        if (data.error) {
            console.error('Resend API Error:', data.error);
        } else {
            console.log(`Email sent to ${to}: ${subject}`, data);
        }
    } catch (error) {
        console.error('Failed to send email:', error);
    }
}

module.exports = { sendEmail };
