// src/services/emailTemplate.js
// Centralized branded HTML email template for HorsePortal.net

const SITE_URL = process.env.APP_WEB_URL || 'https://horseportal.net';
const LOGO_URL = 'https://horseportal.net/images/logos/horseportal-logo-website-formated.png';

// Brand colors
const COLORS = {
    primary: '#171411',       // dark main color for header & buttons
    primaryLight: '#2a241e',  // slightly lighter for subtle gradient
    accent: '#f6a623',        // gold accent
    bg: '#fdf8f4',            // warm off-white
    cardBg: '#ffffff',
    text: '#171411',          // dark text matching primary
    muted: '#5a4a40',         // muted brown
    border: '#e8ddd4',        // light border
    footerBg: '#f5ede4',
};

// Translated footer disclaimer
const AUTO_DISCLAIMER = {
    lv: 'Šis ir automātisks paziņojums. Lūdzu, neatbildiet uz šo e-pastu.',
    lt: 'Tai automatinis pranešimas. Prašome neatsakyti į šį el. laišką.',
    ru: 'Это автоматическое уведомление. Пожалуйста, не отвечайте на это письмо.',
    ee: 'See on automaatne teade. Palun ärge vastake sellele e-kirjale.',
    en: 'This is an automated notification. Please do not reply to this email.',
};

/**
 * Wrap content in the branded email layout.
 *
 * @param {object} opts
 * @param {string} [opts.lang]           - Language code (en/lv/lt/ru/ee), defaults to 'en'
 * @param {string} opts.preheader        - Short preview text (shown in email clients)
 * @param {string} opts.bodyHtml         - Main inner HTML (paragraphs, etc.)
 * @param {string} [opts.ctaLabel]       - Button label (optional)
 * @param {string} [opts.ctaUrl]         - Button URL (optional)
 * @param {string} [opts.footerNote]     - Extra small text below footer
 * @returns {string}                     - Full email HTML
 */
function buildEmail({ lang = 'en', preheader = '', bodyHtml, ctaLabel, ctaUrl, footerNote }) {
    const disclaimer = AUTO_DISCLAIMER[lang] || AUTO_DISCLAIMER['en'];

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
<html lang="${lang}">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width,initial-scale=1.0" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <title>HorsePortal.net</title>
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

          <!-- Header bar with logo -->
          <tr>
            <td align="center"
                style="background:linear-gradient(135deg,${COLORS.primary} 0%,${COLORS.primaryLight} 100%);padding:24px 32px 20px;">
              <a href="${SITE_URL}" target="_blank" style="display:inline-block;text-decoration:none;">
                <img src="${LOGO_URL}"
                     alt="HorsePortal"
                     width="200"
                     style="display:block;height:auto;border:0;max-width:200px;"
                     onerror="this.style.display='none'" />
              </a>
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
            <td bgcolor="${COLORS.footerBg}" style="padding:16px 36px 20px;border-radius:0 0 12px 12px;">
              <table width="100%" cellpadding="0" cellspacing="0" border="0">
                <tr>
                  <td style="font-family:Arial,sans-serif;font-size:12px;color:${COLORS.muted};line-height:1.6;text-align:center;">
                    ${footerNote ? `<span style="opacity:0.8;">${footerNote}</span><br/>` : ''}
                    <span style="opacity:0.65;font-size:11px;">${disclaimer}</span>
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
 * @param {string} [lang]   - Language code
 */
function buildOtpEmail(bodyText, otp, lang = 'en') {
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
        lang,
        preheader: `Your verification code: ${otp}`,
        bodyHtml: body,
        footerNote: null
    });
}

/**
 * Build a CTA (call-to-action) button email — password reset, SSO info, etc.
 * @param {string} bodyText  - Main paragraph text
 * @param {string} btnLabel  - Button label
 * @param {string} btnUrl    - Button URL
 * @param {string} preheader - Short preview text
 * @param {string} [lang]    - Language code
 */
function buildCtaEmail(bodyText, btnLabel, btnUrl, preheader, lang = 'en') {
    const body = `<p style="margin:0 0 8px;">${bodyText}</p>`;
    return buildEmail({
        lang,
        preheader: preheader || bodyText.replace(/<[^>]+>/g, '').slice(0, 80),
        bodyHtml: body,
        ctaLabel: btnLabel,
        ctaUrl: btnUrl,
        footerNote: null
    });
}

/**
 * Build a generic notification email (favorites, new listings, forum replies, etc.)
 * @param {string} bodyHtml      - Main HTML content (paragraphs)
 * @param {string} [ctaLabel]    - Optional button label
 * @param {string} [ctaUrl]      - Optional button URL
 * @param {string} [preheader]   - Preview text
 * @param {string} [lang]        - Language code
 */
function buildNotificationEmail(bodyHtml, ctaLabel, ctaUrl, preheader, lang = 'en') {
    return buildEmail({
        lang,
        preheader: preheader || '',
        bodyHtml,
        ctaLabel,
        ctaUrl
    });
}

module.exports = { buildEmail, buildOtpEmail, buildCtaEmail, buildNotificationEmail };
