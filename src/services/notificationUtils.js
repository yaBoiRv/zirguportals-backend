// src/services/notificationUtils.js
const { sendEmail } = require('./emailService');
const { getTranslation } = require('../config/emailTranslations');

async function broadcastNewListing(prisma, type, b, listingId, userId) {
    try {
        console.log(`[NotificationUtils] Broadcasting email for new ${type} listing`);
        const allUsers = await prisma.user.findMany({
            where: { id: { not: userId } },
            include: { profile: true }
        });
        console.log(`[NotificationUtils] Found ${allUsers.length} potential recipients for ${type}`);

        let title = b.name || b.title || b.full_name || 'New Listing';
        let notificationType = 'new_listing_in_area';
        let notificationTitle = 'New Listing';
        let subjectKey = 'new_listing_subject';
        let bodyKey = 'new_listing_body';
        let typePath = type;

        if (type === 'horse') {
            notificationTitle = 'New Horse Listing';
            typePath = 'horses';
        } else if (type === 'equipment') {
            notificationTitle = 'New Equipment Listing';
            bodyKey = 'new_equipment_body';
        } else if (type === 'service') {
            notificationType = 'new_service';
            notificationTitle = 'New Service Listing';
            subjectKey = 'new_service_subject';
            bodyKey = 'new_service_body';
            typePath = 'services';
        } else if (type === 'trainer') {
            notificationType = 'new_trainer';
            notificationTitle = 'New Trainer Listing';
            subjectKey = 'new_trainer_subject';
            bodyKey = 'new_trainer_body';
            typePath = 'trainers';
        }

        (async () => {
            for (const r of allUsers) {
                const prefs = r.profile?.notificationPreferences || {};
                const emailEnabled = prefs.new_listings_email ?? prefs.new_listings ?? false;

                if (r.email && emailEnabled === true) {
                    const lang = r.profile?.defaultLanguage || 'en';

                    const subjectFn = getTranslation(lang, subjectKey);
                    const subject = typeof subjectFn === 'function' ? subjectFn(title) : subjectFn;

                    const bodyFn = getTranslation(lang, bodyKey);
                    const body = typeof bodyFn === 'function' ? bodyFn(title) : bodyFn;

                    const priceLabel = getTranslation(lang, 'price');

                    let viewListingKey = 'view_listing';
                    if (type === 'service') viewListingKey = 'view_service';
                    if (type === 'trainer') viewListingKey = 'view_trainer';

                    const viewListing = getTranslation(lang, viewListingKey);
                    const listingUrl = `${process.env.APP_WEB_URL}/${lang}/${typePath}/${listingId}`;

                    const desc = b.description || b.bio || b.biography || '';

                    let html = `<p>${body}</p>`;
                    if (desc) {
                        html += `<p>${desc.substring(0, 100) + '...'}</p>`;
                    }
                    if (type === 'horse' || type === 'equipment') {
                        html += `<p>${priceLabel}: ${b.price || 'N/A'} ${b.currency || 'EUR'}</p>`;
                    } else if (type === 'service' || type === 'trainer') {
                        if (b.hourly_rate) {
                            html += `<p>${b.hourly_rate} EUR/hr</p>`;
                        }
                    }
                    html += `<p><a href="${listingUrl}">${viewListing}</a></p>`;

                    await sendEmail({
                        to: r.email,
                        subject: subject,
                        html: html
                    });
                    await new Promise(res => setTimeout(res, 600));
                }
            }
        })();
    } catch (e) {
        console.error(`Error sending new ${type} emails:`, e);
    }
}

module.exports = { broadcastNewListing };
