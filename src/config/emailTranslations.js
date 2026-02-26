const translations = {
    en: {
        forum_reply_subject: "New reply to your topic",
        forum_reply_body: (replierName, topicTitle) => `${replierName} replied to "${topicTitle}"`,
        forum_reply_comment_subject: "New reply to your comment",
        forum_reply_comment_body: (replierName, topicTitle) => `${replierName} replied to your comment in "${topicTitle}"`,
        view_topic: "View Topic",

        chat_subject: "New Message on Horse Portal",
        chat_body: "You have a new message from a user.",
        view_message: "View Message",

        favorite_listing_subject: "Someone favorited your listing!",
        favorite_listing_body: (title) => `A user favorited your listing "${title}".`,
        view_listing: "View Listing",

        favorite_service_subject: "Someone favorited your service!",
        favorite_service_body: (name) => `A user favorited your service "${name}".`,
        view_service: "View Service",

        favorite_trainer_subject: "Someone favorited your trainer profile!",
        favorite_trainer_body: (name) => `A user favorited your trainer profile "${name}".`,
        view_profile: "View Profile",

        new_listing_subject: (title) => `New Listing: ${title}`,
        new_listing_body: (title) => `A new horse listing has been posted: <strong>${title}</strong>`,
        new_equipment_body: (title) => `A new equipment listing has been posted: <strong>${title}</strong>`,
        price: "Price",

        new_announcement_subject: (title) => `New Announcement: ${title}`,
        read_more: "Read more",
        new_service_subject: (title) => `New Service: ${title}`,
        new_service_body: (title) => `A new service listing has been posted: <strong>${title}</strong>`,
        new_trainer_subject: (title) => `New Trainer Profile: ${title}`,
        new_trainer_body: (title) => `A new trainer profile has been created: <strong>${title}</strong>`,

        forgot_password_subject: "Password Reset Request",
        forgot_password_body: "You recently requested to reset your password for your Horse Portal account. Click the button below to reset it. This link is only valid for 1 hour. If you did not request a password reset, please ignore this email.",
        reset_password_btn: "Reset Password",

        sso_password_reset_subject: "Horse Portal Login Info",
        sso_password_reset_body: "You requested a password reset, but you created this account using Google. Please return to Horse Portal and click the 'Continue with Google' button to log in.",
        sso_login_btn: "Return to Website",
    },
    lv: {
        forum_reply_subject: "Jauna atbilde jūsu tēmā",
        forum_reply_body: (replierName, topicTitle) => `${replierName} atbildēja uz "${topicTitle}"`,
        forum_reply_comment_subject: "Jauna atbilde uz jūsu komentāru",
        forum_reply_comment_body: (replierName, topicTitle) => `${replierName} atbildēja uz jūsu komentāru tēmā "${topicTitle}"`,
        view_topic: "Skatīt tēmu",

        chat_subject: "Jauna ziņa Horse Portal",
        chat_body: "Jums pienākusi jauna ziņa no lietotāja.",
        view_message: "Skatīt ziņu",

        favorite_listing_subject: "Kāds pievienoja jūsu sludinājumu favorītiem!",
        favorite_listing_body: (title) => `Lietotājs pievienoja jūsu sludinājumu "${title}" favorītiem.`,
        view_listing: "Skatīt sludinājumu",

        favorite_service_subject: "Kāds pievienoja jūsu pakalpojumu favorītiem!",
        favorite_service_body: (name) => `Lietotājs pievienoja jūsu pakalpojumu "${name}" favorītiem.`,
        view_service: "Skatīt pakalpojumu",

        favorite_trainer_subject: "Kāds pievienoja jūsu trenera profilu favorītiem!",
        favorite_trainer_body: (name) => `Lietotājs pievienoja jūsu trenera profilu "${name}" favorītiem.`,
        view_profile: "Skatīt profilu",

        new_listing_subject: (title) => `Jauns sludinājums: ${title}`,
        new_listing_body: (title) => `Pievienots jauns zirga sludinājums: <strong>${title}</strong>`,
        new_equipment_body: (title) => `Pievienots jauns ekipējuma sludinājums: <strong>${title}</strong>`,
        price: "Cena",

        new_announcement_subject: (title) => `Jauns paziņojums: ${title}`,
        read_more: "Lasīt vairāk",
        new_service_subject: (title) => `Jauns pakalpojums: ${title}`,
        new_service_body: (title) => `Pievienots jauns pakalpojums: <strong>${title}</strong>`,
        new_trainer_subject: (title) => `Jauns treneris: ${title}`,
        new_trainer_body: (title) => `Izveidots jauns trenera profils: <strong>${title}</strong>`,

        forgot_password_subject: "Paroles atiestatīšanas pieprasījums",
        forgot_password_body: "Jūs nesen pieprasījāt atiestatīt savu Horse Portal konta paroli. Noklikšķiniet uz zemāk esošās pogas, lai to atiestatītu. Šī saite ir derīga tikai 1 stundu. Ja neesat pieprasījis paroles atiestatīšanu, lūdzu, ignorējiet šo e-pastu.",
        reset_password_btn: "Atiestatīt paroli",

        sso_password_reset_subject: "Horse Portal pieteikšanās informācija",
        sso_password_reset_body: "Jūs pieprasījāt paroles atiestatīšanu, taču šis konts tika izveidots, izmantojot Google. Lūdzu, atgriezieties Horse Portal un noklikšķiniet uz pogas 'Turpināt ar Google', lai pieteiktos.",
        sso_login_btn: "Atgriezties mājaslapā",
    },
    ru: {
        forum_reply_subject: "Новый ответ в вашей теме",
        forum_reply_body: (replierName, topicTitle) => `${replierName} ответил в "${topicTitle}"`,
        forum_reply_comment_subject: "Новый ответ на ваш комментарий",
        forum_reply_comment_body: (replierName, topicTitle) => `${replierName} ответил на ваш комментарий в "${topicTitle}"`,
        view_topic: "Посмотреть тему",

        chat_subject: "Новое сообщение на Horse Portal",
        chat_body: "У вас новое сообщение от пользователя.",
        view_message: "Посмотреть сообщение",

        favorite_listing_subject: "Кто-то добавил ваше объявление в избранное!",
        favorite_listing_body: (title) => `Пользователь добавил ваше объявление "${title}" в избранное.`,
        view_listing: "Посмотреть объявление",

        favorite_service_subject: "Кто-то добавил вашу услугу в избранное!",
        favorite_service_body: (name) => `Пользователь добавил вашу услугу "${name}" в избранное.`,
        view_service: "Посмотреть услугу",

        favorite_trainer_subject: "Кто-то добавил ваш профиль тренера в избранное!",
        favorite_trainer_body: (name) => `Пользователь добавил ваш профиль тренера "${name}" в избранное.`,
        view_profile: "Посмотреть профиль",

        new_listing_subject: (title) => `Новое объявление: ${title}`,
        new_listing_body: (title) => `Опубликовано новое объявление о продаже лошади: <strong>${title}</strong>`,
        new_equipment_body: (title) => `Опубликовано новое объявление (экипировка): <strong>${title}</strong>`,
        price: "Цена",

        new_announcement_subject: (title) => `Новое уведомление: ${title}`, // Added hint to distinguish
        read_more: "Читать далее",
        new_service_subject: (title) => `Новая услуга: ${title}`,
        new_service_body: (title) => `Добавлена новая услуга: <strong>${title}</strong>`,
        new_trainer_subject: (title) => `Новый тренер: ${title}`,
        new_trainer_body: (title) => `Создан новый профиль тренера: <strong>${title}</strong>`,

        forgot_password_subject: "Запрос на сброс пароля",
        forgot_password_body: "Вы недавно запросили сброс пароля для вашей учетной записи на Horse Portal. Нажмите на кнопку ниже, чтобы сбросить его. Эта ссылка действительна только 1 час. Если вы не запрашивали сброс пароля, просто проигнорируйте это письмо.",
        reset_password_btn: "Сбросить пароль",

        sso_password_reset_subject: "Информация для входа на Horse Portal",
        sso_password_reset_body: "Вы запросили сброс пароля, но эта учетная запись была создана с помощью Google. Пожалуйста, вернитесь на Horse Portal и нажмите кнопку 'Продолжить с Google' для входа.",
        sso_login_btn: "Вернуться на сайт",
    },
    ee: {
        forum_reply_subject: "Uus vastus teie teemale",
        forum_reply_body: (replierName, topicTitle) => `${replierName} vastas teemale "${topicTitle}"`,
        forum_reply_comment_subject: "Uus vastus teie kommentaarile",
        forum_reply_comment_body: (replierName, topicTitle) => `${replierName} vastas teie kommentaarile teemas "${topicTitle}"`,
        view_topic: "Vaata teemat",

        chat_subject: "Uus sõnum Horse Portal'is",
        chat_body: "Teil on uus sõnum kasutajalt.",
        view_message: "Vaata sõnumit",

        favorite_listing_subject: "Keegi lisas teie kuulutuse lemmikutesse!",
        favorite_listing_body: (title) => `Kasutaja lisas teie kuulutuse "${title}" lemmikutesse.`,
        view_listing: "Vaata kuulutust",

        favorite_service_subject: "Keegi lisas teie teenuse lemmikutesse!",
        favorite_service_body: (name) => `Kasutaja lisas teie teenuse "${name}" lemmikutesse.`,
        view_service: "Vaata teenust",

        favorite_trainer_subject: "Keegi lisas teie treeneriprofiili lemmikutesse!",
        favorite_trainer_body: (name) => `Kasutaja lisas teie treeneriprofiili "${name}" lemmikutesse.`,
        view_profile: "Vaata profiili",

        new_listing_subject: (title) => `Uus kuulutus: ${title}`,
        new_listing_body: (title) => `Lisatud uus hobuse müügikuulutus: <strong>${title}</strong>`,
        new_equipment_body: (title) => `Lisati uus varustuse kuulutus: <strong>${title}</strong>`,
        price: "Hind",

        new_announcement_subject: (title) => `Uus teadaanne: ${title}`,
        read_more: "Loe edasi",
        new_service_subject: (title) => `Uus teenus: ${title}`,
        new_service_body: (title) => `Lisati uus teenus: <strong>${title}</strong>`,
        new_trainer_subject: (title) => `Uus treener: ${title}`,
        new_trainer_body: (title) => `Loodi uus treeneri profiil: <strong>${title}</strong>`,

        forgot_password_subject: "Parooli lähtestamise taotlus",
        forgot_password_body: "Te taotlesite hiljuti oma Horse Portal konto parooli lähtestamist. Klõpsake allpool oleval nupul uue parooli määramiseks. See link on kehtiv ainult 1 tund. Kui te ei ole parooli lähtestamist taotlenud, palun ignoreerige seda e-kirja.",
        reset_password_btn: "Lähtesta parool",

        sso_password_reset_subject: "Horse Portal sisselogimise teave",
        sso_password_reset_body: "Te taotlesite parooli lähtestamist, kuid see konto loodi Google'i kaudu. Palun minge tagasi Horse Portalisse ja klõpsake sisselogimiseks nuppu 'Jätka Google'iga'.",
        sso_login_btn: "Tagasi veebilehele",
    },
    lt: {
        forum_reply_subject: "Naujas atsakymas jūsų temoje",
        forum_reply_body: (replierName, topicTitle) => `${replierName} atsakė į "${topicTitle}"`,
        forum_reply_comment_subject: "Naujas atsakymas į jūsų komentarą",
        forum_reply_comment_body: (replierName, topicTitle) => `${replierName} atsakė į jūsų komentarą temoje "${topicTitle}"`,
        view_topic: "Peržiūrėti temą",

        chat_subject: "Nauja žinutė Horse Portal",
        chat_body: "Gavote naują žinutę iš vartotojo.",
        view_message: "Peržiūrėti žinutę",

        favorite_listing_subject: "Kažkas pamėgo jūsų skelbimą!",
        favorite_listing_body: (title) => `Vartotojas pamėgo jūsų skelbimą "${title}".`,
        view_listing: "Peržiūrėti skelbimą",

        favorite_service_subject: "Kažkas pamėgo jūsų paslaugą!",
        favorite_service_body: (name) => `Vartotojas pamėgo jūsų paslaugą "${name}".`,
        view_service: "Peržiūrėti paslaugą",

        favorite_trainer_subject: "Kažkas pamėgo jūsų trenerio profilį!",
        favorite_trainer_body: (name) => `Vartotojas pamėgo jūsų trenerio profilį "${name}".`,
        view_profile: "Peržiūrėti profilį",

        new_listing_subject: (title) => `Naujas skelbimas: ${title}`,
        new_listing_body: (title) => `Įkeltas naujas žirgo pardavimo skelbimas: <strong>${title}</strong>`,
        new_equipment_body: (title) => `Įdėtas naujas įrangos skelbimas: <strong>${title}</strong>`,
        price: "Kaina",

        new_announcement_subject: (title) => `Naujas pranešimas: ${title}`,
        read_more: "Skaityti daugiau",
        new_service_subject: (title) => `Nauja paslauga: ${title}`,
        new_service_body: (title) => `Įdėta nauja paslauga: <strong>${title}</strong>`,
        new_trainer_subject: (title) => `Naujas treneris: ${title}`,
        new_trainer_body: (title) => `Sukurtas naujas trenerio profilis: <strong>${title}</strong>`,

        forgot_password_subject: "Slaptažodžio keitimo prašymas",
        forgot_password_body: "Neseniai paprašėte pakeisti „Horse Portal“ paskyros slaptažodį. Paspauskite žemiau esantį mygtuką, norėdami jį pakeisti. Ši nuoroda galioja tik 1 valandą. Jei neprašėte pakeisti slaptažodžio, tiesiog ignoruokite šį el. laišką.",
        reset_password_btn: "Pakeisti slaptažodį",

        sso_password_reset_subject: "Horse Portal prisijungimo informacija",
        sso_password_reset_body: "Paprašėte pakeisti slaptažodį, tačiau ši paskyra buvo sukurta naudojant „Google“. Grįžkite į „Horse Portal“ ir spustelėkite mygtuką „Tęsti su Google“, kad prisijungtumėte.",
        sso_login_btn: "Grįžti į svetainę",
    }
};

module.exports = {
    getTranslation: (lang, key) => {
        // Fallback to 'en' if language not found
        const l = translations[lang] || translations['en'];
        // Fallback to 'en' key if key not found in language
        return l[key] || translations['en'][key] || key;
    }
};
