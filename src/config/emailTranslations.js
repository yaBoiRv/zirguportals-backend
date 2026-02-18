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
        price: "Price",

        new_announcement_subject: (title) => `New Announcement: ${title}`,
        read_more: "Read more"
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
        price: "Cena",

        new_announcement_subject: (title) => `Jauns paziņojums: ${title}`,
        read_more: "Lasīt vairāk"
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
        price: "Цена",

        new_announcement_subject: (title) => `Новое объявление: ${title}`,
        read_more: "Читать далее"
    }
};

module.exports = {
    getTranslation: (lang, key) => {
        const l = translations[lang] || translations['en'];
        return l[key] || translations['en'][key];
    }
};
