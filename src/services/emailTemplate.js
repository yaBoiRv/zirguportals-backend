// src/services/emailTemplate.js
// Centralized branded HTML email template for HorsePortal.net

const SITE_URL = process.env.APP_WEB_URL || 'https://horseportal.net';
const BRAND_NAME = 'HorsePortal.net';

// Brand colors (equestrian brown/amber theme from index.css)
const COLORS = {
    primary: '#9a4509',       // hsl(28, 85%, 35%)
    primaryLight: '#c9722a',  // hsl(28, 65%, 47%)
    accent: '#f6a623',        // hsl(32, 95%, 55%)
    bg: '#fdf8f4',            // warm off-white
    cardBg: '#ffffff',
    text: '#3d2008',          // hsl(28, 25%, 15%) - dark brown
    muted: '#7a5c40',         // muted brown
    border: '#e8ddd4',        // hsl(42, 20%, 88%)
    footerBg: '#f5ede4',
};

/**
 * Wrap content in the branded email layout.
 *
 * @param {object} opts
 * @param {string} opts.preheader        - Short preview text (shown in email clients)
 * @param {string} opts.bodyHtml         - Main inner HTML (paragraphs, etc.)
 * @param {string} [opts.ctaLabel]       - Button label (optional)
 * @param {string} [opts.ctaUrl]         - Button URL (optional)
 * @param {string} [opts.footerNote]     - Extra small text below footer logo
 * @returns {string}                     - Full email HTML
 */
function buildEmail({ preheader = '', bodyHtml, ctaLabel, ctaUrl, footerNote }) {
    const cta = ctaLabel && ctaUrl ? `
        <table cellpadding="0" cellspacing="0" border="0" style="margin:28px auto 0;">
            <tr>
                <td align="center" bgcolor="${COLORS.primary}" style="border-radius:8px;">
                    <a href="${ctaUrl}"
                       target="_blank"
                       style="display:inline-block;padding:14px 32px;font-family:Arial,sans-serif;font-size:15px;font-weight:bold;color:#ffffff;text-decoration:none;border-radius:8px;letter-spacing:0.3px;">
                        ${ctaLabel}
                    </a>
                </td>
            </tr>
        </table>` : '';

    return `<!DOCTYPE html>
<html lang="lv">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width,initial-scale=1.0" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <title>${BRAND_NAME}</title>
  <!--[if mso]>
  <noscript><xml><o:OfficeDocumentSettings><o:PixelsPerInch>96</o:PixelsPerInch></o:OfficeDocumentSettings></xml></noscript>
  <![endif]-->
</head>
<body style="margin:0;padding:0;background-color:${COLORS.bg};font-family:Arial,'Helvetica Neue',Helvetica,sans-serif;">

  <!-- Preheader (hidden preview text) -->
  <div style="display:none;max-height:0;overflow:hidden;mso-hide:all;font-size:1px;color:${COLORS.bg};">
    ${preheader}&nbsp;&zwnj;&nbsp;&zwnj;&nbsp;&zwnj;&nbsp;&zwnj;&nbsp;&zwnj;&nbsp;&zwnj;&nbsp;&zwnj;
  </div>

  <!-- Outer wrapper -->
  <table width="100%" cellpadding="0" cellspacing="0" border="0"
         style="background-color:${COLORS.bg};padding:32px 12px 48px;">
    <tr>
      <td align="center">

        <!-- Main card (max 560px) -->
        <table width="100%" cellpadding="0" cellspacing="0" border="0"
               style="max-width:560px;border-radius:12px;overflow:hidden;box-shadow:0 4px 24px rgba(154,69,9,0.12);">

          <!-- Header bar -->
          <tr>
            <td align="center"
                style="background:linear-gradient(135deg,${COLORS.primary} 0%,${COLORS.primaryLight} 100%);padding:28px 32px 22px;">
              <table cellpadding="0" cellspacing="0" border="0">
                <tr>
                  <td style="padding-right:10px;vertical-align:middle;">
                    <!-- Horse icon SVG (inline, email-safe) -->
                    <div style="width:40px;height:40px;background:rgba(255,255,255,0.20);border-radius:50%;display:inline-flex;align-items:center;justify-content:center;">
                      <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="#ffffff" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <path d="M2 16s2-2 5-2 5 2 8 2 5-2 5-2"/>
                        <path d="M12 2C9 2 7 4 7 7c0 2 1 4 2.5 5H7l-2 4h14l-2-4h-2.5C16 11 17 9 17 7c0-3-2-5-5-5z"/>
                      </svg>
                    </div>
                  </td>
                  <td style="vertical-align:middle;">
                    <span style="font-family:Arial,sans-serif;font-size:22px;font-weight:bold;color:#ffffff;letter-spacing:-0.3px;">
                      HorsePortal<span style="color:${COLORS.accent};">.net</span>
                    </span>
                  </td>
                </tr>
              </table>
            </td>
          </tr>

          <!-- Body -->
          <tr>
            <td bgcolor="${COLORS.cardBg}" style="padding:36px 36px 28px;">
              <table width="100%" cellpadding="0" cellspacing="0" border="0">
                <tr>
                  <td style="font-family:Arial,sans-serif;font-size:15px;line-height:1.7;color:${COLORS.text};">
                    ${bodyHtml}
                    ${cta}
                  </td>
                </tr>
              </table>
            </td>
          </tr>

          <!-- Divider -->
          <tr>
            <td bgcolor="${COLORS.cardBg}" style="padding:0 36px;">
              <hr style="border:none;border-top:1px solid ${COLORS.border};margin:0;" />
            </td>
          </tr>

          <!-- Footer -->
          <tr>
            <td bgcolor="${COLORS.footerBg}" style="padding:20px 36px 24px;border-radius:0 0 12px 12px;">
              <table width="100%" cellpadding="0" cellspacing="0" border="0">
                <tr>
                  <td style="font-family:Arial,sans-serif;font-size:12px;color:${COLORS.muted};line-height:1.6;text-align:center;">
                    <strong>
                      <a href="${SITE_URL}" style="color:${COLORS.primary};text-decoration:none;">${BRAND_NAME}</a>
                    </strong>
                    &nbsp;— Horse Marketplace in the Baltics<br/>
                    ${footerNote ? `<span style="opacity:0.8;">${footerNote}</span><br/>` : ''}
                    <span style="opacity:0.65;font-size:11px;">
                      Šis ir automātisks paziņojums. Lūdzu, neatbildiet uz šo e-pastu.
                    </span>
                  </td>
                </tr>
              </table>
            </td>
          </tr>

        </table>
        <!-- /Main card -->

      </td>
    </tr>
  </table>
  <!-- /Outer wrapper -->

</body>
</html>`;
}

/**
 * Build an OTP / verification code email.
 * @param {string} bodyText - Translated intro sentence
 * @param {string} otp      - 6-digit code
 */
function buildOtpEmail(bodyText, otp) {
    const body = `
        <p style="margin:0 0 20px;">${bodyText}</p>
        <table cellpadding="0" cellspacing="0" border="0" style="margin:8px auto 24px;width:100%;">
          <tr>
            <td align="center" bgcolor="#fdf1e3"
                style="padding:20px 32px;border-radius:10px;border:2px dashed ${COLORS.accent};">
              <span style="font-family:'Courier New',Courier,monospace;font-size:34px;font-weight:bold;
                           letter-spacing:10px;color:${COLORS.primary};">${otp}</span>
            </td>
          </tr>
        </table>
    `;
    return buildEmail({
        preheader: `Your verification code: ${otp}`,
        bodyHtml: body,
        footerNote: 'Code valid for 15 minutes.'
    });
}

/**
 * Build a CTA (call-to-action) button email — password reset, SSO info, etc.
 * @param {string} bodyText  - Main paragraph text
 * @param {string} btnLabel  - Button label
 * @param {string} btnUrl    - Button URL
 * @param {string} preheader - Short preview text
 */
function buildCtaEmail(bodyText, btnLabel, btnUrl, preheader) {
    const body = `<p style="margin:0 0 8px;">${bodyText}</p>`;
    return buildEmail({
        preheader: preheader || bodyText.replace(/<[^>]+>/g, '').slice(0, 80),
        bodyHtml: body,
        ctaLabel: btnLabel,
        ctaUrl: btnUrl,
        footerNote: 'This link expires in 1 hour.'
    });
}

/**
 * Build a generic notification email (favorites, new listings, forum replies, etc.)
 * @param {string} bodyHtml      - Main HTML content (paragraphs)
 * @param {string} [ctaLabel]    - Optional button label
 * @param {string} [ctaUrl]      - Optional button URL
 * @param {string} [preheader]   - Preview text
 */
function buildNotificationEmail(bodyHtml, ctaLabel, ctaUrl, preheader) {
    return buildEmail({
        preheader: preheader || '',
        bodyHtml,
        ctaLabel,
        ctaUrl
    });
}

module.exports = { buildEmail, buildOtpEmail, buildCtaEmail, buildNotificationEmail };
