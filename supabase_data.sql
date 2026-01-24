--
-- PostgreSQL database dump
--

\restrict KyNaziLaJC9yfohdqlf6qXCb4CtqzOI7aJAMJtozPdDRY25HX9wYYX7yc9Or1Yo

-- Dumped from database version 17.4
-- Dumped by pg_dump version 17.7 (Debian 17.7-3.pgdg13+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Data for Name: announcement_categories; Type: TABLE DATA; Schema: public; Owner: -
--

SET SESSION AUTHORIZATION DEFAULT;

ALTER TABLE public.announcement_categories DISABLE TRIGGER ALL;

COPY public.announcement_categories (id, key, icon) FROM stdin;
1	general	megaphone
2	competitions	trophy
3	events	calendar-days
7	health_care	heart-pulse
\.


ALTER TABLE public.announcement_categories ENABLE TRIGGER ALL;

--
-- Data for Name: announcement_category_translations; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.announcement_category_translations DISABLE TRIGGER ALL;

COPY public.announcement_category_translations (id, category_id, lang_code, name) FROM stdin;
16	1	lv	Vispārīgi
17	1	en	General
18	1	lt	Bendra
19	1	ee	Üldine
20	1	ru	Общее
21	2	lv	Sacensības
22	2	en	Competitions
23	2	lt	Varžybos
24	2	ee	Võistlused
25	2	ru	Соревнования
26	3	lv	Pasākumi
27	3	en	Events
28	3	lt	Renginiai
29	3	ee	Sündmused
30	3	ru	События
46	7	lv	Veselība un aprūpe
47	7	en	Health & Care
48	7	lt	Sveikata ir priežiūra
49	7	ee	Tervis ja hooldus
50	7	ru	Здоровье и уход
\.


ALTER TABLE public.announcement_category_translations ENABLE TRIGGER ALL;

--
-- Data for Name: profiles; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.profiles DISABLE TRIGGER ALL;

COPY public.profiles (id, user_id, name, avatar_url, phone, created_at, updated_at, username, has_trainer_profile, notification_preferences, default_language) FROM stdin;
3c206cb7-800b-41e2-95ce-82e0145e38a2	37bc011e-0f0e-49b8-8b3e-e0f03ec8fd86	Anna Marta Freimane	\N	\N	2025-09-02 17:54:53.733127+00	2025-09-05 12:46:45.535595+00	amf	f	{"favorites": true, "new_listings": true, "chat_messages": true, "first_login_done": false}	en
7bb2b6e5-c490-44ed-b20c-5cb13c3a655e	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	Raimunds Vanags	\N	\N	2025-09-05 16:33:28.363505+00	2025-12-21 16:22:16.937606+00	janis1	t	{"favorites": true, "new_listings": true, "chat_messages": true, "favorites_push": true, "favorites_email": true, "first_login_done": true, "new_listings_push": true, "chat_messages_push": true, "new_listings_email": true, "chat_messages_email": true, "forum_replies_email": true, "forum_mentions_email": true, "new_announcements_push": true, "new_announcements_email": true}	en
f84254c1-e585-4443-b82f-bc6bc887766b	5e2d54d4-10bb-440a-a5c4-7e489a721625	Anna	\N	\N	2025-11-01 19:13:39.834376+00	2025-11-01 19:13:39.834376+00	\N	f	{"favorites": true, "new_listings": true, "chat_messages": true, "first_login_done": false}	en
208ab088-e1a4-4867-8a0a-44d5c8d1d6dc	413d6728-bb68-4ebd-bd39-5b484d37312b	Raimunds	https://qetsvjfknresvkogwlmi.supabase.co/storage/v1/object/public/profile-pics/413d6728-bb68-4ebd-bd39-5b484d37312b-1767454878802.jpg	\N	2025-08-28 15:52:57.72433+00	2026-01-03 15:41:18.59508+00	raimis	t	{"favorites": true, "new_listings": true, "chat_messages": false, "favorites_push": true, "favorites_email": true, "first_login_done": true, "new_announcements": true, "new_listings_push": true, "chat_messages_push": false, "new_listings_email": true, "chat_messages_email": true, "forum_replies_email": true, "forum_mentions_email": true, "new_announcements_push": true, "new_announcements_email": true}	en
737a558d-5190-4fe7-8218-709940f015e3	dd064976-574e-485a-9837-0b7719e448dd	dženifera academy	\N	\N	2026-01-03 16:10:31.904798+00	2026-01-03 16:10:31.904798+00	\N	f	{"favorites": true, "new_listings": true, "chat_messages": true, "first_login_done": false}	en
a721f6fa-3bd4-4095-a173-95df45016722	4a396c17-b4f4-4f7c-b86c-997c10b44d61	Rage Bodybuilding	\N	\N	2025-12-04 17:25:12.884541+00	2025-12-04 17:25:12.884541+00	\N	f	{"favorites": true, "new_listings": true, "chat_messages": true, "first_login_done": false}	en
897af8ef-a53b-4728-a553-da91f5ad35f6	9aa05bb0-8e55-4f47-a9b6-3e7950dd9b32	list420	\N	\N	2026-01-03 17:56:48.708384+00	2026-01-03 17:56:48.708384+00	\N	f	{"favorites": true, "new_listings": true, "chat_messages": true, "first_login_done": false}	en
1769574a-4cf4-4c14-bb09-04c3ddf11535	e9d792ec-1edd-4905-8eef-b3a018d5de35	pagerlatvia	\N	\N	2026-01-05 16:44:03.762017+00	2026-01-05 16:46:40.830656+00	\N	f	{"favorites": true, "new_listings": true, "chat_messages": true, "first_login_done": true}	en
\.


ALTER TABLE public.profiles ENABLE TRIGGER ALL;

--
-- Data for Name: announcements; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.announcements DISABLE TRIGGER ALL;

COPY public.announcements (id, title, content, category, is_pinned, created_at, updated_at, user_id, images, files, pinned_until) FROM stdin;
f9d2ef75-8a96-46e1-8958-d020b7b822a4	eeeeeeeeeeeeeeeee	eeeeeeeeeeee	general	f	2025-11-30 09:52:11.09132+00	2025-11-30 09:52:11.09132+00	413d6728-bb68-4ebd-bd39-5b484d37312b	{}	{https://qetsvjfknresvkogwlmi.supabase.co/storage/v1/object/public/forum-files/forum/7c76h97awm2-1764496295091.jpg,https://qetsvjfknresvkogwlmi.supabase.co/storage/v1/object/public/forum-files/forum/un2of9pz2yh-1764496295574.webp,https://qetsvjfknresvkogwlmi.supabase.co/storage/v1/object/public/forum-files/forum/7bw741dyncq-1764496302601.docx}	\N
93b8d289-62f7-4204-92c4-906303f671c2	kkkkkkk	kkkkkkk	general	f	2025-12-14 15:45:50.461168+00	2025-12-14 15:45:50.461168+00	413d6728-bb68-4ebd-bd39-5b484d37312b	{}	{}	\N
44500baf-5dbd-4e94-a722-eabf5dba500e	jjjjjjjjjjjjjjjjjjj	jjjjjjjjjjj	health_care	t	2025-12-14 17:38:08.462611+00	2025-12-14 17:38:08.462611+00	413d6728-bb68-4ebd-bd39-5b484d37312b	{}	{}	2025-12-15 17:38:09.022+00
11246480-a8c6-41aa-83e7-50818229e36a	dddddddddddddddddddddddddhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh	dddddddddddddddddddhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh	competitions	f	2025-11-28 15:26:18.852121+00	2025-12-16 21:34:13.276865+00	413d6728-bb68-4ebd-bd39-5b484d37312b	{}	{}	\N
ba72521f-5852-4a38-8837-4c0c54bf8354	Sacensības pirmdien	VIsi laiki atrodami citā mājaslapā	general	t	2025-12-14 19:52:05.115326+00	2025-12-16 21:54:13.32736+00	413d6728-bb68-4ebd-bd39-5b484d37312b	{}	{https://qetsvjfknresvkogwlmi.supabase.co/storage/v1/object/public/forum-files/forum/zr5tasa6hen-1765741890786.jpg,https://qetsvjfknresvkogwlmi.supabase.co/storage/v1/object/public/forum-files/forum/1nd9t6fmi9h-1765741891300.docx,https://qetsvjfknresvkogwlmi.supabase.co/storage/v1/object/public/forum-files/forum/es5ups867d-1765743769500.jpg,https://qetsvjfknresvkogwlmi.supabase.co/storage/v1/object/public/forum-files/forum/v59g6ymks7s-1765743769878.jpg,https://qetsvjfknresvkogwlmi.supabase.co/storage/v1/object/public/forum-files/forum/xs28elwd8tf-1765743770136.jpg}	2025-12-17 21:54:13.135+00
f7868bd5-9551-49f6-8d24-6c2a1de8c408	sxdcfvghjkl;	sdfghjikolp;	general	f	2025-12-20 18:02:35.250043+00	2025-12-20 18:02:35.250043+00	413d6728-bb68-4ebd-bd39-5b484d37312b	{}	{}	\N
6407e701-ec0b-4262-bffc-09aa1b44eb17	ddddddddddddddddd	ddddddddddddd	general	f	2025-12-21 18:14:27.832495+00	2025-12-21 18:14:27.832495+00	413d6728-bb68-4ebd-bd39-5b484d37312b	{}	{}	\N
\.


ALTER TABLE public.announcements ENABLE TRIGGER ALL;

--
-- Data for Name: blog_posts; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.blog_posts DISABLE TRIGGER ALL;

COPY public.blog_posts (id, user_id, title, content, excerpt, featured_image_url, slug, status, published_at, created_at, updated_at) FROM stdin;
1973d1bf-16b8-4a95-adff-bf4bf4d2c20f	413d6728-bb68-4ebd-bd39-5b484d37312b	vijbfls;nd	<h3>Testkvn mg<br>frfrfrf</h3><p></p>	Kas šis ir	\N	vijbflsnd	published	2025-09-05 12:31:46.8+00	2025-09-05 12:31:46.969641+00	2025-09-05 12:31:46.969641+00
2b8de010-b412-4d16-8c2d-3b49b4d8e71d	413d6728-bb68-4ebd-bd39-5b484d37312b	eeeeeeeeeee	<h2></h2><p>eeeeeeeeee</p>	eeeeeeeeeee	\N	eeeeeeeeeee	published	2025-10-04 10:01:02.275+00	2025-09-14 10:58:26.273945+00	2025-10-04 10:01:03.09134+00
16f58e10-93e9-40bc-878e-9298c72f9fba	413d6728-bb68-4ebd-bd39-5b484d37312b	test	<p>fjnsvpnnjffknvfsvpfknvsvkfsfkvsfmvsfgggggggggggggggggg</p>	 vrigariga rigariga rigariga rigariga	\N	test	published	2025-10-04 10:02:11.746+00	2025-09-23 06:20:05.888123+00	2025-10-04 10:02:12.586345+00
\.


ALTER TABLE public.blog_posts ENABLE TRIGGER ALL;

--
-- Data for Name: chats; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.chats DISABLE TRIGGER ALL;

COPY public.chats (id, participant_1_id, participant_2_id, source_type, source_id, created_at, updated_at) FROM stdin;
2c19ee1d-7e28-41f8-9e2c-3a10209509ea	413d6728-bb68-4ebd-bd39-5b484d37312b	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	equipment_listing	ade3d46e-f9c2-420b-b4e9-edc1e07843f4	2025-12-21 17:30:42.708869+00	2025-12-23 21:06:24.085056+00
1f5ea624-df43-40ff-9f05-5acd39af8dc2	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	413d6728-bb68-4ebd-bd39-5b484d37312b	service	968b60d1-6aac-44a1-ad9b-7b5892a3ad65	2025-11-26 21:28:35.376453+00	2025-11-26 21:28:35.376453+00
7fab5ead-d37a-4e45-966e-359d10da8e16	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	413d6728-bb68-4ebd-bd39-5b484d37312b	service	8766418a-efd3-4481-a73c-c68b5e87cf94	2025-11-24 18:04:50.304124+00	2025-12-19 14:27:25.393823+00
8e0900f2-5350-433d-81a6-5fbbc8b3a357	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	413d6728-bb68-4ebd-bd39-5b484d37312b	trainer	8b8822db-eb82-4399-b063-5bf576dd4688	2025-12-23 21:09:20.437321+00	2025-12-23 21:19:32.342463+00
01999fd6-1b1e-49b4-9774-8bae5a988ec1	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	413d6728-bb68-4ebd-bd39-5b484d37312b	equipment_listing	fc1d0aa5-1e37-4dab-8719-b60af8596334	2025-12-21 17:33:33.769492+00	2025-12-23 21:19:38.306289+00
637088c4-03bb-4a26-b5b1-8ceb0f2bd925	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	413d6728-bb68-4ebd-bd39-5b484d37312b	service	28b786e5-83ba-4cdb-a114-79d16032e79d	2025-12-19 14:28:03.159716+00	2026-01-05 20:06:42.142003+00
047d0b3a-1d75-452b-96ae-65c3dd018550	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	413d6728-bb68-4ebd-bd39-5b484d37312b	trainer	0adc8dff-d11a-4b20-8c1b-f595d9057bb7	2025-11-23 13:07:39.60146+00	2025-11-23 13:07:39.60146+00
917f3f8b-180a-421e-804d-730613cba2c1	413d6728-bb68-4ebd-bd39-5b484d37312b	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	equipment_listing	d7d545a5-978f-4573-b2bb-543a3be160a4	2025-11-22 12:43:12.152434+00	2026-01-11 17:52:41.275416+00
48ab27cd-affd-4105-8628-a6354c76a3e2	413d6728-bb68-4ebd-bd39-5b484d37312b	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	equipment_listing	72799f8c-e7af-4263-a526-d4b8ef11a83a	2025-12-06 11:12:53.213952+00	2025-12-06 11:13:28.578577+00
ced5a8bb-26f7-45b0-b94b-611ebfe86580	413d6728-bb68-4ebd-bd39-5b484d37312b	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	trainer	22ac7434-eaa0-4a0a-8f7b-6471191417df	2025-11-24 16:25:43.907395+00	2025-12-06 12:22:35.078451+00
06de900c-01ce-408b-95ca-498a4a60b0e3	413d6728-bb68-4ebd-bd39-5b484d37312b	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	service	d3cc6623-8753-40a2-9231-2568d1ba12b5	2025-12-21 18:21:02.817523+00	2025-12-21 18:23:37.038459+00
85526295-6c52-40f8-8764-d64c2c0e9db9	413d6728-bb68-4ebd-bd39-5b484d37312b	37bc011e-0f0e-49b8-8b3e-e0f03ec8fd86	equipment_listing	8b85e009-c7f4-4636-b613-87fba176cf48	2025-12-17 20:05:48.057859+00	2025-12-23 18:14:32.561892+00
4646df06-8976-4668-a9fa-0594ed6131b2	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	413d6728-bb68-4ebd-bd39-5b484d37312b	trainer	8766418a-efd3-4481-a73c-c68b5e87cf94	2025-11-24 16:20:02.813605+00	2025-11-24 16:20:12.016145+00
7e8ea114-b2c6-4190-804e-4b16477c60d5	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	413d6728-bb68-4ebd-bd39-5b484d37312b	trainer	968b60d1-6aac-44a1-ad9b-7b5892a3ad65	2025-11-24 16:22:11.962265+00	2025-11-24 16:22:11.962265+00
6f5b574b-d798-441d-a4fd-2731b3950375	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	37bc011e-0f0e-49b8-8b3e-e0f03ec8fd86	equipment_listing	8b85e009-c7f4-4636-b613-87fba176cf48	2025-11-13 17:29:32.830817+00	2025-11-25 16:32:55.775193+00
\.


ALTER TABLE public.chats ENABLE TRIGGER ALL;

--
-- Data for Name: chat_messages; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.chat_messages DISABLE TRIGGER ALL;

COPY public.chat_messages (id, chat_id, sender_id, message, created_at, read_at, files) FROM stdin;
26c60f14-615d-4846-9767-f9f4af0d73e7	01999fd6-1b1e-49b4-9774-8bae5a988ec1	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	vvv	2025-12-21 17:33:42.369079+00	2026-01-03 16:52:05.286+00	\N
42555878-767a-40e5-ba22-dadd3aa41b83	917f3f8b-180a-421e-804d-730613cba2c1	413d6728-bb68-4ebd-bd39-5b484d37312b	Yo	2025-11-22 12:43:20.980921+00	2025-11-23 13:06:54.069+00	\N
8d187c28-4678-4f0b-bac6-91f5ba74eb5e	917f3f8b-180a-421e-804d-730613cba2c1	413d6728-bb68-4ebd-bd39-5b484d37312b	cc	2025-11-23 15:12:45.14807+00	2025-11-24 16:21:32.445+00	\N
01148593-aa92-4b1e-9efe-c8f60324dabe	917f3f8b-180a-421e-804d-730613cba2c1	413d6728-bb68-4ebd-bd39-5b484d37312b	c	2025-11-23 15:12:46.733729+00	2025-11-24 16:21:32.445+00	\N
be40b672-e1f1-4326-98ac-b91443148776	917f3f8b-180a-421e-804d-730613cba2c1	413d6728-bb68-4ebd-bd39-5b484d37312b	c	2025-11-23 15:12:47.634676+00	2025-11-24 16:21:32.445+00	\N
3a0a2852-9712-4cde-b703-4bf5a17e40d9	917f3f8b-180a-421e-804d-730613cba2c1	413d6728-bb68-4ebd-bd39-5b484d37312b	c	2025-11-23 15:12:49.02529+00	2025-11-24 16:21:32.445+00	\N
5c312fd4-b8fb-43df-a213-ea6a158a320d	917f3f8b-180a-421e-804d-730613cba2c1	413d6728-bb68-4ebd-bd39-5b484d37312b	c	2025-11-23 15:12:51.63326+00	2025-11-24 16:21:32.445+00	\N
0795a17d-73a8-4f1f-a8c9-43df76c936a0	917f3f8b-180a-421e-804d-730613cba2c1	413d6728-bb68-4ebd-bd39-5b484d37312b	c	2025-11-23 15:12:52.544689+00	2025-11-24 16:21:32.445+00	\N
3e3bf8eb-29cf-49ab-a598-4f4a2935ca49	917f3f8b-180a-421e-804d-730613cba2c1	413d6728-bb68-4ebd-bd39-5b484d37312b	c	2025-11-23 15:12:53.323845+00	2025-11-24 16:21:32.445+00	\N
efa82129-3d2a-42f5-8c45-9901234f788a	917f3f8b-180a-421e-804d-730613cba2c1	413d6728-bb68-4ebd-bd39-5b484d37312b	c	2025-11-23 15:12:54.580284+00	2025-11-24 16:21:32.445+00	\N
ebbfcbc1-ee82-4126-9402-c7a34c9cd1ce	4646df06-8976-4668-a9fa-0594ed6131b2	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	tst	2025-11-24 16:20:12.016145+00	2025-11-24 16:26:06.562+00	\N
6a53d1d3-1469-48e5-aa57-7c22612cacb0	ced5a8bb-26f7-45b0-b94b-611ebfe86580	413d6728-bb68-4ebd-bd39-5b484d37312b	r	2025-11-24 16:26:16.377174+00	2025-11-24 17:22:54.021+00	\N
c6fb37e4-ea1d-46a1-a125-1778be238dfd	7fab5ead-d37a-4e45-966e-359d10da8e16	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	test	2025-11-24 18:04:57.280879+00	2025-11-25 15:20:51.435+00	\N
72efd753-9c27-40c2-91d3-092808b3a147	6f5b574b-d798-441d-a4fd-2731b3950375	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	yo ir vēl	2025-11-25 16:32:55.775193+00	\N	\N
7f20a721-a0cc-40da-93b3-283bf3a75327	917f3f8b-180a-421e-804d-730613cba2c1	413d6728-bb68-4ebd-bd39-5b484d37312b	ddd	2025-11-27 17:26:05.159544+00	2025-12-06 11:07:47.644+00	\N
9e4c0118-8306-457f-8514-938a304cfdb8	917f3f8b-180a-421e-804d-730613cba2c1	413d6728-bb68-4ebd-bd39-5b484d37312b	dddfd	2025-12-01 21:27:31.002311+00	2025-12-06 11:07:47.644+00	\N
8671b3b7-5b1d-4f3b-9c2f-50220dfc6da1	917f3f8b-180a-421e-804d-730613cba2c1	413d6728-bb68-4ebd-bd39-5b484d37312b	ddddddddddd	2025-12-01 21:44:35.619774+00	2025-12-06 11:07:47.644+00	\N
49656f22-fd86-43a1-a8f2-6a5b1c8f9ed7	917f3f8b-180a-421e-804d-730613cba2c1	413d6728-bb68-4ebd-bd39-5b484d37312b	ddddddddddddddddddddddddddd	2025-12-01 21:44:58.636932+00	2025-12-06 11:07:47.644+00	\N
e3246393-f1a9-4209-8df5-066ca59ba9eb	48ab27cd-affd-4105-8628-a6354c76a3e2	413d6728-bb68-4ebd-bd39-5b484d37312b	hmmm	2025-12-06 11:12:57.129378+00	2025-12-06 11:13:22.657+00	\N
dad9c1e0-3248-4dc6-b77b-2b0d781f03c4	48ab27cd-affd-4105-8628-a6354c76a3e2	413d6728-bb68-4ebd-bd39-5b484d37312b	toma toma?	2025-12-06 11:13:04.056965+00	2025-12-06 11:13:22.657+00	\N
b198f18c-2630-45c1-bc30-71d21f36715d	48ab27cd-affd-4105-8628-a6354c76a3e2	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	nopirka	2025-12-06 11:13:28.578577+00	2025-12-06 11:16:00.979+00	\N
9e047e05-65d6-4ac3-88b9-076f7f458525	ced5a8bb-26f7-45b0-b94b-611ebfe86580	413d6728-bb68-4ebd-bd39-5b484d37312b	fff	2025-12-06 12:22:35.078451+00	2025-12-14 16:07:11.403+00	\N
4a35ad06-a4db-41a4-a231-43a46ffe97e0	917f3f8b-180a-421e-804d-730613cba2c1	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	kas i	2025-12-14 16:09:28.920927+00	2025-12-16 19:45:07.356+00	\N
5113e035-4444-4996-a9e0-9d8c07eb0f79	917f3f8b-180a-421e-804d-730613cba2c1	413d6728-bb68-4ebd-bd39-5b484d37312b	tttt	2025-12-18 21:47:51.671043+00	2025-12-18 22:05:46.873+00	\N
8760b45d-8138-4081-b7f5-30d0e29711b9	7fab5ead-d37a-4e45-966e-359d10da8e16	413d6728-bb68-4ebd-bd39-5b484d37312b	FFF	2025-12-17 17:48:25.317271+00	2025-12-18 22:06:10.448+00	\N
df581959-d1a2-4efc-9143-f09a0938fac8	7fab5ead-d37a-4e45-966e-359d10da8e16	413d6728-bb68-4ebd-bd39-5b484d37312b	fff	2025-12-17 17:06:29.473247+00	2025-12-18 22:06:10.448+00	\N
53b91006-6d7e-4525-a0f4-bdd3442667c2	7fab5ead-d37a-4e45-966e-359d10da8e16	413d6728-bb68-4ebd-bd39-5b484d37312b	ff	2025-12-17 17:06:30.682034+00	2025-12-18 22:06:10.448+00	\N
c698d623-40f7-454a-87f1-4e07402e1b49	7fab5ead-d37a-4e45-966e-359d10da8e16	413d6728-bb68-4ebd-bd39-5b484d37312b	ff	2025-12-17 17:06:31.763316+00	2025-12-18 22:06:10.448+00	\N
f0998ea6-2491-4b41-a06e-31ad9bbfe1cc	7fab5ead-d37a-4e45-966e-359d10da8e16	413d6728-bb68-4ebd-bd39-5b484d37312b	f	2025-12-17 17:06:33.047779+00	2025-12-18 22:06:10.448+00	\N
59f028a2-0690-4f06-b1e2-9c87e098cab2	7fab5ead-d37a-4e45-966e-359d10da8e16	413d6728-bb68-4ebd-bd39-5b484d37312b	ff	2025-12-17 17:06:34.651142+00	2025-12-18 22:06:10.448+00	\N
320deb56-ebfc-41ac-9867-0c492b392981	7fab5ead-d37a-4e45-966e-359d10da8e16	413d6728-bb68-4ebd-bd39-5b484d37312b	FF	2025-12-17 17:48:21.806305+00	2025-12-18 22:06:10.448+00	\N
03906c8a-688a-4a6c-8d27-4e170b66f5c2	7fab5ead-d37a-4e45-966e-359d10da8e16	413d6728-bb68-4ebd-bd39-5b484d37312b	fffffffff	2025-12-17 18:04:41.974755+00	2025-12-18 22:06:10.448+00	\N
38582418-7d47-482e-9653-bda96ba24acc	7fab5ead-d37a-4e45-966e-359d10da8e16	413d6728-bb68-4ebd-bd39-5b484d37312b	ffffffffffffffffffffffffffffffffffffffff	2025-12-17 18:04:44.824622+00	2025-12-18 22:06:10.448+00	\N
9ba4c83b-1fb1-417d-a4b9-c3b60af0a00c	7fab5ead-d37a-4e45-966e-359d10da8e16	413d6728-bb68-4ebd-bd39-5b484d37312b	ffffffffffffffffffffff	2025-12-17 18:04:46.373875+00	2025-12-18 22:06:10.448+00	\N
710702ed-0fd4-4689-a4fd-d885c3c97ae7	7fab5ead-d37a-4e45-966e-359d10da8e16	413d6728-bb68-4ebd-bd39-5b484d37312b	ffffffffffffffffffffff	2025-12-17 18:04:47.80176+00	2025-12-18 22:06:10.448+00	\N
a2f61a7b-5650-4264-8a05-3c0a1e82fc02	7fab5ead-d37a-4e45-966e-359d10da8e16	413d6728-bb68-4ebd-bd39-5b484d37312b	ffffffffffffffffffff	2025-12-17 18:04:48.959776+00	2025-12-18 22:06:10.448+00	\N
19cbcc10-9fea-4b98-abba-f2048f50665e	7fab5ead-d37a-4e45-966e-359d10da8e16	413d6728-bb68-4ebd-bd39-5b484d37312b	fffffffffffffffffffff	2025-12-17 18:04:50.162286+00	2025-12-18 22:06:10.448+00	\N
71bddcd6-c7de-4a6a-9032-ff94d0ab57ae	7fab5ead-d37a-4e45-966e-359d10da8e16	413d6728-bb68-4ebd-bd39-5b484d37312b		2025-12-17 21:17:43.749232+00	2025-12-18 22:06:10.448+00	[{"url": "https://qetsvjfknresvkogwlmi.supabase.co/storage/v1/object/public/chat-files/413d6728-bb68-4ebd-bd39-5b484d37312b/1766006262598-5zfzub.xlsx", "name": "Copy of Progr_tehn_2024_PKE_audzēkņiem(1).xlsx", "size": 325507, "type": "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"}, {"url": "https://qetsvjfknresvkogwlmi.supabase.co/storage/v1/object/public/chat-files/413d6728-bb68-4ebd-bd39-5b484d37312b/1766006263201-bp9fcf.png", "name": "final-pic.png", "size": 94229, "type": "image/png"}]
ef1a242d-d87e-4353-a556-6fe79a35de65	7fab5ead-d37a-4e45-966e-359d10da8e16	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	sss	2025-12-18 22:06:35.919124+00	2025-12-18 22:07:12.173+00	\N
80d2c6f6-e071-4d3e-a32c-27bbb9b4faf7	7fab5ead-d37a-4e45-966e-359d10da8e16	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	nnnnnnnnnnnn	2025-12-18 22:08:02.850786+00	2025-12-19 14:25:31.252+00	\N
1240bf28-8374-43c5-bb46-db65dc316a42	7fab5ead-d37a-4e45-966e-359d10da8e16	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	pieejams?	2025-12-19 14:27:15.35848+00	\N	\N
64745407-61a6-499d-a2ee-95c3843ecdb6	7fab5ead-d37a-4e45-966e-359d10da8e16	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	aight	2025-12-19 14:27:25.393823+00	\N	\N
7b4163b1-76f6-48a0-8645-b91764db4b49	917f3f8b-180a-421e-804d-730613cba2c1	413d6728-bb68-4ebd-bd39-5b484d37312b	gribu	2025-12-21 16:20:36.098269+00	2025-12-21 16:38:38.393+00	\N
87f3fa1d-cbe7-4ec0-b5ac-be9e2392019c	637088c4-03bb-4a26-b5b1-8ceb0f2bd925	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	ttt\\	2025-12-19 14:28:11.475337+00	2025-12-21 16:49:27.038+00	\N
9629a459-51ad-47c4-a7aa-8e69766e3fe4	637088c4-03bb-4a26-b5b1-8ceb0f2bd925	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	ddd	2025-12-20 17:14:42.224583+00	2025-12-21 16:49:27.038+00	\N
b7fd3724-9634-47f8-8a46-ab2b20061523	637088c4-03bb-4a26-b5b1-8ceb0f2bd925	413d6728-bb68-4ebd-bd39-5b484d37312b	nu nav	2025-12-21 16:49:32.124125+00	2025-12-23 17:52:00.9+00	\N
036c18ca-7c81-4082-b75c-aa732c9f8593	2c19ee1d-7e28-41f8-9e2c-3a10209509ea	413d6728-bb68-4ebd-bd39-5b484d37312b	zxfghj	2025-12-21 17:30:46.853921+00	2025-12-23 17:53:04.857+00	\N
dc09d09f-ff04-47e8-b839-9c4814c701ec	2c19ee1d-7e28-41f8-9e2c-3a10209509ea	413d6728-bb68-4ebd-bd39-5b484d37312b	sssssssssssssssssssss	2025-12-21 18:03:51.677873+00	2025-12-23 17:53:04.857+00	\N
b9168c5b-b2f4-4731-bfd8-0e3a5f7a5d9f	2c19ee1d-7e28-41f8-9e2c-3a10209509ea	413d6728-bb68-4ebd-bd39-5b484d37312b	d	2025-12-21 18:09:01.34729+00	2025-12-23 17:53:04.857+00	\N
afc304ae-72ed-4ffc-8340-54e9b5015065	917f3f8b-180a-421e-804d-730613cba2c1	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	ir	2025-12-21 16:38:42.792194+00	2025-12-21 18:09:03.112+00	\N
123bb024-6ee2-43a8-8f75-495fc4f541af	917f3f8b-180a-421e-804d-730613cba2c1	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	eu	2025-12-21 16:42:28.125135+00	2025-12-21 18:09:03.112+00	\N
b443825d-6ea5-4f8c-9ef7-c1346d89084d	917f3f8b-180a-421e-804d-730613cba2c1	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	answe	2025-12-21 16:42:32.115167+00	2025-12-21 18:09:03.112+00	\N
5dcf1e0d-2b89-4d51-a0b7-8158ced8f8c5	917f3f8b-180a-421e-804d-730613cba2c1	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	eee	2025-12-21 16:43:02.630019+00	2025-12-21 18:09:03.112+00	\N
48c89cdb-9d9f-4a71-b33c-5f6b679c3cfc	917f3f8b-180a-421e-804d-730613cba2c1	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	eeeeee	2025-12-21 16:46:12.334481+00	2025-12-21 18:09:03.112+00	\N
6a0da50c-24ca-4440-bb1f-fcd0159b1586	85526295-6c52-40f8-8764-d64c2c0e9db9	413d6728-bb68-4ebd-bd39-5b484d37312b	jdjd	2025-12-23 17:48:38.906249+00	\N	\N
4447048b-ff62-4f1b-9acb-cb887912e8e0	06de900c-01ce-408b-95ca-498a4a60b0e3	413d6728-bb68-4ebd-bd39-5b484d37312b	kkkkkkkk	2025-12-21 18:21:06.694893+00	2025-12-23 17:52:48.968+00	\N
b80eafec-3967-420a-b25a-3791725d39fe	06de900c-01ce-408b-95ca-498a4a60b0e3	413d6728-bb68-4ebd-bd39-5b484d37312b	xxxxxxxx	2025-12-21 18:23:37.038459+00	2025-12-23 17:52:48.968+00	\N
a4fc18fe-8b69-4728-9cea-dfe80f29d725	85526295-6c52-40f8-8764-d64c2c0e9db9	413d6728-bb68-4ebd-bd39-5b484d37312b	dddgg	2025-12-23 18:14:32.561892+00	\N	\N
537355d9-a057-46fa-8dea-3445bf765e73	917f3f8b-180a-421e-804d-730613cba2c1	413d6728-bb68-4ebd-bd39-5b484d37312b	ddd	2025-12-21 18:09:05.537272+00	2025-12-23 18:22:04.075+00	\N
7c296aa4-e6e6-46c2-b799-80fac9c406b6	2c19ee1d-7e28-41f8-9e2c-3a10209509ea	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	fffffffff	2025-12-23 18:22:01.179461+00	2025-12-23 18:53:39.463+00	\N
b2c7e82a-a3a4-4c96-b16e-9877299a58e5	2c19ee1d-7e28-41f8-9e2c-3a10209509ea	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	fffffffff	2025-12-23 18:22:03.750262+00	2025-12-23 18:53:39.463+00	\N
b88b2f82-50a7-4301-aa55-30a1de6a93bc	2c19ee1d-7e28-41f8-9e2c-3a10209509ea	413d6728-bb68-4ebd-bd39-5b484d37312b	bbbbbbbb	2025-12-23 18:53:42.814085+00	2025-12-23 20:37:43.163+00	\N
ffab6d81-4b0b-4500-b865-a21504b41a2f	2c19ee1d-7e28-41f8-9e2c-3a10209509ea	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	nu nav	2025-12-23 20:37:46.070565+00	2025-12-23 20:38:47.524+00	\N
65d3f7af-e2e2-4599-a5c9-30a4047fc07c	2c19ee1d-7e28-41f8-9e2c-3a10209509ea	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	zzzzzzz	2025-12-23 20:40:47.286855+00	2025-12-23 20:59:40.281+00	\N
27f9f60d-22fb-4f25-863b-1e26f7a1440b	2c19ee1d-7e28-41f8-9e2c-3a10209509ea	413d6728-bb68-4ebd-bd39-5b484d37312b	ddd	2025-12-23 20:59:42.706062+00	2025-12-23 21:00:14.998+00	\N
ef8bd82a-3047-49e8-afb2-a03cf476ef41	2c19ee1d-7e28-41f8-9e2c-3a10209509ea	413d6728-bb68-4ebd-bd39-5b484d37312b	dddddddd	2025-12-23 21:06:24.085056+00	\N	\N
b2523b8c-1667-4b21-a301-0d46fe4b4dcf	637088c4-03bb-4a26-b5b1-8ceb0f2bd925	413d6728-bb68-4ebd-bd39-5b484d37312b	ggg	2025-12-23 20:39:01.313032+00	2025-12-23 21:09:09.562+00	\N
e3e8a5e1-8ac5-4f5b-849b-dd4e68a541d9	8e0900f2-5350-433d-81a6-5fbbc8b3a357	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	ddddddddddddddddd	2025-12-23 21:09:23.994372+00	\N	\N
c50450eb-3dae-4751-81f9-a6229adec463	8e0900f2-5350-433d-81a6-5fbbc8b3a357	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	nnnnnn	2025-12-23 21:12:54.311395+00	\N	\N
290a0a38-0c6f-4c70-8796-f5e8c52c90bf	8e0900f2-5350-433d-81a6-5fbbc8b3a357	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	fghj	2025-12-23 21:18:11.487981+00	\N	\N
cd137962-4dd0-4136-9345-100dd01ff57d	8e0900f2-5350-433d-81a6-5fbbc8b3a357	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	cvb	2025-12-23 21:19:32.342463+00	\N	\N
590804dc-1642-4bd5-8feb-9a0b764bbbe0	01999fd6-1b1e-49b4-9774-8bae5a988ec1	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	nnn	2025-12-23 19:52:29.683803+00	2026-01-03 16:52:05.286+00	\N
e59b7550-bd32-4225-a6f6-1c6ba977d6c6	01999fd6-1b1e-49b4-9774-8bae5a988ec1	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	dddddd	2025-12-23 21:09:02.420174+00	2026-01-03 16:52:05.286+00	\N
1660d07c-0ef0-4403-aee7-79219cbd0a11	01999fd6-1b1e-49b4-9774-8bae5a988ec1	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	nnn	2025-12-23 21:13:00.171464+00	2026-01-03 16:52:05.286+00	\N
e5a8c830-7890-43cb-a6dc-23a949b0f2e4	01999fd6-1b1e-49b4-9774-8bae5a988ec1	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	er5678	2025-12-23 21:17:59.240406+00	2026-01-03 16:52:05.286+00	\N
693e1374-2626-4ef9-9065-1056ae92efa3	01999fd6-1b1e-49b4-9774-8bae5a988ec1	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	gh	2025-12-23 21:19:38.306289+00	2026-01-03 16:52:05.286+00	\N
3497ccad-02e0-46bd-947c-e6d6f90e0dbf	637088c4-03bb-4a26-b5b1-8ceb0f2bd925	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	ddddddd	2025-12-23 21:09:11.408231+00	2026-01-05 20:06:19.114+00	\N
7c054f8e-54d2-4381-acd4-17fb1c529e83	637088c4-03bb-4a26-b5b1-8ceb0f2bd925	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	nnnnnn	2025-12-23 21:12:57.343035+00	2026-01-05 20:06:19.114+00	\N
70815529-3558-4de2-a04f-5b55afcd866d	637088c4-03bb-4a26-b5b1-8ceb0f2bd925	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	dfgyu	2025-12-23 21:18:02.968212+00	2026-01-05 20:06:19.114+00	\N
994b7624-c47e-4f17-a3c7-2ac7f9ec2c30	637088c4-03bb-4a26-b5b1-8ceb0f2bd925	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	gh	2025-12-23 21:19:35.41174+00	2026-01-05 20:06:19.114+00	\N
0cb60467-b0c5-42cc-9c57-170075b920b8	637088c4-03bb-4a26-b5b1-8ceb0f2bd925	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	hey	2026-01-05 20:06:36.488206+00	\N	\N
6362e235-5620-4e03-842d-b5816d37dda7	637088c4-03bb-4a26-b5b1-8ceb0f2bd925	413d6728-bb68-4ebd-bd39-5b484d37312b	huh	2026-01-05 20:06:42.142003+00	\N	\N
7f055243-e402-4629-b373-c100a0cc99b4	917f3f8b-180a-421e-804d-730613cba2c1	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	ffffffff	2025-12-23 18:22:06.859667+00	2026-01-11 17:52:37.782+00	\N
d2103e23-40a2-4cdc-84f6-aae430f10bd8	917f3f8b-180a-421e-804d-730613cba2c1	413d6728-bb68-4ebd-bd39-5b484d37312b	jj	2026-01-11 17:52:41.275416+00	\N	\N
\.


ALTER TABLE public.chat_messages ENABLE TRIGGER ALL;

--
-- Data for Name: countries; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.countries DISABLE TRIGGER ALL;

COPY public.countries (id, key, lat, lon) FROM stdin;
1	LV	56.8796	24.6032
2	LT	55.1694	23.8813
3	EE	58.5953	25.0136
\.


ALTER TABLE public.countries ENABLE TRIGGER ALL;

--
-- Data for Name: municipalities; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.municipalities DISABLE TRIGGER ALL;

COPY public.municipalities (id, key, country_id, lat, lon) FROM stdin;
98	augsdaugavas-novads	1	\N	\N
99	alytaus-miesto-savivaldybe	2	\N	\N
100	alytaus-rajono-savivaldybe	2	\N	\N
101	druskininku-savivaldybe	2	\N	\N
102	lazdiju-rajono-savivaldybe	2	\N	\N
103	varenos-rajono-savivaldybe	2	\N	\N
104	birstono-savivaldybe	2	\N	\N
105	jonavos-rajono-savivaldybe	2	\N	\N
106	kaisiadoriu-rajono-savivaldybe	2	\N	\N
107	kauno-miesto-savivaldybe	2	\N	\N
108	kauno-rajono-savivaldybe	2	\N	\N
109	kedainiu-rajono-savivaldybe	2	\N	\N
110	prienu-rajono-savivaldybe	2	\N	\N
111	raseiniu-rajono-savivaldybe	2	\N	\N
112	klaipedos-miesto-savivaldybe	2	\N	\N
113	klaipedos-rajono-savivaldybe	2	\N	\N
114	kretingos-rajono-savivaldybe	2	\N	\N
115	neringos-savivaldybe	2	\N	\N
116	palangos-miesto-savivaldybe	2	\N	\N
117	silutes-rajono-savivaldybe	2	\N	\N
118	skuodo-rajono-savivaldybe	2	\N	\N
119	kalvarijos-savivaldybe	2	\N	\N
120	kazlu-rudos-savivaldybe	2	\N	\N
121	marijampoles-savivaldybe	2	\N	\N
122	sakiu-rajono-savivaldybe	2	\N	\N
123	vilkaviskio-rajono-savivaldybe	2	\N	\N
124	birzu-rajono-savivaldybe	2	\N	\N
125	kupiskio-rajono-savivaldybe	2	\N	\N
126	panevezio-miesto-savivaldybe	2	\N	\N
127	panevezio-rajono-savivaldybe	2	\N	\N
128	pasvalio-rajono-savivaldybe	2	\N	\N
129	rokiskio-rajono-savivaldybe	2	\N	\N
130	akmenes-rajono-savivaldybe	2	\N	\N
131	joniskio-rajono-savivaldybe	2	\N	\N
132	kelmes-rajono-savivaldybe	2	\N	\N
133	pakruojo-rajono-savivaldybe	2	\N	\N
134	radviliskio-rajono-savivaldybe	2	\N	\N
43	riga	1	\N	\N
44	daugavpils	1	\N	\N
45	liepaja	1	\N	\N
46	jelgava	1	\N	\N
47	jurmala	1	\N	\N
135	siauliu-miesto-savivaldybe	2	\N	\N
49	ventspils	1	\N	\N
50	rezekne	1	\N	\N
51	ogre	1	\N	\N
52	valmiera	1	\N	\N
53	jekabpils	1	\N	\N
54	madonas-novads	1	\N	\N
55	ogres-novads	1	\N	\N
56	limbazu-novads	1	\N	\N
57	talsu-novads	1	\N	\N
58	cesu-novads	1	\N	\N
59	valmieras-novads	1	\N	\N
60	saldus-novads	1	\N	\N
61	kuldigas-novads	1	\N	\N
62	tukuma-novads	1	\N	\N
63	dienvidkurzemes-novads	1	\N	\N
64	salaspils-novads	1	\N	\N
65	adazu-novads	1	\N	\N
66	aizkraukles-novads	1	\N	\N
67	aluksnes-novads	1	\N	\N
68	balvu-novads	1	\N	\N
69	bauskas-novads	1	\N	\N
70	dobeles-novads	1	\N	\N
71	gulbenes-novads	1	\N	\N
72	jekabpils-novads	1	\N	\N
73	jelgavas-novads	1	\N	\N
74	kraslavas-novads	1	\N	\N
75	livanu-novads	1	\N	\N
76	ludzas-novads	1	\N	\N
77	marupes-novads	1	\N	\N
78	olaines-novads	1	\N	\N
79	preilu-novads	1	\N	\N
80	rezeknes-novads	1	\N	\N
81	ropazu-novads	1	\N	\N
82	saulkrastu-novads	1	\N	\N
83	siguldas-novads	1	\N	\N
84	smiltenes-novads	1	\N	\N
85	valkas-novads	1	\N	\N
86	ventspils-novads	1	\N	\N
87	kekavas-novads	1	\N	\N
136	siauliu-rajono-savivaldybe	2	\N	\N
137	jurbarko-rajono-savivaldybe	2	\N	\N
138	pagegiu-savivaldybe	2	\N	\N
139	silales-rajono-savivaldybe	2	\N	\N
140	taurages-rajono-savivaldybe	2	\N	\N
141	mazeikiu-rajono-savivaldybe	2	\N	\N
142	plunges-rajono-savivaldybe	2	\N	\N
143	rietavo-savivaldybe	2	\N	\N
144	telsiu-rajono-savivaldybe	2	\N	\N
145	anyksciu-rajono-savivaldybe	2	\N	\N
146	ignalinos-rajono-savivaldybe	2	\N	\N
147	moletu-rajono-savivaldybe	2	\N	\N
148	utenos-rajono-savivaldybe	2	\N	\N
149	visagino-savivaldybe	2	\N	\N
150	zarasu-rajono-savivaldybe	2	\N	\N
151	elektrenu-savivaldybe	2	\N	\N
152	salcininku-rajono-savivaldybe	2	\N	\N
153	sirvintu-rajono-savivaldybe	2	\N	\N
154	svencioniu-rajono-savivaldybe	2	\N	\N
155	traku-rajono-savivaldybe	2	\N	\N
156	ukmerges-rajono-savivaldybe	2	\N	\N
157	vilniaus-miesto-savivaldybe	2	\N	\N
158	vilniaus-rajono-savivaldybe	2	\N	\N
159	tallinna-linn	3	\N	\N
160	tartu-linn	3	\N	\N
161	narva-linn	3	\N	\N
162	parnu-linn	3	\N	\N
163	kohtla-jarve-linn	3	\N	\N
164	viljandi-linn	3	\N	\N
165	rakvere-linn	3	\N	\N
166	sillamae-linn	3	\N	\N
167	kuressaare-linn	3	\N	\N
168	valga-vald	3	\N	\N
169	voru-linn	3	\N	\N
170	haapsalu-linn	3	\N	\N
171	johvi-vald	3	\N	\N
172	paide-linn	3	\N	\N
173	keila-linn	3	\N	\N
174	alutaguse-vald	3	\N	\N
175	anija-vald	3	\N	\N
176	antsla-vald	3	\N	\N
177	elva-vald	3	\N	\N
178	haljala-vald	3	\N	\N
179	harku-vald	3	\N	\N
180	hiiumaa-vald	3	\N	\N
181	haademeeste-vald	3	\N	\N
182	joelahtme-vald	3	\N	\N
183	jogeva-vald	3	\N	\N
184	kose-vald	3	\N	\N
185	kuusalu-vald	3	\N	\N
186	laane-harju-vald	3	\N	\N
187	laane-nigula-vald	3	\N	\N
188	laaneranna-vald	3	\N	\N
189	lyganuse-vald	3	\N	\N
190	luunja-vald	3	\N	\N
191	muhu-vald	3	\N	\N
192	mulgi-vald	3	\N	\N
193	mustvee-vald	3	\N	\N
194	marjamaa-vald	3	\N	\N
195	noo-vald	3	\N	\N
196	otepaa-vald	3	\N	\N
197	peipsiaare-vald	3	\N	\N
198	pohja-parnumaa-vald	3	\N	\N
199	pohja-sakala-vald	3	\N	\N
200	poltsamaa-vald	3	\N	\N
201	polva-vald	3	\N	\N
202	raasiku-vald	3	\N	\N
203	rae-vald	3	\N	\N
204	rakvere-vald	3	\N	\N
205	rapla-vald	3	\N	\N
206	rouge-vald	3	\N	\N
207	rapina-vald	3	\N	\N
208	ruhnu-vald	3	\N	\N
209	saku-vald	3	\N	\N
210	saarde-vald	3	\N	\N
211	saaremaa-vald	3	\N	\N
212	saue-vald	3	\N	\N
213	setomaa-vald	3	\N	\N
214	tapa-vald	3	\N	\N
215	tartu-vald	3	\N	\N
216	toila-vald	3	\N	\N
217	tori-vald	3	\N	\N
218	torva-vald	3	\N	\N
219	tyri-vald	3	\N	\N
221	viljandi-vald	3	\N	\N
222	vinni-vald	3	\N	\N
223	viru-nigula-vald	3	\N	\N
224	viimsi-vald	3	\N	\N
225	vaike-maarja-vald	3	\N	\N
226	vormsi-vald	3	\N	\N
227	voru-vald	3	\N	\N
229	jarva-vald	3	\N	\N
230	kadrina-vald	3	\N	\N
231	kambja-vald	3	\N	\N
232	kanepi-vald	3	\N	\N
233	kastre-vald	3	\N	\N
234	kehtna-vald	3	\N	\N
235	kihnu-vald	3	\N	\N
236	kiili-vald	3	\N	\N
237	kohila-vald	3	\N	\N
238	maardu-linn	3	\N	\N
239	narva-joesuu-linn	3	\N	\N
\.


ALTER TABLE public.municipalities ENABLE TRIGGER ALL;

--
-- Data for Name: cities; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.cities DISABLE TRIGGER ALL;

COPY public.cities (id, key, municipality_id, lat, lon) FROM stdin;
9	riga	43	\N	\N
10	daugavpils	44	\N	\N
11	liepaja	45	\N	\N
12	jelgava	46	\N	\N
13	jurmala	47	\N	\N
14	ventspils	49	\N	\N
15	rezekne	50	\N	\N
16	ogre	51	\N	\N
18	jekabpils	53	\N	\N
19	madona	54	\N	\N
20	varaklani	54	\N	\N
21	lubana	54	\N	\N
22	cesvaine	54	\N	\N
23	ikskile	55	\N	\N
24	kegums	55	\N	\N
25	lielvarde	55	\N	\N
26	ogre	55	\N	\N
27	ainazi	56	\N	\N
28	aloja	56	\N	\N
29	limbazi	56	\N	\N
30	salacgriva	56	\N	\N
31	staicele	56	\N	\N
32	sabile	57	\N	\N
33	stende	57	\N	\N
34	talsi	57	\N	\N
35	valdemarpils	57	\N	\N
36	cesis	58	\N	\N
37	ligatne	58	\N	\N
38	mazsalaca	59	\N	\N
39	rujiena	59	\N	\N
40	seda	59	\N	\N
41	strenci	59	\N	\N
42	valmiera	59	\N	\N
43	broceni	60	\N	\N
44	saldus	60	\N	\N
45	kuldiga	61	\N	\N
46	skrunda	61	\N	\N
47	kandava	62	\N	\N
48	tukums	62	\N	\N
49	aizpute	63	\N	\N
50	durbe	63	\N	\N
51	grobina	63	\N	\N
52	pavilosta	63	\N	\N
53	priekule	63	\N	\N
54	salaspils	64	\N	\N
55	adazi	65	\N	\N
56	aizkraukle	66	\N	\N
57	jaunjelgava	66	\N	\N
58	koknese	66	\N	\N
59	plavinas	66	\N	\N
60	aluksne	67	\N	\N
61	balvi	68	\N	\N
62	vilaka	68	\N	\N
63	bauska	69	\N	\N
64	iecava	69	\N	\N
65	auce	70	\N	\N
66	dobele	70	\N	\N
67	gulbene	71	\N	\N
68	akniste	72	\N	\N
69	viesite	72	\N	\N
71	dagda	74	\N	\N
72	kraslava	74	\N	\N
73	livani	75	\N	\N
74	karsava	76	\N	\N
75	ludza	76	\N	\N
76	zilupe	76	\N	\N
77	marupe	77	\N	\N
78	olaine	78	\N	\N
79	preili	79	\N	\N
80	vilani	80	\N	\N
81	vangazi	81	\N	\N
82	saulkrasti	82	\N	\N
83	sigulda	83	\N	\N
84	ape	84	\N	\N
85	smiltene	84	\N	\N
86	valka	85	\N	\N
87	piltene	86	\N	\N
88	baldone	87	\N	\N
89	balozi	87	\N	\N
90	kekava	87	\N	\N
91	ilukste	98	\N	\N
92	subate	98	\N	\N
129	naukseni	59	\N	\N
140	malta	80	\N	\N
141	luznava	80	\N	\N
144	riebini	79	\N	\N
148	berzaunes-pagasts	54	\N	\N
149	praulienas-pagasts	54	\N	\N
150	varaklanu-pagasts	54	\N	\N
151	cesvaines-pagasts	54	\N	\N
152	sausnejas-pagasts	54	\N	\N
153	lazdonas-pagasts	54	\N	\N
154	barkavas-pagasts	54	\N	\N
155	vestienas-pagasts	54	\N	\N
156	osupes-pagasts	54	\N	\N
157	laudonas-pagasts	54	\N	\N
158	kalsnavas-pagasts	54	\N	\N
159	jumurdas-pagasts	54	\N	\N
160	erglu-pagasts	54	\N	\N
161	marcienas-pagasts	54	\N	\N
162	indranu-pagasts	54	\N	\N
163	liezeres-pagasts	54	\N	\N
164	metrienas-pagasts	54	\N	\N
165	sarkanu-pagasts	54	\N	\N
17	valmiera-city	52	\N	\N
166	murmastienes-pagasts	54	\N	\N
167	aronas-pagasts	54	\N	\N
168	dzelzavas-pagasts	54	\N	\N
169	elksnu-pagasts	72	\N	\N
170	salas-pagasts	72	\N	\N
171	mezarez-pagasts	72	\N	\N
172	zasas-pagasts	72	\N	\N
173	atasienes-pagasts	72	\N	\N
174	dignajas-pagasts	72	\N	\N
175	kalna-pagasts	72	\N	\N
176	variesu-pagasts	72	\N	\N
177	leimanu-pagasts	72	\N	\N
178	viesites-pagasts	72	\N	\N
179	dunavas-pagasts	72	\N	\N
180	asares-pagasts	72	\N	\N
181	kuku-pagasts	72	\N	\N
182	vipes-pagasts	72	\N	\N
183	rites-pagasts	72	\N	\N
184	abelu-pagasts	72	\N	\N
185	aknistes-pagasts	72	\N	\N
186	saukas-pagasts	72	\N	\N
187	krustpils-pagasts	72	\N	\N
188	garsenes-pagasts	72	\N	\N
189	selpils-pagasts	72	\N	\N
190	rubenes-pagasts	72	\N	\N
191	upmalas-pagasts	79	\N	\N
192	preilu-pagasts	79	\N	\N
193	galenu-pagasts	79	\N	\N
194	silajanu-pagasts	79	\N	\N
195	stabulnieku-pagasts	79	\N	\N
196	aizkalnes-pagasts	79	\N	\N
197	silukalna-pagasts	79	\N	\N
198	rusonas-pagasts	79	\N	\N
199	riebinu-pagasts	79	\N	\N
200	pelecu-pagasts	79	\N	\N
201	aglonas-pagasts	79	\N	\N
202	rozkalnu-pagasts	79	\N	\N
203	saunas-pagasts	79	\N	\N
204	varkavas-pagasts	79	\N	\N
205	kantinieku-pagasts	80	\N	\N
206	ozolmuizas-pagasts	80	\N	\N
207	makonkalna-pagasts	80	\N	\N
208	luznavas-pagasts	80	\N	\N
209	vilanu-pagasts	80	\N	\N
210	stolerovas-pagasts	80	\N	\N
211	lendzu-pagasts	80	\N	\N
212	naglu-pagasts	80	\N	\N
213	struzanu-pagasts	80	\N	\N
214	ozolaines-pagasts	80	\N	\N
215	audrinu-pagasts	80	\N	\N
216	sakstagala-pagasts	80	\N	\N
217	ilzeskalna-pagasts	80	\N	\N
218	sokolku-pagasts	80	\N	\N
219	rikavas-pagasts	80	\N	\N
220	deksares-pagasts	80	\N	\N
221	berzgales-pagasts	80	\N	\N
222	pusas-pagasts	80	\N	\N
223	maltas-pagasts	80	\N	\N
224	silmalas-pagasts	80	\N	\N
225	griskanu-pagasts	80	\N	\N
226	gaigalavas-pagasts	80	\N	\N
227	kaunatas-pagasts	80	\N	\N
228	nautrenu-pagasts	80	\N	\N
229	veremu-pagasts	80	\N	\N
230	cornajas-pagasts	80	\N	\N
231	feimanu-pagasts	80	\N	\N
232	dricanu-pagasts	80	\N	\N
233	mezares-pagasts	72	\N	\N
234	sederes-pagasts	98	\N	\N
235	ambelu-pagasts	98	\N	\N
236	tabores-pagasts	98	\N	\N
237	vecsalienas-pagasts	98	\N	\N
238	bebrenes-pagasts	98	\N	\N
239	prodes-pagasts	98	\N	\N
240	dubnas-pagasts	98	\N	\N
241	laucesas-pagasts	98	\N	\N
242	medumu-pagasts	98	\N	\N
243	dvietes-pagasts	98	\N	\N
244	bikernieku-pagasts	98	\N	\N
245	kalkunes-pagasts	98	\N	\N
246	pilskalnes-pagasts	98	\N	\N
247	demenes-pagasts	98	\N	\N
248	malinovas-pagasts	98	\N	\N
249	naujenes-pagasts	98	\N	\N
250	visku-pagasts	98	\N	\N
251	kalupes-pagasts	98	\N	\N
252	eglaines-pagasts	98	\N	\N
253	skrudalienas-pagasts	98	\N	\N
254	liksnas-pagasts	98	\N	\N
255	vaboles-pagasts	98	\N	\N
256	sventes-pagasts	98	\N	\N
257	nicgales-pagasts	98	\N	\N
258	salienas-pagasts	98	\N	\N
259	baldones-pagasts	87	\N	\N
260	kekavas-pagasts	87	\N	\N
261	daugmales-pagasts	87	\N	\N
262	ceres-pagasts	62	\N	\N
263	vanes-pagasts	62	\N	\N
264	lestenes-pagasts	62	\N	\N
265	matkules-pagasts	62	\N	\N
266	dzukstes-pagasts	62	\N	\N
267	smardes-pagasts	62	\N	\N
268	semes-pagasts	62	\N	\N
269	tumes-pagasts	62	\N	\N
270	degoles-pagasts	62	\N	\N
271	irlavas-pagasts	62	\N	\N
272	zemites-pagasts	62	\N	\N
273	zantes-pagasts	62	\N	\N
274	lapmezciema-pagasts	62	\N	\N
275	slampes-pagasts	62	\N	\N
276	viesatu-pagasts	62	\N	\N
277	jaunsatu-pagasts	62	\N	\N
278	engures-pagasts	62	\N	\N
279	zenten es-pagasts	62	\N	\N
280	jaunpils-pagasts	62	\N	\N
281	kandavas-pagasts	62	\N	\N
282	pures-pagasts	62	\N	\N
283	turlavas-pagasts	61	\N	\N
284	ivandes-pagasts	61	\N	\N
285	kurmales-pagasts	61	\N	\N
286	rumbas-pagasts	61	\N	\N
287	varmes-pagasts	61	\N	\N
288	pelcu-pagasts	61	\N	\N
289	gudenieku-pagasts	61	\N	\N
290	rendas-pagasts	61	\N	\N
291	skrundas-pagasts	61	\N	\N
292	rudbarzu-pagasts	61	\N	\N
293	laidu-pagasts	61	\N	\N
294	kabiles-pagasts	61	\N	\N
295	nikraces-pagasts	61	\N	\N
296	padures-pagasts	61	\N	\N
297	ranku-pagasts	61	\N	\N
298	alsungas-pagasts	61	\N	\N
299	snepeles-pagasts	61	\N	\N
300	gibulu-pagasts	57	\N	\N
301	arlavas-pagasts	57	\N	\N
302	balgales-pagasts	57	\N	\N
303	vandzenes-pagasts	57	\N	\N
304	libagu-pagasts	57	\N	\N
305	kulciema-pagasts	57	\N	\N
306	mersraga-pagasts	57	\N	\N
307	laidzes-pagasts	57	\N	\N
308	valdgales-pagasts	57	\N	\N
309	kolkas-pagasts	57	\N	\N
310	rojas-pagasts	57	\N	\N
311	lubes-pagasts	57	\N	\N
312	virbu-pagasts	57	\N	\N
313	abavas-pagasts	57	\N	\N
314	ive-pagasts	57	\N	\N
315	laucienes-pagasts	57	\N	\N
316	strazdes-pagasts	57	\N	\N
317	dundagas-pagasts	57	\N	\N
318	novadnieku-pagasts	60	\N	\N
319	remtes-pagasts	60	\N	\N
320	vadakstes-pagasts	60	\N	\N
321	cieceres-pagasts	60	\N	\N
322	nigrandes-pagasts	60	\N	\N
323	kursisu-pagasts	60	\N	\N
324	zirnu-pagasts	60	\N	\N
325	zvardes-pagasts	60	\N	\N
326	pampalu-pagasts	60	\N	\N
327	ezeres-pagasts	60	\N	\N
328	gaiku-pagasts	60	\N	\N
329	jaunauces-pagasts	60	\N	\N
330	rubas-pagasts	60	\N	\N
331	saldus-pagasts	60	\N	\N
332	jaunlutrinu-pagasts	60	\N	\N
333	zanas-pagasts	60	\N	\N
334	skedes-pagasts	60	\N	\N
335	blidenes-pagasts	60	\N	\N
336	lutrinu-pagasts	60	\N	\N
337	vaidavas-pagasts	59	\N	\N
338	jercenu-pagasts	59	\N	\N
339	berzaines-pagasts	59	\N	\N
340	lodes-pagasts	59	\N	\N
341	skankalnes-pagasts	59	\N	\N
342	burtnieku-pagasts	59	\N	\N
343	valmieras-pagasts	59	\N	\N
344	matisu-pagasts	59	\N	\N
345	vecates-pagasts	59	\N	\N
346	planu-pagasts	59	\N	\N
347	kauguru-pagasts	59	\N	\N
348	selu-pagasts	59	\N	\N
349	trikatas-pagasts	59	\N	\N
350	rencenu-pagasts	59	\N	\N
351	ramatas-pagasts	59	\N	\N
352	nauksenu-pagasts	59	\N	\N
353	ipiku-pagasts	59	\N	\N
354	kocenu-pagasts	59	\N	\N
355	eveles-pagasts	59	\N	\N
356	brengulu-pagasts	59	\N	\N
357	jeru-pagasts	59	\N	\N
358	konu-pagasts	59	\N	\N
359	mazsalacas-pagasts	59	\N	\N
360	zilakalna-pagasts	59	\N	\N
361	diklu-pagasts	59	\N	\N
362	vilpulkas-pagasts	59	\N	\N
363	ligatnes-pagasts	58	\N	\N
364	priekulu-pagasts	58	\N	\N
365	taurenes-pagasts	58	\N	\N
366	marsnenu-pagasts	58	\N	\N
367	stalbes-pagasts	58	\N	\N
368	raiskuma-pagasts	58	\N	\N
369	veselavas-pagasts	58	\N	\N
370	amatas-pagasts	58	\N	\N
371	zaubes-pagasts	58	\N	\N
372	inesu-pagasts	58	\N	\N
373	drabesu-pagasts	58	\N	\N
374	kaives-pagasts	58	\N	\N
375	straupes-pagasts	58	\N	\N
376	liepas-pagasts	58	\N	\N
377	vaives-pagasts	58	\N	\N
378	zosenu-pagasts	58	\N	\N
379	dzerbenes-pagasts	58	\N	\N
380	vecpiebalgas-pagasts	58	\N	\N
381	nitaures-pagasts	58	\N	\N
383	jaunpiebalgas-pagasts	58	\N	\N
386	skujenes-pagasts	58	\N	\N
387	uzavas-pagasts	86	\N	\N
388	varves-pagasts	86	\N	\N
389	puzes-pagasts	86	\N	\N
390	ugales-pagasts	86	\N	\N
391	targales-pagasts	86	\N	\N
392	usmas-pagasts	86	\N	\N
393	ances-pagasts	86	\N	\N
394	jurkalnes-pagasts	86	\N	\N
395	popes-pagasts	86	\N	\N
396	piltenes-pagasts	86	\N	\N
397	zleku-pagasts	86	\N	\N
398	ziru-pagasts	86	\N	\N
399	karku-pagasts	85	\N	\N
400	ergemes-pagasts	85	\N	\N
401	vijciema-pagasts	85	\N	\N
402	valkas-pagasts	85	\N	\N
403	zvartavas-pagasts	85	\N	\N
404	smiltenes-pagasts	84	\N	\N
405	raunas-pagasts	84	\N	\N
406	palsmanes-pagasts	84	\N	\N
407	brantu-pagasts	84	\N	\N
408	drustu-pagasts	84	\N	\N
409	gaujienas-pagasts	84	\N	\N
410	bilskas-pagasts	84	\N	\N
411	grundzales-pagasts	84	\N	\N
412	apes-pagasts	84	\N	\N
413	blomes-pagasts	84	\N	\N
414	launkalnes-pagasts	84	\N	\N
415	trapenes-pagasts	84	\N	\N
416	varinu-pagasts	84	\N	\N
417	viresu-pagasts	84	\N	\N
418	siguldas-pagasts	83	\N	\N
419	ledurgas-pagasts	83	\N	\N
420	allazu-pagasts	83	\N	\N
421	krimuldas-pagasts	83	\N	\N
422	mores-pagasts	83	\N	\N
423	malpils-pagasts	83	\N	\N
424	incukalna-pagasts	83	\N	\N
425	sejas-pagasts	82	\N	\N
426	saulkrastu-pagasts	82	\N	\N
427	garkalnes-pagasts	81	\N	\N
428	stopinu-pagasts	81	\N	\N
429	ropazu-pagasts	81	\N	\N
430	silmala-pagasts	80	\N	\N
432	olaines-pagasts	78	\N	\N
433	salas-pagasts	77	\N	\N
434	marupes-pagasts	77	\N	\N
435	babites-pagasts	77	\N	\N
436	nirzas-pagasts	76	\N	\N
437	blontu-pagasts	76	\N	\N
438	merdzenes-pagasts	76	\N	\N
439	pildas-pagasts	76	\N	\N
440	istras-pagasts	76	\N	\N
441	nuksu-pagasts	76	\N	\N
442	lauderu-pagasts	76	\N	\N
443	mezvidu-pagasts	76	\N	\N
444	isnaudas-pagasts	76	\N	\N
445	zvirgzdenes-pagasts	76	\N	\N
446	salnavas-pagasts	76	\N	\N
447	ciblas-pagasts	76	\N	\N
448	zalesjes-pagasts	76	\N	\N
449	rundenu-pagasts	76	\N	\N
450	lidumnieku-pagasts	76	\N	\N
451	golisevas-pagasts	76	\N	\N
452	cirmas-pagasts	76	\N	\N
453	purenu-pagasts	76	\N	\N
454	pusmucovas-pagasts	76	\N	\N
455	brigu-pagasts	76	\N	\N
456	malnavas-pagasts	76	\N	\N
457	pasienes-pagasts	76	\N	\N
458	jersikas-pagasts	75	\N	\N
459	rudzatu-pagasts	75	\N	\N
460	rozupes-pagasts	75	\N	\N
461	sutru-pagasts	75	\N	\N
462	turku-pagasts	75	\N	\N
463	skeltovas-pagasts	74	\N	\N
464	asunes-pagasts	74	\N	\N
465	kraslavas-pagasts	74	\N	\N
466	kalniesu-pagasts	74	\N	\N
467	andrupenes-pagasts	74	\N	\N
468	berzinu-pagasts	74	\N	\N
469	skaunes-pagasts	74	\N	\N
470	izvaltas-pagasts	74	\N	\N
471	robeznieku-pagasts	74	\N	\N
472	andzelu-pagasts	74	\N	\N
473	kepovas-pagasts	74	\N	\N
474	kaplavas-pagasts	74	\N	\N
475	kombulu-pagasts	74	\N	\N
476	dagdas-pagasts	74	\N	\N
477	udrisu-pagasts	74	\N	\N
478	kastulinas-pagasts	74	\N	\N
479	svarinu-pagasts	74	\N	\N
480	ezernieku-pagasts	74	\N	\N
481	skaistas-pagasts	74	\N	\N
482	aulejas-pagasts	74	\N	\N
483	graveru-pagasts	74	\N	\N
484	konstantinovas-pagasts	74	\N	\N
485	piedrujas-pagasts	74	\N	\N
486	indras-pagasts	74	\N	\N
487	adazu-pagasts	65	\N	\N
488	carnikavas-pagasts	65	\N	\N
489	plavinu-pagasts	66	\N	\N
490	kokneses-pagasts	66	\N	\N
491	aizkraukles-pagasts	66	\N	\N
492	skrivenu-pagasts	66	\N	\N
493	jaunjelgavas-pagasts	66	\N	\N
494	krapes-pagasts	55	\N	\N
495	jumpravas-pagasts	55	\N	\N
496	lauberes-pagasts	55	\N	\N
497	lielvardes-pagasts	55	\N	\N
498	madlienas-pagasts	55	\N	\N
499	suntazu-pagasts	55	\N	\N
500	tinuzu-pagasts	55	\N	\N
501	ogresgala-pagasts	55	\N	\N
502	ledmanes-pagasts	55	\N	\N
503	tomes-pagasts	55	\N	\N
504	birzgales-pagasts	55	\N	\N
505	taurupes-pagasts	55	\N	\N
506	mazeozolu-pagasts	55	\N	\N
507	mengeles-pagasts	55	\N	\N
508	keipenes-pagasts	55	\N	\N
509	rembates-pagasts	55	\N	\N
510	liepupes-pagasts	56	\N	\N
511	braslavas-pagasts	56	\N	\N
512	ainazu-pagasts	56	\N	\N
513	alojas-pagasts	56	\N	\N
514	pales-pagasts	56	\N	\N
515	vidrizu-pagasts	56	\N	\N
516	staiceles-pagasts	56	\N	\N
517	salacgrivas-pagasts	56	\N	\N
518	limbazu-pagasts	56	\N	\N
519	vilkenes-pagasts	56	\N	\N
520	brivzemnieku-pagasts	56	\N	\N
521	katvaru-pagasts	56	\N	\N
522	umurgas-pagasts	56	\N	\N
523	skultes-pagasts	56	\N	\N
524	kalvenes-pagasts	63	\N	\N
525	vainodes-pagasts	63	\N	\N
526	grobinas-pagasts	63	\N	\N
527	vecpils-pagasts	63	\N	\N
528	bunkas-pagasts	63	\N	\N
529	priekules-pagasts	63	\N	\N
530	lazas-pagasts	63	\N	\N
531	embutes-pagasts	63	\N	\N
532	dunalkas-pagasts	63	\N	\N
533	durbes-pagasts	63	\N	\N
534	gramzdas-pagasts	63	\N	\N
535	vergales-pagasts	63	\N	\N
536	medzes-pagasts	63	\N	\N
537	dunikas-pagasts	63	\N	\N
538	virgas-pagasts	63	\N	\N
539	bartas-pagasts	63	\N	\N
540	nicas-pagasts	63	\N	\N
541	rucavas-pagasts	63	\N	\N
542	kazdang as-pagasts	63	\N	\N
543	sakas-pagasts	63	\N	\N
544	aizputes-pagasts	63	\N	\N
545	otanku-pagasts	63	\N	\N
546	kaletu-pagasts	63	\N	\N
547	gaviezes-pagasts	63	\N	\N
548	tadaiku-pagasts	63	\N	\N
549	ciravas-pagasts	63	\N	\N
550	salaspils-pagasts	64	\N	\N
551	gailisu-pagasts	69	\N	\N
552	codes-pagasts	69	\N	\N
553	ceraukstes-pagasts	69	\N	\N
554	davinu-pagasts	69	\N	\N
555	stelpes-pagasts	69	\N	\N
556	islices-pagasts	69	\N	\N
557	mezotnes-pagasts	69	\N	\N
558	skaistkalnes-pagasts	69	\N	\N
559	vecumnieku-pagasts	69	\N	\N
560	rundales-pagasts	69	\N	\N
561	vecsaules-pagasts	69	\N	\N
562	svitenes-pagasts	69	\N	\N
563	iecavas-pagasts	69	\N	\N
564	brunavas-pagasts	69	\N	\N
565	kurmenes-pagasts	69	\N	\N
566	barbeles-pagasts	69	\N	\N
567	augstkalnes-pagasts	70	\N	\N
568	dobeles-pagasts	70	\N	\N
569	iles-pagasts	70	\N	\N
570	annenieku-pagasts	70	\N	\N
571	zebrenes-pagasts	70	\N	\N
572	auru-pagasts	70	\N	\N
573	lielauces-pagasts	70	\N	\N
574	naudites-pagasts	70	\N	\N
575	benes-pagasts	70	\N	\N
576	vitinu-pagasts	70	\N	\N
577	ukru-pagasts	70	\N	\N
578	tervetes-pagasts	70	\N	\N
579	penkules-pagasts	70	\N	\N
580	jaunberzes-pagasts	70	\N	\N
581	krimunas-pagasts	70	\N	\N
582	bukaisu-pagasts	70	\N	\N
583	berzes-pagasts	70	\N	\N
584	bikstu-pagasts	70	\N	\N
585	belavas-pagasts	71	\N	\N
586	tirzas-pagasts	71	\N	\N
587	ligo-pagasts	71	\N	\N
588	lizuma-pagasts	71	\N	\N
589	druvienas-pagasts	71	\N	\N
590	rankas-pagasts	71	\N	\N
591	lejasciema-pagasts	71	\N	\N
592	jaungulbenes-pagasts	71	\N	\N
593	stamerienas-pagasts	71	\N	\N
594	galgauskas-pagasts	71	\N	\N
595	daukstu-pagasts	71	\N	\N
596	litenes-pagasts	71	\N	\N
597	stradu-pagasts	71	\N	\N
598	svetes-pagasts	73	\N	\N
599	vircavas-pagasts	73	\N	\N
600	jaunsvirlaukas-pagasts	73	\N	\N
601	gludas-pagasts	73	\N	\N
602	ozolnieku-pagasts	73	\N	\N
603	valgundes-pagasts	73	\N	\N
604	platones-pagasts	73	\N	\N
605	sesavas-pagasts	73	\N	\N
606	lielplatones-pagasts	73	\N	\N
607	cenu-pagasts	73	\N	\N
608	livberzes-pagasts	73	\N	\N
609	salgales-pagasts	73	\N	\N
610	vilces-pagasts	73	\N	\N
611	elejas-pagasts	73	\N	\N
612	ives-pagasts	57	\N	\N
613	kubulu-pagasts	68	\N	\N
614	skilbenu-pagasts	68	\N	\N
615	ziguru-pagasts	68	\N	\N
616	lazdulejas-pagasts	68	\N	\N
617	lazdukalna-pagasts	68	\N	\N
618	vecumu-pagasts	68	\N	\N
619	rugaju-pagasts	68	\N	\N
620	baltinavas-pagasts	68	\N	\N
621	berzpils-pagasts	68	\N	\N
622	balvu-pagasts	68	\N	\N
623	mednevas-pagasts	68	\N	\N
624	tilzas-pagasts	68	\N	\N
625	susaju-pagasts	68	\N	\N
626	vectilzas-pagasts	68	\N	\N
627	berzkalnes-pagasts	68	\N	\N
628	krisjanu-pagasts	68	\N	\N
629	kupravas-pagasts	68	\N	\N
630	briezuciema-pagasts	68	\N	\N
631	viksnas-pagasts	68	\N	\N
632	mazzalves-pagasts	66	\N	\N
633	aiviekstes-pagasts	66	\N	\N
634	irsu-pagasts	66	\N	\N
635	pilskalnes-pagasts	66	\N	\N
636	serenes-pagasts	66	\N	\N
637	daudzeses-pagasts	66	\N	\N
638	sunakstes-pagasts	66	\N	\N
639	neretas-pagasts	66	\N	\N
640	klintaines-pagasts	66	\N	\N
641	seces-pagasts	66	\N	\N
642	bebru-pagasts	66	\N	\N
643	staburaga-pagasts	66	\N	\N
644	vietalvas-pagasts	66	\N	\N
645	zalves-pagasts	66	\N	\N
646	markalnes-pagasts	67	\N	\N
647	malienas-pagasts	67	\N	\N
648	jaunlaicenes-pagasts	67	\N	\N
649	liepnas-pagasts	67	\N	\N
650	ziemera-pagasts	67	\N	\N
651	malupes-pagasts	67	\N	\N
652	jaunannas-pagasts	67	\N	\N
653	jaunaluksnes-pagasts	67	\N	\N
654	zeltinu-pagasts	67	\N	\N
655	ilzenes-pagasts	67	\N	\N
656	alsviku-pagasts	67	\N	\N
657	kalncempju-pagasts	67	\N	\N
658	veclaicenes-pagasts	67	\N	\N
659	annas-pagasts	67	\N	\N
660	pededzes-pagasts	67	\N	\N
661	valles-pagasts	69	\N	\N
662	viesturu-pagasts	69	\N	\N
663	vecauces-pagasts	70	\N	\N
664	alytus	99	\N	\N
665	daugai	100	\N	\N
666	simnas	100	\N	\N
667	druskininkai	101	\N	\N
668	lazdijai	102	\N	\N
669	varena	103	\N	\N
670	birstonas	104	\N	\N
671	jonava	105	\N	\N
672	kaisiadorys	106	\N	\N
673	ziezmariai	106	\N	\N
674	kaunas	107	\N	\N
675	ezerelis	108	\N	\N
676	garliava	108	\N	\N
677	vilkija	108	\N	\N
678	kedainiai	109	\N	\N
679	prienai	110	\N	\N
680	jieznas	110	\N	\N
681	raseiniai	111	\N	\N
682	ariogala	111	\N	\N
683	klaipeda	112	\N	\N
684	gargzdai	113	\N	\N
685	kretinga	114	\N	\N
686	salantai	114	\N	\N
687	neringa	115	\N	\N
688	palanga	116	\N	\N
689	silute	117	\N	\N
690	skuodas	118	\N	\N
691	kalvarija	119	\N	\N
692	kazlu-ruda	120	\N	\N
693	marijampole	121	\N	\N
694	sakiai	122	\N	\N
695	kudirkos-naumiestis	122	\N	\N
696	vilkaviskis	123	\N	\N
697	kybartai	123	\N	\N
698	kursenai	136	\N	\N
699	siauliai	135	\N	\N
700	radviliskis	134	\N	\N
701	seduva	134	\N	\N
702	pakruojis	133	\N	\N
703	linkuva	133	\N	\N
704	kelme	132	\N	\N
705	tytuvenai	132	\N	\N
706	uzventis	132	\N	\N
707	joniskis	131	\N	\N
708	zagare	131	\N	\N
709	akmene	130	\N	\N
710	naujoji-akmene	130	\N	\N
711	venta	130	\N	\N
712	rokiskis	129	\N	\N
713	obeliai	129	\N	\N
714	pandelys	129	\N	\N
715	pasvalys	128	\N	\N
716	joniskelis	128	\N	\N
717	ramygala	127	\N	\N
718	panevezys	126	\N	\N
719	kupiskis	125	\N	\N
720	subacius	125	\N	\N
721	birzai	124	\N	\N
722	vabalninkas	124	\N	\N
723	jurbarkas	137	\N	\N
724	pagegiai	138	\N	\N
725	silale	139	\N	\N
726	taurage	140	\N	\N
727	skaudvile	140	\N	\N
728	mazeikiai	141	\N	\N
729	vieskniai	141	\N	\N
730	seda	141	\N	\N
731	plunge	142	\N	\N
732	rietavas	143	\N	\N
733	telsiai	144	\N	\N
734	varniai	144	\N	\N
735	anyksciai	145	\N	\N
736	kavarskas	145	\N	\N
737	troskunai	145	\N	\N
738	ignalina	146	\N	\N
739	dukstas	146	\N	\N
740	moletai	147	\N	\N
741	utena	148	\N	\N
742	visaginas	149	\N	\N
743	zarasai	150	\N	\N
744	dusetos	150	\N	\N
745	elektrenai	151	\N	\N
746	vievis	151	\N	\N
747	salcininkai	152	\N	\N
748	eisiskes	152	\N	\N
749	sirvintos	153	\N	\N
750	svencionys	154	\N	\N
751	svencioneliai	154	\N	\N
752	pabrade	154	\N	\N
753	trakai	155	\N	\N
754	lentvaris	155	\N	\N
755	rudiskes	155	\N	\N
756	ukmerge	156	\N	\N
757	vilnius	157	\N	\N
758	nemencine	158	\N	\N
759	tallinn	159	\N	\N
760	tartu	160	\N	\N
761	narva	161	\N	\N
762	parnu	162	\N	\N
763	kohtla-jarve	163	\N	\N
764	viljandi	164	\N	\N
765	rakvere	165	\N	\N
766	sillamae	166	\N	\N
767	maardu	238	\N	\N
768	haapsalu	170	\N	\N
769	paide	172	\N	\N
770	keila	173	\N	\N
771	narva-joesuu	239	\N	\N
772	voru	169	\N	\N
773	valga	168	\N	\N
774	kuressaare	211	\N	\N
775	johvi	171	\N	\N
776	tapa	214	\N	\N
777	rapla	205	\N	\N
778	turi	219	\N	\N
780	voru	227	\N	\N
781	haapsalu	187	\N	\N
782	rakvere	204	\N	\N
783	kunda	223	\N	\N
784	tamsalu	214	\N	\N
787	kardla	180	\N	\N
788	paldiski	186	\N	\N
789	saue	212	\N	\N
790	sindi	217	\N	\N
791	kilingi-nomme	210	\N	\N
792	abja-paluoja	192	\N	\N
793	moisakula	192	\N	\N
794	suure-jaani	199	\N	\N
795	tyri	219	\N	\N
796	polva	201	\N	\N
797	rapina	207	\N	\N
798	otepaa	196	\N	\N
799	elva	177	\N	\N
800	jogeva	183	\N	\N
801	poltsamaa	200	\N	\N
802	viljandi	221	\N	\N
803	torva	218	\N	\N
804	antsla	176	\N	\N
\.


ALTER TABLE public.cities ENABLE TRIGGER ALL;

--
-- Data for Name: city_translations; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.city_translations DISABLE TRIGGER ALL;

COPY public.city_translations (id, city_id, lang_code, name) FROM stdin;
1111	148	lv	Bērzaunes pagasts
1112	148	lt	Bērzaunės valsčius
1113	148	ee	Bērzaune vald
1114	148	ru	волость Берзауне
1115	148	en	Bērzaune Parish
1116	149	lv	Praulienas pagasts
1117	149	lt	Praulienos valsčius
1118	149	ee	Prauliena vald
1119	149	ru	волость Праулиена
1120	149	en	Prauliena Parish
1121	150	lv	Varakļānu pagasts
1122	150	lt	Varakļānų valsčius
1123	150	ee	Varakļāni vald
1124	150	ru	волость Варакляны
1125	150	en	Varakļāni Parish
1126	151	lv	Cesvaines pagasts
1127	151	lt	Cesvainės valsčius
1128	151	ee	Cesvaine vald
1129	151	ru	волость Цесваине
1130	151	en	Cesvaine Parish
1131	152	lv	Sausnējas pagasts
1132	152	lt	Sausnėjos valsčius
1133	152	ee	Sausnēja vald
1134	152	ru	волость Сауснея
1135	152	en	Sausnēja Parish
1136	153	lv	Lazdonas pagasts
1137	153	lt	Lazdonos valsčius
1138	153	ee	Lazdona vald
1139	153	ru	волость Лаздона
1140	153	en	Lazdona Parish
56	9	lv	Rīga
59	9	ru	Рига
60	9	en	Riga
57	9	lt	Ryga
58	9	ee	Riia
61	10	lv	Daugavpils
62	10	lt	Daugpilis
63	10	ee	Daugavpils
64	10	ru	Даугавпилс
65	10	en	Daugavpils
66	11	lv	Liepāja
67	11	lt	Liepoja
68	11	ee	Liepāja
69	11	ru	Лиепая
70	11	en	Liepaja
71	12	lv	Jelgava
72	12	lt	Jelgava
73	12	ee	Jelgava
74	12	ru	Елгава
75	12	en	Jelgava
76	13	lv	Jūrmala
77	13	lt	Jūrmala
78	13	ee	Jūrmala
79	13	ru	Юрмала
80	13	en	Jurmala
81	14	lv	Ventspils
82	14	lt	Ventspilis
83	14	ee	Ventspils
84	14	ru	Вентспилс
85	14	en	Ventspils
86	15	lv	Rēzekne
87	15	lt	Rėzeknė
88	15	ee	Rēzekne
89	15	ru	Резекне
90	15	en	Rezekne
91	16	lv	Ogre
92	16	lt	Ogrė
93	16	ee	Ogre
94	16	ru	Огре
95	16	en	Ogre
96	17	lv	Valmiera
97	17	lt	Valmiera
98	17	ee	Valmiera
99	17	ru	Валмиера
100	17	en	Valmiera
101	18	lv	Jēkabpils
102	18	lt	Jėkabpilis
103	18	ee	Jēkabpils
104	18	ru	Екабпилс
105	18	en	Jēkabpils
171	32	lv	Sabile
172	32	lt	Sabile
173	32	ee	Sabile
174	32	ru	Сабиле
175	32	en	Sabile
176	33	lv	Stende
177	33	lt	Stende
178	33	ee	Stende
179	33	ru	Стенде
180	33	en	Stende
181	34	lv	Talsi
182	34	lt	Talsi
183	34	ee	Talsi
184	34	ru	Талси
185	34	en	Talsi
186	35	lv	Valdemārpils
187	35	lt	Valdemārpils
188	35	ee	Valdemārpils
189	35	ru	Валдемарпилс
190	35	en	Valdemārpils
191	36	lv	Cēsis
192	36	lt	Cēsis
193	36	ee	Cēsis
194	36	ru	Цесис
195	36	en	Cēsis
196	37	lv	Līgatne
197	37	lt	Līgatne
198	37	ee	Līgatne
199	37	ru	Лигатне
200	37	en	Līgatne
201	38	lv	Mazsalaca
202	38	lt	Mazsalaca
203	38	ee	Mazsalaca
204	38	ru	Мазсалаца
205	38	en	Mazsalaca
206	39	lv	Rūjiena
207	39	lt	Rūjiena
208	39	ee	Rūjiena
209	39	ru	Руйиена
210	39	en	Rūjiena
126	23	lv	Ikšķile
127	23	lt	Ikšķile
128	23	ee	Ikšķile
129	23	ru	Икшкиле
130	23	en	Ikšķile
131	24	lv	Ķegums
132	24	lt	Ķegums
133	24	ee	Ķegums
134	24	ru	Кегумс
135	24	en	Ķegums
136	25	lv	Lielvārde
137	25	lt	Lielvārde
138	25	ee	Lielvārde
139	25	ru	Лиелварде
140	25	en	Lielvārde
141	26	lv	Ogre
142	26	lt	Ogre
143	26	ee	Ogre
144	26	ru	Огре
146	27	lv	Ainaži
1141	154	lv	Barkavas pagasts
1142	154	lt	Barkavos valsčius
1143	154	ee	Barkava vald
1144	154	ru	волость Баркава
1145	154	en	Barkava Parish
256	49	lv	Aizpute
257	49	lt	Aizpute
258	49	ee	Aizpute
259	49	ru	Айзпуте
260	49	en	Aizpute
261	50	lv	Durbe
262	50	lt	Durbe
263	50	ee	Durbe
264	50	ru	Дурбе
265	50	en	Durbe
266	51	lv	Grobiņa
267	51	lt	Grobiņa
268	51	ee	Grobiņa
269	51	ru	Гробиня
270	51	en	Grobiņa
271	52	lv	Pāvilosta
272	52	lt	Pāvilosta
273	52	ee	Pāvilosta
274	52	ru	Павилоста
275	52	en	Pāvilosta
276	53	lv	Priekule
277	53	lt	Priekule
278	53	ee	Priekule
279	53	ru	Приекуле
280	53	en	Priekule
281	54	lv	Salaspils
282	54	lt	Salaspils
283	54	ee	Salaspils
284	54	ru	Саласпилс
285	54	en	Salaspils
286	55	lv	Ādaži
287	55	lt	Ādaži
288	55	ee	Ādaži
289	55	ru	Адажи
290	55	en	Ādaži
291	56	lv	Aizkraukle
292	56	lt	Aizkraukle
293	56	ee	Aizkraukle
294	56	ru	Айзкраукле
295	56	en	Aizkraukle
296	57	lv	Jaunjelgava
297	57	lt	Jaunjelgava
298	57	ee	Jaunjelgava
299	57	ru	Яунелгава
300	57	en	Jaunjelgava
301	58	lv	Koknese
302	58	lt	Koknese
303	58	ee	Koknese
304	58	ru	Кокнесе
305	58	en	Koknese
306	59	lv	Pļaviņas
307	59	lt	Pļaviņas
308	59	ee	Pļaviņas
309	59	ru	Плявиняс
310	59	en	Pļaviņas
311	60	lv	Alūksne
312	60	lt	Alūksne
313	60	ee	Alūksne
314	60	ru	Алуксне
315	60	en	Alūksne
1146	155	lv	Vestienas pagasts
1147	155	lt	Vestienos valsčius
1148	155	ee	Vestiena vald
1149	155	ru	волость Вестиена
1150	155	en	Vestiena Parish
1151	156	lv	Ošupes pagasts
1152	156	lt	Ošupės valsčius
1153	156	ee	Ošupe vald
1154	156	ru	волость Ошупе
346	67	lv	Gulbene
347	67	lt	Gulbene
348	67	ee	Gulbene
349	67	ru	Гулбене
350	67	en	Gulbene
351	68	lv	Aknīste
352	68	lt	Aknīste
353	68	ee	Aknīste
354	68	ru	Акнисте
355	68	en	Aknīste
356	69	lv	Viesīte
357	69	lt	Viesīte
358	69	ee	Viesīte
359	69	ru	Виесите
360	69	en	Viesīte
336	65	lv	Auce
337	65	lt	Auce
338	65	ee	Auce
339	65	ru	Ауце
340	65	en	Auce
341	66	lv	Dobele
342	66	lt	Dobele
343	66	ee	Dobele
344	66	ru	Добеле
345	66	en	Dobele
316	61	lv	Balvi
317	61	lt	Balvi
318	61	ee	Balvi
319	61	ru	Балви
320	61	en	Balvi
321	62	lv	Viļaka
322	62	lt	Viļaka
323	62	ee	Viļaka
211	40	lv	Seda
212	40	lt	Seda
213	40	ee	Seda
214	40	ru	Седа
215	40	en	Seda
216	41	lv	Strenči
217	41	lt	Strenči
218	41	ee	Strenči
219	41	ru	Стренчи
220	41	en	Strenči
236	45	lv	Kuldīga
237	45	lt	Kuldīga
238	45	ee	Kuldīga
239	45	ru	Кулдига
240	45	en	Kuldīga
241	46	lv	Skrunda
242	46	lt	Skrunda
243	46	ee	Skrunda
244	46	ru	Скрунда
245	46	en	Skrunda
246	47	lv	Kandava
247	47	lt	Kandava
248	47	ee	Kandava
249	47	ru	Кандава
250	47	en	Kandava
251	48	lv	Tukums
252	48	lt	Tukums
253	48	ee	Tukums
254	48	ru	Тукумс
255	48	en	Tukums
226	43	lv	Brocēni
227	43	lt	Brocēni
228	43	ee	Brocēni
229	43	ru	Броцени
230	43	en	Brocēni
231	44	lv	Saldus
232	44	lt	Saldus
233	44	ee	Saldus
234	44	ru	Салдус
235	44	en	Saldus
376	73	lv	Līvāni
377	73	lt	Līvāni
378	73	ee	Līvāni
379	73	ru	Ливаны
380	73	en	Līvāni
1155	156	en	Ošupe Parish
1156	157	lv	Ļaudonas pagasts
1157	157	lt	Ļaudonos valsčius
1158	157	ee	Ļaudona vald
1159	157	ru	волость Ляудона
1160	157	en	Ļaudona Parish
1161	158	lv	Kalsnavas pagasts
1162	158	lt	Kalsnavos valsčius
1163	158	ee	Kalsnava vald
1164	158	ru	волость Калснава
1165	158	en	Kalsnava Parish
1166	159	lv	Jumurdas pagasts
1167	159	lt	Jumurdos valsčius
1168	159	ee	Jumurda vald
1169	159	ru	волость Юмурда
396	77	lv	Mārupe
397	77	lt	Mārupe
398	77	ee	Mārupe
399	77	ru	Марупе
400	77	en	Mārupe
401	78	lv	Olaine
402	78	lt	Olaine
403	78	ee	Olaine
404	78	ru	Олайне
405	78	en	Olaine
416	81	lv	Vangaži
417	81	lt	Vangaži
418	81	ee	Vangaži
419	81	ru	Вангажи
420	81	en	Vangaži
421	82	lv	Saulkrasti
422	82	lt	Saulkrasti
423	82	ee	Saulkrasti
424	82	ru	Saulkrasti
425	82	en	Saulkrasti
431	84	lv	Ape
432	84	lt	Ape
433	84	ee	Ape
434	84	ru	Апe
435	84	en	Ape
436	85	lv	Smiltene
437	85	lt	Smiltene
438	85	ee	Smiltene
439	85	ru	Смилтене
440	85	en	Smiltene
1170	159	en	Jumurda Parish
1171	160	lv	Ērgļu pagasts
1172	160	lt	Ērglių valsčius
1173	160	ee	Ērgļi vald
1174	160	ru	волость Эргли
446	87	lv	Piltene
447	87	lt	Piltene
448	87	ee	Piltene
449	87	ru	Пилтене
450	87	en	Piltene
451	88	lv	Baldone
452	88	lt	Baldone
453	88	ee	Baldone
454	88	ru	Балдоне
455	88	en	Baldone
456	89	lv	Baloži
457	89	lt	Baloži
458	89	ee	Baloži
459	89	ru	Баложи
460	89	en	Baloži
461	90	lv	Ķekava
462	90	lt	Ķekava
463	90	ee	Ķekava
464	90	ru	Кекава
465	90	en	Ķekava
466	91	lv	Ilūkste
467	91	lt	Ilūkste
468	91	ee	Ilūkste
469	91	ru	Илуксте
470	91	en	Ilūkste
471	92	lv	Subate
472	92	lt	Subate
473	92	ee	Subate
474	92	ru	Субате
475	92	en	Subate
1175	160	en	Ērgļi Parish
1176	161	lv	Mārcienas pagasts
1177	161	lt	Mārcienos valsčius
1178	161	ee	Mārciena vald
1179	161	ru	волость Марциена
1180	161	en	Mārciena Parish
1181	162	lv	Indrānu pagasts
1182	162	lt	Indrānų valsčius
1183	162	ee	Indrāni vald
1184	162	ru	волость Индрани
1185	162	en	Indrāni Parish
1186	163	lv	Liezēres pagasts
1187	163	lt	Liezērės valsčius
1188	163	ee	Liezēre vald
1189	163	ru	волость Лиезере
1190	163	en	Liezēre Parish
1191	164	lv	Mētrienas pagasts
1192	164	lt	Mētrienos valsčius
1193	164	ee	Mētriena vald
1194	164	ru	волость Метриена
1195	164	en	Mētriena Parish
1196	165	lv	Sarkaņu pagasts
1197	165	lt	Sarkaņu valsčius
1198	165	ee	Sarkaņi vald
1199	165	ru	волость Саркань
1200	165	en	Sarkaņi Parish
1201	166	lv	Murmastienes pagasts
1202	166	lt	Murmastienės valsčius
1203	166	ee	Murmastiene vald
1204	166	ru	волость Мурмастине
366	71	lv	Dagda
367	71	lt	Dagda
368	71	ee	Dagda
369	71	ru	Дагда
370	71	en	Dagda
371	72	lv	Krāslava
372	72	lt	Krāslava
373	72	ee	Krāslava
374	72	ru	Краслава
375	72	en	Krāslava
426	83	lv	Sigulda
427	83	lt	Sigulda
428	83	ee	Sigulda
429	83	ru	Сигулда
430	83	en	Sigulda
411	80	lv	Viļāni
412	80	lt	Viļāni
413	80	ee	Viļāni
414	80	ru	Виляны
415	80	en	Viļāni
406	79	lv	Preiļi
407	79	lt	Preiļi
408	79	ee	Preiļi
409	79	ru	Прейли
410	79	en	Preiļi
106	19	lv	Madona
107	19	lt	Madona
108	19	ee	Madona
1205	166	en	Murmastiene Parish
1206	167	lv	Aronas pagasts
1207	167	lt	Aronos valsčius
1208	167	ee	Arona vald
1209	167	ru	волость Арона
1210	167	en	Arona Parish
1211	168	lv	Dzelzavas pagasts
1212	168	lt	Dzelzavos valsčius
1213	168	ee	Dzelzava vald
1214	168	ru	волость Дзелзава
1215	168	en	Dzelzava Parish
1681	234	lv	Šēderes pagasts
1682	234	lt	Šėderės valsčius
1683	234	ee	Šēdere vald
1684	234	ru	волость Шедере
1685	234	en	Šēdere Parish
1686	235	lv	Ambeļu pagasts
1687	235	lt	Ambelių valsčius
1688	235	ee	Ambeļi vald
1689	235	ru	волость Амбели
1690	235	en	Ambeļi Parish
1691	236	lv	Tabores pagasts
1692	236	lt	Taborės valsčius
1693	236	ee	Tabore vald
1694	236	ru	волость Таборе
1695	236	en	Tabore Parish
1696	237	lv	Vecsalienas pagasts
1697	237	lt	Vecsalienos valsčius
1698	237	ee	Vecsaliena vald
1699	237	ru	волость Вецсалиена
1700	237	en	Vecsaliena Parish
1701	238	lv	Bebrenes pagasts
1702	238	lt	Bebrenės valsčius
1703	238	ee	Bebrene vald
1704	238	ru	волость Бебрене
1705	238	en	Bebrene Parish
1706	239	lv	Prodes pagasts
1707	239	lt	Prodės valsčius
1708	239	ee	Prode vald
1709	239	ru	волость Проде
1710	239	en	Prode Parish
1711	240	lv	Dubnas pagasts
1712	240	lt	Dubnos valsčius
1713	240	ee	Dubna vald
1714	240	ru	волость Дубна
1376	201	lv	Aglonas pagasts
1377	201	lt	Aglonos valsčius
1378	201	ee	Aglona vald
1379	201	ru	волость Аглона
1380	201	en	Aglona Parish
1715	240	en	Dubna Parish
1716	241	lv	Laucesas pagasts
1717	241	lt	Laucesos valsčius
1718	241	ee	Laucesa vald
1719	241	ru	волость Лауцеса
326	63	lv	Bauska
327	63	lt	Bauska
328	63	ee	Bauska
329	63	ru	Бауска
330	63	en	Bauska
331	64	lv	Iecava
332	64	lt	Iecava
333	64	ee	Iecava
334	64	ru	Иецава
335	64	en	Iecava
3567	566	lv	Bārbeles pagasts
3568	566	lt	Bārbelės valsčius
3569	566	ee	Bārbele vald
3570	566	ru	волость Барбеле
3571	566	en	Bārbele Parish
3572	564	lv	Brunavas pagasts
3573	564	lt	Brunavos valsčius
3574	564	ee	Brunava vald
3575	564	ru	волость Брунава
3576	564	en	Brunava Parish
3577	553	lv	Ceraukstes pagasts
3578	553	lt	Ceraukstės valsčius
3579	553	ee	Ceraukste vald
3580	553	ru	волость Церауксте
3581	553	en	Ceraukste Parish
3582	552	lv	Codes pagasts
3583	552	lt	Kodės valsčius
3584	552	ee	Code vald
3585	552	ru	волость Коде
3586	552	en	Code Parish
3587	554	lv	Dāviņu pagasts
3588	554	lt	Dāviņų valsčius
324	62	ru	Виляка
325	62	en	Viļaka
3589	554	ee	Dāviņi vald
3590	554	ru	волость Давини
3591	554	en	Dāviņi Parish
3592	551	lv	Gailīšu pagasts
1720	241	en	Laucesa Parish
1336	193	lv	Galēnu pagasts
1337	193	lt	Galėnų valsčius
1338	193	ee	Galēni vald
381	74	lv	Kārsava
382	74	lt	Kārsava
383	74	ee	Kārsava
384	74	ru	Карсава
385	74	en	Kārsava
386	75	lv	Ludza
387	75	lt	Ludza
388	75	ee	Ludza
389	75	ru	Лудза
390	75	en	Ludza
391	76	lv	Zilupe
392	76	lt	Zilupe
393	76	ee	Zilupe
394	76	ru	Зилупе
395	76	en	Zilupe
1339	193	ru	волость Галену
1340	193	en	Galēni Parish
1331	192	lv	Preiļu pagasts
1381	202	lv	Rožkalnu pagasts
1382	202	lt	Rožkalnų valsčius
1383	202	ee	Rožkalni vald
1384	202	ru	волость Рожкални
1385	202	en	Rožkalni Parish
1356	197	lv	Sīļukalna pagasts
1357	197	lt	Sīļukalno valsčius
1358	197	ee	Sīļukalns vald
1359	197	ru	волость Сийлукалнс
1360	197	en	Sīļukalns Parish
1326	191	lv	Upmalas pagasts
1327	191	lt	Upmalos valsčius
1328	191	ee	Upmala vald
1329	191	ru	волость Упмала
1330	191	en	Upmala Parish
1391	204	lv	Vārkavas pagasts
1392	204	lt	Vārkavos valsčius
1393	204	ee	Vārkava vald
1394	204	ru	волость Варкaва
1395	204	en	Vārkava Parish
1721	242	lv	Medumu pagasts
1722	242	lt	Medumų valsčius
1723	242	ee	Medumi vald
1724	242	ru	волость Медуми
1725	242	en	Medumi Parish
1726	243	lv	Dvietes pagasts
1727	243	lt	Dvieties valsčius
1728	243	ee	Dviete vald
1729	243	ru	волость Двиете
1730	243	en	Dviete Parish
1731	244	lv	Biķernieku pagasts
1732	244	lt	Biķerniekų valsčius
1733	244	ee	Biķernieki vald
1734	244	ru	волость Бикерниеки
1735	244	en	Biķernieki Parish
1736	245	lv	Kalkūnes pagasts
1737	245	lt	Kalkūnės valsčius
1738	245	ee	Kalkūne vald
1739	245	ru	волость Калкуне
1740	245	en	Kalkūne Parish
1741	246	lv	Pilskalnes pagasts
1742	246	lt	Pilskalnės valsčius
1743	246	ee	Pilskalne vald
1744	246	ru	волость Пилскалне
1745	246	en	Pilskalne Parish
811	129	lv	Naukšēni
812	129	lt	Naukšēni
813	129	ee	Naukšēni
814	129	ru	Наукшени
815	129	en	Naukšēni
221	42	lv	Valmiera
222	42	lt	Valmiera
223	42	ee	Valmiera
224	42	ru	Валмиера
225	42	en	Valmiera
1746	247	lv	Demenes pagasts
1747	247	lt	Demenės valsčius
1748	247	ee	Demene vald
1749	247	ru	волость Дэмэне
1750	247	en	Demene Parish
1751	248	lv	Maļinovas pagasts
1752	248	lt	Maļinovos valsčius
1753	248	ee	Maļinova vald
1754	248	ru	волость Малинова
1755	248	en	Maļinova Parish
1756	249	lv	Naujenes pagasts
1757	249	lt	Naujenės valsčius
1758	249	ee	Naujene vald
1759	249	ru	волость Науене
1760	249	en	Naujene Parish
1761	250	lv	Višķu pagasts
1762	250	lt	Viškių valsčius
1763	250	ee	Višķi vald
1764	250	ru	волость Вишки
1765	250	en	Višķi Parish
1766	251	lv	Kalupes pagasts
1767	251	lt	Kalupės valsčius
1768	251	ee	Kalupe vald
1769	251	ru	волость Калупе
1770	251	en	Kalupe Parish
1771	252	lv	Eglaines pagasts
1772	252	lt	Eglainės valsčius
1773	252	ee	Eglaine vald
1774	252	ru	волость Эглайне
1775	252	en	Eglaine Parish
1776	253	lv	Skrudalienas pagasts
1236	173	lv	Atašienes pagasts
1226	171	lv	Mežāres pagasts
1227	171	lt	Mežarės valsčius
1228	171	ee	Mežāre vald
1229	171	ru	волость Межаре
1230	171	en	Mežāre Parish
926	140	lv	Malta
927	141	lv	Lūznavā
929	140	lt	Malta
930	141	lt	Lūznavā
932	140	ee	Malta
933	141	ee	Lūznavā
935	140	ru	Малта
936	141	ru	Лузнава
938	140	en	Malta
939	141	en	Lūznavā
951	144	lv	Riebiņi
952	144	lt	Riebiņi
953	144	ee	Riebiņi
954	144	ru	Риебини
955	144	en	Riebiņi
109	19	ru	Мадона
110	19	en	Madona
111	20	lv	Varakļāni
112	20	lt	Varakļāni
113	20	ee	Varakļāni
114	20	ru	Варакляны
115	20	en	Varakļāni
116	21	lv	Lubāna
117	21	lt	Lubāna
118	21	ee	Lubāna
119	21	ru	Лубана
120	21	en	Lubāna
121	22	lv	Cesvaine
122	22	lt	Cesvaine
123	22	ee	Cesvaine
124	22	ru	Цесвайне
125	22	en	Cesvaine
145	26	en	Ogre
1777	253	lt	Skrudalienos valsčius
1778	253	ee	Skrudaliena vald
1779	253	ru	волость Скрудалена
1780	253	en	Skrudaliena Parish
1781	254	lv	Līksnas pagasts
1782	254	lt	Līksnos valsčius
1783	254	ee	Līksna vald
1784	254	ru	волость Ликсна
1785	254	en	Līksna Parish
1786	255	lv	Vaboles pagasts
1787	255	lt	Vabolės valsčius
1788	255	ee	Vabole vald
1789	255	ru	волость Ваболе
1790	255	en	Vabole Parish
1791	256	lv	Sventes pagasts
1792	256	lt	Sventės valsčius
147	27	lt	Ainaži
148	27	ee	Ainaži
149	27	ru	Айнажи
150	27	en	Ainaži
151	28	lv	Aloja
152	28	lt	Aloja
153	28	ee	Aloja
154	28	ru	Алоя
155	28	en	Aloja
156	29	lv	Limbaži
157	29	lt	Limbaži
158	29	ee	Limbaži
159	29	ru	Лимбажи
160	29	en	Limbaži
161	30	lv	Salacgrīva
162	30	lt	Salacgrīva
163	30	ee	Salacgrīva
164	30	ru	Салацгрива
165	30	en	Salacgrīva
166	31	lv	Staicele
167	31	lt	Staicele
168	31	ee	Staicele
169	31	ru	Стайцеле
170	31	en	Staicele
1793	256	ee	Svente vald
1794	256	ru	волость Свенте
1795	256	en	Svente Parish
1796	257	lv	Nīcgales pagasts
1797	257	lt	Nīcgalės valsčius
1798	257	ee	Nīcgale vald
1799	257	ru	волость Ницгале
1800	257	en	Nīcgale Parish
1801	258	lv	Salienas pagasts
1802	258	lt	Salienos valsčius
1803	258	ee	Saliena vald
1804	258	ru	волость Салиена
1805	258	en	Saliena Parish
1821	262	lv	Cēres pagasts
1822	262	lt	Cėrės valsčius
1823	262	ee	Cēre vald
1824	262	ru	волость Цере
1825	262	en	Cēre Parish
1826	263	lv	Vānes pagasts
1827	263	lt	Vānės valsčius
1828	263	ee	Vāne vald
1829	263	ru	волость Ване
1830	263	en	Vāne Parish
1831	264	lv	Lestenes pagasts
1832	264	lt	Lestenės valsčius
1833	264	ee	Lestene vald
1834	264	ru	волость Лестене
1835	264	en	Lestene Parish
1836	265	lv	Matkules pagasts
1837	265	lt	Matkulės valsčius
441	86	lv	Valka
442	86	lt	Valka
443	86	ee	Valka
444	86	ru	Валка
445	86	en	Valka
1838	265	ee	Matkule vald
1839	265	ru	волость Маткуле
1840	265	en	Matkule Parish
1841	266	lv	Džūkstes pagasts
1842	266	lt	Džūkstės valsčius
1843	266	ee	Džūkste vald
1844	266	ru	волость Джуксте
1845	266	en	Džūkste Parish
1846	267	lv	Smārdes pagasts
1847	267	lt	Smardės valsčius
1848	267	ee	Smārde vald
1849	267	ru	волость Смардe
1850	267	en	Smārde Parish
1851	268	lv	Sēmes pagasts
1852	268	lt	Sėmės valsčius
1853	268	ee	Sēme vald
1854	268	ru	волость Семе
1855	268	en	Sēme Parish
1856	269	lv	Tumes pagasts
1857	269	lt	Tumės valsčius
1858	269	ee	Tume vald
1859	269	ru	волость Туме
3593	551	lt	Gailišių valsčius
3594	551	ee	Gailīši vald
3595	551	ru	волость Гайлиши
3596	551	en	Gailīši Parish
3597	556	lv	Īslīces pagasts
3598	556	lt	Īslīcės valsčius
3599	556	ee	Īslīce vald
3600	556	ru	волость Исліце
3601	556	en	Īslīce Parish
3602	563	lv	Iecavas pagasts
3603	563	lt	Iecavos valsčius
3604	563	ee	Iecava vald
3605	563	ru	волость Ияцава
3606	563	en	Iecava Parish
3607	565	lv	Kurmenes pagasts
3608	565	lt	Kurmenės valsčius
3609	565	ee	Kurmene vald
3610	565	ru	волость Курмене
3611	565	en	Kurmene Parish
3612	557	lv	Mežotnes pagasts
3613	557	lt	Mežotnės valsčius
3614	557	ee	Mežotne vald
3615	557	ru	волость Межотне
3616	557	en	Mežotne Parish
3617	560	lv	Rundāles pagasts
3618	560	lt	Rundālės valsčius
3619	560	ee	Rundāle vald
3620	560	ru	волость Рундалі
3621	560	en	Rundāle Parish
3622	558	lv	Skaistkalnes pagasts
3623	558	lt	Skaistkalnės valsčius
3624	558	ee	Skaistkalne vald
3625	558	ru	волость Скайсткалне
3626	558	en	Skaistkalne Parish
3627	555	lv	Stelpes pagasts
3628	555	lt	Stelpės valsčius
3629	555	ee	Stelpe vald
3630	555	ru	волость Стелпе
3631	555	en	Stelpe Parish
3632	562	lv	Svitenei pagasts
3633	562	lt	Svitenės valsčius
3634	562	ee	Svitene vald
3635	562	ru	волость Свитене
3636	562	en	Svitene Parish
3637	561	lv	Vecsaules pagasts
3638	561	lt	Vecsaulės valsčius
3639	561	ee	Vecsaules vald
3640	561	ru	волость Вецсауле
3641	561	en	Vecsaules Parish
3642	559	lv	Vecumnieku pagasts
3643	559	lt	Vecumniekų valsčius
3644	559	ee	Vecumnieki vald
3645	559	ru	волость Вецумниеки
3646	559	en	Vecumnieki Parish
3647	570	lv	Annenieku pagasts
3648	570	lt	Anneniekų valsčius
3649	570	ee	Annenieki vald
3650	570	ru	волость Аннениеки
3651	570	en	Annenieki Parish
3652	572	lv	Auru pagasts
3653	572	lt	Aurų valsčius
3654	572	ee	Auru vald
3655	572	ru	волость Ауру
3656	572	en	Auru Parish
3657	583	lv	Bērzes pagasts
3658	583	lt	Bērzės valsčius
3659	583	ee	Bērze vald
3660	583	ru	волость Берзе
3661	583	en	Bērze Parish
1491	224	lv	Silmalas pagasts
1492	224	lt	Silmalos valsčius
1493	224	ee	Silmala vald
1494	224	ru	волость Силмала
1495	224	en	Silmala Parish
3662	584	lv	Bikstu pagasts
3663	584	lt	Bikstų valsčius
3664	584	ee	Biksti vald
3665	584	ru	волость Биксти
3666	584	en	Biksti Parish
3667	568	lv	Dobeles pagasts
3668	568	lt	Dobelės valsčius
3669	568	ee	Dobele vald
3670	568	ru	волость Добеле
3671	568	en	Dobele Parish
3672	580	lv	Jaunbērzes pagasts
3673	580	lt	Jaunbėrzės valsčius
3674	580	ee	Jaunbērze vald
3675	580	ru	волость Яунберзе
3676	580	en	Jaunbērze Parish
3677	581	lv	Krimūnas pagasts
3678	581	lt	Krimūnų valsčius
3679	581	ee	Krimūna vald
3680	581	ru	волость Кримуна
3681	581	en	Krimūna Parish
3682	574	lv	Naudītes pagasts
3683	574	lt	Naudītės valsčius
3684	574	ee	Naudīte vald
3685	574	ru	волость Наудите
3686	574	en	Naudīte Parish
3687	579	lv	Penkules pagasts
3688	579	lt	Penkulės valsčius
3689	579	ee	Penkule vald
3690	579	ru	волость Пенкуле
3691	579	en	Penkule Parish
3692	571	lv	Zebrenes pagasts
3693	571	lt	Zebrenės valsčius
3694	571	ee	Zebrene vald
3695	571	ru	волость Зебрене
3696	571	en	Zebrene Parish
3697	575	lv	Bēnes pagasts
3698	575	lt	Bėnės valsčius
3699	575	ee	Bēne vald
1351	196	lv	Aizkalnes pagasts
1352	196	lt	Aizkalnės valsčius
1353	196	ee	Aizkalne vald
1354	196	ru	волость Айзкалне
1355	196	en	Aizkalne Parish
1371	200	lv	Pelēču pagasts
1372	200	lt	Pelėčių valsčius
1373	200	ee	Pelēči vald
1374	200	ru	волость Пелечи
1375	200	en	Pelēči Parish
1332	192	lt	Preilių valsčius
1333	192	ee	Preiļi vald
1334	192	ru	волость Прейли
1335	192	en	Preiļi Parish
1366	199	lv	Riebiņu pagasts
1367	199	lt	Riebiñų valsčius
1368	199	ee	Riebiņi vald
1369	199	ru	волость Риебиньи
1370	199	en	Riebiņi Parish
1361	198	lv	Rušonas pagasts
1362	198	lt	Rušonos valsčius
1363	198	ee	Rušona vald
1364	198	ru	волость Рушона
1365	198	en	Rušona Parish
1386	203	lv	Saunas pagasts
1387	203	lt	Saunos valsčius
1388	203	ee	Sauna vald
1389	203	ru	волость Саунa
1390	203	en	Sauna Parish
1341	194	lv	Silajāņu pagasts
1342	194	lt	Silajānų valsčius
1343	194	ee	Silajāņi vald
1344	194	ru	волость Силаяни
1345	194	en	Silajāņi Parish
1346	195	lv	Stabulnieku pagasts
1347	195	lt	Stabulniekų valsčius
1348	195	ee	Stabulnieki vald
1349	195	ru	волость Стабулники
1350	195	en	Stabulnieki Parish
1806	259	lv	Baldones pagasts
1807	260	lv	Ķekavas pagasts
1808	261	lv	Daugmales pagasts
1809	259	lt	Baldonės valsčius
1810	260	lt	Kėkavos valsčius
1811	261	lt	Daugmalės valsčius
1812	259	ee	Baldone vald
1813	260	ee	Ķekava vald
1814	261	ee	Daugmale vald
1815	259	ru	волость Балдоне
1816	260	ru	волость Кекава
1817	261	ru	волость Даугмале
1818	259	en	Baldone Parish
1819	260	en	Ķekava Parish
1820	261	en	Daugmale Parish
1860	269	en	Tume Parish
1861	270	lv	Degoles pagasts
1862	270	lt	Degolės valsčius
1863	270	ee	Degole vald
1864	270	ru	волость Деголе
1865	270	en	Degole Parish
1866	271	lv	Irlavas pagasts
1867	271	lt	Irlavos valsčius
1868	271	ee	Irlava vald
1869	271	ru	волость Ирлава
1870	271	en	Irlava Parish
1871	272	lv	Zemītes pagasts
1872	272	lt	Zemītės valsčius
1873	272	ee	Zemīte vald
1874	272	ru	волость Земите
1875	272	en	Zemīte Parish
1876	273	lv	Zantes pagasts
1877	273	lt	Zantės valsčius
1878	273	ee	Zante vald
1879	273	ru	волость Занте
1880	273	en	Zante Parish
1881	274	lv	Lapmežciema pagasts
1882	274	lt	Lapmežciemo valsčius
1883	274	ee	Lapmežciems vald
1884	274	ru	волость Лапмежциемс
1885	274	en	Lapmežciems Parish
1886	275	lv	Slampes pagasts
1887	275	lt	Slampės valsčius
1888	275	ee	Slampe vald
1889	275	ru	волость Слампе
1890	275	en	Slampe Parish
1891	276	lv	Viesatu pagasts
1892	276	lt	Viesatų valsčius
1893	276	ee	Viesati vald
1894	276	ru	волость Виесаты
1895	276	en	Viesati Parish
1896	277	lv	Jaunsātu pagasts
1897	277	lt	Jaunsatų valsčius
1898	277	ee	Jaunsāti vald
1899	277	ru	волость Яунсати
1900	277	en	Jaunsāti Parish
1901	278	lv	Engures pagasts
1902	278	lt	Engurės valsčius
1903	278	ee	Engure vald
1904	278	ru	волость Энгуре
1905	278	en	Engure Parish
1906	279	lv	Zentenes pagasts
1907	279	lt	Zentenės valsčius
1908	279	ee	Zentene vald
1909	279	ru	волость Зентене
1910	279	en	Zentene Parish
1911	280	lv	Jaunpils pagasts
1912	280	lt	Jaunpilio valsčius
1913	280	ee	Jaunpils vald
1914	280	ru	волость Яунпилс
1915	280	en	Jaunpils Parish
1273	180	ee	Asare vald
1916	281	lv	Kandavas pagasts
1917	281	lt	Kandavos valsčius
1918	281	ee	Kandava vald
1919	281	ru	волость Кандава
1920	281	en	Kandava Parish
1921	282	lv	Pūres pagasts
1922	282	lt	Pūrės valsčius
1923	282	ee	Pūre vald
1924	282	ru	волость Пуре
1925	282	en	Pūre Parish
1926	283	lv	Turlavas pagasts
1927	283	lt	Turlavos valsčius
1928	283	ee	Turlava vald
1929	283	ru	волость Турлава
1930	283	en	Turlava Parish
1931	284	lv	Īvandes pagasts
1932	284	lt	Īvandės valsčius
1933	284	ee	Īvande vald
1934	284	ru	волость Ивандe
1935	284	en	Īvande Parish
1936	285	lv	Kurmāles pagasts
1937	285	lt	Kurmālės valsčius
1938	285	ee	Kurmāle vald
1939	285	ru	волость Курмале
1940	285	en	Kurmāle Parish
1941	286	lv	Rumbas pagasts
1942	286	lt	Rumbos valsčius
1943	286	ee	Rumba vald
1944	286	ru	волость Румба
1945	286	en	Rumba Parish
1946	287	lv	Vārmes pagasts
1947	287	lt	Varmės valsčius
1948	287	ee	Vārme vald
1949	287	ru	волость Варме
1950	287	en	Vārme Parish
1951	288	lv	Pelču pagasts
1952	288	lt	Pelčų valsčius
1953	288	ee	Pelči vald
1954	288	ru	волость Пелчи
1955	288	en	Pelči Parish
1956	289	lv	Gudenieku pagasts
1957	289	lt	Gudeniekų valsčius
1958	289	ee	Gudenieki vald
1959	289	ru	волость Гудениеки
1960	289	en	Gudenieki Parish
1961	290	lv	Rendas pagasts
1962	290	lt	Rendos valsčius
1963	290	ee	Renda vald
1964	290	ru	волость Ренда
1965	290	en	Renda Parish
1966	291	lv	Skrundas pagasts
1967	291	lt	Skrundos valsčius
1968	291	ee	Skrunda vald
1969	291	ru	волость Скрунда
1970	291	en	Skrunda Parish
1971	292	lv	Rudbāržu pagasts
1972	292	lt	Rudbāržų valsčius
1973	292	ee	Rudbārži vald
1974	292	ru	волость Рудбаржи
1975	292	en	Rudbārži Parish
1976	293	lv	Laidu pagasts
1977	293	lt	Laidų valsčius
1978	293	ee	Laidi vald
1979	293	ru	волость Лайды
1980	293	en	Laidi Parish
1981	294	lv	Kabiles pagasts
1982	294	lt	Kabilės valsčius
1983	294	ee	Kabile vald
1984	294	ru	волость Кабиле
1985	294	en	Kabile Parish
1986	295	lv	Nīkrāces pagasts
1987	295	lt	Nīkracės valsčius
1988	295	ee	Nīkrāce vald
1989	295	ru	волость Никраце
1990	295	en	Nīkrāce Parish
1991	296	lv	Padures pagasts
1992	296	lt	Padurės valsčius
1993	296	ee	Padure vald
1994	296	ru	волость Падуре
1995	296	en	Padure Parish
1996	297	lv	Raņķu pagasts
1997	297	lt	Raņkių valsčius
1998	297	ee	Raņķi vald
1999	297	ru	волость Раньки
2000	297	en	Raņķi Parish
2001	298	lv	Alsungas pagasts
2002	298	lt	Alsungos valsčius
2003	298	ee	Alsunga vald
2004	298	ru	волость Алсунга
2005	298	en	Alsunga Parish
2006	299	lv	Snēpeles pagasts
2007	299	lt	Snēpelės valsčius
2008	299	ee	Snēpele vald
2009	299	ru	волость Снепеле
2010	299	en	Snēpele Parish
2081	314	lv	Īves pagasts
2082	314	lt	Īvės valsčius
2083	314	ee	Īve vald
2084	314	ru	волость Иве
2085	314	en	Īve Parish
2116	321	lv	Cieceres pagasts
2117	321	lt	Ciecerės valsčius
2118	321	ee	Ciecere vald
2119	321	ru	волость Циецере
2120	321	en	Ciecere Parish
2146	327	lv	Ezeres pagasts
2147	327	lt	Ezeros valsčius
2148	327	ee	Ezere vald
2149	327	ru	волость Эзере
2150	327	en	Ezere Parish
2151	328	lv	Gaiķu pagasts
2152	328	lt	Gaiķių valsčius
2153	328	ee	Gaiķi vald
2154	328	ru	волость Гайки
2155	328	en	Gaiķi Parish
2156	329	lv	Jaunauces pagasts
2157	329	lt	Jaunaucės valsčius
2158	329	ee	Jaunauce vald
2159	329	ru	волость Яунауце
2160	329	en	Jaunauce Parish
2171	332	lv	Jaunlutriņu pagasts
2172	332	lt	Jaunlutriņų valsčius
2173	332	ee	Jaunlutriņi vald
2174	332	ru	волость Яунлутрини
2175	332	en	Jaunlutriņi Parish
2126	323	lv	Kursīšu pagasts
2127	323	lt	Kursišių valsčius
2128	323	ee	Kursīši vald
2129	323	ru	волость Курсищи
2130	323	en	Kursīši Parish
2121	322	lv	Nīgrandes pagasts
2122	322	lt	Nīgrandės valsčius
2123	322	ee	Nīgrande vald
2124	322	ru	волость Нигранде
2125	322	en	Nīgrande Parish
2101	318	lv	Novadnieku pagasts
2102	318	lt	Novadniekų valsčius
2103	318	ee	Novadnieki vald
2104	318	ru	волость Новадниеки
2105	318	en	Novadnieki Parish
2141	326	lv	Pampāļu pagasts
2142	326	lt	Pampālių valsčius
2196	337	lv	Vaidavas pagasts
2197	337	lt	Vaidavos valsčius
2198	337	ee	Vaidava vald
2199	337	ru	волость Вайдава
2200	337	en	Vaidava Parish
2201	338	lv	Jērcēnu pagasts
2202	338	lt	Jērcėnų valsčius
2203	338	ee	Jērcēni vald
2204	338	ru	волость Ерцены
2205	338	en	Jērcēni Parish
2206	339	lv	Bērzaines pagasts
2207	339	lt	Bėrzainės valsčius
2209	339	ru	волость Бэрзаине
3700	575	ru	волость Бэне
2211	340	lv	Lodes pagasts
2212	340	lt	Lodės valsčius
2213	340	ee	Lode vald
2214	340	ru	волость Лоде
2215	340	en	Lode Parish
2216	341	lv	Skaņkalnes pagasts
2217	341	lt	Skaņkalnės valsčius
2218	341	ee	Skaņkalne vald
2219	341	ru	волость Сканькалне
2220	341	en	Skaņkalne Parish
2221	342	lv	Burtnieku pagasts
2222	342	lt	Burtniekų valsčius
2223	342	ee	Burtnieki vald
2224	342	ru	волость Буртниеки
2225	342	en	Burtnieki Parish
2226	343	lv	Valmieras pagasts
2227	343	lt	Valmieros valsčius
2228	343	ee	Valmiera vald
2229	343	ru	волость Валмиера
2230	343	en	Valmiera Parish
2231	344	lv	Matīšu pagasts
2232	344	lt	Matīšių valsčius
2233	344	ee	Matīši vald
2234	344	ru	волость Матиши
2235	344	en	Matīši Parish
2236	345	lv	Vecates pagasts
2237	345	lt	Vecatės valsčius
2238	345	ee	Vecate vald
2239	345	ru	волость Вецате
2240	345	en	Vecate Parish
2241	346	lv	Plāņu pagasts
2242	346	lt	Plānių valsčius
2243	346	ee	Plāņi vald
2244	346	ru	волость Плāни
2245	346	en	Plāņi Parish
2246	347	lv	Kauguru pagasts
2247	347	lt	Kaugurų valsčius
2248	347	ee	Kauguri vald
2249	347	ru	волость Каугури
2250	347	en	Kauguri Parish
2251	348	lv	Sēļu pagasts
2252	348	lt	Sėlių valsčius
2253	348	ee	Sēļi vald
2254	348	ru	волость Сели
2255	348	en	Sēļi Parish
2256	349	lv	Trikātas pagasts
2257	349	lt	Trikātos valsčius
2258	349	ee	Trikāta vald
2259	349	ru	волость Триката
2260	349	en	Trikāta Parish
2261	350	lv	Rencēnu pagasts
2262	350	lt	Rencėnų valsčius
2263	350	ee	Rencēni vald
2264	350	ru	волость Ренцены
2265	350	en	Rencēni Parish
2266	351	lv	Ramatas pagasts
2267	351	lt	Ramatos valsčius
2268	351	ee	Ramata vald
2269	351	ru	волость Рамата
2270	351	en	Ramata Parish
2271	352	lv	Naukšēnu pagasts
2272	352	lt	Naukšėnų valsčius
2273	352	ee	Naukšēni vald
2274	352	ru	волость Наукшени
2275	352	en	Naukšēni Parish
2276	353	lv	Ipiķu pagasts
2277	353	lt	Ipiškių valsčius
2278	353	ee	Ipiķi vald
2279	353	ru	волость Ипики
2280	353	en	Ipiķi Parish
2281	354	lv	Kocēnu pagasts
2282	354	lt	Kocėnų valsčius
2283	354	ee	Kocēni vald
2284	354	ru	волость Коцены
2285	354	en	Kocēni Parish
2286	355	lv	Ēveles pagasts
2287	355	lt	Ēvelės valsčius
2288	355	ee	Ēvele vald
2289	355	ru	волость Эвелe
2290	355	en	Ēvele Parish
2291	356	lv	Brenguļu pagasts
2292	356	lt	Brengulių valsčius
2293	356	ee	Brenguļi vald
2294	356	ru	волость Брeнгули
2295	356	en	Brenguļi Parish
2296	357	lv	Jeru pagasts
2297	357	lt	Jerų valsčius
2298	357	ee	Jeri vald
2299	357	ru	волость Еры
2300	357	en	Jeri Parish
2301	358	lv	Ķoņu pagasts
2302	358	lt	Ķonių valsčius
2303	358	ee	Ķoņi vald
2304	358	ru	волость Кёни
2305	358	en	Ķoņi Parish
2306	359	lv	Mazsalacas pagasts
2307	359	lt	Mazsalacos valsčius
2308	359	ee	Mazsalaca vald
2309	359	ru	волость Мазсалаца
2310	359	en	Mazsalaca Parish
2311	360	lv	Zilākalna pagasts
2312	360	lt	Zilākalno valsčius
2313	360	ee	Zilākalns vald
2314	360	ru	волость Зилакалнс
2208	339	ee	Bērzaine vald
2315	360	en	Zilākalns Parish
2316	361	lv	Dikļu pagasts
2317	361	lt	Diklių valsčius
2318	361	ee	Dikļi vald
2319	361	ru	волость Дикли
2320	361	en	Dikļi Parish
2321	362	lv	Vilpulkas pagasts
2322	362	lt	Vilpulkos valsčius
2323	362	ee	Vilpulka vald
2324	362	ru	волость Вилпулка
2325	362	en	Vilpulka Parish
3701	575	en	Bēne Parish
3702	569	lv	Īles pagasts
3703	569	lt	Īlės valsčius
3704	569	ee	Īle vald
3705	569	ru	волость Иле
3706	569	en	Īle Parish
3707	573	lv	Lielauces pagasts
3708	573	lt	Lielaucės valsčius
3709	573	ee	Lielauce vald
3710	573	ru	волость Лиелауце
3711	573	en	Lielauce Parish
3712	577	lv	Ukru pagasts
3713	577	lt	Ukrų valsčius
3714	577	ee	Ukri vald
3715	577	ru	волость Укри
3716	577	en	Ukri Parish
3717	576	lv	Vītiņu pagasts
3718	576	lt	Vītiņų valsčius
3719	576	ee	Vītiņi vald
3720	576	ru	волость Витиньи
3721	576	en	Vītiņi Parish
3722	567	lv	Augstkalnes pagasts
3723	567	lt	Aukštkalnės valsčius
3724	567	ee	Augstkalne vald
3725	567	ru	волость Аугсткалне
3726	567	en	Augstkalne Parish
3727	582	lv	Bukaišu pagasts
3728	582	lt	Bukaišių valsčius
3729	582	ee	Bukaiši vald
3730	582	ru	волость Букайши
3731	582	en	Bukaiši Parish
3732	578	lv	Tērvetes pagasts
3733	578	lt	Tėrvetės valsčius
3734	578	ee	Tērvete vald
3735	578	ru	волость Тервете
3736	578	en	Tērvete Parish
3737	585	lv	Beļavas pagasts
3738	585	lt	Beļavos valsčius
3739	585	ee	Beļava vald
3740	585	ru	волость Белява
3741	585	en	Beļava Parish
3742	595	lv	Daukstu pagasts
3743	595	lt	Daukstų valsčius
3744	595	ee	Dauksti vald
3745	595	ru	волость Дауксти
3746	595	en	Dauksti Parish
3747	589	lv	Druvienas pagasts
3748	589	lt	Druvienos valsčius
3749	589	ee	Druviena vald
3750	589	ru	волость Друвьена
3751	589	en	Druviena Parish
3752	594	lv	Galgauskas pagasts
3753	594	lt	Galgauskos valsčius
3754	594	ee	Galgauska vald
3755	594	ru	волость Галгауска
3756	594	en	Galgauska Parish
3757	592	lv	Jaungulbenes pagasts
3758	592	lt	Jaungulbenės valsčius
3759	592	ee	Jaungulbene vald
3760	592	ru	волость Яунгулбене
3761	592	en	Jaungulbene Parish
3762	591	lv	Lejasciema pagasts
3763	591	lt	Lejasciemo valsčius
3764	591	ee	Lejasciems vald
3765	591	ru	волость Леяшциемс
3766	591	en	Lejasciems Parish
3767	588	lv	Lizuma pagasts
3768	588	lt	Lizumo valsčius
3769	588	ee	Lizums vald
3770	588	ru	волость Лизумс
3771	588	en	Lizums Parish
3772	587	lv	Līgo pagasts
3773	587	lt	Līgo valsčius
3774	587	ee	Līgo vald
3775	587	ru	волость Лиго
3776	587	en	Līgo Parish
3777	596	lv	Litenes pagasts
3778	596	lt	Litenės valsčius
3779	596	ee	Litene vald
3780	596	ru	волость Литене
3781	596	en	Litene Parish
3782	590	lv	Rankas pagasts
3783	590	lt	Rankos valsčius
3784	590	ee	Ranka vald
3785	590	ru	волость Ранка
3786	590	en	Ranka Parish
3787	593	lv	Stāmerienas pagasts
3788	593	lt	Stāmerienos valsčius
3789	593	ee	Stāmeriena vald
3790	593	ru	волость Стамериена
3791	593	en	Stāmeriena Parish
3792	597	lv	Stradu pagasts
3793	597	lt	Stradų valsčius
3794	597	ee	Stradi vald
3795	597	ru	волость Стради
3796	597	en	Stradi Parish
3797	586	lv	Tirzas pagasts
3798	586	lt	Tirzos valsčius
3799	586	ee	Tirza vald
2326	363	lv	Līgatnes pagasts
2327	363	lt	Līgatnės valsčius
2328	363	ee	Līgatne vald
2329	363	ru	волость Лигатне
2330	363	en	Līgatne Parish
2331	364	lv	Priekuļu pagasts
2332	364	lt	Priekulių valsčius
2333	364	ee	Priekuļi vald
2334	364	ru	волость Приекули
2335	364	en	Priekuļi Parish
2338	365	ee	Taurene vald
3800	586	ru	волость Тирза
3801	586	en	Tirza Parish
3802	607	lv	Cenu pagasts
3803	607	lt	Cenų valsčius
3804	607	ee	Cenu vald
3805	607	ru	волость Цену
3806	607	en	Cenu Parish
3807	611	lv	Elejas pagasts
3808	611	lt	Elejos valsčius
3809	611	ee	Eleja vald
3810	611	ru	волость Элея
2336	365	lv	Taurenes pagasts
2337	365	lt	Taurenės valsčius
2339	365	ru	волость Таурене
2340	365	en	Taurene Parish
2341	366	lv	Mārsnēnu pagasts
2342	366	lt	Mārsnėnų valsčius
2343	366	ee	Mārsnēni vald
2344	366	ru	волость Марснени
2345	366	en	Mārsnēni Parish
2346	367	lv	Stalbes pagasts
2347	367	lt	Stalbės valsčius
2348	367	ee	Stalbe vald
2349	367	ru	волость Сталбе
2350	367	en	Stalbe Parish
2351	368	lv	Raiskuma pagasts
2352	368	lt	Raiskumo valsčius
2353	368	ee	Raiskums vald
2354	368	ru	волость Райскумс
2355	368	en	Raiskums Parish
2356	369	lv	Veselavas pagasts
2357	369	lt	Veselavos valsčius
2358	369	ee	Veselava vald
2359	369	ru	волость Веселава
2360	369	en	Veselava Parish
2361	370	lv	Amatas pagasts
2362	370	lt	Amatos valsčius
2363	370	ee	Amata vald
2364	370	ru	волость Амата
2365	370	en	Amata Parish
2366	371	lv	Zaubes pagasts
2367	371	lt	Zaubės valsčius
2368	371	ee	Zaube vald
2369	371	ru	волость Заубе
2370	371	en	Zaube Parish
2371	372	lv	Inešu pagasts
2372	372	lt	Inešių valsčius
2373	372	ee	Ineši vald
2374	372	ru	волость Инеши
2375	372	en	Ineši Parish
2376	373	lv	Drabešu pagasts
2377	373	lt	Drabešių valsčius
2378	373	ee	Drabeši vald
2379	373	ru	волость Драбеши
2380	373	en	Drabeši Parish
2381	374	lv	Kaives pagasts
2382	374	lt	Kaivės valsčius
2383	374	ee	Kaive vald
2384	374	ru	волость Кайве
2385	374	en	Kaive Parish
2386	375	lv	Straupes pagasts
2387	375	lt	Straupės valsčius
2388	375	ee	Straupe vald
2389	375	ru	волость Страупе
2390	375	en	Straupe Parish
2391	376	lv	Liepas pagasts
2392	376	lt	Liep os valsčius
2393	376	ee	Liepa vald
2394	376	ru	волость Лиепа
2395	376	en	Liepa Parish
2396	377	lv	Vaives pagasts
2397	377	lt	Vaivės valsčius
2398	377	ee	Vaive vald
2399	377	ru	волость Вайве
2400	377	en	Vaive Parish
2401	378	lv	Zosēnu pagasts
2402	378	lt	Zosėnų valsčius
2403	378	ee	Zosēni vald
2404	378	ru	волость Зосени
2405	378	en	Zosēni Parish
2406	379	lv	Dzērbenes pagasts
2407	379	lt	Dzėrbenės valsčius
2408	379	ee	Dzērbene vald
2409	379	ru	волость Дзербене
2410	379	en	Dzērbene Parish
2411	380	lv	Vecpiebalgas pagasts
2412	380	lt	Vecpiebalgos valsčius
2413	380	ee	Vecpiebalga vald
2414	380	ru	волость Вецпиебалга
2415	380	en	Vecpiebalga Parish
2416	381	lv	Nītaures pagasts
2417	381	lt	Nītaurės valsčius
2418	381	ee	Nītaure vald
2419	381	ru	волость Нитауре
2420	381	en	Nītaure Parish
2426	383	lv	Jaunpiebalgas pagasts
2427	383	lt	Jaunpiebalgos valsčius
2428	383	ee	Jaunpiebalga vald
2429	383	ru	волость Яунпиебалга
2430	383	en	Jaunpiebalga Parish
2210	339	en	Bērzaine Parish
2542	386	lv	Skujenes pagasts
2543	386	lt	Skujenės valsčius
3811	611	en	Eleja Parish
2545	386	ru	волость Скуйене
2546	386	en	Skujene Parish
2544	386	ee	Skujene vald
2547	393	lv	Ances pagasts
2548	393	lt	Ances valsčius
2549	393	ee	Ance vald
2550	393	ru	волость Анце
2551	393	en	Ance Parish
2552	394	lv	Jūrkalnes pagasts
2553	394	lt	Jūrkalnės valsčius
2554	394	ee	Jūrkalne vald
2555	394	ru	волость Юркалне
2556	394	en	Jūrkalne Parish
2557	396	lv	Piltenes pagasts
2558	396	lt	Piltenės valsčius
2559	396	ee	Piltene vald
2560	396	ru	волость Пилтене
2561	396	en	Piltene Parish
2562	395	lv	Popes pagasts
2563	395	lt	Popės valsčius
2564	395	ee	Pope vald
2565	395	ru	волость Попе
2566	395	en	Pope Parish
2567	389	lv	Puzes pagasts
2568	389	lt	Puzės valsčius
2569	389	ee	Puze vald
2570	389	ru	волость Пузе
2571	389	en	Puze Parish
2572	391	lv	Tārgales pagasts
2573	391	lt	Tārgales valsčius
2574	391	ee	Tārgale vald
2575	391	ru	волость Таргале
2576	391	en	Tārgale Parish
2577	390	lv	Ugāles pagasts
2578	390	lt	Ugālės valsčius
2579	390	ee	Ugāle vald
2580	390	ru	волость Угале
2581	390	en	Ugāle Parish
2582	392	lv	Usmas pagasts
2583	392	lt	Usmos valsčius
2584	392	ee	Usma vald
2585	392	ru	волость Усма
2586	392	en	Usma Parish
2587	387	lv	Užavas pagasts
2588	387	lt	Užavos valsčius
2589	387	ee	Užava vald
2590	387	ru	волость Ужава
2591	387	en	Užava Parish
2592	388	lv	Vārves pagasts
2593	388	lt	Vārvės valsčius
2594	388	ee	Vārve vald
2595	388	ru	волость Варве
2596	388	en	Vārve Parish
2597	398	lv	Ziru pagasts
2598	398	lt	Zirų valsčius
2599	398	ee	Ziru vald
2600	398	ru	волость Зиру
2601	398	en	Ziru Parish
2602	397	lv	Zlēku pagasts
2603	397	lt	Zlėkų valsčius
2604	397	ee	Zlēku vald
2605	397	ru	волость Злеку
2606	397	en	Zlēku Parish
2607	400	lv	Ērģemes pagasts
2608	400	lt	Ērģemės valsčius
2609	400	ee	Ērģeme vald
2610	400	ru	волость Эрģеме
2611	400	en	Ērģeme Parish
2612	399	lv	Kārķu pagasts
2613	399	lt	Kārķių valsčius
2614	399	ee	Kārķi vald
2615	399	ru	волость Карки
2616	399	en	Kārķi Parish
2617	402	lv	Valkas pagasts
2618	402	lt	Valkos valsčius
2619	402	ee	Valka vald
2620	402	ru	волость Валка
2621	402	en	Valka Parish
2622	401	lv	Vijciema pagasts
2623	401	lt	Vijciemo valsčius
2624	401	ee	Vijciems vald
2625	401	ru	волость Вийциемс
2626	401	en	Vijciems Parish
2627	403	lv	Zvārtavas pagasts
2628	403	lt	Zvārtavos valsčius
2629	403	ee	Zvārtava vald
2630	403	ru	волость Звартaва
2631	403	en	Zvārtava Parish
2632	412	lv	Apes pagasts
2633	412	lt	Apės valsčius
2634	412	ee	Ape vald
2635	412	ru	волость Апe
2636	412	en	Ape Parish
2637	410	lv	Bilskas pagasts
2638	410	lt	Bilskos valsčius
2639	410	ee	Bilska vald
2640	410	ru	волость Билска
2641	410	en	Bilska Parish
2642	413	lv	Blomes pagasts
2643	413	lt	Blomės valsčius
2644	413	ee	Blome vald
2645	413	ru	волость Бломе
2646	413	en	Blome Parish
2647	407	lv	Brantu pagasts
2648	407	lt	Brantų valsčius
2649	407	ee	Branti vald
2650	407	ru	волость Бранти
2651	407	en	Branti Parish
2652	408	lv	Drustu pagasts
2653	408	lt	Drustų valsčius
2654	408	ee	Drusti vald
2655	408	ru	волость Друстu
2656	408	en	Drusti Parish
2657	409	lv	Gaujienas pagasts
2658	409	lt	Gaujienos valsčius
2659	409	ee	Gaujiena vald
2660	409	ru	волость Гауйена
2661	409	en	Gaujiena Parish
2662	411	lv	Grundzāles pagasts
2663	411	lt	Grundzālės valsčius
2664	411	ee	Grundzāle vald
2665	411	ru	волость Грундзале
2666	411	en	Grundzāle Parish
2667	414	lv	Launkalnes pagasts
2668	414	lt	Launkalnės valsčius
2669	414	ee	Launkalne vald
2670	414	ru	волость Лаункалне
2671	414	en	Launkalne Parish
2672	406	lv	Palsmanes pagasts
2673	406	lt	Palsmanės valsčius
2674	406	ee	Palsmane vald
2675	406	ru	волость Палсмане
2676	406	en	Palsmane Parish
2677	405	lv	Raunas pagasts
2678	405	lt	Raunos valsčius
2679	405	ee	Rauna vald
2680	405	ru	волость Раунa
2681	405	en	Rauna Parish
2682	404	lv	Smiltenes pagasts
2683	404	lt	Smiltenės valsčius
2684	404	ee	Smiltene vald
2685	404	ru	волость Смилтене
2686	404	en	Smiltene Parish
2687	415	lv	Trapenes pagasts
2688	415	lt	Trapenės valsčius
2689	415	ee	Trapene vald
2690	415	ru	волость Трапене
2691	415	en	Trapene Parish
2692	416	lv	Variņu pagasts
2693	416	lt	Variņų valsčius
2694	416	ee	Variņi vald
2695	416	ru	волость Варини
2696	416	en	Variņi Parish
2697	417	lv	Virešu pagasts
2698	417	lt	Virešų valsčius
2699	417	ee	Vireši vald
2700	417	ru	волость Виреши
2701	417	en	Vireši Parish
2702	420	lv	Allažu pagasts
2703	420	lt	Allažų valsčius
2704	420	ee	Allaži vald
2705	420	ru	волость Аллажи
2706	420	en	Allaži Parish
2707	424	lv	Inčukalna pagasts
2708	424	lt	Inčukalno valsčius
2709	424	ee	Inčukalns vald
2710	424	ru	волость Инчукалнс
2711	424	en	Inčukalns Parish
2712	421	lv	Krimuldas pagasts
2713	421	lt	Krimuldos valsčius
2714	421	ee	Krimulda vald
2715	421	ru	волость Кримулда
2716	421	en	Krimulda Parish
2717	419	lv	Lēdurgas pagasts
2718	419	lt	Lėdurgos valsčius
2719	419	ee	Lēdurga vald
2720	419	ru	волость Ледурга
2721	419	en	Lēdurga Parish
2722	423	lv	Mālpils pagasts
2723	423	lt	Mālpilio valsčius
2724	423	ee	Mālpils vald
2725	423	ru	волость Мāлпилс
2726	423	en	Mālpils Parish
2727	422	lv	Mores pagasts
2728	422	lt	Morės valsčius
2729	422	ee	More vald
2730	422	ru	волость Море
2731	422	en	More Parish
2732	418	lv	Siguldas pagasts
2733	418	lt	Siguldos valsčius
2734	418	ee	Sigulda vald
2735	418	ru	волость Сигулда
2736	418	en	Sigulda Parish
2737	425	en	Sēja Parish
2738	425	ru	волость Сея
2739	425	ee	Sēja vald
2740	425	lt	Sėjos valsčius
2741	425	lv	Sējas pagasts
2742	426	en	Saulkrasti Parish
2743	426	ru	волость Саулкрасти
2744	426	ee	Saulkrasti vald
2745	426	lt	Saulkrastų valsčius
2746	426	lv	Saulkrastu pagasts
2747	427	lv	Garkalnes pagasts
2748	427	lt	Garkalnės valsčius
2749	427	ee	Garkalne vald
2750	427	ru	волость Гаркалне
2751	427	en	Garkalne Parish
2752	429	lv	Ropažu pagasts
2753	429	lt	Ropažų valsčius
2754	429	ee	Ropaži vald
2755	429	ru	волость Ропажи
2756	429	en	Ropaži Parish
2757	428	lv	Stopiņu pagasts
2758	428	lt	Stopinių valsčius
2759	428	ee	Stopiņi vald
2760	428	ru	волость Стопини
2761	428	en	Stopiņi Parish
1446	215	lv	Audriņu pagasts
1447	215	lt	Audriņu valsčius
1448	215	ee	Audriņi vald
1449	215	ru	волость Аудрини
1450	215	en	Audriņi Parish
1476	221	lv	Bērzgales pagasts
1477	221	lt	Bērzgalės valsčius
1478	221	ee	Bērzgale vald
1479	221	ru	волость Берзгале
1480	221	en	Bērzgale Parish
1521	230	lv	Čornajas pagasts
1522	230	lt	Čornajos valsčius
1523	230	ee	Čornaja vald
1524	230	ru	волость Чорнаја
1525	230	en	Čornaja Parish
1471	220	lv	Dekšāres pagasts
1472	220	lt	Dekšarės valsčius
1473	220	ee	Dekšāre vald
1474	220	ru	волость Декшаре
1475	220	en	Dekšāre Parish
1531	232	lv	Dricānu pagasts
1532	232	lt	Dricānų valsčius
1533	232	ee	Dricāni vald
1534	232	ru	волость Дрицани
1535	232	en	Dricāni Parish
1526	231	lv	Feimaņu pagasts
1527	231	lt	Feimaņu valsčius
1528	231	ee	Feimaņi vald
1529	231	ru	волость Феймани
1530	231	en	Feimaņi Parish
1501	226	lv	Gaigalavas pagasts
1502	226	lt	Gaigalavos valsčius
1503	226	ee	Gaigalava vald
1504	226	ru	волость Гайгалaва
1505	226	en	Gaigalava Parish
1496	225	lv	Griškānu pagasts
1497	225	lt	Griškānų valsčius
1498	225	ee	Griškāni vald
1499	225	ru	волость Гришкани
1500	225	en	Griškāni Parish
1456	217	lv	Ilzeskalna pagasts
1457	217	lt	Ilzeskalno valsčius
1458	217	ee	Ilzeskalns vald
1459	217	ru	волость Илзескалнс
1460	217	en	Ilzeskalns Parish
1396	205	lv	Kantinieku pagasts
1397	205	lt	Kantiniekų valsčius
1398	205	ee	Kantin ieki vald
1399	205	ru	волость Кантиниеки
1400	205	en	Kantiņieki Parish
1506	227	lv	Kaunatas pagasts
1507	227	lt	Kaunatos valsčius
1508	227	ee	Kaunata vald
1509	227	ru	волость Кауната
1510	227	en	Kaunata Parish
1426	211	lv	Lendžu pagasts
1427	211	lt	Lendžų valsčius
1428	211	ee	Lendži vald
1429	211	ru	волость Ленджи
1430	211	en	Lendži Parish
1411	208	lv	Lūznavas pagasts
1412	208	lt	Lūznavos valsčius
1413	208	ee	Lūznava vald
1414	208	ru	волость Лузнава
1415	208	en	Lūznava Parish
1406	207	lv	Mākoņkalna pagasts
1407	207	lt	Mākoņkalno valsčius
1408	207	ee	Mākoņkalns vald
1409	207	ru	волость Маконькалнс
1410	207	en	Mākoņkalns Parish
1486	223	lv	Maltas pagasts
1487	223	lt	Maltos valsčius
1488	223	ee	Malta vald
1489	223	ru	волость Малта
1490	223	en	Malta Parish
1431	212	lv	Nagļu pagasts
1432	212	lt	Naglių valsčius
1433	212	ee	Nagļi vald
1434	212	ru	волость Нагли
1435	212	en	Nagļi Parish
1511	228	lv	Nautrēnu pagasts
1512	228	lt	Nautrėnų valsčius
1513	228	ee	Nautrēni vald
1514	228	ru	волость Наутрени
1515	228	en	Nautrēni Parish
1441	214	lv	Ozolaines pagasts
1442	214	lt	Ozolainės valsčius
1443	214	ee	Ozolaina vald
1444	214	ru	волость Озолайне
1445	214	en	Ozolaina Parish
1401	206	lv	Ozolmuižas pagasts
1402	206	lt	Ozolmuižos valsčius
1403	206	ee	Ozolmuiža vald
1404	206	ru	волость Озолмуйжа
1405	206	en	Ozolmuiža Parish
1481	222	lv	Pušas pagasts
1482	222	lt	Pušos valsčius
1483	222	ee	Puša vald
1484	222	ru	волость Пуша
1485	222	en	Puša Parish
1466	219	lv	Rikavas pagasts
1467	219	lt	Rikavos valsčius
1468	219	ee	Rikava vald
1469	219	ru	волость Рикава
1470	219	en	Rikava Parish
1451	216	lv	Sakstagala pagasts
1452	216	lt	Sakstagalos valsčius
1453	216	ee	Sakstagals vald
1454	216	ru	волость Сакстагалс
1455	216	en	Sakstagals Parish
2872	430	lv	Silmala pagasts
2873	430	lt	Silmala valsčius
2874	430	ee	Silmala vald
2875	430	ru	волость Силмала
2876	430	en	Silmala Parish
1461	218	lv	Sokolku pagasts
1462	218	lt	Sokolkų valsčius
1463	218	ee	Sokolki vald
1464	218	ru	волость Соколки
1465	218	en	Sokolki Parish
1421	210	lv	Stoļerovas pagasts
1422	210	lt	Stoļerovos valsčius
1423	210	ee	Stoļerova vald
1424	210	ru	волость Стольерова
1425	210	en	Stoļerova Parish
1436	213	lv	Strūžānu pagasts
1437	213	lt	Strūžānų valsčius
1438	213	ee	Strūžāni vald
1439	213	ru	волость Стружани
1440	213	en	Strūžāni Parish
1516	229	lv	Vērēmu pagasts
1517	229	lt	Vērėmų valsčius
1518	229	ee	Vērēmi vald
1519	229	ru	волость Вереми
1520	229	en	Vērēmi Parish
1416	209	lv	Viļānu pagasts
1417	209	lt	Viļānų valsčius
1418	209	ee	Viļāni vald
1419	209	ru	волость Вилянu
1420	209	en	Viļāni Parish
3812	601	lv	Glūdas pagasts
3813	601	lt	Glūdos valsčius
3814	601	ee	Glūda vald
3815	601	ru	волость Глюда
3816	601	en	Glūda Parish
2972	432	lv	Olaines pagasts
2973	432	lt	Olainės valsčius
2974	432	ee	Olaine vald
2975	432	ru	волость Олайне
2976	432	en	Olaine Parish
2977	435	lv	Babītes pagasts
2978	435	lt	Babītės valsčius
2979	435	ee	Babīte vald
2980	435	ru	волость Бабите
2981	435	en	Babīte Parish
2982	434	lv	Mārupes pagasts
2983	434	lt	Mārupės valsčius
2984	434	ee	Mārupe vald
2985	434	ru	волость Мāрупе
2986	434	en	Mārupe Parish
2987	433	lv	Salas pagasts
2988	433	lt	Salos valsčius
2989	433	ee	Sala vald
2990	433	ru	волость Сала
2991	433	en	Sala Parish
2992	437	lv	Blontu pagasts
2993	437	lt	Blontų valsčius
2994	437	ee	Blonti vald
2995	437	ru	волость Блонти
2996	437	en	Blonti Parish
2997	455	lv	Briģu pagasts
2998	455	lt	Briģų valsčius
2999	455	ee	Briģi vald
3000	455	ru	волость Бриги
3001	455	en	Briģi Parish
3002	447	lv	Ciblas pagasts
3003	447	lt	Ciblos valsčius
3004	447	ee	Cibla vald
3005	447	ru	волость Цибла
3006	447	en	Cibla Parish
3007	452	lv	Cirmas pagasts
3008	452	lt	Cirmos valsčius
3009	452	ee	Cirma vald
3010	452	ru	волость Цирма
3011	452	en	Cirma Parish
3012	451	lv	Goliševas pagasts
3013	451	lt	Goliševos valsčius
3014	451	ee	Goliševa vald
3015	451	ru	волость Голишева
3016	451	en	Goliševa Parish
3017	444	lv	Isnaudas pagasts
3018	444	lt	Isnaudos valsčius
3019	444	ee	Isnauda vald
3020	444	ru	волость Иснауда
3021	444	en	Isnauda Parish
3022	440	lv	Istras pagasts
3023	440	lt	Istros valsčius
3024	440	ee	Istra vald
3025	440	ru	волость Истра
3026	440	en	Istra Parish
3027	442	lv	Lauderu pagasts
3028	442	lt	Lauderų valsčius
3029	442	ee	Lauderi vald
3030	442	ru	волость Лаудери
3031	442	en	Lauderi Parish
3032	450	lv	Līdumnieku pagasts
3033	450	lt	Līdumniekų valsčius
3034	450	ee	Līdumnieki vald
3035	450	ru	волость Лидумниеки
3036	450	en	Līdumnieki Parish
3037	456	lv	Malnavas pagasts
3038	456	lt	Malnavos valsčius
3039	456	ee	Malnava vald
3040	456	ru	волость Малнава
3041	456	en	Malnava Parish
3042	443	lv	Mežvidu pagasts
3043	443	lt	Mežvidų valsčius
3044	443	ee	Mežvidi vald
3045	443	ru	волость Межвиди
3046	443	en	Mežvidi Parish
3047	438	lv	Mērdzenes pagasts
3048	438	lt	Mėrdzenės valsčius
3049	438	ee	Mērdzene vald
3050	438	ru	волость Мердзене
3051	438	en	Mērdzene Parish
3052	436	lv	Nirzas pagasts
3053	436	lt	Nirzos valsčius
3054	436	ee	Nirza vald
3055	436	ru	волость Нирза
3056	436	en	Nirza Parish
3057	441	lv	Ņukšu pagasts
3058	441	lt	Ņukšų valsčius
3059	441	ee	Ņukši vald
3060	441	ru	волость Ньюкши
3061	441	en	Ņukši Parish
3062	457	lv	Pasienes pagasts
3063	457	lt	Pasienės valsčius
3064	457	ee	Pasiene vald
3065	457	ru	волость Пасиене
3066	457	en	Pasiene Parish
3067	439	lv	Pildas pagasts
3068	439	lt	Pildos valsčius
3069	439	ee	Pilda vald
3070	439	ru	волость Пилда
3071	439	en	Pilda Parish
3072	453	lv	Pureņu pagasts
3073	453	lt	Purenių valsčius
3074	453	ee	Pureņi vald
3075	453	ru	волость Пурени
3076	453	en	Pureņi Parish
3077	454	lv	Pušmucovas pagasts
3078	454	lt	Pušmucovos valsčius
3079	454	ee	Pušmucova vald
3080	454	ru	волость Пушмуцова
3081	454	en	Pušmucova Parish
3082	449	lv	Rundēnu pagasts
3083	449	lt	Rundėnų valsčius
3084	449	ee	Rundēni vald
3085	449	ru	волость Рундени
3086	449	en	Rundēni Parish
3087	446	lv	Salnavas pagasts
3088	446	lt	Salnavos valsčius
3089	446	ee	Salnava vald
3090	446	ru	волость Салнава
3091	446	en	Salnava Parish
3092	448	lv	Zaļesjes pagasts
3093	448	lt	Zaļesjės valsčius
3094	448	ee	Zaļesje vald
3095	448	ru	волость Залесье
3096	448	en	Zaļesje Parish
3097	445	lv	Zvirgzdenes pagasts
3098	445	lt	Zvirgzdenės valsčius
3099	445	ee	Zvirgzdene vald
3100	445	ru	волость Звиргздене
3101	445	en	Zvirgzdene Parish
3102	458	lv	Jersikas pagasts
3103	458	lt	Jersikos valsčius
3104	458	ee	Jersika vald
3105	458	ru	волость Ерсика
3106	458	en	Jersika Parish
3107	460	lv	Rožupes pagasts
3108	460	lt	Rožupės valsčius
3109	460	ee	Rožupe vald
3110	460	ru	волость Рожупе
3111	460	en	Rožupe Parish
3112	459	lv	Rudzātu pagasts
3113	459	lt	Rudzatų valsčius
3114	459	ee	Rudzāti vald
3115	459	ru	волость Рудзаты
3116	459	en	Rudzāti Parish
3117	461	lv	Sutru pagasts
3118	461	lt	Sutrų valsčius
3119	461	ee	Sutri vald
3120	461	ru	волость Сутри
3121	461	en	Sutri Parish
3122	462	lv	Turku pagasts
3123	462	lt	Turkų valsčius
3124	462	ee	Turki vald
3125	462	ru	волость Турки
3126	462	en	Turki Parish
3127	467	lv	Andrupenes pagasts
3128	467	lt	Andrupenės valsčius
3129	467	ee	Andrupene vald
3130	467	ru	волость Андрупене
3131	467	en	Andrupene Parish
3132	472	lv	Andzeļu pagasts
3133	472	lt	Andželių valsčius
3134	472	ee	Andzeļi vald
3135	472	ru	волость Андзели
3136	472	en	Andzeļi Parish
3137	464	lv	Asūnes pagasts
3138	464	lt	Asūnės valsčius
3139	464	ee	Asūne vald
3140	464	ru	волость Асунe
3141	464	en	Asūne Parish
3142	482	lv	Aulejas pagasts
3143	482	lt	Aulejos valsčius
3144	482	ee	Auleja vald
3145	482	ru	волость Аулея
3146	482	en	Auleja Parish
3147	468	lv	Bērziņu pagasts
3148	468	lt	Bērzinių valsčius
3149	468	ee	Bērziņi vald
3150	468	ru	волость Берзини
3151	468	en	Bērziņi Parish
3152	476	lv	Dagdas pagasts
3153	476	lt	Dagdos valsčius
3154	476	ee	Dagda vald
3155	476	ru	волость Дагда
3156	476	en	Dagda Parish
3157	480	lv	Ezernieku pagasts
3158	480	lt	Ezerniekų valsčius
3159	480	ee	Ezernieki vald
3160	480	ru	волость Эзерниекі
3161	480	en	Ezernieki Parish
3162	483	lv	Grāveru pagasts
3163	483	lt	Grāverų valsčius
3164	483	ee	Grāveri vald
3165	483	ru	волость Гравери
3166	483	en	Grāveri Parish
3167	486	lv	Indras pagasts
3168	486	lt	Indros valsčius
3169	486	ee	Indra vald
3170	486	ru	волость Индра
3171	486	en	Indra Parish
3172	470	lv	Izvaltas pagasts
3173	470	lt	Izvaltos valsčius
3174	470	ee	Izvalta vald
3175	470	ru	волость Извалта
3176	470	en	Izvalta Parish
3177	466	lv	Kalniešu pagasts
3178	466	lt	Kalniešių valsčius
3179	466	ee	Kalnieši vald
3180	466	ru	волость Калниеши
3181	466	en	Kalnieši Parish
3182	474	lv	Kaplavas pagasts
3183	474	lt	Kaplavos valsčius
3184	474	ee	Kaplava vald
3185	474	ru	волость Каплава
3186	474	en	Kaplava Parish
3187	478	lv	Kastuļinas pagasts
3188	478	lt	Kastuļinos valsčius
3189	478	ee	Kastuļina vald
3190	478	ru	волость Кастулина
3191	478	en	Kastuļina Parish
3192	475	lv	Kombuļu pagasts
3193	475	lt	Kombulių valsčius
3194	475	ee	Kombuļi vald
3195	475	ru	волость Комбули
3196	475	en	Kombuļi Parish
3197	484	lv	Konstantinovas pagasts
3198	484	lt	Konstantinovos valsčius
3199	484	ee	Konstantinova vald
3200	484	ru	волость Константинова
3201	484	en	Konstantinova Parish
3202	465	lv	Krāslavas pagasts
3203	465	lt	Krāslavos valsčius
3204	465	ee	Krāslava vald
3205	465	ru	волость Краслава
3206	465	en	Krāslava Parish
3207	473	lv	Ķepovas pagasts
3208	473	lt	Ķepovos valsčius
3209	473	ee	Ķepova vald
3210	473	ru	волость Кепова
3211	473	en	Ķepova Parish
3212	485	lv	Piedrujas pagasts
3213	485	lt	Piedrujos valsčius
3214	485	ee	Piedruja vald
3215	485	ru	волость Педруя
3216	485	en	Piedruja Parish
3217	471	lv	Robežnieku pagasts
3218	471	lt	Robežniekų valsčius
3219	471	ee	Robežnieki vald
3220	471	ru	волость Робежниеки
3221	471	en	Robežnieki Parish
3222	481	lv	Skaistas pagasts
3223	481	lt	Skaištos valsčius
3224	481	ee	Skaista vald
3225	481	ru	волость Скайста
3226	481	en	Skaista Parish
3227	479	lv	Svariņu pagasts
3228	479	lt	Svariņų valsčius
3229	479	ee	Svariņi vald
3230	479	ru	волость Сварини
3231	479	en	Svariņi Parish
3232	469	lv	Šķaunes pagasts
3233	469	lt	Šķaunės valsčius
3234	469	ee	Šķaune vald
3235	469	ru	волость Шькауне
3236	469	en	Šķaune Parish
3237	463	lv	Šķeltovas pagasts
3238	463	lt	Škeltovos valsčius
3239	463	ee	Šķeltova vald
3240	463	ru	волость Шкельтова
3241	463	en	Šķeltova Parish
3242	477	lv	Ūdrīšu pagasts
3243	477	lt	Ūdrīšių valsčius
3244	477	ee	Ūdrīši vald
3245	477	ru	волость Удриши
3246	477	en	Ūdrīši Parish
3247	487	lv	Ādažu pagasts
3248	487	lt	Ādažų valsčius
3249	487	ee	Ādaži vald
3250	487	ru	волость Адажи
3251	487	en	Ādaži Parish
3252	488	lv	Carnikavas pagasts
3253	488	lt	Carnikovos valsčius
3254	488	ee	Carnikava vald
3255	488	ru	волость Царникава
3256	488	en	Carnikava Parish
3282	504	lv	Birzgales pagasts
3283	504	lt	Birzgalės valsčius
3284	504	ee	Birzgale vald
3285	504	ru	волость Бирзгале
3286	504	en	Birzgale Parish
3287	495	lv	Jumpravas pagasts
3288	495	lt	Jumpravos valsčius
3289	495	ee	Jumprava vald
3290	495	ru	волость Юмправа
3291	495	en	Jumprava Parish
3292	494	lv	Krapes pagasts
3293	494	lt	Krapės valsčius
3294	494	ee	Krape vald
3295	494	ru	волость Крапе
3296	494	en	Krape Parish
3297	508	lv	Ķeipenes pagasts
3298	508	lt	Ķeipenės valsčius
3299	508	ee	Ķeipene vald
3300	508	ru	волость Кейпене
3301	508	en	Ķeipene Parish
3302	496	lv	Lauberes pagasts
3303	496	lt	Lauberės valsčius
3304	496	ee	Laubere vald
3305	496	ru	волость Лаубере
3306	496	en	Laubere Parish
3307	502	lv	Lēdmanes pagasts
3308	502	lt	Lėdmanės valsčius
3309	502	ee	Lēdmane vald
3310	502	ru	волость Ледмане
3311	502	en	Lēdmane Parish
3312	497	lv	Lielvārdes pagasts
3313	497	lt	Lielvardės valsčius
3314	497	ee	Lielvārde vald
3315	497	ru	волость Лиелварде
3316	497	en	Lielvārde Parish
3317	498	lv	Madlienas pagasts
3318	498	lt	Madlienos valsčius
3319	498	ee	Madliena vald
3320	498	ru	волость Мадлиена
3321	498	en	Madliena Parish
3322	506	lv	Mazozolu pagasts
3323	506	lt	Mazozolų valsčius
3324	506	ee	Mazozoli vald
3325	506	ru	волость Мазозоли
3326	506	en	Mazozoli Parish
3327	507	lv	Meņģeles pagasts
3328	507	lt	Meņģelės valsčius
3329	507	ee	Meņģele vald
3330	507	ru	волость Менгелe
3331	507	en	Meņģele Parish
3332	501	lv	Ogresgala pagasts
3333	501	lt	Ogresgalo valsčius
3334	501	ee	Ogresgals vald
3335	501	ru	волость Огресгалс
3336	501	en	Ogresgals Parish
3337	509	lv	Rembates pagasts
3338	509	lt	Rembatės valsčius
3339	509	ee	Rembate vald
3340	509	ru	волость Рембате
3341	509	en	Rembate Parish
3342	499	lv	Suntažu pagasts
3343	499	lt	Suntažų valsčius
3344	499	ee	Suntaži vald
3345	499	ru	волость Сунтажи
3346	499	en	Suntaži Parish
3347	505	lv	Taurupes pagasts
3348	505	lt	Taurupės valsčius
3349	505	ee	Taurupe vald
3350	505	ru	волость Таурупе
3351	505	en	Taurupe Parish
3352	500	lv	Tīnūžu pagasts
3353	500	lt	Tīnūžų valsčius
3354	500	ee	Tīnūži vald
3355	500	ru	волость Тийнужи
3356	500	en	Tīnūži Parish
3357	503	lv	Tomes pagasts
3358	503	lt	Tomės valsčius
3359	503	ee	Tome vald
3360	503	ru	волость Томе
3361	503	en	Tome Parish
3362	512	lv	Ainažu pagasts
3363	512	lt	Ainažų valsčius
3364	512	ee	Ainaži vald
3365	512	ru	волость Айнажи
3366	512	en	Ainaži Parish
3367	513	lv	Alojas pagasts
3368	513	lt	Alojos valsčius
3369	513	ee	Aloja vald
3370	513	ru	волость Алоя
3371	513	en	Aloja Parish
3372	511	lv	Braslavas pagasts
3373	511	lt	Braslavos valsčius
3374	511	ee	Braslava vald
3375	511	ru	волость Браслава
3376	511	en	Braslava Parish
3377	520	lv	Brīvzemnieku pagasts
3378	520	lt	Brīvzemniekų valsčius
3379	520	ee	Brīvzemnieki vald
3380	520	ru	волость Бривземниеки
3381	520	en	Brīvzemnieki Parish
3382	521	lv	Katvaru pagasts
3383	521	lt	Katvarų valsčius
3384	521	ee	Katvari vald
3385	521	ru	волость Катвари
3386	521	en	Katvari Parish
3387	510	lv	Liepupes pagasts
3388	510	lt	Liepupės valsčius
3389	510	ee	Liepupė vald
3390	510	ru	волость Лиепупе
3391	510	en	Liepupė Parish
3392	518	lv	Limbažu pagasts
3393	518	lt	Limbažų valsčius
3394	518	ee	Limbaži vald
3395	518	ru	волость Лимбажи
3396	518	en	Limbaži Parish
3397	514	lv	Pāles pagasts
3398	514	lt	Pālės valsčius
3399	514	ee	Pāle vald
3400	514	ru	волость Палe
3401	514	en	Pāle Parish
3402	517	lv	Salacgrīvas pagasts
3403	517	lt	Salacgrīvos valsčius
3404	517	ee	Salacgrīva vald
3405	517	ru	волость Салацгрива
3406	517	en	Salacgrīva Parish
3407	523	lv	Skultes pagasts
3408	523	lt	Skultės valsčius
3409	523	ee	Skulte vald
3410	523	ru	волость Скултe
3411	523	en	Skulte Parish
3412	516	lv	Staiceles pagasts
3413	516	lt	Staicelės valsčius
3414	516	ee	Staicele vald
3415	516	ru	волость Стайцеле
3416	516	en	Staicele Parish
3417	522	lv	Umurgas pagasts
3418	522	lt	Umurgos valsčius
3419	522	ee	Umurga vald
3420	522	ru	волость Умурга
3421	522	en	Umurga Parish
3422	515	lv	Vidrižu pagasts
3423	515	lt	Vidrižų valsčius
3424	515	ee	Vidriži vald
3425	515	ru	волость Видрижi
3426	515	en	Vidriži Parish
3427	519	lv	Viļķenes pagasts
3428	519	lt	Viļķenės valsčius
3429	519	ee	Viļķene vald
3430	519	ru	волость Вилькене
3431	519	en	Viļķene Parish
3432	544	lv	Aizputes pagasts
3433	544	lt	Aizputės valsčius
3434	544	ee	Aizpute vald
3435	544	ru	волость Айзпуте
3436	544	en	Aizpute Parish
3437	539	lv	Bārtas pagasts
3438	539	lt	Bārtos valsčius
3439	539	ee	Bārta vald
3440	539	ru	волость Барта
3441	539	en	Bārta Parish
3442	528	lv	Bunkas pagasts
3443	528	lt	Bunkos valsčius
3444	528	ee	Bunka vald
3445	528	ru	волость Бунка
3446	528	en	Bunka Parish
3447	549	lv	Cīravas pagasts
3448	549	lt	Cīravos valsčius
3449	549	ee	Cīrava vald
3450	549	ru	волость Цирава
3451	549	en	Cīrava Parish
3452	532	lv	Dunalkas pagasts
3453	532	lt	Dunalkos valsčius
3454	532	ee	Dunalka vald
3455	532	ru	волость Дуналка
3456	532	en	Dunalka Parish
3457	537	lv	Dunikas pagasts
3458	537	lt	Dunikos valsčius
3459	537	ee	Dunika vald
3460	537	ru	волость Дуника
3461	537	en	Dunika Parish
3462	533	lv	Durbes pagasts
3463	533	lt	Durbės valsčius
3464	533	ee	Durbe vald
3465	533	ru	волость Дурбе
3466	533	en	Durbe Parish
3467	531	lv	Embūtes pagasts
3468	531	lt	Embūtės valsčius
3469	531	ee	Embūte vald
3470	531	ru	волость Эмбуте
3471	531	en	Embūte Parish
3472	547	lv	Gārdas/Gaviezes pagasts
3473	547	lt	Gaviezės valsčius
3474	547	ee	Gavieze vald
3475	547	ru	волость Гавиeзе
3476	547	en	Gavieze Parish
3477	534	lv	Gramzdas pagasts
3478	534	lt	Gramzdos valsčius
3479	534	ee	Gramzda vald
3480	534	ru	волость Грамзда
3481	534	en	Gramzda Parish
3482	526	lv	Grobiņas pagasts
3483	526	lt	Grobinės valsčius
3484	526	ee	Grobiņa vald
3485	526	ru	волость Гробиня
3486	526	en	Grobiņa Parish
3487	546	lv	Kalētu pagasts
3488	546	lt	Kalėtų valsčius
3489	546	ee	Kalēti vald
3490	546	ru	волость Калеты
3491	546	en	Kalēti Parish
3492	524	lv	Kalvenes pagasts
3493	524	lt	Kalv ėnės valsčius
3494	524	ee	Kalvene vald
3495	524	ru	волость Калвене
3496	524	en	Kalvene Parish
3497	542	lv	Kazdangas pagasts
3498	542	lt	Kazdang os valsčius
3499	542	ee	Kazdanga vald
3500	542	ru	волость Казданга
3501	542	en	Kazdanga Parish
3502	530	lv	Lažas pagasts
3503	530	lt	Lažos valsčius
3504	530	ee	Laža vald
3505	530	ru	волость Лажа
3506	530	en	Laža Parish
3507	536	lv	Medzes pagasts
3508	536	lt	Medzės valsčius
3509	536	ee	Medze vald
3510	536	ru	волость Медзе
3511	536	en	Medze Parish
3512	540	lv	Nīcas pagasts
3513	540	lt	Nīcos valsčius
3514	540	ee	Nīca vald
3515	540	ru	волость Ница
3516	540	en	Nīca Parish
3517	545	lv	Otaņķu pagasts
3518	545	lt	Otaņķių valsčius
3519	545	ee	Otaņķi vald
3520	545	ru	волость Отаньки
3521	545	en	Otaņķi Parish
3522	529	lv	Priekules pagasts
3523	529	lt	Priekulės valsčius
3524	529	ee	Priekule vald
3525	529	ru	волость Приекуле
3526	529	en	Priekule Parish
3527	541	lv	Rucavas pagasts
3528	541	lt	Rucavos valsčius
3529	541	ee	Rucava vald
3530	541	ru	волость Руцава
3531	541	en	Rucava Parish
3532	543	lv	Sakas pagasts
3533	543	lt	Sakos valsčius
3534	543	ee	Saka vald
3535	543	ru	волость Сака
3536	543	en	Saka Parish
3537	548	lv	Tadaiķu pagasts
3538	548	lt	Tadaičių valsčius
3539	548	ee	Tadaiķi vald
3540	548	ru	волость Тадайки
3541	548	en	Tadaiķi Parish
3542	525	lv	Vaiņodes pagasts
3543	525	lt	Vaiņodės valsčius
3544	525	ee	Vaiņode vald
3545	525	ru	волость Вайноде
3546	525	en	Vaiņode Parish
3547	527	lv	Vecpils pagasts
3548	527	lt	Vecpilio valsčius
3549	527	ee	Vecpils vald
3550	527	ru	волость Вецпилс
3551	527	en	Vecpils Parish
3552	535	lv	Vērgales pagasts
3553	535	lt	Vėrgalės valsčius
3554	535	ee	Vērgale vald
3555	535	ru	волость Вергале
3556	535	en	Vērgale Parish
3557	538	lv	Virgas pagasts
3558	538	lt	Virgos valsčius
3559	538	ee	Virga vald
3560	538	ru	волость Вирга
3561	538	en	Virga Parish
3562	550	en	Salaspils Parish
3563	550	ru	волость Саласпилс
3564	550	ee	Salaspils vald
3565	550	lt	Salaspilio valsčius
3566	550	lv	Salaspils pagasts
3817	600	lv	Jaunsvirlaukas pagasts
3818	600	lt	Jaunsvirlaukos valsčius
3819	600	ee	Jaunsvirlauka vald
3820	600	ru	волость Яунсвирлаука
3821	600	en	Jaunsvirlauka Parish
3822	606	lv	Lielplatones pagasts
3823	606	lt	Lielplatonės valsčius
3824	606	ee	Lielplatone vald
3825	606	ru	волость Лиелплатоне
3826	606	en	Lielplatone Parish
3827	608	lv	Līvbērzes pagasts
3828	608	lt	Līvbėrzės valsčius
3829	608	ee	Līvbērze vald
3830	608	ru	волость Ливберзе
3831	608	en	Līvbērze Parish
3832	602	lv	Ozolnieku pagasts
3833	602	lt	Ozolniekų valsčius
3834	602	ee	Ozolnieki vald
3835	602	ru	волость Озолниеки
3836	602	en	Ozolnieki Parish
3837	604	lv	Platones pagasts
3838	604	lt	Platonės valsčius
3839	604	ee	Platone vald
3840	604	ru	волость Платоне
3841	604	en	Platone Parish
3842	605	lv	Sesavas pagasts
3843	605	lt	Sesavos valsčius
3844	605	ee	Sesava vald
3845	605	ru	волость Сесава
3846	605	en	Sesava Parish
3847	609	lv	Salgales pagasts
3848	609	lt	Salgėlės valsčius
3849	609	ee	Salgale vald
3850	609	ru	волость Салга ле
3851	609	en	Salgale Parish
3852	598	lv	Svētes pagasts
3853	598	lt	Svetės valsčius
3854	598	ee	Svēte vald
3855	598	ru	волость Свете
3856	598	en	Svēte Parish
3857	603	lv	Valgundes pagasts
3858	603	lt	Valgundės valsčius
3859	603	ee	Valgunde vald
3860	603	ru	волость Валгунде
3861	603	en	Valgunde Parish
3862	610	lv	Vilces pagasts
3863	610	lt	Vilcės valsčius
3864	610	ee	Vilce vald
3865	610	ru	волость Вилце
3866	610	en	Vilce Parish
3867	599	lv	Vircavas pagasts
3868	599	lt	Vircavos valsčius
3869	599	ee	Vircava vald
3870	599	ru	волость Вирцава
3871	599	en	Vircava Parish
2076	313	lv	Abavas pagasts
2077	313	lt	Abavos valsčius
2078	313	ee	Abava vald
2079	313	ru	волость Абавa
2080	313	en	Abava Parish
2016	301	lv	Ārlavas pagasts
2017	301	lt	Ārlavos valsčius
2018	301	ee	Ārlava vald
2019	301	ru	волость Арлава
2020	301	en	Ārlava Parish
2021	302	lv	Balgales pagasts
2022	302	lt	Balgales valsčius
2023	302	ee	Balgale vald
2024	302	ru	волость Балгале
2025	302	en	Balgale Parish
2096	317	lv	Dundagas pagasts
2097	317	lt	Dundagos valsčius
2098	317	ee	Dundaga vald
2099	317	ru	волость Дундага
2100	317	en	Dundaga Parish
2011	300	lv	Ģibuļu pagasts
2012	300	lt	Ģibulių valsčius
2013	300	ee	Ģibuļi vald
2014	300	ru	волость Гибули
2015	300	en	Ģibuļi Parish
3897	612	lv	Īves pagasts
3898	612	lt	Īvės valsčius
3899	612	ee	Īve vald
3900	612	ru	волость Иве
3901	612	en	Īve Parish
2056	309	lv	Kolkas pagasts
2057	309	lt	Kolkos valsčius
2058	309	ee	Kolka vald
2059	309	ru	волость Колка
2060	309	en	Kolka Parish
2036	305	lv	Ķūļciema pagasts
2037	305	lt	Ķūļciemo valsčius
2038	305	ee	Ķūļciems vald
2039	305	ru	волость Кульциемс
2040	305	en	Ķūļciems Parish
2046	307	lv	Laidzes pagasts
2047	307	lt	Laidzės valsčius
2048	307	ee	Laidze vald
2049	307	ru	волость Лайдзе
2050	307	en	Laidze Parish
2086	315	lv	Laucienes pagasts
2087	315	lt	Laucienės valsčius
2088	315	ee	Lauciene vald
2089	315	ru	волость Лауциене
2090	315	en	Lauciene Parish
2031	304	lv	Lībagu pagasts
2032	304	lt	Lībagų valsčius
2033	304	ee	Lībagi vald
2034	304	ru	волость Либаги
2035	304	en	Lībagi Parish
2066	311	lv	Lubes pagasts
2067	311	lt	Lubės valsčius
2068	311	ee	Lube vald
2069	311	ru	волость Лубе
2070	311	en	Lube Parish
2041	306	lv	Mērsraga pagasts
2042	306	lt	Mėrsrago valsčius
2043	306	ee	Mērsrags vald
2044	306	ru	волость Мерсрагс
2045	306	en	Mērsrags Parish
2061	310	lv	Rojas pagasts
2062	310	lt	Rojos valsčius
2063	310	ee	Roja vald
2064	310	ru	волость Роя
2065	310	en	Roja Parish
2091	316	lv	Strazdes pagasts
2092	316	lt	Strazdės valsčius
2093	316	ee	Strazde vald
2094	316	ru	волость Страдзе
2095	316	en	Strazde Parish
2051	308	lv	Valdgales pagasts
2052	308	lt	Valdgalės valsčius
2053	308	ee	Valdgale vald
2054	308	ru	волость Валдгале
2055	308	en	Valdgale Parish
2026	303	lv	Vandzenes pagasts
2027	303	lt	Vandzenės valsčius
2028	303	ee	Vandzene vald
2029	303	ru	волость Вандзене
2030	303	en	Vandzene Parish
2071	312	lv	Virbu pagasts
2072	312	lt	Virbų valsčius
2073	312	ee	Virbi vald
2074	312	ru	волость Вирби
2075	312	en	Virbi Parish
2186	335	lv	Blīdenes pagasts
2187	335	lt	Blīdenės valsčius
2188	335	ee	Blīdene vald
2189	335	ru	волость Блидене
2190	335	en	Blīdene Parish
2191	336	lv	Lutriņu pagasts
2192	336	lt	Lutriņų valsčius
2193	336	ee	Lutriņi vald
2194	336	ru	волость Лутрини
2195	336	en	Lutriņi Parish
2143	326	ee	Pampāļi vald
2144	326	ru	волость Пампали
2145	326	en	Pampāļi Parish
2106	319	lv	Remtes pagasts
2107	319	lt	Remtės valsčius
2108	319	ee	Remte vald
2109	319	ru	волость Ремте
2110	319	en	Remte Parish
2161	330	lv	Rubas pagasts
2162	330	lt	Rubos valsčius
2163	330	ee	Ruba vald
2164	330	ru	волость Руба
2165	330	en	Ruba Parish
2166	331	lv	Saldus pagasts
2167	331	lt	Saldus valsčius
2168	331	ee	Saldus vald
2169	331	ru	волость Салдус
2170	331	en	Saldus Parish
2181	334	lv	Šķēdes pagasts
2182	334	lt	Škėdės valsčius
2183	334	ee	Šķēde vald
2184	334	ru	волость Шкедe
2185	334	en	Šķēde Parish
2111	320	lv	Vadakstes pagasts
2112	320	lt	Vadakstės valsčius
2113	320	ee	Vadakste vald
2114	320	ru	волость Вадаксте
2115	320	en	Vadakste Parish
2176	333	lv	Zaņas pagasts
2177	333	lt	Zaņos valsčius
2178	333	ee	Zaņa vald
2179	333	ru	волость Заня
2180	333	en	Zaņa Parish
2131	324	lv	Zirņu pagasts
2132	324	lt	Zirnių valsčius
2133	324	ee	Zirņi vald
2134	324	ru	волость Зирни
2135	324	en	Zirņi Parish
2136	325	lv	Zvārdes pagasts
2137	325	lt	Zvārdes valsčius
2138	325	ee	Zvārde vald
2139	325	ru	волость Зварде
2140	325	en	Zvārde Parish
1296	185	lv	Aknīstes pagasts
1297	185	lt	Aknīstės valsčius
1298	185	ee	Aknīste vald
1299	185	ru	волость Акнистe
1300	185	en	Aknīste Parish
1271	180	lv	Asares pagasts
1272	180	lt	Asarės valsčius
1274	180	ru	волость Асаре
1275	180	en	Asare Parish
1237	173	lt	Atašienės valsčius
1238	173	ee	Atašiene vald
1239	173	ru	волость Аташене
1240	173	en	Atašiene Parish
1291	184	lv	Ābeļu pagasts
1292	184	lt	Ābelių valsčius
1293	184	ee	Ābeļi vald
1294	184	ru	волость Абели
1295	184	en	Ābeļi Parish
1241	174	lv	Dignājas pagasts
1242	174	lt	Dignajos valsčius
1243	174	ee	Dignāja vald
1244	174	ru	волость Дигнаја
1245	174	en	Dignāja Parish
1266	179	lv	Dunavas pagasts
1267	179	lt	Dunavos valsčius
1268	179	ee	Dunava vald
1269	179	ru	волость Дунава
1270	179	en	Dunava Parish
1216	169	lv	Elkšņu pagasts
1217	169	lt	Elkšnių valsčius
1218	169	ee	Elkšņi vald
1219	169	ru	волость Элкшни
1220	169	en	Elkšņi Parish
1311	188	lv	Gārsenes pagasts
1312	188	lt	Gārsenės valsčius
1313	188	ee	Gārsene vald
1314	188	ru	волость Гарсене
1315	188	en	Gārsene Parish
1246	175	lv	Kalna pagasts
1247	175	lt	Kalno valsčius
1248	175	ee	Kalna vald
1249	175	ru	волость Кална
1250	175	en	Kalna Parish
1306	187	lv	Krustpils pagasts
1307	187	lt	Krustpilio valsčius
1308	187	ee	Krustpils vald
1309	187	ru	волость Крустпилс
1310	187	en	Krustpils Parish
1276	181	lv	Kūku pagasts
1277	181	lt	Kūkų valsčius
1278	181	ee	Kūkas vald
1279	181	ru	волость Кукус
1280	181	en	Kūkas Parish
1256	177	lv	Leimaņu pagasts
1257	177	lt	Leimanių valsčius
1258	177	ee	Leimaņi vald
1259	177	ru	волость Леймани
1260	177	en	Leimaņi Parish
1576	233	lv	Mežāres pagasts
1577	233	lt	Mežarės valsčius
1578	233	ee	Mežāre vald
1579	233	ru	волость Межаре
1580	233	en	Mežāre Parish
1286	183	lv	Rites pagasts
1287	183	lt	Ritės valsčius
1288	183	ee	Rite vald
1289	183	ru	волость Рите
1290	183	en	Rite Parish
1321	190	lv	Rubenes pagasts
1322	190	lt	Rubenės valsčius
1323	190	ee	Rubene vald
1324	190	ru	волость Рубене
1325	190	en	Rubene Parish
1221	170	lv	Salas pagasts
1222	170	lt	Salos valsčius
1223	170	ee	Sala vald
1224	170	ru	волость Сала
1225	170	en	Sala Parish
1301	186	lv	Saukas pagasts
1302	186	lt	Saukos valsčius
1303	186	ee	Sauka vald
1304	186	ru	волость Саукa
1305	186	en	Sauka Parish
1316	189	lv	Sēlpils pagasts
1317	189	lt	Sėlpilio valsčius
1318	189	ee	Sēlpils vald
1319	189	ru	волость Селпилс
1320	189	en	Sēlpils Parish
1251	176	lv	Variešu pagasts
1252	176	lt	Variešių valsčius
1253	176	ee	Varieši vald
1254	176	ru	волость Вариеши
1255	176	en	Varieši Parish
1261	178	lv	Viesītes pagasts
1262	178	lt	Viesītės valsčius
1263	178	ee	Viesīte vald
1264	178	ru	волость Виесите
1265	178	en	Viesīte Parish
1281	182	lv	Vīpes pagasts
1282	182	lt	Vīpės valsčius
1283	182	ee	Vīpe vald
1284	182	ru	волость Випе
1285	182	en	Vīpe Parish
1231	172	lv	Zasas pagasts
1232	172	lt	Zasos valsčius
1233	172	ee	Zasa vald
1234	172	ru	волость Заса
1235	172	en	Zasa Parish
4167	620	lv	Baltinavas pagasts
4168	620	lt	Baltinavos valsčius
4169	620	ee	Baltinava vald
4170	620	ru	волость Балтинава
4171	620	en	Baltinava Parish
4172	622	lv	Balvu pagasts
4173	622	lt	Balvų valsčius
4174	622	ee	Balvi vald
4175	622	ru	волость Балви
4176	622	en	Balvi Parish
4177	627	lv	Bērzkalnes pagasts
4178	627	lt	Bērzkalnės valsčius
4179	627	ee	Bērzkalne vald
4180	627	ru	волость Берзкалне
4181	627	en	Bērzkalne Parish
4182	621	lv	Bērzpils pagasts
4183	621	lt	Bērzpilio valsčius
4184	621	ee	Bērzpils vald
4185	621	ru	волость Берзпилс
4186	621	en	Bērzpils Parish
4187	630	lv	Briežuciema pagasts
4188	630	lt	Briežuciemo valsčius
4189	630	ee	Briežuciema vald
4190	630	ru	волость Брежуциемс
4191	630	en	Briežuciema Parish
4192	628	lv	Krišjāņu pagasts
4193	628	lt	Krišjāņu valsčius
4194	628	ee	Krišjāņi vald
4195	628	ru	волость Кришъяни
4196	628	en	Krišjāņi Parish
4197	613	lv	Kubulu pagasts
4198	613	lt	Kubulų valsčius
4199	613	ee	Kubuli vald
4200	613	ru	волость Кубули
4201	613	en	Kubuli Parish
4202	629	lv	Kupravas pagasts
4203	629	lt	Kupravos valsčius
4204	629	ee	Kuprava vald
4205	629	ru	волость Куправа
4206	629	en	Kuprava Parish
4207	617	lv	Lazdukalna pagasts
4208	617	lt	Lazdukalno valsčius
4209	617	ee	Lazdukalns vald
4210	617	ru	волость Лаздукалнс
4211	617	en	Lazdukalns Parish
4212	616	lv	Lazdulejas pagasts
4213	616	lt	Lazdulejos valsčius
4214	616	ee	Lazduleja vald
4215	616	ru	волость Лаздулея
4216	616	en	Lazduleja Parish
4217	623	lv	Medņevas pagasts
4218	623	lt	Medņevos valsčius
4219	623	ee	Medņeva vald
4220	623	ru	волость Меднева
4221	623	en	Medņeva Parish
4222	619	lv	Rugāju pagasts
4223	619	lt	Rugajų valsčius
4224	619	ee	Rugāji vald
4225	619	ru	волость Ругаи
4226	619	en	Rugāji Parish
4227	625	lv	Susāju pagasts
4228	625	lt	Sušajų valsčius
4229	625	ee	Susāji vald
4230	625	ru	волость Сусаи
4231	625	en	Susāji Parish
4232	614	lv	Šķilbēnu pagasts
4233	614	lt	Šķilbėnų valsčius
4234	614	ee	Šķilbēni vald
4235	614	ru	волость Шкильбены
4236	614	en	Šķilbēni Parish
4237	624	lv	Tilžas pagasts
4238	624	lt	Tilžos valsčius
4239	624	ee	Tilža vald
4240	624	ru	волость Тильжа
4241	624	en	Tilža Parish
4242	626	lv	Vectilžas pagasts
4243	626	lt	Vectilžos valsčius
4244	626	ee	Vectilža vald
4245	626	ru	волость Вектильжа
4246	626	en	Vectilža Parish
4247	618	lv	Vecumu pagasts
4248	618	lt	Vecumų valsčius
4249	618	ee	Vecumi vald
4250	618	ru	волость Вецуми
4251	618	en	Vecumi Parish
4252	631	lv	Vīksnas pagasts
4253	631	lt	Vīksnos valsčius
4254	631	ee	Vīksna vald
4255	631	ru	волость Виксна
4256	631	en	Vīksna Parish
4257	615	lv	Žīguru pagasts
4258	615	lt	Žīgūrų valsčius
4259	615	ee	Žīguri vald
4260	615	ru	волость Жигури
4261	615	en	Žīguri Parish
4262	633	lv	Aiviekstes pagasts
4263	633	lt	Aiviekstes pagasts
4264	633	ee	Aiviekstes pagasts
4265	633	ru	Аивиекстес пагастс
4266	633	en	Aiviekste Parish
3257	491	lv	Aizkraukles pagasts
3258	491	lt	Aizkraukles pagasts
3259	491	ee	Aizkraukles pagasts
3260	491	ru	Айзкрауклес погост
3261	491	en	Aizkraukle Parish
4272	642	lv	Bebru pagasts
4273	642	lt	Bebru pagasts
4274	642	ee	Bebru pagasts
4275	642	ru	Бебру погост
4276	642	en	Bebri Parish
4277	637	lv	Daudzeses pagasts
4278	637	lt	Daudzeses pagasts
4279	637	ee	Daudzeses pagasts
4280	637	ru	Даудзесес погост
4281	637	en	Daudzeses Parish
4282	634	lv	Iršu pagasts
4283	634	lt	Iršu pagasts
4284	634	ee	Iršu pagasts
4285	634	ru	Иршy погост
4286	634	en	Irši Parish
3277	493	lv	Jaunjelgavas pagasts
3278	493	lt	Jaunjelgavos pagasts
3279	493	ee	Jaunjelgavas pagasts
3280	493	ru	Яунелгавaс погост
3281	493	en	Jaunjelgava Parish
4292	640	lv	Klintaines pagasts
4293	640	lt	Klintaines pagasts
4294	640	ee	Klintaines pagasts
4295	640	ru	Клинтайнес погост
4296	640	en	Klintaine Parish
3262	490	lv	Kokneses pagasts
3263	490	lt	Koknesės pagasts
3264	490	ee	Kokneses pagasts
3265	490	ru	Кокнесес погост
3266	490	en	Koknese Parish
4302	632	lv	Mazzalves pagasts
4303	632	lt	Mazzalvės pagasts
4304	632	ee	Mazzalves pagasts
4305	632	ru	Маззалвес погост
4306	632	en	Mazzalve Parish
4307	639	lv	Neretas pagasts
4308	639	lt	Neretas pagasts
4309	639	ee	Neretas pagasts
4310	639	ru	Неретас погост
4311	639	en	Nereta Parish
4312	635	lv	Pilskalnes pagasts
4313	635	lt	Pilskalnės pagasts
4314	635	ee	Pilskalnes pagasts
4315	635	ru	Пилскалнес погост
4316	635	en	Pilskalne Parish
4317	641	lv	Seces pagasts
4318	641	lt	Seces pagasts
4319	641	ee	Seces pagasts
4320	641	ru	Сецес погост
4321	641	en	Sece Parish
4322	636	lv	Sērenes pagasts
4323	636	lt	Sērenes pagasts
4324	636	ee	Sērenes pagasts
4325	636	ru	Серенес погост
4326	636	en	Sērene Parish
3272	492	lv	Skrīveru pagasts
3273	492	lt	Skrīverų pagasts
3274	492	ee	Skrīveru pagasts
3275	492	ru	Скриверу погост
3276	492	en	Skrīveri Parish
4332	643	lv	Staburaga pagasts
4333	643	lt	Staburaga pagasts
4334	643	ee	Staburaga pagasts
4335	643	ru	Стабурага погост
4336	643	en	Staburags Parish
4337	638	lv	Sunākstes pagasts
4338	638	lt	Sunākstės pagasts
4339	638	ee	Sunākstes pagasts
4340	638	ru	Сунакстес погост
4341	638	en	Sunākste Parish
4342	644	lv	Vietalvas pagasts
4343	644	lt	Vietalvos pagasts
4344	644	ee	Vietalvas pagasts
4345	644	ru	Виеталвас погост
4346	644	en	Vietalva Parish
4347	645	lv	Zālves pagasts
4348	645	lt	Zālves pagasts
4349	645	ee	Zālves pagasts
4350	645	ru	Залвес погост
4351	645	en	Zālve Parish
3267	489	lv	Pļaviņu pagasts
3268	489	lt	Pļaviņu pagasts
3269	489	ee	Pļaviņu pagasts
3270	489	ru	Плявиню погост
3271	489	en	Pļaviņas Parish
4357	656	lv	Alsviķu pagasts
4358	656	lt	Alsviķu pagasts
4359	656	ee	Alsviķu pagasts
4360	656	ru	Алсвикю погост
4361	656	en	Alsviķi Parish
4362	659	lv	Annas pagasts
4363	659	lt	Annas pagasts
4364	659	ee	Annas pagasts
4365	659	ru	Аннас погост
4366	659	en	Anna Parish
4367	655	lv	Ilzenes pagasts
4368	655	lt	Ilzenes pagasts
4369	655	ee	Ilzenes pagasts
4370	655	ru	Илзенес погост
4371	655	en	Ilzene Parish
4372	653	lv	Jaunalūksnes pagasts
4373	653	lt	Jaunalūksnes pagasts
4374	653	ee	Jaunalūksnes pagasts
4375	653	ru	Яуналукснес погост
4376	653	en	Jaunalūksne Parish
4377	652	lv	Jaunannas pagasts
4378	652	lt	Jaunannas pagasts
4379	652	ee	Jaunannas pagasts
4380	652	ru	Яунаннас погост
4381	652	en	Jaunanna Parish
4382	648	lv	Jaunlaicenes pagasts
4383	648	lt	Jaunlaicenes pagasts
4384	648	ee	Jaunlaicenes pagasts
4385	648	ru	Яунлайценес погост
4386	648	en	Jaunlaicene Parish
4387	657	lv	Kalncempju pagasts
4388	657	lt	Kalncempju pagasts
4389	657	ee	Kalncempju pagasts
4390	657	ru	Калнцемпью погост
4391	657	en	Kalncempji Parish
4392	649	lv	Liepnas pagasts
4393	649	lt	Liepnas pagasts
4394	649	ee	Liepnas pagasts
4395	649	ru	Лиепнас погост
4396	649	en	Liepna Parish
4397	647	lv	Malienas pagasts
4398	647	lt	Malienas pagasts
4399	647	ee	Malienas pagasts
4400	647	ru	Малиенас погост
4401	647	en	Maliena Parish
4402	651	lv	Mālupes pagasts
4403	651	lt	Mālupes pagasts
4404	651	ee	Mālupes pagasts
4405	651	ru	Малупес погост
4406	651	en	Mālupes Parish
4407	646	lv	Mārkalnes pagasts
4408	646	lt	Mārkalnes pagasts
4409	646	ee	Mārkalnes pagasts
4410	646	ru	Маркалнес погост
4411	646	en	Mārkalne Parish
4412	660	lv	Pededzes pagasts
4413	660	lt	Pededzes pagasts
4414	660	ee	Pededzes pagasts
4415	660	ru	Педедзес погост
4416	660	en	Pededze Parish
4417	658	lv	Veclaicenes pagasts
4418	658	lt	Veclaicenes pagasts
4419	658	ee	Veclaicenes pagasts
4420	658	ru	Веклайценес погост
4421	658	en	Veclaicene Parish
4422	654	lv	Zeltiņu pagasts
4423	654	lt	Zeltiņu pagasts
4424	654	ee	Zeltiņu pagasts
4425	654	ru	Зелтиню погост
4426	654	en	Zeltiņi Parish
4427	650	lv	Ziemera pagasts
4428	650	lt	Ziemera pagasts
4429	650	ee	Ziemera pagasts
4430	650	ru	Зиемера погост
4431	650	en	Ziemeri Parish
4432	661	lv	Valles pagasts
4433	661	lt	Valles pagasts
4434	661	ee	Valles pagasts
4435	661	ru	Valles pagasts
4436	661	en	Valles Parish
4437	662	lv	Viesturu pagasts
4438	662	lt	Viesturu pagasts
4439	662	ee	Viesturu pagasts
4440	662	ru	Viesturu pagasts
4441	662	en	Viesturu Parish
4442	663	en	Vecauce Parish
4443	663	ru	Вецауцеc погост
4444	663	ee	Vecauces pagasts
4445	663	lt	Vecauces pagasts
4446	663	lv	Vecauces pagasts
4447	664	lv	Alīta
4452	665	lv	Daugai
4457	666	lv	Simnas
4462	667	lv	Druskininki
4467	668	lv	Lazdiji
4472	669	lv	Varēna
4477	670	lv	Birštona
4482	671	lv	Jonava
4487	672	lv	Kaišiadorys
4492	673	lv	Žiežmariai
4497	674	lv	Kauņa
4502	675	lv	Ežerelis
4507	676	lv	Garliava
4512	677	lv	Vilkija
4517	678	lv	Ķēdaiņi
4522	679	lv	Prieni
4527	680	lv	Jiezna
4532	681	lv	Raseiņi
4537	682	lv	Ariogala
4448	664	lt	Alytus
4453	665	lt	Daugai
4458	666	lt	Simnas
4463	667	lt	Druskininkai
4468	668	lt	Lazdijai
4473	669	lt	Varėna
4478	670	lt	Birštonas
4483	671	lt	Jonava
4488	672	lt	Kaišiadorys
4493	673	lt	Žiežmariai
4498	674	lt	Kaunas
4503	675	lt	Ežerėlis
4508	676	lt	Garliava
4513	677	lt	Vilkija
4518	678	lt	Kėdainiai
4523	679	lt	Prienai
4528	680	lt	Jieznas
4533	681	lt	Raseiniai
4538	682	lt	Ariogala
4449	664	ee	Alytus
4454	665	ee	Daugai
4459	666	ee	Simnas
4464	667	ee	Druskininkai
4469	668	ee	Lazdijai
4474	669	ee	Varėna
4479	670	ee	Birštonas
4484	671	ee	Jonava
4489	672	ee	Kaišiadorys
4494	673	ee	Žiežmariai
4499	674	ee	Kaunas
4504	675	ee	Ežerėlis
4509	676	ee	Garliava
4514	677	ee	Vilkija
4519	678	ee	Kėdainiai
4524	679	ee	Prienai
4529	680	ee	Jieznas
4534	681	ee	Raseiniai
4539	682	ee	Ariogala
4450	664	ru	Алитус
4455	665	ru	Даугаи
4460	666	ru	Симнас
4465	667	ru	Друскининкай
4470	668	ru	Лаздияй
4475	669	ru	Варена
4480	670	ru	Бирштонас
4485	671	ru	Йонава
4490	672	ru	Кайшядорис
4495	673	ru	Жежмаряй
4500	674	ru	Каунас
4505	675	ru	Эжерялис
4510	676	ru	Гарлява
4515	677	ru	Вилькия
4520	678	ru	Кедайняй
4525	679	ru	Пренай
4530	680	ru	Езнас
4535	681	ru	Расейняй
4540	682	ru	Ариогала
4451	664	en	Alytus
4456	665	en	Daugai
4461	666	en	Simnas
4466	667	en	Druskininkai
4471	668	en	Lazdijai
4476	669	en	Varėna
4481	670	en	Birštonas
4486	671	en	Jonava
4491	672	en	Kaišiadorys
4496	673	en	Žiežmariai
4501	674	en	Kaunas
4506	675	en	Ežerėlis
4511	676	en	Garliava
4516	677	en	Vilkija
4521	678	en	Kėdainiai
4526	679	en	Prienai
4531	680	en	Jieznas
4536	681	en	Raseiniai
4541	682	en	Ariogala
4637	683	lv	Klaipēda
4638	683	lt	Klaipėda
4639	683	ee	Klaipėda
4640	683	ru	Клайпеда
4641	683	en	Klaipėda
4642	684	lv	Gargždi
4643	684	lt	Gargždai
4644	684	ee	Gargždai
4645	684	ru	Гаргждай
4646	684	en	Gargždai
4647	685	lv	Kretinga
4648	685	lt	Kretinga
4649	685	ee	Kretinga
4650	685	ru	Кретинга
4651	685	en	Kretinga
4652	686	lv	Salantai
4653	686	lt	Salantai
4654	686	ee	Salantai
4655	686	ru	Салантаи
4656	686	en	Salantai
4657	687	lv	Neringa
4658	687	lt	Neringa
4659	687	ee	Neringa
4660	687	ru	Неринга
4661	687	en	Neringa
4662	688	lv	Palanga
4663	688	lt	Palanga
4664	688	ee	Palanga
4665	688	ru	Паланга
4666	688	en	Palanga
4667	689	lv	Šilute
4668	689	lt	Šilutė
4669	689	ee	Šilutė
4670	689	ru	Шилуте
4671	689	en	Šilutė
4672	690	lv	Skuodas
4673	690	lt	Skuodas
4674	690	ee	Skuodas
4675	690	ru	Скуодас
4676	690	en	Skuodas
4677	691	lv	Kalvarija
4678	691	lt	Kalvarija
4679	691	ee	Kalvarija
4680	691	ru	Калвария
4681	691	en	Kalvarija
4682	692	lv	Kazlu Rūda
4683	692	lt	Kazlų Rūda
4684	692	ee	Kazlų Rūda
4685	692	ru	Казлу-Руда
4686	692	en	Kazlų Rūda
4687	693	lv	Marijampole
4688	693	lt	Marijampolė
4689	693	ee	Marijampolė
4690	693	ru	Мариямполе
4691	693	en	Marijampolė
4692	694	lv	Šakiai
4693	694	lt	Šakiai
4694	694	ee	Šakiai
4695	694	ru	Шакяй
4696	694	en	Šakiai
4697	695	lv	Kudirkos Naumiestis
4698	695	lt	Kudirkos Naumiestis
4699	695	ee	Kudirkos Naumiestis
4700	695	ru	Кудиркос Науместис
4701	695	en	Kudirkos Naumiestis
4702	696	lv	Vilkavišķis
4703	696	lt	Vilkaviškis
4704	696	ee	Vilkaviškis
4705	696	ru	Вилкавишкис
4706	696	en	Vilkaviškis
4707	697	lv	Kybartai
4708	697	lt	Kybartai
4709	697	ee	Kybartai
4710	697	ru	Кибартай
4711	697	en	Kybartai
4712	698	en	Kuršėnai
4713	698	ru	Куршяняй
4714	698	ee	Kuršėnai
4715	698	lt	Kuršėnai
4716	698	lv	Kuršėnai
4717	699	en	Šiauliai
4718	699	ru	Шяуляй
4719	699	ee	Šiauliai
4720	699	lt	Šiauliai
4721	699	lv	Šauļi
4722	700	lv	Radviliškis
4723	700	lt	Radviliškis
4724	700	ee	Radviliškis
4725	700	ru	Радвилишкис
4726	700	en	Radviliškis
4727	701	lv	Šeduva
4728	701	lt	Šeduva
4729	701	ee	Šeduva
4730	701	ru	Шедува
4731	701	en	Šeduva
4732	702	lv	Pakruojis
4733	702	lt	Pakruojis
4734	702	ee	Pakruojis
4735	702	ru	Пакруоис
4736	702	en	Pakruojis
4737	703	lv	Linkuva
4738	703	lt	Linkuva
4739	703	ee	Linkuva
4740	703	ru	Линкува
4741	703	en	Linkuva
4742	704	lv	Kelmė
4743	704	lt	Kelmė
4744	704	ee	Kelmė
4745	704	ru	Кельме
4746	704	en	Kelmė
4747	705	lv	Tytuvėnai
4748	705	lt	Tytuvėnai
4749	705	ee	Tytuvėnai
4750	705	ru	Тituvėnai
4751	705	en	Tytuvėnai
4752	706	lv	Užventis
4753	706	lt	Užventis
4754	706	ee	Užventis
4755	706	ru	Ужвентис
4756	706	en	Užventis
4757	707	lv	Jonišķis
4758	707	lt	Joniškis
4759	707	ee	Joniškis
4760	707	ru	Йонишкис
4761	707	en	Joniškis
4762	708	lv	Žagarė
4763	708	lt	Žagarė
4764	708	ee	Žagarė
4765	708	ru	Жагаре
4766	708	en	Žagarė
4767	709	lv	Akmenė
4768	709	lt	Akmenė
4769	709	ee	Akmenė
4770	709	ru	Акмяне
4771	709	en	Akmenė
4772	710	lv	Naujoji Akmenė
4773	710	lt	Naujoji Akmenė
4774	710	ee	Naujoji Akmenė
4775	710	ru	Новая Акмяне
4776	710	en	Naujoji Akmenė
4777	711	lv	Venta
4778	711	lt	Venta
4779	711	ee	Venta
4780	711	ru	Вента
4781	711	en	Venta
4782	712	lv	Rokiškis
4783	712	lt	Rokiškis
4784	712	ee	Rokiškis
4785	712	ru	Рокишкис
4786	712	en	Rokiškis
4787	713	lv	Obeliai
4788	713	lt	Obeliai
4789	713	ee	Obeliai
4790	713	ru	Обеляй
4791	713	en	Obeliai
4792	714	lv	Pandėlys
4793	714	lt	Pandėlys
4794	714	ee	Pandėlys
4795	714	ru	Пандялис
4796	714	en	Pandėlys
4797	715	lv	Pasvalys
4798	715	lt	Pasvalys
4799	715	ee	Pasvalys
4800	715	ru	Пасвалис
4801	715	en	Pasvalys
4802	716	lv	Joniškėlis
4803	716	lt	Joniškėlis
4804	716	ee	Joniškėlis
4805	716	ru	Ионишкялис
4806	716	en	Joniškėlis
4807	717	en	Ramygala
4808	717	ru	Рамигала
4809	717	ee	Ramygala
4810	717	lt	Ramygala
4811	717	lv	Ramygala
4812	718	en	Panevėžys
4813	718	ru	Паневежис
4814	718	ee	Panevėžys
4815	718	lt	Panevėžys
4816	718	lv	Panevėžys
4817	719	lv	Kupiškis
4818	719	lt	Kupiškis
4819	719	ee	Kupiškis
4820	719	ru	Купишкис
4821	719	en	Kupiškis
4822	720	lv	Subačius
4823	720	lt	Subačius
4824	720	ee	Subačius
4825	720	ru	Субачюс
4826	720	en	Subačius
4827	721	lv	Biržai
4828	721	lt	Biržai
4829	721	ee	Biržai
4830	721	ru	Биржай
4831	721	en	Biržai
4832	722	lv	Vabalninkas
4833	722	lt	Vabalninkas
4834	722	ee	Vabalninkas
4835	722	ru	Вабалнинкас
4836	722	en	Vabalninkas
4837	723	lv	Jurbarkas
4838	723	lt	Jurbarkas
4839	723	ee	Jurbarkas
4840	723	ru	Юрбаркас
4841	723	en	Jurbarkas
4842	724	lv	Pagėgiai
4843	724	lt	Pagėgiai
4844	724	ee	Pagėgiai
4845	724	ru	Пагегяй
4846	724	en	Pagėgiai
4847	725	lv	Šilalė
4848	725	lt	Šilalė
4849	725	ee	Šilalė
4850	725	ru	Шилале
4851	725	en	Šilalė
4852	726	lv	Tauragė
4853	726	lt	Tauragė
4854	726	ee	Tauragė
4855	726	ru	Таураге
4856	726	en	Tauragė
4857	727	lv	Skaudvilė
4858	727	lt	Skaudvilė
4859	727	ee	Skaudvilė
4860	727	ru	Скаудвиле
4861	727	en	Skaudvilė
4862	728	lv	Mažeikiai
4863	728	lt	Mažeikiai
4864	728	ee	Mažeikiai
4865	728	ru	Мажейкяй
4866	728	en	Mažeikiai
4867	729	lv	Viekšniai
4868	729	lt	Viekšniai
4869	729	ee	Viekšniai
4870	729	ru	Векшняй
4871	729	en	Viekšniai
4872	730	lv	Seda
4873	730	lt	Seda
4874	730	ee	Seda
4875	730	ru	Седа
4876	730	en	Seda
4877	731	lv	Plungė
4878	731	lt	Plungė
4879	731	ee	Plungė
4880	731	ru	Плунге
4881	731	en	Plungė
4882	732	lv	Rietavas
4883	732	lt	Rietavas
4884	732	ee	Rietavas
4885	732	ru	Риетавас
4886	732	en	Rietavas
4887	733	lv	Telšiai
4888	733	lt	Telšiai
4889	733	ee	Telšiai
4890	733	ru	Тельшяй
4891	733	en	Telšiai
4892	734	lv	Varniai
4893	734	lt	Varniai
4894	734	ee	Varniai
4895	734	ru	Варняй
4896	734	en	Varniai
4897	735	lv	Anīkščiai
4898	735	lt	Anykščiai
4899	735	ee	Anykščiai
4900	735	ru	Аникщяй
4901	735	en	Anykščiai
4902	736	lv	Kavarskas
4903	736	lt	Kavarskas
4904	736	ee	Kavarskas
4905	736	ru	Каварскас
4906	736	en	Kavarskas
4907	737	lv	Troškūnai
4908	737	lt	Troškūnai
4909	737	ee	Troškūnai
4910	737	ru	Трошкунай
4911	737	en	Troškūnai
4912	738	lv	Ignalina
4913	738	lt	Ignalina
4914	738	ee	Ignalina
4915	738	ru	Игналина
4916	738	en	Ignalina
4917	739	lv	Dūkštas
4918	739	lt	Dūkštas
4919	739	ee	Dūkštas
4920	739	ru	Дукштас
4921	739	en	Dūkštas
4922	740	lv	Molėtai
4923	740	lt	Molėtai
4924	740	ee	Molėtai
4925	740	ru	Молетай
4926	740	en	Molėtai
4927	741	lv	Utena
4928	741	lt	Utena
4929	741	ee	Utena
4930	741	ru	Утена
4931	741	en	Utena
4932	742	lv	Visaginas
4933	742	lt	Visaginas
4934	742	ee	Visaginas
4935	742	ru	Висагинас
4936	742	en	Visaginas
4937	743	lv	Zarasai
4938	743	lt	Zarasai
4939	743	ee	Zarasai
4940	743	ru	Зарасай
4941	743	en	Zarasai
4942	744	lv	Dusetos
4943	744	lt	Dusetos
4944	744	ee	Dusetos
4945	744	ru	Дусетос
4946	744	en	Dusetos
4947	745	lv	Elektrēni
4948	745	lt	Elektrėnai
4949	745	ee	Elektrėnai
4950	745	ru	Электренай
4951	745	en	Elektrėnai
4952	746	lv	Vievis
4953	746	lt	Vievis
4954	746	ee	Vievis
4955	746	ru	Виевис
4956	746	en	Vievis
4957	747	lv	Šalčininki
4958	747	lt	Šalčininkai
4959	747	ee	Šalčininkai
4960	747	ru	Шальчининкай
4961	747	en	Šalčininkai
4962	748	lv	Eišišķes
4963	748	lt	Eišiškės
4964	748	ee	Eišiškės
4965	748	ru	Эйшишкес
4966	748	en	Eišiškės
4967	749	lv	Širvintos
4968	749	lt	Širvintos
4969	749	ee	Širvintos
4970	749	ru	Ширвинтос
4971	749	en	Širvintos
4972	750	lv	Švenčonys
4973	750	lt	Švenčionys
4974	750	ee	Švenčionys
4975	750	ru	Швенчёнис
4976	750	en	Švenčionys
4977	751	lv	Švenčionėliai
4978	751	lt	Švenčionėliai
4979	751	ee	Švenčionėliai
4980	751	ru	Швенчонеляй
4981	751	en	Švenčionėliai
4982	752	lv	Pabrade
4983	752	lt	Pabradė
4984	752	ee	Pabradė
4985	752	ru	Пабраде
4986	752	en	Pabradė
4987	753	lv	Trakai
4988	753	lt	Trakai
4989	753	ee	Trakai
4990	753	ru	Тракай
4991	753	en	Trakai
4992	754	lv	Lentvaris
4993	754	lt	Lentvaris
4994	754	ee	Lentvaris
4995	754	ru	Лентварис
4996	754	en	Lentvaris
4997	755	lv	Rūdiškes
4998	755	lt	Rūdiškės
4999	755	ee	Rūdiškės
5000	755	ru	Рудишкес
5001	755	en	Rūdiškės
5002	756	lv	Ukmerģe
5003	756	lt	Ukmergė
5004	756	ee	Ukmergė
5005	756	ru	Укмерге
5006	756	en	Ukmergė
5007	757	lv	Viļņa
5008	757	lt	Vilnius
5009	757	ee	Vilnius
5010	757	ru	Вильнюс
5011	757	en	Vilnius
5012	758	lv	Nemenčina
5013	758	lt	Nemenčinė
5014	758	ee	Nemenčinė
5015	758	ru	Неменчине
5016	758	en	Nemenčinė
5017	759	lv	Tallina
5018	760	lv	Tartu
5019	761	lv	Narva
5020	762	lv	Pērnava
5021	763	lv	Kohtla-Jervē
5022	764	lv	Viljandi
5023	765	lv	Rakvere
5024	766	lv	Sillamē
5025	767	lv	Mārdu
5026	768	lv	Hāpsalu
5027	759	lt	Talinas
5028	760	lt	Tartu
5029	761	lt	Narva
5030	762	lt	Pernu
5031	763	lt	Kohtla-Jervė
5032	764	lt	Viljandi
5033	765	lt	Rakverė
5034	766	lt	Sillamė
5035	767	lt	Maardu
5036	768	lt	Hapsalu
5037	759	ee	Tallinn
5038	760	ee	Tartu
5039	761	ee	Narva
5040	762	ee	Pärnu
5041	763	ee	Kohtla-Järve
5042	764	ee	Viljandi
5043	765	ee	Rakvere
5044	766	ee	Sillamäe
5045	767	ee	Maardu
5046	768	ee	Haapsalu
5047	759	ru	Таллин
5048	760	ru	Тарту
5049	761	ru	Нарва
5050	762	ru	Пярну
5051	763	ru	Кохтла-Ярве
5052	764	ru	Вильянди
5053	765	ru	Раквере
5054	766	ru	Силламяэ
5055	767	ru	Маарду
5056	768	ru	Хаапсалу
5057	759	en	Tallinn
5058	760	en	Tartu
5059	761	en	Narva
5060	762	en	Pärnu
5061	763	en	Kohtla-Järve
5062	764	en	Viljandi
5063	765	en	Rakvere
5064	766	en	Sillamäe
5065	767	en	Maardu
5066	768	en	Haapsalu
5067	769	lv	Paide
5068	770	lv	Keila
5070	772	lv	Veru
5072	774	lv	Kuresāre
5074	776	lv	Tapa
5075	777	lv	Rapla
5076	769	lt	Paidė
5077	770	lt	Keila
5079	772	lt	Voru
5081	774	lt	Kuressarė
5083	776	lt	Tapa
5084	777	lt	Rapla
5085	769	ee	Paide
5086	770	ee	Keila
5088	772	ee	Võru
5090	774	ee	Kuressaare
5092	776	ee	Tapa
5093	777	ee	Rapla
5094	769	ru	Пайде
5095	770	ru	Кейла
5097	772	ru	Выру
5099	774	ru	Курессааре
5101	776	ru	Тапа
5102	777	ru	Рапла
5103	769	en	Paide
5104	770	en	Keila
5106	772	en	Võru
5108	774	en	Kuressaare
5110	776	en	Tapa
5111	777	en	Rapla
5112	778	lv	Turi
5113	780	lv	Veru
5114	781	lv	Hāpsalu
5115	782	lv	Rakvere
5116	783	lv	Kunda
5117	784	lv	Tamsalu
5118	787	lv	Kerdla
5073	775	lv	Jõhvi
5071	773	lv	Valga
5069	771	lv	Narva-Jēsū
5122	778	lt	Turi
5123	780	lt	Voru
5124	781	lt	Hapsalu
5125	782	lt	Rakverė
5126	783	lt	Kunda
5127	784	lt	Tamsalu
5128	787	lt	Kerdla
5082	775	lt	Jõhvi
5080	773	lt	Valga
5078	771	lt	Narva-Jesu
5132	778	ee	Türi
5133	780	ee	Võru
5134	781	ee	Haapsalu
5135	782	ee	Rakvere
5136	783	ee	Kunda
5137	784	ee	Tamsalu
5138	787	ee	Kärdla
5091	775	ee	Jõhvi
5089	773	ee	Valga
5087	771	ee	Narva-Jõesuu
5142	778	ru	Тюри
5143	780	ru	Выру
5144	781	ru	Хаапсалу
5145	782	ru	Раквере
5146	783	ru	Кунда
5100	775	ru	Йыхви
5147	784	ru	Тамсалу
5148	787	ru	Кярдла
5098	773	ru	Валга
5096	771	ru	Нарва-Йыэсуу
5152	778	en	Türi
5153	780	en	Võru
5154	781	en	Haapsalu
5155	782	en	Rakvere
5156	783	en	Kunda
5157	784	en	Tamsalu
5158	787	en	Kärdla
5109	775	en	Jõhvi
5107	773	en	Valga
5105	771	en	Narva-Jõesuu
5162	788	lv	Paldiski
5163	789	lv	Saue
5164	790	lv	Sindi
5165	791	lv	Kilingi-Nomme
5166	792	lv	Abja-Paluoja
5167	793	lv	Mõisaküla
5168	794	lv	Suure-Jaani
5169	788	lt	Paldiski
5170	789	lt	Saue
5171	790	lt	Sindi
5172	791	lt	Kilingi-Nomme
5173	792	lt	Abja-Paluoja
5174	793	lt	Moisaküla
5175	794	lt	Suure-Jaani
5176	788	ee	Paldiski
5177	789	ee	Saue
5178	790	ee	Sindi
5179	791	ee	Kilingi-Nõmme
5180	792	ee	Abja-Paluoja
5181	793	ee	Mõisaküla
5182	794	ee	Suure-Jaani
5183	788	ru	Палдиски
5184	789	ru	Сауэ
5185	790	ru	Синди
5186	791	ru	Килинги-Нымме
5187	792	ru	Абья-Палуоя
5188	793	ru	Мыйзакюла
5189	794	ru	Сууре-Яани
5190	788	en	Paldiski
5191	789	en	Saue
5192	790	en	Sindi
5193	791	en	Kilingi-Nõmme
5194	792	en	Abja-Paluoja
5195	793	en	Mõisaküla
5196	794	en	Suure-Jaani
5197	795	lv	Türi
5198	796	lv	Põlva
5199	797	lv	Räpina
5200	798	lv	Otepää
5201	799	lv	Elva
5202	800	lv	Jõgeva
5203	801	lv	Põltsamaa
5204	802	lv	Viljandi
5205	803	lv	Tõrva
5206	804	lv	Antsla
5207	795	lt	Türi
5208	796	lt	Põlva
5209	797	lt	Räpina
5210	798	lt	Otepää
5211	799	lt	Elva
5212	800	lt	Jõgeva
5213	801	lt	Põltsamaa
5214	802	lt	Viljandi
5215	803	lt	Tõrva
5216	804	lt	Antsla
5217	795	ee	Türi
5218	796	ee	Põlva
5219	797	ee	Räpina
5220	798	ee	Otepää
5221	799	ee	Elva
5222	800	ee	Jõgeva
5223	801	ee	Põltsamaa
5224	802	ee	Viljandi
5225	803	ee	Tõrva
5226	804	ee	Antsla
5227	795	ru	Тюри
5228	796	ru	Пылва
5229	797	ru	Ряпина
5230	798	ru	Отепя
5231	799	ru	Элва
5232	800	ru	Йыгева
5233	801	ru	Пыльтсамаа
5234	802	ru	Вильянди
5235	803	ru	Тырва
5236	804	ru	Антсла
5237	795	en	Türi
5238	796	en	Põlva
5239	797	en	Räpina
5240	798	en	Otepää
5241	799	en	Elva
5242	800	en	Jõgeva
5243	801	en	Põltsamaa
5244	802	en	Viljandi
5245	803	en	Tõrva
5246	804	en	Antsla
\.


ALTER TABLE public.city_translations ENABLE TRIGGER ALL;

--
-- Data for Name: country_translations; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.country_translations DISABLE TRIGGER ALL;

COPY public.country_translations (id, country_id, lang_code, name) FROM stdin;
1	1	en	Latvia
2	1	lv	Latvija
4	2	en	Lithuania
5	2	lt	Lietuva
7	3	en	Estonia
3	1	ru	Латвия
6	2	ru	Литва
9	3	ru	Эстония
10	3	lv	Igaunija
11	1	lt	Latvija
13	2	lv	Lietuva
15	3	lt	Estija
8	3	ee	Eesti
12	1	ee	Läti
14	2	ee	Leedu
\.


ALTER TABLE public.country_translations ENABLE TRIGGER ALL;

--
-- Data for Name: equipment_brands; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.equipment_brands DISABLE TRIGGER ALL;

COPY public.equipment_brands (id, key, name) FROM stdin;
1	kieffer	kieffer
2	passier	passier
3	stübben	stübben
4	busse	busse
5	kingsland	kingsland
6	pikeur	pikeur
7	cavallo	cavallo
8	euro-star	euro-star
9	eskadron	eskadron
10	anky	anky
11	fair-play	fair-play
12	weatherbeeta	weatherbeeta
13	horseware	horseware
14	kentucky	kentucky
15	lemieux	lemieux
16	trust	trust
17	sprenger	sprenger
18	waldhausen	waldhausen
19	other	other
\.


ALTER TABLE public.equipment_brands ENABLE TRIGGER ALL;

--
-- Data for Name: equipment_colors; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.equipment_colors DISABLE TRIGGER ALL;

COPY public.equipment_colors (id, key, hex) FROM stdin;
1	black	#000000
2	white	#FFFFFF
4	dark_brown	#654321
5	tan	#D2B48C
6	orange	#FF8C00
7	red	#DC143C
8	burgundy	#800020
9	pink	#FFC0CB
10	blue	#0000FF
11	navy	#000080
12	green	#008000
13	dark_green	#006400
14	purple	#800080
15	gray	#808080
16	silver	#C0C0C0
17	gold	#FFD700
18	yellow	#FFFF00
19	beige	#F5F5DC
3	brown	#964B00
20	other	\N
\.


ALTER TABLE public.equipment_colors ENABLE TRIGGER ALL;

--
-- Data for Name: equipment_color_translations; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.equipment_color_translations DISABLE TRIGGER ALL;

COPY public.equipment_color_translations (id, color_id, lang_code, name) FROM stdin;
1	1	en	Black
2	2	en	White
3	3	en	Brown
4	4	en	Dark Brown
5	5	en	Tan
6	6	en	Orange
7	7	en	Red
8	8	en	Burgundy
9	9	en	Pink
10	10	en	Blue
11	11	en	Navy
12	12	en	Green
13	13	en	Dark Green
14	14	en	Purple
15	15	en	Gray
16	16	en	Silver
17	17	en	Gold
18	18	en	Yellow
19	19	en	Beige
20	1	lv	Melns
21	2	lv	Balts
22	3	lv	Brūns
23	4	lv	Tumši brūns
24	5	lv	Smilškrāsas
25	6	lv	Oranžs
26	7	lv	Sarkans
27	8	lv	Burgundietis
28	9	lv	Rozā
29	10	lv	Zils
30	11	lv	Tumši zils
31	12	lv	Zaļš
32	13	lv	Tumši zaļš
33	14	lv	Violets
34	15	lv	Pelēks
35	16	lv	Sudraba
36	17	lv	Zelta
37	18	lv	Dzeltens
38	19	lv	Bēšs
53	15	et	Hall
58	1	lt	Juoda
59	2	lt	Balta
60	3	lt	Ruda
61	4	lt	Tamsiai ruda
62	5	lt	Smėlio
63	6	lt	Oranžinė
64	7	lt	Raudona
65	8	lt	Burgundiška
66	9	lt	Rožinė
67	10	lt	Mėlyna
68	11	lt	Tamsiai mėlyna
69	12	lt	Žalia
70	13	lt	Tamsiai žalia
71	14	lt	Violetinė
72	15	lt	Pilka
73	16	lt	Sidabrinė
74	17	lt	Auksinė
75	18	lt	Geltona
76	19	lt	Smėlinė
77	1	ru	Чёрный
78	2	ru	Белый
79	3	ru	Коричневый
80	4	ru	Тёмно-коричневый
81	5	ru	Бежевый
82	6	ru	Оранжевый
83	7	ru	Красный
84	8	ru	Бордовый
85	9	ru	Розовый
86	10	ru	Синий
87	11	ru	Тёмно-синий
88	12	ru	Зелёный
89	13	ru	Тёмно-зелёный
90	14	ru	Фиолетовый
91	15	ru	Серый
92	16	ru	Серебряный
93	17	ru	Золотой
94	18	ru	Жёлтый
95	19	ru	Бежевый
39	1	ee	Must
41	3	ee	Pruun
40	2	ee	Valge
43	5	ee	Beež
42	4	ee	Tumepruun
57	19	ee	Beež
56	18	ee	Kollane
54	16	ee	Hõbedane
55	17	ee	Kuldne
52	14	ee	Lilla
51	13	ee	Tumeroheline
50	12	ee	Roheline
49	11	ee	Tumesinine
48	10	ee	Sinine
47	9	ee	Roosa
46	8	ee	Burgundia
45	7	ee	Punane
44	6	ee	Oranž
96	20	en	Other
97	20	lv	Cits
98	20	lt	Kita
99	20	ee	Muu
100	20	ru	Другой
\.


ALTER TABLE public.equipment_color_translations ENABLE TRIGGER ALL;

--
-- Data for Name: equipment_conditions; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.equipment_conditions DISABLE TRIGGER ALL;

COPY public.equipment_conditions (id, key) FROM stdin;
1	new
2	like_new
3	good
4	fair
5	poor
\.


ALTER TABLE public.equipment_conditions ENABLE TRIGGER ALL;

--
-- Data for Name: equipment_condition_translations; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.equipment_condition_translations DISABLE TRIGGER ALL;

COPY public.equipment_condition_translations (id, condition_id, lang_code, name) FROM stdin;
11	1	lv	Jauns
12	1	en	New
13	1	ee	Uus
14	1	ru	Новый
15	2	lv	Kā jauns
16	2	en	Like new
17	2	ee	Nagu uus
18	2	ru	Почти новый
20	3	en	Good
24	4	en	Fair
25	4	ee	Rahuldav
28	5	en	Poor
19	3	lv	Labs
27	5	lv	Slikts
23	4	lv	Vidējs
21	3	ee	Hea
29	5	ee	Halb
22	3	ru	Хороший
26	4	ru	Удовлетворительный
30	5	ru	Плохой
31	1	lt	Naujas
32	2	lt	Kaip naujas
33	3	lt	Geras
34	4	lt	Patenkinamas
35	5	lt	Blogas
\.


ALTER TABLE public.equipment_condition_translations ENABLE TRIGGER ALL;

--
-- Data for Name: equipment_materials; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.equipment_materials DISABLE TRIGGER ALL;

COPY public.equipment_materials (id, key) FROM stdin;
1	leather
2	synthetic
3	nylon
4	cotton
5	wool
6	fleece
7	rubber
8	metal
9	plastic
10	wood
11	mixed
12	other
13	canvas
14	linen
15	hemp
16	sheepskin
17	felt
18	fur
19	down
20	polyester
21	spandex
22	microfiber
23	neoprene
24	kevlar
25	goretex
26	mesh
27	latex
28	polyurethane
29	carbon_fiber
30	foam
31	stainless_steel
32	brass
33	aluminum
34	iron
35	ceramic
36	silicone
37	biothane
38	eco_leather
39	recycled_material
40	composite
41	fabric_mix
42	fiber_glass
\.


ALTER TABLE public.equipment_materials ENABLE TRIGGER ALL;

--
-- Data for Name: equipment_types; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.equipment_types DISABLE TRIGGER ALL;

COPY public.equipment_types (id, key) FROM stdin;
1	saddle
2	bridle
3	blanket
4	boots
5	clothing
6	grooming
7	stable_equipment
8	trailer
9	other
10	saddle_pad
11	half_pad
12	girth
13	stirrups
14	stirrup_leathers
15	breastplate
16	martingale
17	bit
18	reins
19	noseband
20	hackamore
21	halter
22	lead_rope
23	cavesson
24	surcingle
25	training_aids
26	side_reins
27	draw_reins
28	pessoa_system
29	browband
30	bit_guards
31	ear_bonnet
32	saddle_bags
33	headstall
34	cinch
35	bosal
36	tendon_boots
37	fetlock_boots
38	overreach_boots
39	shipping_boots
40	hoof_boots
41	polo_wraps
42	stable_wraps
43	bandages
44	turnout_blanket
45	stable_blanket
46	rain_sheet
47	fly_rug
48	cooler
49	quarter_sheet
50	exercise_sheet
51	neck_cover
52	fly_mask
53	grooming_kit
54	body_brush
55	dandy_brush
56	hoof_pick
57	mane_tail_comb
58	sweat_scraper
59	clippers
60	hay_net
61	hay_bag
62	slow_feeder
63	feed_bucket
64	water_bucket
65	feed_scoop
66	salt_lick_holder
67	muck_fork
68	wheelbarrow
69	stable_mats
70	stall_guard
71	tie_ring
72	cross_tie
73	lead_chain
74	saddle_rack
75	bridle_hook
76	tack_trunk
77	boot_tree
78	ground_poles
79	cavaletti
80	jump_standards
81	jump_cups
82	arena_letters
83	training_cones
84	first_aid_kit
85	ice_boots
86	cooling_wraps
87	therapy_boots
88	magnetic_therapy
\.


ALTER TABLE public.equipment_types ENABLE TRIGGER ALL;

--
-- Data for Name: equipment_listings; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.equipment_listings DISABLE TRIGGER ALL;

COPY public.equipment_listings (id, user_id, title, description, price, currency, condition, size, color, country, images, status, featured, views_count, favorites_count, created_at, updated_at, sold_at, visible, city, lat, lon, municipality, brand_id, material_id, equipment_type_id, custom_equipment_type) FROM stdin;
fc1d0aa5-1e37-4dab-8719-b60af8596334	413d6728-bb68-4ebd-bd39-5b484d37312b	Saddles	111111111111111111111111111	45.00	EUR	good	15	Black	EE	{https://qetsvjfknresvkogwlmi.supabase.co/storage/v1/object/public/equipment-images/413d6728-bb68-4ebd-bd39-5b484d37312b/1756918720741-0.jpg}	available	f	15	1	2025-08-29 17:14:30.899645+00	2026-01-03 16:52:08.383202+00	\N	t	tallinn	\N	\N	tallinna-linn	8	\N	4	\N
62600565-ba8d-4453-b827-fadd7f64b686	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	ssssssssssssssssssssssssssssssssssssssssssss	sssssssssssssssssssssssssssss	34.50	EUR	good	15	Black	EE	{https://qetsvjfknresvkogwlmi.supabase.co/storage/v1/object/public/equipment-images/c82181b0-f29d-4ddc-aac1-2ac11ae9f361/1757094541893-0.jpg}	available	f	4	1	2025-09-05 17:49:02.445857+00	2026-01-03 17:14:09.424894+00	\N	f		\N	\N	\N	\N	\N	9	\N
b3d2e7da-6e9b-4dec-9f3f-a168fc3fe607	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz	zzzzzzzzzzzzzzzzzzzzzzzzzzzzz	67.70	EUR	good	\N	\N	FI	{https://qetsvjfknresvkogwlmi.supabase.co/storage/v1/object/public/equipment-images/c82181b0-f29d-4ddc-aac1-2ac11ae9f361/1757094382560-0.png}	available	f	1	1	2025-09-05 17:46:23.364154+00	2025-10-22 08:17:02.855809+00	\N	f		\N	\N	\N	\N	\N	9	\N
d7d545a5-978f-4573-b2bb-543a3be160a4	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	ddddddddddddddd	ddddddddddddddddddddfff	3.00	EUR	good	15	\N	Latvia	{https://qetsvjfknresvkogwlmi.supabase.co/storage/v1/object/public/equipment-images/413d6728-bb68-4ebd-bd39-5b484d37312b/0.22388234095944104.png,https://qetsvjfknresvkogwlmi.supabase.co/storage/v1/object/public/equipment-images/413d6728-bb68-4ebd-bd39-5b484d37312b/0.8245719841536062.jpg}	available	f	129	1	2025-10-18 15:52:50.399039+00	2026-01-03 17:40:31.314968+00	\N	t	Rite	56.2053606674801	25.4839701796902	Jēkabpils	7	2	3	\N
0e9e0ffd-1f4a-4bf8-92bc-4e62b4ac7297	413d6728-bb68-4ebd-bd39-5b484d37312b	FDFSfffffffffffffffffffffffffffffffffffffffff	fvfvfffffffffffffffffffffffffffv	56.00	EUR	good	89	Black	Latvia	{https://qetsvjfknresvkogwlmi.supabase.co/storage/v1/object/public/equipment-images/413d6728-bb68-4ebd-bd39-5b484d37312b/1760037984393-0.jpg}	sold	f	2	0	2025-10-09 19:26:24.865246+00	2025-12-02 21:37:14.830192+00	2025-12-02 21:37:01.938+00	t	Allaži	57.0781362523758	24.8003166201227	Sigulda	14	\N	9	\N
ff3c6a5a-4579-4609-a5a2-b03ab9a33526	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	fggggggggggggggggggggggggggggggg	gggggggggggggggggggggggggggggggggggggg	45.50	EUR	poor	15	Black	EE	{https://qetsvjfknresvkogwlmi.supabase.co/storage/v1/object/public/equipment-images/c82181b0-f29d-4ddc-aac1-2ac11ae9f361/1757094576177-0.jpg,https://qetsvjfknresvkogwlmi.supabase.co/storage/v1/object/public/equipment-images/c82181b0-f29d-4ddc-aac1-2ac11ae9f361/1757100902864-0.png,https://qetsvjfknresvkogwlmi.supabase.co/storage/v1/object/public/equipment-images/c82181b0-f29d-4ddc-aac1-2ac11ae9f361/1757100903554-1.jpg,https://qetsvjfknresvkogwlmi.supabase.co/storage/v1/object/public/equipment-images/c82181b0-f29d-4ddc-aac1-2ac11ae9f361/1757100903848-2.jpg,https://qetsvjfknresvkogwlmi.supabase.co/storage/v1/object/public/equipment-images/c82181b0-f29d-4ddc-aac1-2ac11ae9f361/1757100904251-3.png,https://qetsvjfknresvkogwlmi.supabase.co/storage/v1/object/public/equipment-images/c82181b0-f29d-4ddc-aac1-2ac11ae9f361/1757100904951-4.jpeg}	available	f	2	2	2025-09-05 17:49:36.736295+00	2025-11-12 17:29:04.029934+00	\N	f		\N	\N	\N	\N	\N	9	\N
8b85e009-c7f4-4636-b613-87fba176cf48	37bc011e-0f0e-49b8-8b3e-e0f03ec8fd86	Kivere	Noice  very gud wualityeee	100.00	EUR	good	Medium 56 izmers	\N	Lithuania	{https://qetsvjfknresvkogwlmi.supabase.co/storage/v1/object/public/equipment-images/37bc011e-0f0e-49b8-8b3e-e0f03ec8fd86/0.5189675168389718.jpeg}	available	f	87	2	2025-10-18 16:11:08.339177+00	2026-01-03 17:48:30.248276+00	\N	t	Vidiškiai	55.325171646714	24.8733649225048	Ukmergė	19	2	3	\N
ade3d46e-f9c2-420b-b4e9-edc1e07843f4	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	fffffffffffffff	rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr	44.00	EUR	excellent	56	\N	Latvia	{https://qetsvjfknresvkogwlmi.supabase.co/storage/v1/object/public/equipment-images/c82181b0-f29d-4ddc-aac1-2ac11ae9f361/0.24222451561314917.jpg,https://qetsvjfknresvkogwlmi.supabase.co/storage/v1/object/public/equipment-images/c82181b0-f29d-4ddc-aac1-2ac11ae9f361/0.09471337235573607.png}	available	f	4	1	2025-12-19 14:28:54.81013+00	2026-01-03 17:48:31.284223+00	\N	t	Ķekava	56.86017011624952	24.158260677088066	Ķekava	13	\N	77	\N
72799f8c-e7af-4263-a526-d4b8ef11a83a	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	ttttttttttttttttttttt	fffffffffffffffffffffffffffffffffc	55.00	EUR	excellent	56	\N	Latvia	{https://qetsvjfknresvkogwlmi.supabase.co/storage/v1/object/public/equipment-images/c82181b0-f29d-4ddc-aac1-2ac11ae9f361/0.7734890225696137.png}	sold	f	3	0	2025-12-06 11:10:54.055285+00	2025-12-06 11:50:43.174627+00	2025-12-06 11:15:23.013+00	t	Ķekava	56.8121105559398	24.2021879770164	Ķekava	13	\N	65	\N
\.


ALTER TABLE public.equipment_listings ENABLE TRIGGER ALL;

--
-- Data for Name: equipment_listing_colors; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.equipment_listing_colors DISABLE TRIGGER ALL;

COPY public.equipment_listing_colors (listing_id, color_id) FROM stdin;
d7d545a5-978f-4573-b2bb-543a3be160a4	5
fc1d0aa5-1e37-4dab-8719-b60af8596334	2
fc1d0aa5-1e37-4dab-8719-b60af8596334	4
0e9e0ffd-1f4a-4bf8-92bc-4e62b4ac7297	2
0e9e0ffd-1f4a-4bf8-92bc-4e62b4ac7297	6
72799f8c-e7af-4263-a526-d4b8ef11a83a	2
72799f8c-e7af-4263-a526-d4b8ef11a83a	4
72799f8c-e7af-4263-a526-d4b8ef11a83a	5
ade3d46e-f9c2-420b-b4e9-edc1e07843f4	5
ade3d46e-f9c2-420b-b4e9-edc1e07843f4	4
ade3d46e-f9c2-420b-b4e9-edc1e07843f4	9
\.


ALTER TABLE public.equipment_listing_colors ENABLE TRIGGER ALL;

--
-- Data for Name: equipment_material_translations; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.equipment_material_translations DISABLE TRIGGER ALL;

COPY public.equipment_material_translations (id, material_id, lang_code, name) FROM stdin;
25	1	lv	Āda
26	1	en	Leather
27	1	ee	Nahk
28	1	ru	Кожа
29	2	lv	Sintētisks
30	2	en	Synthetic
31	2	ee	Sünteetiline
32	2	ru	Синтетика
33	3	lv	Neilons
34	3	en	Nylon
35	3	ee	Nailon
36	3	ru	Нейлон
37	4	lv	Kokvilna
38	4	en	Cotton
39	4	ee	Puuvill
40	4	ru	Хлопок
41	5	lv	Vilna
42	5	en	Wool
43	5	ee	Vill
44	5	ru	Шерсть
45	6	lv	Flīss
46	6	en	Fleece
47	6	ee	Fliis
48	6	ru	Флис
49	7	lv	Gumija
50	7	en	Rubber
51	7	ee	Kumm
52	7	ru	Резина
53	8	lv	Metāls
54	8	en	Metal
55	8	ee	Metall
56	8	ru	Металл
57	9	lv	Plastmasa
58	9	en	Plastic
59	9	ee	Plastik
60	9	ru	Пластик
61	10	lv	Koks
62	10	en	Wood
63	10	ee	Puit
64	10	ru	Дерево
65	11	lv	Jaukts
66	11	en	Mixed
67	11	ee	Segamaterjal
68	11	ru	Смешанный
69	12	lv	Cits
70	12	en	Other
71	12	ee	Muu
72	12	ru	Другое
73	13	lv	Audekls
74	13	en	Canvas
75	13	ee	Lõuend
76	13	ru	Холст
77	14	lv	Lins
78	14	en	Linen
79	14	ee	Lina
80	14	ru	Лён
81	15	lv	Kaņepes
82	15	en	Hemp
83	15	ee	Kanep
84	15	ru	Конопля
85	16	lv	Aitas āda
86	16	en	Sheepskin
87	16	ee	Lambanahk
88	16	ru	Овчина
89	17	lv	Filcs
90	17	en	Felt
91	17	ee	Vilt
92	17	ru	Фетр
93	18	lv	Kažokāda
94	18	en	Fur
95	18	ee	Karusnahk
96	18	ru	Мех
97	19	lv	Dūnas
98	19	en	Down
99	19	ee	Udusuled
100	19	ru	Пух
101	20	lv	Poliesters
102	20	en	Polyester
103	20	ee	Polüester
104	20	ru	Полиэстер
105	21	lv	Spandekss
106	21	en	Spandex
107	21	ee	Spandeks
108	21	ru	Спандекс
109	22	lv	Mikrošķiedra
110	22	en	Microfiber
111	22	ee	Mikrokiud
112	22	ru	Микрофибра
113	23	lv	Neoprēns
114	23	en	Neoprene
115	23	ee	Neopreen
116	23	ru	Неопрен
117	24	lv	Kevlars
118	24	en	Kevlar
119	24	ee	Kevlar
120	24	ru	Кевлар
121	25	lv	Gore-Tex
122	25	en	Gore-Tex
123	25	ee	Gore-Tex
124	25	ru	Гортекс
125	26	lv	Tīkls
126	26	en	Mesh
127	26	ee	Võrk
128	26	ru	Сетка
129	27	lv	Latekss
130	27	en	Latex
131	27	ee	Lateks
132	27	ru	Латекс
133	28	lv	Poliuretāns
134	28	en	Polyurethane
135	28	ee	Polüuretaan
136	28	ru	Полиуретан
137	29	lv	Oglekļa šķiedra
138	29	en	Carbon fiber
139	29	ee	Süsinikkiud
140	29	ru	Углеродное волокно
141	30	lv	Putas
142	30	en	Foam
143	30	ee	Vaht
144	30	ru	Пена
145	31	lv	Nerūsējošais tērauds
146	31	en	Stainless steel
147	31	ee	Roostevaba teras
148	31	ru	Нержавеющая сталь
149	32	lv	Misiņš
150	32	en	Brass
151	32	ee	Messing
152	32	ru	Латунь
153	33	lv	Alumīnijs
154	33	en	Aluminum
155	33	ee	Alumiinium
156	33	ru	Алюминий
157	34	lv	Dzelzs
158	34	en	Iron
159	34	ee	Raud
160	34	ru	Железо
161	35	lv	Keramika
162	35	en	Ceramic
163	35	ee	Keraamika
164	35	ru	Керамика
165	36	lv	Silikons
166	36	en	Silicone
167	36	ee	Silikoon
168	36	ru	Силикон
169	37	lv	Biotāns
170	37	en	Biothane
171	37	ee	Biothane
172	37	ru	Биотан
173	38	lv	Eko āda
174	38	en	Eco leather
175	38	ee	Ökonahk
176	38	ru	Эко-кожа
177	39	lv	Pārstrādāts materiāls
178	39	en	Recycled material
179	39	ee	Taaskasutatud materjal
180	39	ru	Переработанный материал
181	40	lv	Kompozīts
182	40	en	Composite
183	40	ee	Komposiit
184	40	ru	Композит
185	41	lv	Auduma maisījums
186	41	en	Fabric mix
187	41	ee	Kangasegu
188	41	ru	Смесь тканей
189	42	lv	Stikla šķiedra
190	42	en	Fiberglass
191	42	ee	Klaaskiud
192	42	ru	Стекловолокно
\.


ALTER TABLE public.equipment_material_translations ENABLE TRIGGER ALL;

--
-- Data for Name: equipment_type_materials; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.equipment_type_materials DISABLE TRIGGER ALL;

COPY public.equipment_type_materials (equipment_type_id, material_id) FROM stdin;
1	1
1	2
2	1
2	2
18	1
18	2
21	1
21	2
3	2
10	2
3	4
10	4
3	5
10	5
3	6
10	6
\.


ALTER TABLE public.equipment_type_materials ENABLE TRIGGER ALL;

--
-- Data for Name: equipment_type_translations; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.equipment_type_translations DISABLE TRIGGER ALL;

COPY public.equipment_type_translations (id, type_id, lang_code, name) FROM stdin;
41	1	lv	Segli
42	1	en	Saddle
43	1	ee	Sadul
44	1	ru	Седло
45	2	lv	Iemaukti
46	2	en	Bridle
47	2	ee	Suitsed
48	2	ru	Уздечка
49	3	lv	Segas
50	3	en	Blanket
51	3	ee	Tekk
52	3	ru	Попона
53	4	lv	Zābaki
54	4	en	Boots
55	4	ee	Saapad
56	4	ru	Сапоги
57	5	lv	Apģērbs
58	5	en	Clothing
59	5	ee	Riietus
60	5	ru	Одежда
61	6	lv	Kopšana
62	6	en	Grooming
63	6	ee	Hooldus
64	6	ru	Уход
65	7	lv	Staļļa aprīkojums
66	7	en	Stable equipment
67	7	ee	Tallivarustus
68	7	ru	Конюшенное оборудование
69	8	lv	Treileris
70	8	en	Trailer
71	8	ee	Haagis
72	8	ru	Прицеп
73	9	lv	Cits
74	9	en	Other
75	9	ee	Muu
76	9	ru	Другое
77	10	lv	Seglu paliktnis
78	10	en	Saddle pad
79	10	ee	Sadulapehmendus
80	10	ru	Потник
81	11	lv	Puspaliktnis
82	11	en	Half pad
83	11	ee	Poolpadi
84	11	ru	Подкладка
85	12	lv	Jostas siksna
86	12	en	Girth
87	12	ee	Vöö
88	12	ru	Подпруга
89	13	lv	Kāpsli
90	13	en	Stirrups
91	13	ee	Jalused
92	13	ru	Стремена
93	14	lv	Kāpšļu siksnas
94	14	en	Stirrup leathers
95	14	ee	Jalurihmad
96	14	ru	Путлища
97	15	lv	Krūšu siksna
98	15	en	Breastplate
99	15	ee	Rinnarihm
100	15	ru	Нагрудник
101	16	lv	Martingals
102	16	en	Martingale
103	16	ee	Martingal
104	16	ru	Мартингал
105	17	lv	Iemutnis
106	17	en	Bit
107	17	ee	Suulised
108	17	ru	Удило
109	18	lv	Pavadas
110	18	en	Reins
111	18	ee	Ohjad
112	18	ru	Поводья
113	19	lv	Deguna siksna
114	19	en	Noseband
115	19	ee	Ninarihm
116	19	ru	Носовой ремень
117	20	lv	Hakamora
118	20	en	Hackamore
119	20	ee	Hakamor
120	20	ru	Хакамора
121	21	lv	Iemaukti bez iemutņa
122	21	en	Halter
123	21	ee	Päitsed
124	21	ru	Недоуздок
125	22	lv	Pavada virve
126	22	en	Lead rope
127	22	ee	Juhtnöör
128	22	ru	Поводок
129	23	lv	Kavesons
130	23	en	Cavesson
131	23	ee	Kapesoon
132	23	ru	Капцунг
133	24	lv	Surčingls
134	24	en	Surcingle
135	24	ee	Surtsingel
136	24	ru	Гурт
137	25	lv	Treniņu palīglīdzekļi
138	25	en	Training aids
139	25	ee	Treeningvahendid
140	25	ru	Тренировочные средства
141	26	lv	Sānu pavadas
142	26	en	Side reins
143	26	ee	Kõrvalohjad
144	26	ru	Боковые поводья
145	27	lv	Pievilkšanas pavadas
146	27	en	Draw reins
147	27	ee	Tõmbeohjad
148	27	ru	Вытяжные поводья
149	28	lv	Pessoa sistēma
150	28	en	Pessoa system
151	28	ee	Pessoa süsteem
152	28	ru	Система Pessoa
153	29	lv	Pieressiksna
154	29	en	Browband
155	29	ee	Peapael
156	29	ru	Налобный ремень
157	30	lv	Iemutņa aizsargi
158	30	en	Bit guards
159	30	ee	Suuliste kaitsed
160	30	ru	Защита удила
161	31	lv	Ausu tīkliņš
162	31	en	Ear bonnet
163	31	ee	Kõrvamüts
164	31	ru	Ушная сетка
165	32	lv	Seglu somas
166	32	en	Saddle bags
167	32	ee	Sadulakotid
168	32	ru	Сумки на седло
169	33	lv	Iemauktu galvasdaļa
170	33	en	Headstall
171	33	ee	Pearihm
172	33	ru	Головная часть уздечки
173	34	lv	Rietumu josta (cinch)
174	34	en	Cinch
175	34	ee	Läänevöö
176	34	ru	Синч
177	35	lv	Bosals
178	35	en	Bosal
179	35	ee	Bosal
180	35	ru	Босал
181	36	lv	Cīpslu sargi
182	36	en	Tendon boots
183	36	ee	Kõõlusekaitsmed
184	36	ru	Ногавки (сухожильные)
185	37	lv	Pakaļpēdas aizsargi
186	37	en	Fetlock boots
187	37	ee	Kannu-kaitsmed
188	37	ru	Ногавки на путовые суставы
189	38	lv	Zvana sargi
190	38	en	Overreach boots
191	38	ee	Kaitsukellad
192	38	ru	Колокольчики (защита от задевания)
193	39	lv	Transporta sargi
194	39	en	Shipping boots
195	39	ee	Transpordikaitsmed
196	39	ru	Транспортные защиты
197	40	lv	Nagu zābaciņi
198	40	en	Hoof boots
199	40	ee	Kabjasaapad
200	40	ru	Копытные ботинки
201	41	lv	Polo apsēji
202	41	en	Polo wraps
203	41	ee	Polo-sidemed
204	41	ru	Поло-бинты
205	42	lv	Staļļa apsēji
206	42	en	Stable wraps
207	42	ee	Tallisidemed
208	42	ru	Бинты для стойла
209	43	lv	Apsēji
210	43	en	Bandages
211	43	ee	Sidemed
212	43	ru	Бинты
213	44	lv	Āra sega
214	44	en	Turnout blanket
215	44	ee	Välistekk
216	44	ru	Прогулочная попона
217	45	lv	Staļļa sega
218	45	en	Stable blanket
219	45	ee	Tallitekk
220	45	ru	Стойловая попона
221	46	lv	Lietus sega
222	46	en	Rain sheet
223	46	ee	Vihmatekk
224	46	ru	Дождевочная попона
225	47	lv	Mušu sega
226	47	en	Fly rug
227	47	ee	Kärbeste tekk
228	47	ru	Сетчатая попона (от насекомых)
229	48	lv	Dzesēšanas sega
230	48	en	Cooler
231	48	ee	Jahutustekk
232	48	ru	Охлаждающая попона
233	49	lv	Krustu sega
234	49	en	Quarter sheet
235	49	ee	Ratsutamistekk
236	49	ru	Попона на круп (quarter sheet)
237	50	lv	Treniņu sega
238	50	en	Exercise sheet
239	50	ee	Treeningtekk
240	50	ru	Тренировочная попона
241	51	lv	Kakla pārsegs
242	51	en	Neck cover
243	51	ee	Kaelakate
244	51	ru	Шейная накидка
245	52	lv	Mušu maska
246	52	en	Fly mask
247	52	ee	Kärbsemask
248	52	ru	Маска от насекомых
249	53	lv	Kopšanas komplekts
250	53	en	Grooming kit
251	53	ee	Hoolduskomplekt
252	53	ru	Набор для ухода
253	54	lv	Mīkstā birste
254	54	en	Body brush
255	54	ee	Kehahari
256	54	ru	Щётка (мягкая)
257	55	lv	Cietā birste
258	55	en	Dandy brush
259	55	ee	Dandy-hari
260	55	ru	Щётка (жёсткая)
261	56	lv	Nagu āķis
262	56	en	Hoof pick
263	56	ee	Kabjahaak
264	56	ru	Крючок для копыт
265	57	lv	Krēpju un astes ķemme
266	57	en	Mane & tail comb
267	57	ee	Laka ja saba kamm
268	57	ru	Гребень для гривы и хвоста
269	58	lv	Sviedru skrāpis
270	58	en	Sweat scraper
271	58	ee	Higikraabits
272	58	ru	Скребок для пота
273	59	lv	Apcirpjamo mašīnīte
274	59	en	Clippers
275	59	ee	Karvalõikur
276	59	ru	Машинка для стрижки
277	60	lv	Siena tīkls
278	60	en	Hay net
279	60	ee	Heinavõrk
280	60	ru	Сетка для сена
281	61	lv	Siena maiss
282	61	en	Hay bag
283	61	ee	Heinakott
284	61	ru	Сумка для сена
285	62	lv	Lēnās barošanas siets
286	62	en	Slow feeder
287	62	ee	Aeglane söötur
288	62	ru	Замедлитель кормления
289	63	lv	Barības spainis
290	63	en	Feed bucket
291	63	ee	Söödanõu
292	63	ru	Кормовое ведро
293	64	lv	Ūdens spainis
294	64	en	Water bucket
295	64	ee	Veekopp
296	64	ru	Ведро для воды
297	65	lv	Barības kauss
298	65	en	Feed scoop
299	65	ee	Söödalusikas
300	65	ru	Ковш для корма
301	66	lv	Sāls briketes turētājs
302	66	en	Salt lick holder
303	66	ee	Soolakivi hoidja
304	66	ru	Держатель соляного лизунца
305	67	lv	Mēslu dakša
306	67	en	Muck fork
307	67	ee	Sõnnikuhark
308	67	ru	Навозные вилы
309	68	lv	Ķerra
310	68	en	Wheelbarrow
311	68	ee	Käru
312	68	ru	Тачка
313	69	lv	Staļļa paklāji
314	69	en	Stable mats
315	69	ee	Tallimatid
316	69	ru	Коврики для денника
317	70	lv	Boksa ķēde
318	70	en	Stall guard
319	70	ee	Boksi turvakett
320	70	ru	Перегородка/цепь на денник
321	71	lv	Piesiešanas gredzens
322	71	en	Tie ring
323	71	ee	Kinnitusrõngas
324	71	ru	Кольцо для привязи
325	72	lv	Dubultā piesiešana
326	72	en	Cross tie
327	72	ee	Ristkinnitused
328	72	ru	Кросс-тай (двойная привязь)
329	73	lv	Pavadas ķēde
330	73	en	Lead chain
331	73	ee	Juhtkett
332	73	ru	Цепь на повод
333	74	lv	Seglu statīvs
334	74	en	Saddle rack
335	74	ee	Sadularaam
336	74	ru	Держатель для седла
337	75	lv	Iemauktu āķis
338	75	en	Bridle hook
339	75	ee	Suitsenagi
340	75	ru	Крючок для уздечки
341	76	lv	Aprīkojuma kaste
342	76	en	Tack trunk
343	76	ee	Varustuse kast
344	76	ru	Сундук для амуниции
345	77	lv	Zābaku ieliktnis
346	77	en	Boot trees
347	77	ee	Saapavormid
348	77	ru	Формодержатели для сапог
349	78	lv	Zemes kavaletes
350	78	en	Ground poles
351	78	ee	Maapuud
352	78	ru	Палки на земле
353	79	lv	Kavaletes
354	79	en	Cavaletti
355	79	ee	Kavaleti
356	79	ru	Кавалетти
357	80	lv	Tīklu statīvi
358	80	en	Jump standards
359	80	ee	Tõkestandid
360	80	ru	Стойки для препятствий
361	81	lv	Stieņu turētāji
362	81	en	Jump cups
363	81	ee	Tõkkehoidjad
364	81	ru	Держатели жердей
365	82	lv	Manežas burti
366	82	en	Arena letters
367	82	ee	Platsi tähed
368	82	ru	Буквы манежа
369	83	lv	Treniņu konusi
370	83	en	Training cones
371	83	ee	Treenimiskoonused
372	83	ru	Тренировочные конусы
373	84	lv	Pirmās palīdzības komplekts
374	84	en	First aid kit
375	84	ee	Esmaabikomplekt
376	84	ru	Аптечка
377	85	lv	Ledus zābaki
378	85	en	Ice boots
379	85	ee	Jääsaapad
380	85	ru	Ледяные сапоги
381	86	lv	Dzesējošie apsēji
382	86	en	Cooling wraps
383	86	ee	Jahutussidemed
384	86	ru	Охлаждающие повязки
385	87	lv	Terapijas zābaki
386	87	en	Therapy boots
387	87	ee	Teraapiasaapad
388	87	ru	Терапевтические сапоги
389	88	lv	Magnētterapija
390	88	en	Magnetic therapy
391	88	ee	Magnetteraapia
392	88	ru	Магнитотерапия
\.


ALTER TABLE public.equipment_type_translations ENABLE TRIGGER ALL;

--
-- Data for Name: forum_categories; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.forum_categories DISABLE TRIGGER ALL;

COPY public.forum_categories (id, key, icon) FROM stdin;
1	general	💬
2	horses	🐴
3	equipment	🎯
4	training	📚
5	health	🏥
6	events	🏆
7	marketplace	🛒
8	off_topic	☕
\.


ALTER TABLE public.forum_categories ENABLE TRIGGER ALL;

--
-- Data for Name: forum_category_translations; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.forum_category_translations DISABLE TRIGGER ALL;

COPY public.forum_category_translations (id, category_id, lang_code, name, description) FROM stdin;
1	1	en	General Discussion	General topics and discussions
2	2	en	Horses	Everything about horses
3	3	en	Equipment & Tack	Discuss equipment and tack
4	4	en	Training & Techniques	Training methods and techniques
5	5	en	Health & Care	Horse health and care topics
6	6	en	Events & Competitions	Discuss events and competitions
7	7	en	Marketplace	Buy, sell, and trade discussions
8	8	en	Off Topic	Non-horse related discussions
9	1	lv	Vispārīgas diskusijas	Vispārīgas tēmas un diskusijas
10	2	lv	Zirgi	Viss par zirgiem
11	3	lv	Ekipējums	Diskusijas par ekipējumu
12	4	lv	Apmācība	Apmācības metodes un tehnikas
13	5	lv	Veselība un kopšana	Zirgu veselība un kopšana
14	6	lv	Pasākumi	Pasākumi un sacensības
15	7	lv	Tirgus	Pirkšanas, pārdošanas diskusijas
16	8	lv	Citas tēmas	Ne zirgu tēmas
17	1	ru	Общие обсуждения	Общие темы и обсуждения
18	2	ru	Лошади	Всё о лошадях
19	3	ru	Снаряжение	Обсуждение снаряжения
20	4	ru	Обучение	Методы и техники обучения
21	5	ru	Здоровье и уход	Здоровье и уход за лошадьми
22	6	ru	Мероприятия	Мероприятия и соревнования
23	7	ru	Рынок	Обсуждения купли-продажи
24	8	ru	Оффтоп	Не связанные с лошадьми темы
25	1	lt	Bendros diskusijos	Bendros temos ir diskusijos
26	2	lt	Arkliai	Viskas apie arklius
27	3	lt	Įranga	Diskusijos apie įrangą
28	4	lt	Mokymas	Mokymo metodai ir technikos
29	5	lt	Sveikata ir priežiūra	Arklių sveikata ir priežiūra
30	6	lt	Renginiai	Renginiai ir varžybos
31	7	lt	Rinka	Pirkimo, pardavimo diskusijos
32	8	lt	Kitos temos	Ne arklių temos
33	1	ee	Üldised arutelud	Üldised teemad ja arutelud
34	2	ee	Hobused	Kõik hobuste kohta
35	3	ee	Varustus	Arutelud varustuse kohta
36	4	ee	Treening	Treenimismeetodid ja tehnikad
37	5	ee	Tervis ja hooldus	Hobuste tervis ja hooldus
38	6	ee	Üritused	Üritused ja võistlused
39	7	ee	Turg	Ost-müügi arutelud
40	8	ee	Muu	Mitte hobustega seotud teemad
\.


ALTER TABLE public.forum_category_translations ENABLE TRIGGER ALL;

--
-- Data for Name: forum_groups; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.forum_groups DISABLE TRIGGER ALL;

COPY public.forum_groups (id, name, description, is_private, owner_id, avatar_url, member_count, created_at, updated_at) FROM stdin;
bb0a5d48-1e45-4c52-abf2-bb16c9f5da7e	QQ	QQ	f	413d6728-bb68-4ebd-bd39-5b484d37312b	\N	2	2025-11-14 17:25:56.95329+00	2025-11-15 10:09:19.578843+00
6c6d4ada-0273-4ab4-b044-2c19634e054a	Alpu zirgi grupa	Viss par un ap zirgiem	t	413d6728-bb68-4ebd-bd39-5b484d37312b	\N	1	2025-11-15 15:37:49.75306+00	2025-11-15 15:37:49.849678+00
deb3f890-2662-47db-a975-03bcb6aab214	d	d	f	413d6728-bb68-4ebd-bd39-5b484d37312b	https://qetsvjfknresvkogwlmi.supabase.co/storage/v1/object/public/group-avatars/avatars/0.4859418509565271.webp	1	2025-11-18 21:04:40.660051+00	2025-11-18 21:04:40.769065+00
7817f0b4-9912-416d-a766-1cc8a19e09ef	ff	ff	t	413d6728-bb68-4ebd-bd39-5b484d37312b	https://qetsvjfknresvkogwlmi.supabase.co/storage/v1/object/public/group-avatars/avatars/0.42613817559379574.webp	1	2025-11-19 22:29:52.884506+00	2025-11-19 22:29:52.989689+00
\.


ALTER TABLE public.forum_groups ENABLE TRIGGER ALL;

--
-- Data for Name: forum_group_members; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.forum_group_members DISABLE TRIGGER ALL;

COPY public.forum_group_members (id, group_id, user_id, role, joined_at) FROM stdin;
ca9de22a-740f-48f5-ba7e-4f644593a13b	bb0a5d48-1e45-4c52-abf2-bb16c9f5da7e	413d6728-bb68-4ebd-bd39-5b484d37312b	owner	2025-11-14 17:25:57.093855+00
2ce3c2fb-c2ef-457b-836c-66fd34bbde63	bb0a5d48-1e45-4c52-abf2-bb16c9f5da7e	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	member	2025-11-15 10:09:19.578843+00
31360d57-3384-4660-ae3f-7a2ba9cca310	6c6d4ada-0273-4ab4-b044-2c19634e054a	413d6728-bb68-4ebd-bd39-5b484d37312b	owner	2025-11-15 15:37:49.849678+00
a5d72bff-5e7c-4a1e-a1c6-aa3d3780feed	deb3f890-2662-47db-a975-03bcb6aab214	413d6728-bb68-4ebd-bd39-5b484d37312b	owner	2025-11-18 21:04:40.769065+00
3e7b7398-7253-4c8f-a5b0-4dbd595daa71	7817f0b4-9912-416d-a766-1cc8a19e09ef	413d6728-bb68-4ebd-bd39-5b484d37312b	owner	2025-11-19 22:29:52.989689+00
\.


ALTER TABLE public.forum_group_members ENABLE TRIGGER ALL;

--
-- Data for Name: forum_topics; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.forum_topics DISABLE TRIGGER ALL;

COPY public.forum_topics (id, title, content, category, user_id, created_at, updated_at, likes_count, replies_count, is_pinned, last_reply_at, images, group_id, files) FROM stdin;
691827b7-3be3-4109-a616-3a30ffdf17e3	rrrrrrr	@janis1 rrrr	general	413d6728-bb68-4ebd-bd39-5b484d37312b	2025-11-20 19:21:21.621352+00	2025-11-23 10:32:51.686669+00	0	7	f	2025-11-23 10:32:51.686669+00	{}	\N	\N
11acb60b-09b6-4ce4-bad4-1d7db3820ccf	rggggg	rrr	general	413d6728-bb68-4ebd-bd39-5b484d37312b	2025-12-17 19:47:44.71211+00	2025-12-21 17:35:04.120517+00	0	6	f	2025-12-21 17:35:04.120517+00	{}	\N	{https://qetsvjfknresvkogwlmi.supabase.co/storage/v1/object/public/forum-files/forum/9os5o3chri5-1766000852598.webp,https://qetsvjfknresvkogwlmi.supabase.co/storage/v1/object/public/forum-files/forum/aidbh9jiyn-1766000859572.docx}
a4f88245-2ef6-4b05-bde7-444dc699391c	Kāpēc Melvins ir apvēlies?	Anna dod pārāk daudz kārums, tā es uzskatu, kādām ir cits variants?	general	413d6728-bb68-4ebd-bd39-5b484d37312b	2025-09-02 17:49:19.12815+00	2025-09-02 18:03:55.350663+00	1	7	f	2025-09-02 18:03:55.350663+00	{}	\N	\N
2dc2137b-8b21-458d-9140-6fa72f2587eb	ee	ee	general	413d6728-bb68-4ebd-bd39-5b484d37312b	2025-11-19 19:03:45.465513+00	2025-12-23 17:49:53.416634+00	0	3	f	2025-12-23 17:49:53.416634+00	{}	\N	\N
1628dbec-9b6c-49c5-af36-32e906d16266	Test	Test	general	413d6728-bb68-4ebd-bd39-5b484d37312b	2025-09-03 14:30:51.196514+00	2025-09-03 16:59:42.205402+00	0	6	f	2025-09-03 16:59:42.205402+00	{}	\N	\N
cd3f49bd-9ae7-45a9-893c-de5577ca544b	dd	dd	general	413d6728-bb68-4ebd-bd39-5b484d37312b	2025-11-23 10:57:35.064114+00	2025-11-23 11:39:17.562445+00	0	1	f	2025-11-23 11:39:17.562445+00	{}	\N	{https://qetsvjfknresvkogwlmi.supabase.co/storage/v1/object/public/forum-files/forum/c063wyyihn-1763895438394.pdf}
c6ec0f91-9bc1-4654-8eba-2fc8ca4eb11e	dd	d	general	413d6728-bb68-4ebd-bd39-5b484d37312b	2025-11-23 10:50:56.020811+00	2025-11-23 11:58:08.215665+00	0	4	f	2025-11-23 11:58:08.215665+00	{https://qetsvjfknresvkogwlmi.supabase.co/storage/v1/object/public/forum-files/forum/1763895045375-0.1198124987161251.webp}	\N	\N
25735fe2-a270-4a96-889c-d884115e74b4	teseg	@AnnaMartaFreimane tests	general	413d6728-bb68-4ebd-bd39-5b484d37312b	2025-09-04 18:28:08.141088+00	2025-11-01 20:11:00.789417+00	0	2	f	2025-11-01 20:11:00.789417+00	{}	\N	\N
a4802abf-6192-4cda-826e-1ef578dee35c	Inventāra meklēšana	Kurš ir visizdevīgākais veikals cenu ziņā, kur iegādāties inventāru?	equipment	37bc011e-0f0e-49b8-8b3e-e0f03ec8fd86	2025-09-05 12:42:29.979188+00	2025-11-15 15:52:05.977124+00	0	4	f	2025-11-15 15:52:05.977124+00	{}	\N	\N
5fe2daa8-55d4-43b0-9e04-10ef4b373a09	ff	ffff	general	413d6728-bb68-4ebd-bd39-5b484d37312b	2025-11-19 18:52:14.377699+00	2025-11-19 18:52:14.377699+00	0	0	f	2025-11-19 18:52:14.377699+00	{https://qetsvjfknresvkogwlmi.supabase.co/storage/v1/object/public/forum-files/forum/1763577606248-0.6344122824167681.webp}	\N	\N
458b17a8-cd47-4ec5-a68b-066f610ec4c3	d	dd	general	413d6728-bb68-4ebd-bd39-5b484d37312b	2025-11-19 18:53:02.417063+00	2025-11-19 18:53:02.417063+00	0	0	f	2025-11-19 18:53:02.417063+00	{https://qetsvjfknresvkogwlmi.supabase.co/storage/v1/object/public/forum-files/forum/1763578357294-0.41517348583410585.webp,https://qetsvjfknresvkogwlmi.supabase.co/storage/v1/object/public/forum-files/forum/1763578357295-0.08582784452936887.webp,https://qetsvjfknresvkogwlmi.supabase.co/storage/v1/object/public/forum-files/forum/1763578357295-0.11532764239788962.png}	\N	\N
1353281c-0cb2-4df7-9277-3bb502aada7a	dd	dd	general	413d6728-bb68-4ebd-bd39-5b484d37312b	2025-11-19 19:00:09.505915+00	2025-11-19 19:00:09.505915+00	0	0	f	2025-11-19 19:00:09.505915+00	{https://qetsvjfknresvkogwlmi.supabase.co/storage/v1/object/public/forum-files/forum/1763578798984-0.6727597805773696.png}	\N	\N
3aa192e6-56e8-45b8-9e73-9b4a7d22accd	dd	dd	general	413d6728-bb68-4ebd-bd39-5b484d37312b	2025-11-19 19:07:09.837078+00	2025-11-19 19:07:09.837078+00	0	0	f	2025-11-19 19:07:09.837078+00	{}	\N	\N
6452eaf6-881c-4681-ba9f-7b62c5cc14b3	ff	ff	general	413d6728-bb68-4ebd-bd39-5b484d37312b	2025-11-19 19:11:44.073285+00	2025-11-19 19:11:44.073285+00	0	0	f	2025-11-19 19:11:44.073285+00	{}	\N	\N
d0a0dc2d-0c8f-48b7-8bde-ff62aa53d51d	222	ssssssssss	events	413d6728-bb68-4ebd-bd39-5b484d37312b	2025-11-19 19:12:08.61189+00	2025-11-19 19:12:08.61189+00	0	0	f	2025-11-19 19:12:08.61189+00	{}	\N	\N
287d20a7-5eb3-4746-bece-3db28ef7e82d	sssss	sss	general	413d6728-bb68-4ebd-bd39-5b484d37312b	2025-11-23 10:34:23.595349+00	2025-12-17 18:43:14.522598+00	0	5	f	2025-12-17 18:43:14.522598+00	{}	\N	\N
6f326480-a9d0-4f11-bc4d-2e2d76367633	ddddddddddd	dddddddd	general	413d6728-bb68-4ebd-bd39-5b484d37312b	2025-11-19 19:13:33.409734+00	2025-11-20 16:50:43.459428+00	0	3	f	2025-11-20 16:50:43.459428+00	{}	\N	\N
82f02150-4585-4550-ad5b-1ae81093e8c7	hhhh	hhhhhhhhhhhhhhhhh	general	e9d792ec-1edd-4905-8eef-b3a018d5de35	2026-01-05 16:45:21.438619+00	2026-01-05 16:45:21.438619+00	0	0	f	2026-01-05 16:45:21.438619+00	{}	\N	{https://qetsvjfknresvkogwlmi.supabase.co/storage/v1/object/public/forum-files/forum/0mjekrxp9lp-1767631520149.jpg}
fc75c6ca-291b-41f8-8f11-d7dc85912c86	dddddddddd	ddddddddddddddddddddddd	general	413d6728-bb68-4ebd-bd39-5b484d37312b	2025-12-23 21:02:33.089721+00	2026-01-05 16:47:19.485971+00	0	6	f	2026-01-05 16:47:19.485971+00	{}	\N	\N
\.


ALTER TABLE public.forum_topics ENABLE TRIGGER ALL;

--
-- Data for Name: forum_replies; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.forum_replies DISABLE TRIGGER ALL;

COPY public.forum_replies (id, topic_id, content, user_id, created_at, updated_at, likes_count, images, parent_id, files) FROM stdin;
7767f6d6-9c87-4f4d-b048-e8c0615fc7fc	a4f88245-2ef6-4b05-bde7-444dc699391c	Nee, varbūt viņam ir lieli kauli  :)	413d6728-bb68-4ebd-bd39-5b484d37312b	2025-09-02 17:49:54.46867+00	2025-09-02 17:49:54.46867+00	0	{}	\N	\N
5e8d3d19-dae7-4811-851e-2bd8cdb2cbcd	a4f88245-2ef6-4b05-bde7-444dc699391c	What neee, vinam ir bieza ada	413d6728-bb68-4ebd-bd39-5b484d37312b	2025-09-02 17:50:14.379059+00	2025-09-02 17:50:14.379059+00	0	{}	\N	\N
39842a1e-c9c5-428c-a397-98ccae15ee72	a4f88245-2ef6-4b05-bde7-444dc699391c	Melvins ir perfekts. Neabižot manu poniju. Zvanīšu policijai.	37bc011e-0f0e-49b8-8b3e-e0f03ec8fd86	2025-09-02 17:57:13.885316+00	2025-09-02 17:57:13.885316+00	0	{}	\N	\N
90a4a345-fa32-4215-8e1f-4dfdd92c2a7f	a4f88245-2ef6-4b05-bde7-444dc699391c	Zvani. Man sencis tur strādā	413d6728-bb68-4ebd-bd39-5b484d37312b	2025-09-02 17:59:34.924626+00	2025-09-02 17:59:34.924626+00	0	{}	\N	\N
322f1310-d730-482e-be85-c3dbd6712a49	a4f88245-2ef6-4b05-bde7-444dc699391c	Man brālēns. Atkal, Melvins ir perfekts.	37bc011e-0f0e-49b8-8b3e-e0f03ec8fd86	2025-09-02 18:00:57.103255+00	2025-09-02 18:00:57.103255+00	0	{}	\N	\N
67d8d6e4-b057-495e-801e-72acda44a3cf	a4f88245-2ef6-4b05-bde7-444dc699391c	Ja Melvins ir perfekts, tad es esmu Neretnieks muahahahba	413d6728-bb68-4ebd-bd39-5b484d37312b	2025-09-02 18:02:10.396229+00	2025-09-02 18:02:10.396229+00	0	{}	\N	\N
d4673923-571e-4081-8aee-46aabd975a6b	a4f88245-2ef6-4b05-bde7-444dc699391c	Labi. Galvenais, ka Melvins paliek perfekts.	37bc011e-0f0e-49b8-8b3e-e0f03ec8fd86	2025-09-02 18:03:55.350663+00	2025-09-02 18:03:55.350663+00	0	{}	\N	\N
95dd2c50-b0c6-4506-8952-09bffda34a78	1628dbec-9b6c-49c5-af36-32e906d16266	kas i	413d6728-bb68-4ebd-bd39-5b484d37312b	2025-09-03 14:31:00.626813+00	2025-09-03 14:31:00.626813+00	0	{}	\N	\N
8353eb26-4a52-4200-a29c-08219256f09e	1628dbec-9b6c-49c5-af36-32e906d16266	test	413d6728-bb68-4ebd-bd39-5b484d37312b	2025-09-03 14:39:07.947594+00	2025-09-03 14:39:07.947594+00	0	{}	95dd2c50-b0c6-4506-8952-09bffda34a78	\N
933e03e6-8363-4efa-aabe-938cacfae360	1628dbec-9b6c-49c5-af36-32e906d16266	Anna	413d6728-bb68-4ebd-bd39-5b484d37312b	2025-09-03 14:39:17.000689+00	2025-09-03 14:39:17.000689+00	0	{}	\N	\N
2531144f-322e-47e1-a414-ffe5b987159e	1628dbec-9b6c-49c5-af36-32e906d16266	update	413d6728-bb68-4ebd-bd39-5b484d37312b	2025-09-03 14:39:28.359143+00	2025-09-03 14:39:28.359143+00	0	{}	8353eb26-4a52-4200-a29c-08219256f09e	\N
50fa6bc4-fb30-4671-95ad-6a4dfcf29f73	1628dbec-9b6c-49c5-af36-32e906d16266	Ko tu ardies	37bc011e-0f0e-49b8-8b3e-e0f03ec8fd86	2025-09-03 14:44:28.139329+00	2025-09-03 14:44:28.139329+00	0	{}	\N	\N
f66008e0-6495-4b3b-a8e4-a605e4f93f54	1628dbec-9b6c-49c5-af36-32e906d16266	nac un izdari kautko	413d6728-bb68-4ebd-bd39-5b484d37312b	2025-09-03 16:59:42.205402+00	2025-09-03 16:59:42.205402+00	0	{}	50fa6bc4-fb30-4671-95ad-6a4dfcf29f73	\N
3c9c942a-da50-4893-b831-8250967c2e97	a4802abf-6192-4cda-826e-1ef578dee35c	Nav tāda	413d6728-bb68-4ebd-bd39-5b484d37312b	2025-09-05 14:27:25.889734+00	2025-09-05 14:27:25.889734+00	0	{}	\N	\N
87cbe679-fb8a-44a5-9ef2-9bf9f808ee9b	a4802abf-6192-4cda-826e-1ef578dee35c	Rīgā ir	413d6728-bb68-4ebd-bd39-5b484d37312b	2025-10-02 16:58:23.280904+00	2025-10-02 16:58:23.280904+00	0	{}	\N	\N
505aed5a-120f-4935-bbc4-4f03820bf2f0	25735fe2-a270-4a96-889c-d884115e74b4	riga	413d6728-bb68-4ebd-bd39-5b484d37312b	2025-10-04 10:03:18.326183+00	2025-10-04 10:03:18.326183+00	0	{}	\N	\N
d1f0f1ba-4598-439e-ade9-382717036d3f	25735fe2-a270-4a96-889c-d884115e74b4	@amf check this out	413d6728-bb68-4ebd-bd39-5b484d37312b	2025-11-01 20:11:00.789417+00	2025-11-01 20:11:00.789417+00	0	{}	\N	\N
d3b0cfb3-0ce8-482a-95e8-0ac3f273886f	a4802abf-6192-4cda-826e-1ef578dee35c	tes	413d6728-bb68-4ebd-bd39-5b484d37312b	2025-11-03 21:34:43.500047+00	2025-11-03 21:34:43.500047+00	0	{}	3c9c942a-da50-4893-b831-8250967c2e97	\N
8de0e74d-8ceb-4d77-8e12-403d2d609416	a4802abf-6192-4cda-826e-1ef578dee35c	aa	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	2025-11-15 15:52:05.977124+00	2025-11-15 15:52:05.977124+00	0	{https://qetsvjfknresvkogwlmi.supabase.co/storage/v1/object/public/forum-files/forum/1763221870694-0.31303960308853696.png,https://qetsvjfknresvkogwlmi.supabase.co/storage/v1/object/public/forum-files/forum/1763221882376-0.5541275016954889.png,https://qetsvjfknresvkogwlmi.supabase.co/storage/v1/object/public/forum-files/forum/1763221882377-0.5461801803666019.png}	\N	\N
77784d35-5702-4256-91e8-868c587c0156	6f326480-a9d0-4f11-bc4d-2e2d76367633	dd	413d6728-bb68-4ebd-bd39-5b484d37312b	2025-11-19 22:28:48.334443+00	2025-11-19 22:28:48.334443+00	0	{}	cb0e3d9d-fc1c-4839-b2bf-ed1b699d80c8	\N
c0c7b3ed-1a8c-4aa5-adb1-3efbd0fb67be	6f326480-a9d0-4f11-bc4d-2e2d76367633	jjj	413d6728-bb68-4ebd-bd39-5b484d37312b	2025-11-20 16:50:43.459428+00	2025-11-20 16:50:43.459428+00	0	{https://qetsvjfknresvkogwlmi.supabase.co/storage/v1/object/public/forum-files/forum/1763657428948-0.2747335527527667.png}	\N	\N
cb6967bc-6de8-4856-9abc-4b1bdefb55cf	11acb60b-09b6-4ce4-bad4-1d7db3820ccf	ok	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	2025-12-19 14:27:38.701304+00	2025-12-19 14:27:38.701304+00	0	{}	\N	\N
f418026b-a178-49e0-9c0b-e32ca0efe98d	11acb60b-09b6-4ce4-bad4-1d7db3820ccf	huh	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	2025-12-20 17:59:02.223119+00	2025-12-20 17:59:02.223119+00	0	{}	\N	\N
cb0e3d9d-fc1c-4839-b2bf-ed1b699d80c8	6f326480-a9d0-4f11-bc4d-2e2d76367633	dd	413d6728-bb68-4ebd-bd39-5b484d37312b	2025-11-19 22:28:43.619314+00	2025-11-20 16:51:00.953983+00	1	{}	\N	\N
6da94204-fe82-4ee1-8d78-5526a2d115a2	691827b7-3be3-4109-a616-3a30ffdf17e3	ss	413d6728-bb68-4ebd-bd39-5b484d37312b	2025-11-20 20:38:22.837675+00	2025-11-20 20:38:22.837675+00	0	{}	\N	\N
73f0a154-856f-44d0-b0b9-2cbeafa99963	691827b7-3be3-4109-a616-3a30ffdf17e3	dd	413d6728-bb68-4ebd-bd39-5b484d37312b	2025-11-22 12:50:04.933486+00	2025-11-22 12:50:04.933486+00	0	{https://qetsvjfknresvkogwlmi.supabase.co/storage/v1/object/public/forum-files/forum/1763815785791-0.06941662989274833.webp}	6da94204-fe82-4ee1-8d78-5526a2d115a2	\N
78700c22-c0a9-47a7-9a74-84bc216ee8ba	691827b7-3be3-4109-a616-3a30ffdf17e3	6	413d6728-bb68-4ebd-bd39-5b484d37312b	2025-11-23 10:07:30.835384+00	2025-11-23 10:07:30.835384+00	0	{}	6da94204-fe82-4ee1-8d78-5526a2d115a2	\N
f4ea8275-fcd4-4bf7-9ee1-b6eb55fb6486	691827b7-3be3-4109-a616-3a30ffdf17e3	lllll	413d6728-bb68-4ebd-bd39-5b484d37312b	2025-11-23 10:13:38.437887+00	2025-11-23 10:13:38.437887+00	0	{}	\N	\N
e8e77ec7-1954-452a-ba34-a405b95e1645	691827b7-3be3-4109-a616-3a30ffdf17e3	fffff	413d6728-bb68-4ebd-bd39-5b484d37312b	2025-11-23 10:27:29.808578+00	2025-11-23 10:27:29.808578+00	0	{}	\N	\N
678d07b4-f275-4732-886f-e31fb1291bfe	691827b7-3be3-4109-a616-3a30ffdf17e3	vv	413d6728-bb68-4ebd-bd39-5b484d37312b	2025-11-23 10:27:50.114955+00	2025-11-23 10:27:50.114955+00	0	{https://qetsvjfknresvkogwlmi.supabase.co/storage/v1/object/public/forum-files/forum/1763893660185-0.25031761815194453.png}	\N	\N
21521777-bdb6-4503-bfdf-72dfe9e368d9	691827b7-3be3-4109-a616-3a30ffdf17e3	sw	413d6728-bb68-4ebd-bd39-5b484d37312b	2025-11-23 10:32:51.686669+00	2025-11-23 10:32:51.686669+00	0	{}	\N	\N
d8c86c20-44fc-4eff-ab6b-d1db3ec4ea97	287d20a7-5eb3-4746-bece-3db28ef7e82d	dd	413d6728-bb68-4ebd-bd39-5b484d37312b	2025-11-23 10:34:52.815089+00	2025-11-23 10:34:52.815089+00	0	{https://qetsvjfknresvkogwlmi.supabase.co/storage/v1/object/public/forum-files/forum/1763894083863-0.11807985998733683.webp}	\N	\N
6243791f-0863-489f-aba8-4e95f2ae4055	287d20a7-5eb3-4746-bece-3db28ef7e82d	edd	413d6728-bb68-4ebd-bd39-5b484d37312b	2025-11-23 10:47:41.014047+00	2025-11-23 10:47:41.014047+00	0	{}	\N	\N
5ee02ca6-c032-4612-9989-ed0f850c8a81	c6ec0f91-9bc1-4654-8eba-2fc8ca4eb11e	vv	413d6728-bb68-4ebd-bd39-5b484d37312b	2025-11-23 10:52:45.754061+00	2025-11-23 10:52:45.754061+00	0	{https://qetsvjfknresvkogwlmi.supabase.co/storage/v1/object/public/forum-files/forum/1763895159609-0.2466546637691296.png}	\N	\N
be4c3a73-0675-40b6-a2ef-535d4b8cbded	c6ec0f91-9bc1-4654-8eba-2fc8ca4eb11e	dd	413d6728-bb68-4ebd-bd39-5b484d37312b	2025-11-23 10:53:14.596054+00	2025-11-23 10:53:14.596054+00	0	{}	\N	\N
587cc93b-a0d3-4d54-b5ea-a0247b697ab1	c6ec0f91-9bc1-4654-8eba-2fc8ca4eb11e	dd	413d6728-bb68-4ebd-bd39-5b484d37312b	2025-11-23 10:54:43.731379+00	2025-11-23 10:54:43.731379+00	0	{}	\N	{https://qetsvjfknresvkogwlmi.supabase.co/storage/v1/object/public/forum-files/forum/mf5hfp0dpb8-1763895274417.pdf}
0f80a374-ee33-48a6-b22e-fbf3dd280570	cd3f49bd-9ae7-45a9-893c-de5577ca544b	gtt	413d6728-bb68-4ebd-bd39-5b484d37312b	2025-11-23 11:39:17.562445+00	2025-11-23 11:39:17.562445+00	0	{}	\N	{https://qetsvjfknresvkogwlmi.supabase.co/storage/v1/object/public/forum-files/forum/nahnz3d1ys-1763897946759.pdf,https://qetsvjfknresvkogwlmi.supabase.co/storage/v1/object/public/forum-files/forum/w26qzpak3jm-1763897952219.png}
6cdbd544-fa14-4018-baf4-24dc5526c350	c6ec0f91-9bc1-4654-8eba-2fc8ca4eb11e	ggg	413d6728-bb68-4ebd-bd39-5b484d37312b	2025-11-23 11:58:08.215665+00	2025-11-23 11:58:08.215665+00	0	{}	587cc93b-a0d3-4d54-b5ea-a0247b697ab1	{https://qetsvjfknresvkogwlmi.supabase.co/storage/v1/object/public/forum-files/forum/dve7xjx8gqc-1763899084706.png}
396c3b13-120f-44f0-9f6d-f4a0cde9a9dd	287d20a7-5eb3-4746-bece-3db28ef7e82d	test	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	2025-12-05 20:05:56.340723+00	2025-12-05 20:05:56.340723+00	0	{}	d8c86c20-44fc-4eff-ab6b-d1db3ec4ea97	\N
4a855e5f-9aef-46b2-bf6a-a825939ca3e8	287d20a7-5eb3-4746-bece-3db28ef7e82d	fff	413d6728-bb68-4ebd-bd39-5b484d37312b	2025-12-17 18:43:05.745017+00	2025-12-17 18:43:05.745017+00	0	{}	396c3b13-120f-44f0-9f6d-f4a0cde9a9dd	\N
b96f1db1-8688-4b2b-8a9f-d93e439bd0fc	287d20a7-5eb3-4746-bece-3db28ef7e82d	fff	413d6728-bb68-4ebd-bd39-5b484d37312b	2025-12-17 18:43:14.522598+00	2025-12-17 18:43:14.522598+00	0	{}	4a855e5f-9aef-46b2-bf6a-a825939ca3e8	\N
38706d22-9ab7-4082-9835-a3ebbff93215	11acb60b-09b6-4ce4-bad4-1d7db3820ccf	bro ne	413d6728-bb68-4ebd-bd39-5b484d37312b	2025-12-20 18:07:53.425071+00	2025-12-20 18:07:53.425071+00	0	{}	f418026b-a178-49e0-9c0b-e32ca0efe98d	\N
54ec6d73-222a-4ed5-a2d8-10b427bd34d1	11acb60b-09b6-4ce4-bad4-1d7db3820ccf	aaaaaaaaaa	413d6728-bb68-4ebd-bd39-5b484d37312b	2025-12-20 20:51:58.762995+00	2025-12-20 20:51:58.762995+00	0	{}	\N	{https://qetsvjfknresvkogwlmi.supabase.co/storage/v1/object/public/forum-files/forum/uwhyag2amdr-1766263910281.jpg,https://qetsvjfknresvkogwlmi.supabase.co/storage/v1/object/public/forum-files/forum/8fztedujmpa-1766263910973.jpg}
8c222253-5af0-4872-8ac2-cab00f1ad3e0	11acb60b-09b6-4ce4-bad4-1d7db3820ccf	test	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	2025-12-21 17:32:57.472311+00	2025-12-21 17:32:57.472311+00	0	{}	\N	\N
9bd10d3f-d787-49b1-b002-eab2c4dfded0	11acb60b-09b6-4ce4-bad4-1d7db3820ccf	a jaaaa	413d6728-bb68-4ebd-bd39-5b484d37312b	2025-12-21 17:35:04.120517+00	2025-12-21 17:35:04.120517+00	0	{}	cb6967bc-6de8-4856-9abc-4b1bdefb55cf	\N
37973a47-0fa2-478a-b690-8cc36d823f5a	2dc2137b-8b21-458d-9140-6fa72f2587eb	p	413d6728-bb68-4ebd-bd39-5b484d37312b	2025-12-21 18:21:26.625757+00	2025-12-21 18:21:26.625757+00	0	{}	\N	\N
899e7131-3b36-407c-ae55-73329fb7f42d	2dc2137b-8b21-458d-9140-6fa72f2587eb	TEST	413d6728-bb68-4ebd-bd39-5b484d37312b	2025-12-23 17:49:39.06446+00	2025-12-23 17:49:39.06446+00	0	{}	\N	\N
55c4b7cb-846c-4e0c-8c31-b8127ad6f037	2dc2137b-8b21-458d-9140-6fa72f2587eb	Test	413d6728-bb68-4ebd-bd39-5b484d37312b	2025-12-23 17:49:53.416634+00	2025-12-23 17:49:53.416634+00	0	{}	899e7131-3b36-407c-ae55-73329fb7f42d	\N
aec55528-fcd7-4ff5-8274-801f6a9f2dd3	fc75c6ca-291b-41f8-8f11-d7dc85912c86	ddddddddd	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	2025-12-23 21:02:44.794019+00	2025-12-23 21:02:44.794019+00	0	{}	\N	\N
a159fad1-38c5-406b-983d-847d8e9e6343	fc75c6ca-291b-41f8-8f11-d7dc85912c86	ddddd	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	2025-12-23 21:02:48.306847+00	2025-12-23 21:02:48.306847+00	0	{}	\N	\N
2ae72501-2a88-4aea-8e3b-e649b71916ea	fc75c6ca-291b-41f8-8f11-d7dc85912c86	dddddddddddddddddddd	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	2025-12-23 21:05:58.124415+00	2025-12-23 21:05:58.124415+00	0	{}	\N	\N
8813b5a9-bd05-4b17-8dcb-a777bbf93d93	fc75c6ca-291b-41f8-8f11-d7dc85912c86	ddd	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	2025-12-23 21:07:23.432706+00	2025-12-23 21:07:23.432706+00	0	{}	\N	\N
4e95ae68-9f16-4236-ae28-5093a0acd510	fc75c6ca-291b-41f8-8f11-d7dc85912c86	ddddd	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	2025-12-23 21:07:33.732025+00	2025-12-23 21:07:33.732025+00	0	{}	\N	\N
8508acc2-5c89-4935-ae08-a7ded08d74fd	fc75c6ca-291b-41f8-8f11-d7dc85912c86	k	e9d792ec-1edd-4905-8eef-b3a018d5de35	2026-01-05 16:47:19.485971+00	2026-01-05 16:47:19.485971+00	0	{}	\N	\N
\.


ALTER TABLE public.forum_replies ENABLE TRIGGER ALL;

--
-- Data for Name: forum_likes; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.forum_likes DISABLE TRIGGER ALL;

COPY public.forum_likes (id, user_id, topic_id, reply_id, created_at) FROM stdin;
e116d731-f30b-41a0-a23a-fa5927f270f1	413d6728-bb68-4ebd-bd39-5b484d37312b	a4f88245-2ef6-4b05-bde7-444dc699391c	\N	2025-09-02 17:50:44.576796+00
9e8aabef-f2cb-4cfd-ad9f-2305f2856e4e	413d6728-bb68-4ebd-bd39-5b484d37312b	\N	cb0e3d9d-fc1c-4839-b2bf-ed1b699d80c8	2025-11-20 16:51:00.953983+00
\.


ALTER TABLE public.forum_likes ENABLE TRIGGER ALL;

--
-- Data for Name: group_announcements; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.group_announcements DISABLE TRIGGER ALL;

COPY public.group_announcements (id, group_id, user_id, title, content, created_at, updated_at) FROM stdin;
982623dd-8f90-4387-a468-7a28aeb08a7c	bb0a5d48-1e45-4c52-abf2-bb16c9f5da7e	413d6728-bb68-4ebd-bd39-5b484d37312b	a	a	2025-11-14 17:43:58.921768+00	2025-11-14 17:43:58.921768+00
24b5f152-5e5f-4381-89ae-078185f857fd	bb0a5d48-1e45-4c52-abf2-bb16c9f5da7e	413d6728-bb68-4ebd-bd39-5b484d37312b	omg kas notiek?	eee	2025-11-15 16:02:38.084328+00	2025-11-15 16:02:38.084328+00
dfdac4b2-6230-4191-ba9e-88044dedbac4	bb0a5d48-1e45-4c52-abf2-bb16c9f5da7e	413d6728-bb68-4ebd-bd39-5b484d37312b	eee	eeee	2025-11-15 16:02:55.270354+00	2025-11-15 16:02:55.270354+00
\.


ALTER TABLE public.group_announcements ENABLE TRIGGER ALL;

--
-- Data for Name: group_invites; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.group_invites DISABLE TRIGGER ALL;

COPY public.group_invites (id, group_id, token, created_by, created_at, expires_at, max_uses, use_count) FROM stdin;
18b3f31a-1473-4e24-8bd3-bf6161b0cbff	bb0a5d48-1e45-4c52-abf2-bb16c9f5da7e	4xrbyezu9wbmi2121z7	413d6728-bb68-4ebd-bd39-5b484d37312b	2025-11-16 18:06:40.251791+00	\N	\N	0
d9ae64ed-ccfa-4782-8474-30c2a07a8726	6c6d4ada-0273-4ab4-b044-2c19634e054a	2xbopn521xrmi4xoyxr	413d6728-bb68-4ebd-bd39-5b484d37312b	2025-11-18 18:55:49.497002+00	\N	\N	0
101da6c7-2a6c-462f-b6d2-78534857e845	7817f0b4-9912-416d-a766-1cc8a19e09ef	jqewdozj9cdmi6ksd20	413d6728-bb68-4ebd-bd39-5b484d37312b	2025-11-19 22:30:05.419472+00	\N	\N	0
\.


ALTER TABLE public.group_invites ENABLE TRIGGER ALL;

--
-- Data for Name: group_messages; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.group_messages DISABLE TRIGGER ALL;

COPY public.group_messages (id, group_id, user_id, message, reply_to_id, files, created_at, updated_at) FROM stdin;
77df20ad-214e-453a-81a3-f4f42a72f5f1	bb0a5d48-1e45-4c52-abf2-bb16c9f5da7e	413d6728-bb68-4ebd-bd39-5b484d37312b	a	\N	[]	2025-11-14 17:44:12.548548+00	2025-11-14 17:44:12.548548+00
2b85bff3-da2a-4b94-b9ea-c34aa465187a	bb0a5d48-1e45-4c52-abf2-bb16c9f5da7e	413d6728-bb68-4ebd-bd39-5b484d37312b	aaaa	\N	[]	2025-11-14 17:44:21.703524+00	2025-11-14 17:44:21.703524+00
8f3e9ea7-8773-4938-b8c5-c85a7d18bd39	bb0a5d48-1e45-4c52-abf2-bb16c9f5da7e	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	kooo	\N	[]	2025-11-15 10:09:45.99053+00	2025-11-15 10:09:45.99053+00
90ec2f9a-7c3c-4d5f-a547-05a2837f75ca	bb0a5d48-1e45-4c52-abf2-bb16c9f5da7e	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	i	\N	[{"url": "https://qetsvjfknresvkogwlmi.supabase.co/storage/v1/object/public/forum-files/c82181b0-f29d-4ddc-aac1-2ac11ae9f361-1763201588331.docx", "name": "anagnostis.org_Raimunds_2025_10_30.docx", "size": 17375, "type": "application/vnd.openxmlformats-officedocument.wordprocessingml.document"}]	2025-11-15 10:13:09.341606+00	2025-11-15 10:13:09.341606+00
55d16770-59cf-466f-be01-792b66950574	6c6d4ada-0273-4ab4-b044-2c19634e054a	413d6728-bb68-4ebd-bd39-5b484d37312b	huhs	\N	[]	2025-11-15 15:38:00.033614+00	2025-11-15 15:38:00.033614+00
70534b8b-7837-4ea6-bb37-dd7e53038d71	bb0a5d48-1e45-4c52-abf2-bb16c9f5da7e	413d6728-bb68-4ebd-bd39-5b484d37312b	huh	\N	[{"url": "https://qetsvjfknresvkogwlmi.supabase.co/storage/v1/object/public/forum-files/413d6728-bb68-4ebd-bd39-5b484d37312b-1763222462631.png", "name": "joy.png", "size": 276725, "type": "image/png"}, {"url": "https://qetsvjfknresvkogwlmi.supabase.co/storage/v1/object/public/forum-files/413d6728-bb68-4ebd-bd39-5b484d37312b-1763222463501.png", "name": "final-pic.png", "size": 94229, "type": "image/png"}]	2025-11-15 16:01:04.419249+00	2025-11-15 16:01:04.419249+00
a36bb477-7584-43b7-8b3b-4a6365860af8	bb0a5d48-1e45-4c52-abf2-bb16c9f5da7e	413d6728-bb68-4ebd-bd39-5b484d37312b	ee	90ec2f9a-7c3c-4d5f-a547-05a2837f75ca	[]	2025-11-18 16:55:18.318887+00	2025-11-18 16:55:18.318887+00
22c85731-d517-4243-a9dd-a96006cd3a2a	6c6d4ada-0273-4ab4-b044-2c19634e054a	413d6728-bb68-4ebd-bd39-5b484d37312b	ff	55d16770-59cf-466f-be01-792b66950574	[]	2025-11-19 22:29:33.260213+00	2025-11-19 22:29:33.260213+00
\.


ALTER TABLE public.group_messages ENABLE TRIGGER ALL;

--
-- Data for Name: horse_breeds; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.horse_breeds DISABLE TRIGGER ALL;

COPY public.horse_breeds (id, key) FROM stdin;
4	warmblood
5	friesian
9	paint
21	latvian_warmblood
22	lithuanian_warmblood
23	estonian_warmblood
24	dutch_warmblood
\.


ALTER TABLE public.horse_breeds ENABLE TRIGGER ALL;

--
-- Data for Name: horse_breed_translations; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.horse_breed_translations DISABLE TRIGGER ALL;

COPY public.horse_breed_translations (id, breed_id, lang_code, name) FROM stdin;
11	4	en	Warmblood
12	4	lv	Siltasiņu
13	4	ee	Soojaverelised
14	4	lt	Šiltakraujis
15	4	rus	Полукровная
21	5	en	Friesian
22	5	lv	Frīzu zirgs
23	5	ee	Friisi hobune
24	5	lt	Fryzų arklys
25	5	rus	Фризская
41	9	en	Paint
42	9	lv	Peints
43	9	ee	Paint
44	9	lt	Peintas
45	9	rus	Пейнт
102	21	lv	Latvian siltasiņu
103	21	ee	Läti soojavereline
104	21	lt	Latvijos šiltakraujis
105	21	rus	Латвийская теплокровная
101	21	en	Latvian Warmblood
107	22	en	Lithuanian Warmblood
108	22	lv	Lietuvas siltasiņu
109	22	ee	Leedu poolveri
110	22	lt	Lietuvos šiltakraujis
111	22	rus	Литовская тяжелоупряжная
112	23	en	Estonian Warmblood
113	23	lv	Igaunijas siltasiņu
114	23	ee	Eesti poolveri
115	23	lt	Estijos šiltakraujis
116	23	rus	Эстонская полукровная
117	24	en	Dutch Warmblood
118	24	lv	Holandes siltasiņu
119	24	ee	Hollandi poolveri
120	24	lt	Olandijos šiltakraujis
121	24	rus	Голландская полукровная
125	4	ru	Теплокровная (Warmblood)
126	5	ru	Фризская лошадь
130	9	ru	Американская пейнт-лошадь
142	21	ru	Латвийская теплокровная
143	22	ru	Литовская теплокровная
144	23	ru	Эстонская теплокровная
145	24	ru	Голландская теплокровная
\.


ALTER TABLE public.horse_breed_translations ENABLE TRIGGER ALL;

--
-- Data for Name: horse_colors; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.horse_colors DISABLE TRIGGER ALL;

COPY public.horse_colors (id, key, hex) FROM stdin;
16	Other	#D2691E
1	Bay	#67412B
2	Chestnut	#954535
3	Black	#000000
4	Grey	#808080
5	White	#FFFFFF
6	Balomino	#CA9C7F
7	Buckskin	#DAAC87
8	Dun	#DEB587
9	Grullo	#a99a86
10	Roan	#ccb29d
11	Cremello	#ebdfce
13	Silver dapple	#A8AEB3
14	Paint	#F7F7F5
\.


ALTER TABLE public.horse_colors ENABLE TRIGGER ALL;

--
-- Data for Name: horse_color_translations; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.horse_color_translations DISABLE TRIGGER ALL;

COPY public.horse_color_translations (id, color_id, lang_code, name) FROM stdin;
1	1	en	Bay
3	1	lt	Bėjas
4	1	ee	Bai
5	1	ru	Бай
6	2	en	Chestnut
7	2	lv	Kastanis
8	2	lt	Kastanas
9	2	ee	Kastan
10	2	ru	Каштановый
11	3	en	Black
12	3	lv	Melnā
13	3	lt	Juoda
14	3	ee	Must
15	3	ru	Черный
16	4	en	Grey
17	4	lv	Pelēks
18	4	lt	Pilkas
19	4	ee	Hall
20	4	ru	Серый
21	5	en	White
22	5	lv	Balts
23	5	lt	Baltas
24	5	ee	Valge
25	5	ru	Белый
26	6	en	Palomino
27	6	lv	Palomino
28	6	lt	Palomino
29	6	ee	Palomino
30	6	ru	Паломино
31	7	en	Buckskin
32	7	lv	Baksķīns
33	7	lt	Baksinas
34	7	ee	Bakskiin
35	7	ru	Бакскин
36	8	en	Dun
37	8	lv	Duns
38	8	lt	Dunas
39	8	ee	Duun
40	8	ru	Дан
41	9	en	Grullo
42	9	lv	Grulo
43	9	lt	Grulo
44	9	ee	Grullo
45	9	ru	Грулло
46	10	en	Roan
47	10	lv	Rona
48	10	lt	Ronas
49	10	ee	Roan
50	10	ru	Роан
51	11	en	Cremello
52	11	lv	Kremello
53	11	lt	Kremelo
54	11	ee	Kremello
55	11	ru	Кремелло
61	13	en	Silver Dapple
62	13	lv	Sudrabains
63	13	lt	Sidabrinis
64	13	ee	Hõbedane
65	13	ru	Серебристый
76	16	en	Other
77	16	lv	Cits
78	16	lt	Kitas
79	16	ee	Muu
80	16	ru	Другое
2	1	lv	Bērs
66	14	en	Paint
67	14	lv	Paint
68	14	lt	Paint
69	14	ee	Paint
70	14	ru	Пейнт
\.


ALTER TABLE public.horse_color_translations ENABLE TRIGGER ALL;

--
-- Data for Name: horse_disciplines; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.horse_disciplines DISABLE TRIGGER ALL;

COPY public.horse_disciplines (id, key) FROM stdin;
1	dressage
2	show_jumping
3	eventing
4	endurance
5	western
6	trail_riding
7	racing
8	polo
9	driving
10	pleasure
11	horse_trail
\.


ALTER TABLE public.horse_disciplines ENABLE TRIGGER ALL;

--
-- Data for Name: horse_discipline_translations; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.horse_discipline_translations DISABLE TRIGGER ALL;

COPY public.horse_discipline_translations (id, discipline_id, lang_code, name) FROM stdin;
1	1	en	Dressage
2	1	lv	Dresūra
3	1	ee	Dressuuri
4	1	lt	Dresūra
6	2	en	Show Jumping
7	2	lv	Šķēršļu jāšana
8	2	ee	Takistussõit
16	3	en	Eventing
17	3	lv	Trīscīņa
18	3	ee	Kolmevõistlus
19	3	lt	Trijūšis
21	4	en	Endurance
22	4	lv	Izturības jāšana
23	4	ee	Vastupidavusala
24	4	lt	Ištvermės jojimas
26	5	en	Western
27	5	lv	Vesterns
28	5	ee	Western-ratsastus
29	5	lt	Vesternas
30	5	rus	Вестерн
31	6	en	Trail Riding
32	6	lv	Taku jāšana
33	6	ee	Maastikuratsutus
34	6	lt	Žygių jojimas
36	7	en	Racing
37	7	lv	Skriešanās
38	7	ee	Ratsavõistlus
39	7	lt	Lenktynės
41	8	en	Polo
42	8	lv	Polo
43	8	ee	Polo
44	8	lt	Polas
46	9	en	Driving
47	9	lv	Iejūgšana
48	9	ee	Rakendus
49	9	lt	Važiavimas
51	10	en	Pleasure
52	10	lv	Atpūtas jāšana
53	10	ee	Hobiratsastus
54	10	lt	Mėgėjiškas jojimas
5	1	ru	Выездка
10	2	ru	Конкур
20	3	ru	Троеборье
25	4	ru	Пробеги
35	6	ru	Трейл-райдинг
40	7	ru	Скачки
45	8	ru	Поло
50	9	ru	Драйвинг
55	10	ru	Хобби-класс
9	2	lt	Konkūrs
56	11	en	Trail (obstacle course)
57	11	lv	Trail (šķēršļu taka)
58	11	ru	Трейл (полоса препятствий)
59	11	lt	Trailas (kliūčių ruožas)
60	11	ee	Trail (takistusrada)
\.


ALTER TABLE public.horse_discipline_translations ENABLE TRIGGER ALL;

--
-- Data for Name: horse_sex; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.horse_sex DISABLE TRIGGER ALL;

COPY public.horse_sex (id, key) FROM stdin;
1	mare
2	stallion
3	gelding
\.


ALTER TABLE public.horse_sex ENABLE TRIGGER ALL;

--
-- Data for Name: pony_breeds; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.pony_breeds DISABLE TRIGGER ALL;

COPY public.pony_breeds (id, key) FROM stdin;
1	shetland
2	welsh_pony
3	connemara
12	fjord
13	american_shetland
\.


ALTER TABLE public.pony_breeds ENABLE TRIGGER ALL;

--
-- Data for Name: horse_listings; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.horse_listings DISABLE TRIGGER ALL;

COPY public.horse_listings (id, user_id, title, description, price, currency, country, images, status, featured, views_count, favorites_count, created_at, updated_at, sold_at, age, height, registration_id, video_urls, breed_id, sex_id, animal_type, pony_breed_id, visible, municipality, lat, lon, city, custom_breed, custom_pony_breed) FROM stdin;
bed57446-7247-4eda-938d-aaf8d9120c9d	e9d792ec-1edd-4905-8eef-b3a018d5de35	jjjjjjjjjj	nnnnnnnnnnnnnnnnnnnnnnn	66	EUR	Latvia	{https://qetsvjfknresvkogwlmi.supabase.co/storage/v1/object/public/horse-listing-images/e9d792ec-1edd-4905-8eef-b3a018d5de35/0.13180567521807307.jpeg}	available	f	0	0	2026-01-05 16:54:41.429772+00	2026-01-05 16:54:41.429772+00	\N	7	133	\N	{}	22	2	horse	\N	t	Olaine	56.79955588531669	24.033774867189948	Olaine	\N	\N
b312deef-53a4-487b-a0b0-761d22270f40	413d6728-bb68-4ebd-bd39-5b484d37312b	drrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr	drrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr	33	EUR	Latvia	{https://qetsvjfknresvkogwlmi.supabase.co/storage/v1/object/public/horse-listing-images/413d6728-bb68-4ebd-bd39-5b484d37312b/0.9147767875422511.webp,https://qetsvjfknresvkogwlmi.supabase.co/storage/v1/object/public/horse-listing-images/413d6728-bb68-4ebd-bd39-5b484d37312b/0.8891339848375763.webp,https://qetsvjfknresvkogwlmi.supabase.co/storage/v1/object/public/horse-listing-images/413d6728-bb68-4ebd-bd39-5b484d37312b/0.5206379354786237.png}	available	f	0	2	2025-11-19 21:46:25.181732+00	2026-01-05 16:17:57.865021+00	\N	4	150	LV001000001916	{}	\N	2	pony	3	t	Bauska	56.4975585076404	24.6490092421895	Valle	\N	\N
3987fa64-2b5e-4564-9cf2-e5ecec0880de	413d6728-bb68-4ebd-bd39-5b484d37312b	dd	rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr	4	EUR	Latvia	{https://qetsvjfknresvkogwlmi.supabase.co/storage/v1/object/public/horse-listing-images/413d6728-bb68-4ebd-bd39-5b484d37312b/0.8588289668908903.jpg,https://qetsvjfknresvkogwlmi.supabase.co/storage/v1/object/public/horse-listing-images/413d6728-bb68-4ebd-bd39-5b484d37312b/0.7353857636719242.png}	available	f	0	1	2025-11-11 21:02:32.502495+00	2026-01-03 17:48:16.748972+00	\N	4	150	\tLV001000001916	{}	\N	2	pony	2	t	Salaspils	56.8799985868116	24.3903606736488	Salaspils	\N	\N
ce671880-e3f9-4851-aef3-621a76b21fed	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	dddddddddd	ddddddddddddddddddddd	33	EUR	Latvia	{https://qetsvjfknresvkogwlmi.supabase.co/storage/v1/object/public/horse-listing-images/c82181b0-f29d-4ddc-aac1-2ac11ae9f361/0.7612356535078375.jpeg}	available	f	0	1	2025-12-29 10:13:07.990855+00	2026-01-03 17:48:09.546773+00	\N	3	144	\tLV001000001916	{}	\N	2	pony	1	t	Dobele	56.6126024667542	23.36360885156475	Bērze	\N	\N
\.


ALTER TABLE public.horse_listings ENABLE TRIGGER ALL;

--
-- Data for Name: horse_listing_colors; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.horse_listing_colors DISABLE TRIGGER ALL;

COPY public.horse_listing_colors (listing_id, color_id) FROM stdin;
3987fa64-2b5e-4564-9cf2-e5ecec0880de	5
3987fa64-2b5e-4564-9cf2-e5ecec0880de	4
b312deef-53a4-487b-a0b0-761d22270f40	5
ce671880-e3f9-4851-aef3-621a76b21fed	4
ce671880-e3f9-4851-aef3-621a76b21fed	1
ce671880-e3f9-4851-aef3-621a76b21fed	2
bed57446-7247-4eda-938d-aaf8d9120c9d	1
bed57446-7247-4eda-938d-aaf8d9120c9d	2
\.


ALTER TABLE public.horse_listing_colors ENABLE TRIGGER ALL;

--
-- Data for Name: horse_listing_disciplines; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.horse_listing_disciplines DISABLE TRIGGER ALL;

COPY public.horse_listing_disciplines (listing_id, discipline_id) FROM stdin;
b312deef-53a4-487b-a0b0-761d22270f40	6
b312deef-53a4-487b-a0b0-761d22270f40	10
b312deef-53a4-487b-a0b0-761d22270f40	11
ce671880-e3f9-4851-aef3-621a76b21fed	1
ce671880-e3f9-4851-aef3-621a76b21fed	6
bed57446-7247-4eda-938d-aaf8d9120c9d	5
bed57446-7247-4eda-938d-aaf8d9120c9d	6
3987fa64-2b5e-4564-9cf2-e5ecec0880de	2
3987fa64-2b5e-4564-9cf2-e5ecec0880de	6
\.


ALTER TABLE public.horse_listing_disciplines ENABLE TRIGGER ALL;

--
-- Data for Name: horse_temperament; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.horse_temperament DISABLE TRIGGER ALL;

COPY public.horse_temperament (id, key) FROM stdin;
1	calm
2	spirited
3	gentle
4	energetic
5	trained
\.


ALTER TABLE public.horse_temperament ENABLE TRIGGER ALL;

--
-- Data for Name: horse_listing_temperaments; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.horse_listing_temperaments DISABLE TRIGGER ALL;

COPY public.horse_listing_temperaments (id, listing_id, temperament_id, created_at) FROM stdin;
e0f01ed5-7a96-40c4-9785-389fc6d77e0c	b312deef-53a4-487b-a0b0-761d22270f40	1	2025-11-29 18:53:32.647306+00
b1e9b327-5b34-4aa4-ada8-f8551c9e8c85	b312deef-53a4-487b-a0b0-761d22270f40	2	2025-11-29 18:53:32.647306+00
73182eb6-da0b-44fa-8135-a0dbba27d8c9	ce671880-e3f9-4851-aef3-621a76b21fed	2	2025-12-29 10:13:15.537909+00
3d3fabba-32e2-4329-beac-e609406d8cac	ce671880-e3f9-4851-aef3-621a76b21fed	1	2025-12-29 10:13:15.537909+00
b0806767-81a3-4bc2-940a-1e0df58ab8ab	ce671880-e3f9-4851-aef3-621a76b21fed	5	2025-12-29 10:13:15.537909+00
87275838-7907-4e84-b8bf-778d0fe5c7e8	bed57446-7247-4eda-938d-aaf8d9120c9d	2	2026-01-05 16:54:42.888394+00
6e19575a-086a-48d8-bdfe-4adae340c9db	bed57446-7247-4eda-938d-aaf8d9120c9d	5	2026-01-05 16:54:42.888394+00
a9f35b95-cf21-4e50-a3dc-318a2d3c073f	3987fa64-2b5e-4564-9cf2-e5ecec0880de	5	2025-11-13 15:33:59.276195+00
319737b2-080e-42ed-b84a-21a42ba7539a	3987fa64-2b5e-4564-9cf2-e5ecec0880de	1	2025-11-13 15:33:59.276195+00
5d7b6f84-8f41-4180-bf30-ede368c78ab2	3987fa64-2b5e-4564-9cf2-e5ecec0880de	2	2025-11-13 15:33:59.276195+00
\.


ALTER TABLE public.horse_listing_temperaments ENABLE TRIGGER ALL;

--
-- Data for Name: horse_sex_translations; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.horse_sex_translations DISABLE TRIGGER ALL;

COPY public.horse_sex_translations (id, sex_id, lang_code, name) FROM stdin;
1	1	en	Mare
2	1	lv	Ķēve
3	1	ee	Mära
4	1	lt	Kumelė
6	2	en	Stallion
7	2	lv	Ērzelis
8	2	ee	Täkk
9	2	lt	Eržilas
11	3	en	Gelding
13	3	ee	Ruun
12	3	lv	Kastrāts
14	3	lt	Kastruotas arklys
15	3	ru	Мерин
5	1	ru	Кобыла
10	2	ru	Жеребец
\.


ALTER TABLE public.horse_sex_translations ENABLE TRIGGER ALL;

--
-- Data for Name: horse_temperament_translations; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.horse_temperament_translations DISABLE TRIGGER ALL;

COPY public.horse_temperament_translations (id, temperament_id, lang_code, name) FROM stdin;
1	1	en	Calm
2	1	lv	Mierīgs
3	1	ee	Rahulik
4	1	lt	Ramus
6	2	en	Spirited
7	2	lv	Dzīvespriecīgs
8	2	ee	Elav
9	2	lt	Gyvybingas
11	3	en	Gentle
12	3	lv	Maigs
13	3	ee	Õrn
14	3	lt	Švelnus
16	4	en	Energetic
17	4	lv	Enerģisks
18	4	ee	Energiline
19	4	lt	Energingas
21	5	en	Trained
22	5	lv	Apmācīts
23	5	ee	Treenitud
24	5	lt	Išdresiruotas
5	1	ru	Спокойный
10	2	ru	Темпераментный
15	3	ru	Кроткий
20	4	ru	Энергичный
25	5	ru	Обученный
\.


ALTER TABLE public.horse_temperament_translations ENABLE TRIGGER ALL;

--
-- Data for Name: listing_favorites; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.listing_favorites DISABLE TRIGGER ALL;

COPY public.listing_favorites (id, user_id, listing_id, listing_type, created_at) FROM stdin;
5a153a58-6079-4360-b2fe-921a507d82c1	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	ff3c6a5a-4579-4609-a5a2-b03ab9a33526	equipment	2025-09-22 16:47:25.781277+00
10aa4f89-ba89-41bb-8b31-60aa655070ae	413d6728-bb68-4ebd-bd39-5b484d37312b	9f07b154-6a46-475a-bb07-26a8a2d6e32e	horses	2025-09-25 20:15:14.458199+00
99050b7e-febb-4e8c-8a13-167b10157e19	413d6728-bb68-4ebd-bd39-5b484d37312b	ab8afe30-3614-4f52-9eb7-afea3d1a40b2	horses	2025-09-25 20:15:22.99869+00
5eef7009-6a6b-41da-8afd-e02c7b94e52d	413d6728-bb68-4ebd-bd39-5b484d37312b	a68c747e-45a3-4d9b-b1ef-61394570a871	horses	2025-11-10 22:53:31.345025+00
ab4b8996-db10-4432-af66-6a42250ff9f0	413d6728-bb68-4ebd-bd39-5b484d37312b	292371aa-800e-4b73-8dd1-0a54e473e478	horses	2025-11-10 22:55:15.103664+00
599d66fc-7946-4d41-8954-607b236471e5	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	8b85e009-c7f4-4636-b613-87fba176cf48	equipment	2025-12-20 17:10:37.68696+00
7f62d9da-df83-480b-ba81-99ad1d0aa824	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	ab8afe30-3614-4f52-9eb7-afea3d1a40b2	horses	2025-12-20 17:54:39.525093+00
e459610d-9712-49cd-ae61-a269b246b586	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	292371aa-800e-4b73-8dd1-0a54e473e478	horses	2025-12-20 17:57:56.325772+00
43a027b3-6015-40fe-882e-2bc62aec8e9d	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	fc1d0aa5-1e37-4dab-8719-b60af8596334	equipment	2025-12-20 17:58:21.461401+00
44428842-3bf9-4a33-8f56-6dd096e4bc74	413d6728-bb68-4ebd-bd39-5b484d37312b	ce671880-e3f9-4851-aef3-621a76b21fed	horses	2026-01-03 17:39:01.416922+00
2b5c6776-e35d-47f6-91fe-551265f98d0f	413d6728-bb68-4ebd-bd39-5b484d37312b	b312deef-53a4-487b-a0b0-761d22270f40	horses	2026-01-03 17:39:02.389635+00
97bd23b9-9873-4991-9d52-3da8e4c29fa0	413d6728-bb68-4ebd-bd39-5b484d37312b	3987fa64-2b5e-4564-9cf2-e5ecec0880de	horses	2026-01-03 17:39:03.214654+00
47d8a555-2be2-4f2e-861a-cce839e0a951	413d6728-bb68-4ebd-bd39-5b484d37312b	b3d2e7da-6e9b-4dec-9f3f-a168fc3fe607	equipment	2025-09-25 12:15:53.799822+00
d0856207-9f3b-4c25-8d28-ff282c81a6e6	413d6728-bb68-4ebd-bd39-5b484d37312b	d7d545a5-978f-4573-b2bb-543a3be160a4	equipment	2026-01-03 17:40:31.314968+00
c483302c-a9c2-413c-9ab1-f44817202122	413d6728-bb68-4ebd-bd39-5b484d37312b	ce671880-e3f9-4851-aef3-621a76b21fed	horse	2026-01-03 17:48:09.546773+00
07df5781-5627-4f96-820c-cf8bfe64a539	413d6728-bb68-4ebd-bd39-5b484d37312b	b312deef-53a4-487b-a0b0-761d22270f40	horse	2026-01-03 17:48:14.137631+00
acff5e85-f76d-4e62-a758-7c365aa37158	413d6728-bb68-4ebd-bd39-5b484d37312b	3987fa64-2b5e-4564-9cf2-e5ecec0880de	horse	2026-01-03 17:48:16.748972+00
ace54bf6-07e0-4762-bf22-55f2445c5edf	413d6728-bb68-4ebd-bd39-5b484d37312b	8b85e009-c7f4-4636-b613-87fba176cf48	equipment	2026-01-03 17:48:30.248276+00
4579541a-86bc-4c07-bdf8-99f195616252	413d6728-bb68-4ebd-bd39-5b484d37312b	ade3d46e-f9c2-420b-b4e9-edc1e07843f4	equipment	2026-01-03 17:48:31.284223+00
99d0e24e-f95d-4334-aa01-f121d6a0bf42	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	b312deef-53a4-487b-a0b0-761d22270f40	horse	2026-01-05 16:17:57.865021+00
533a6300-4922-4d09-8ec2-7373c030d6ff	413d6728-bb68-4ebd-bd39-5b484d37312b	62600565-ba8d-4453-b827-fadd7f64b686	equipment	2025-09-25 20:07:43.364472+00
e5a3a144-e165-45ee-9b90-0b268fdc2ccf	413d6728-bb68-4ebd-bd39-5b484d37312b	ff3c6a5a-4579-4609-a5a2-b03ab9a33526	equipment	2025-09-25 20:07:51.109328+00
\.


ALTER TABLE public.listing_favorites ENABLE TRIGGER ALL;

--
-- Data for Name: municipality_translations; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.municipality_translations DISABLE TRIGGER ALL;

COPY public.municipality_translations (id, municipality_id, lang_code, name) FROM stdin;
66	43	lv	Rīgas valstspilsēta
67	43	lt	Rygos valstybinis miestas
68	43	ee	Riia riigilinn
69	43	ru	Государственный город Рига
70	43	en	State city of Riga
71	44	lv	Daugavpils valstspilsēta
72	44	lt	Daugpilio valstybinis miestas
73	44	ee	Daugavpilsi riigilinn
74	44	ru	Государственный город Даугавпилс
75	44	en	State city of Daugavpils
76	45	lv	Liepājas valstspilsēta
77	45	lt	Liepojos valstybinis miestas
78	45	ee	Liepāja riigilinn
79	45	ru	Государственный город Лиепая
80	45	en	State city of Liepāja
81	46	lv	Jelgavas valstspilsēta
82	46	lt	Jelgavos valstybinis miestas
83	46	ee	Jelgava riigilinn
84	46	ru	Государственный город Елгава
85	46	en	State city of Jelgava
86	47	lv	Jūrmalas valstspilsēta
87	47	lt	Jūrmalos valstybinis miestas
88	47	ee	Jūrmala riigilinn
89	47	ru	Государственный город Юрмала
90	47	en	State city of Jūrmala
91	49	lv	Ventspils valstspilsēta
92	49	lt	Ventspilio valstybinis miestas
93	49	ee	Ventspilsi riigilinn
94	49	ru	Государственный город Вентспилс
95	49	en	State city of Ventspils
96	50	lv	Rēzeknes valstspilsēta
97	50	lt	Rėzeknės valstybinis miestas
98	50	ee	Rēzekne riigilinn
99	50	ru	Государственный город Резекне
100	50	en	State city of Rēzekne
101	51	lv	Ogres valstspilsēta
102	51	lt	Ogrės valstybinis miestas
103	51	ee	Ogre riigilinn
104	51	ru	Государственный город Огре
105	51	en	State city of Ogre
106	52	lv	Valmieras valstspilsēta
107	52	lt	Valmieros valstybinis miestas
108	52	ee	Valmiera riigilinn
109	52	ru	Государственный город Валмиера
110	52	en	State city of Valmiera
111	53	lv	Jēkabpils valstspilsēta
112	53	lt	Jėkabpilio valstybinis miestas
113	53	ee	Jēkabpils riigilinn
114	53	ru	Государственный город Екабпилс
115	53	en	State city of Jēkabpils
116	54	lv	Madonas novads
117	54	lt	Madonos savivaldybė
118	54	ee	Madona omavalitsus
119	54	ru	Мадонский край
120	54	en	Madona Municipality
121	55	lv	Ogres novads
122	55	lt	Ogrės savivaldybė
123	55	ee	Ogre omavalitsus
124	55	ru	Огрский край
125	55	en	Ogre Municipality
126	56	lv	Limbažu novads
127	56	lt	Limbažu savivaldybė
128	56	ee	Limbaži omavalitsus
129	56	ru	Лимбажский край
130	56	en	Limbaži Municipality
131	57	lv	Talsu novads
132	57	lt	Talsų savivaldybė
133	57	ee	Talsi omavalitsus
134	57	ru	Талсский край
135	57	en	Talsi Municipality
136	58	lv	Cēsu novads
137	58	lt	Cēsu savivaldybė
138	58	ee	Cēsis omavalitsus
139	58	ru	Цесисский край
140	58	en	Cēsis Municipality
141	59	lv	Valmieras novads
142	59	lt	Valmieros savivaldybė
143	59	ee	Valmiera omavalitsus
144	59	ru	Валмиерский край
145	59	en	Valmiera Municipality
146	60	lv	Saldus novads
147	60	lt	Saldus savivaldybė
148	60	ee	Saldus omavalitsus
149	60	ru	Салдусский край
150	60	en	Saldus Municipality
151	61	lv	Kuldīgas novads
152	61	lt	Kuldigos savivaldybė
153	61	ee	Kuldīga omavalitsus
154	61	ru	Кулдигский край
155	61	en	Kuldīga Municipality
156	62	lv	Tukuma novads
157	62	lt	Tukumo savivaldybė
158	62	ee	Tukums omavalitsus
159	62	ru	Тукумский край
160	62	en	Tukums Municipality
161	63	lv	Dienvidkurzemes novads
162	63	lt	Pietų Kuržemės savivaldybė
163	63	ee	Lõuna-Kuramaa omavalitsus
290	98	en	Augšdaugava Municipality
407	120	lv	Kazlu Rūdas pašvaldība
408	120	ee	Kazlų Rūda omavalitsus
287	98	lt	Augšdaugavos regionas
409	120	ru	Самоуправление Казлу-Руда
410	120	en	Kazlų Rūda Municipality
411	121	lt	Marijampolės savivaldybė
412	121	lv	Marijampoles pašvaldība
413	121	ee	Marijampolė omavalitsus
414	121	ru	Самоуправление Мариямполе
415	121	en	Marijampolė Municipality
416	122	lt	Šakių rajono savivaldybė
417	122	lv	Šaķu rajona pašvaldība
418	122	ee	Šakiai rajooni omavalitsus
419	122	ru	Самоуправление Шакяйского района
420	122	en	Šakiai District Municipality
421	123	lt	Vilkaviškio rajono savivaldybė
422	123	lv	Vilkavišķu rajona pašvaldība
164	63	ru	Южнокурземский край
165	63	en	South Kurzeme Municipality
166	64	lv	Salaspils novads
167	64	lt	Salaspilio savivaldybė
168	64	ee	Salaspils omavalitsus
169	64	ru	Саласпилсский край
170	64	en	Salaspils Municipality
171	65	lv	Ādažu novads
172	65	lt	Ādaži savivaldybė
173	65	ee	Ādaži omavalitsus
174	65	ru	Адажский край
175	65	en	Ādaži Municipality
176	66	lv	Aizkraukles novads
177	66	lt	Aizkraukle savivaldybė
178	66	ee	Aizkraukle omavalitsus
179	66	ru	Айзкраукльский край
180	66	en	Aizkraukle Municipality
181	67	lv	Alūksnes novads
182	67	lt	Alūksne savivaldybė
183	67	ee	Alūksne omavalitsus
184	67	ru	Алуксненский край
185	67	en	Alūksne Municipality
186	68	lv	Balvu novads
187	68	lt	Balvi savivaldybė
188	68	ee	Balvi omavalitsus
189	68	ru	Балвский край
190	68	en	Balvi Municipality
191	69	lv	Bauskas novads
192	69	lt	Bauska savivaldybė
193	69	ee	Bauska omavalitsus
194	69	ru	Бауский край
195	69	en	Bauska Municipality
196	70	lv	Dobeles novads
197	70	lt	Dobele savivaldybė
198	70	ee	Dobele omavalitsus
199	70	ru	Добельский край
200	70	en	Dobele Municipality
201	71	lv	Gulbenes novads
202	71	lt	Gulbene savivaldybė
203	71	ee	Gulbene omavalitsus
204	71	ru	Гулбенский край
205	71	en	Gulbene Municipality
206	72	lv	Jēkabpils novads
207	72	lt	Jēkabpils savivaldybė
208	72	ee	Jēkabpils omavalitsus
209	72	ru	Екабпилсский край
210	72	en	Jēkabpils Municipality
211	73	lv	Jelgavas novads
212	73	lt	Jelgava savivaldybė
213	73	ee	Jelgava omavalitsus
214	73	ru	Елгавский край
215	73	en	Jelgava Municipality
216	74	lv	Krāslavas novads
217	74	lt	Krāslava savivaldybė
218	74	ee	Krāslava omavalitsus
219	74	ru	Краславский край
220	74	en	Krāslava Municipality
221	75	lv	Līvānu novads
222	75	lt	Līvāni savivaldybė
223	75	ee	Līvāni omavalitsus
224	75	ru	Ливанский край
225	75	en	Līvāni Municipality
226	76	lv	Ludzas novads
227	76	lt	Ludza savivaldybė
228	76	ee	Ludza omavalitsus
229	76	ru	Лудзенский край
230	76	en	Ludza Municipality
231	77	lv	Mārupes novads
232	77	lt	Mārupe savivaldybė
233	77	ee	Mārupe omavalitsus
234	77	ru	Марупесский край
235	77	en	Mārupe Municipality
236	78	lv	Olaines novads
237	78	lt	Olaine savivaldybė
238	78	ee	Olaine omavalitsus
239	78	ru	Олайнский край
240	78	en	Olaine Municipality
241	79	lv	Preiļu novads
242	79	lt	Preiļi savivaldybė
243	79	ee	Preiļi omavalitsus
244	79	ru	Прейльский край
245	79	en	Preiļi Municipality
246	80	lv	Rēzeknes novads
247	80	lt	Rēzekne savivaldybė
248	80	ee	Rēzekne omavalitsus
249	80	ru	Резекненский край
250	80	en	Rēzekne Municipality
251	81	lv	Ropažu novads
252	81	lt	Ropaži savivaldybė
253	81	ee	Ropaži omavalitsus
254	81	ru	Ропажский край
255	81	en	Ropaži Municipality
256	82	lv	Saulkrastu novads
257	82	lt	Saulkrasti savivaldybė
258	82	ee	Saulkrasti omavalitsus
259	82	ru	Саулкрастский край
260	82	en	Saulkrasti Municipality
261	83	lv	Siguldas novads
262	83	lt	Sigulda savivaldybė
263	83	ee	Sigulda omavalitsus
264	83	ru	Сигулдский край
265	83	en	Sigulda Municipality
266	84	lv	Smiltenes novads
267	84	lt	Smiltene savivaldybė
268	84	ee	Smiltene omavalitsus
269	84	ru	Смилтенский край
270	84	en	Smiltene Municipality
271	85	lv	Valkas novads
272	85	lt	Valka savivaldybė
273	85	ee	Valka omavalitsus
274	85	ru	Валкский край
275	85	en	Valka Municipality
276	86	lv	Ventspils novads
277	86	lt	Ventspils savivaldybė
278	86	ee	Ventspils omavalitsus
279	86	ru	Вентспилсский край
280	86	en	Ventspils Municipality
281	87	lv	Ķekavas novads
282	87	lt	Ķekava savivaldybė
283	87	ee	Ķekava omavalitsus
284	87	ru	Кекавский край
285	87	en	Ķekava Municipality
286	98	lv	Augšdaugavas novads
288	98	ee	Augšdaugava omavalitsus
289	98	ru	Аугшдаугавский край
301	99	lt	Alytaus miesto savivaldybė
302	99	lv	Alītas pilsētas pašvaldība
303	99	ee	Alytuse linna omavalitsus
304	99	ru	Городское самоуправление г. Алитус
305	99	en	Alytus City Municipality
306	100	lt	Alytaus rajono savivaldybė
307	100	lv	Alītas rajona pašvaldība
308	100	ee	Alytuse rajooni omavalitsus
309	100	ru	Самоуправление Алитусского района
310	100	en	Alytus District Municipality
311	101	lt	Druskininkų savivaldybė
312	101	lv	Druskininku pilsētas pašvaldība
313	101	ee	Druskininkai linna omavalitsus
314	101	ru	Самоуправление г. Друскининкай
315	101	en	Druskininkai Municipality
316	102	lt	Lazdijų rajono savivaldybė
317	102	lv	Lazdiju rajona pašvaldība
318	102	ee	Lazdijai rajooni omavalitsus
319	102	ru	Самоуправление Лаздийского района
320	102	en	Lazdijai District Municipality
321	103	lt	Varėnos rajono savivaldybė
322	103	lv	Varēnas rajona pašvaldība
323	103	ee	Varėna rajooni omavalitsus
324	103	ru	Самоуправление Варėнского района
325	103	en	Varėna District Municipality
326	104	lt	Birštono savivaldybė
327	104	lv	Birštonas pašvaldība
328	104	ee	Birštonas linna omavalitsus
329	104	ru	Самоуправление г. Бирштонас
330	104	en	Birštonas Municipality
331	105	lt	Jonavos rajono savivaldybė
332	105	lv	Jonavas rajona pašvaldība
333	105	ee	Jonava rajooni omavalitsus
334	105	ru	Самоуправление Йонавского района
335	105	en	Jonava District Municipality
336	106	lt	Kaišiadorių rajono savivaldybė
337	106	lv	Kaišadorys rajona pašvaldība
338	106	ee	Kaišiadorys rajooni omavalitsus
339	106	ru	Самоуправление района Кайшядорис
340	106	en	Kaišiadorys District Municipality
341	107	lt	Kauno miesto savivaldybė
342	107	lv	Kauņas pilsētas pašvaldība
343	107	ee	Kaunase linna omavalitsus
344	107	ru	Городское самоуправление г. Каунас
345	107	en	Kaunas City Municipality
346	108	lt	Kauno rajono savivaldybė
347	108	lv	Kauņas rajona pašvaldība
348	108	ee	Kaunase rajooni omavalitsus
349	108	ru	Самоуправление Каунасского района
350	108	en	Kaunas District Municipality
351	109	lt	Kėdainių rajono savivaldybė
352	109	lv	Ķēdaiņu rajona pašvaldība
353	109	ee	Kėdainiai rajooni omavalitsus
354	109	ru	Самоуправление Кедайнского района
355	109	en	Kėdainiai District Municipality
356	110	lt	Prienų rajono savivaldybė
357	110	lv	Prienu rajona pašvaldība
358	110	ee	Prienai rajooni omavalitsus
359	110	ru	Самоуправление Пренайского района
360	110	en	Prienai District Municipality
361	111	lt	Raseinių rajono savivaldybė
362	111	lv	Raseiņu rajona pašvaldība
363	111	ee	Raseiniai rajooni omavalitsus
364	111	ru	Самоуправление Расейняйского района
365	111	en	Raseiniai District Municipality
366	112	lt	Klaipėdos miesto savivaldybė
367	112	lv	Klaipēdas pilsētas pašvaldība
368	112	ee	Klaipėda linna omavalitsus
369	112	ru	Городское самоуправление г. Клайпеда
370	112	en	Klaipėda City Municipality
371	113	lt	Klaipėdos rajono savivaldybė
372	113	lv	Klaipēdas rajona pašvaldība
373	113	ee	Klaipėda rajooni omavalitsus
374	113	ru	Самоуправление Клайпедского района
375	113	en	Klaipėda District Municipality
376	114	lt	Kretingos rajono savivaldybė
377	114	lv	Kretingas rajona pašvaldība
378	114	ee	Kretinga rajooni omavalitsus
379	114	ru	Самоуправление Кретингского района
380	114	en	Kretinga District Municipality
381	115	lt	Neringos savivaldybė
382	115	lv	Neringas pašvaldība
383	115	ee	Neringa omavalitsus
384	115	ru	Самоуправление Неринги
385	115	en	Neringa Municipality
386	116	lt	Palangos miesto savivaldybė
387	116	lv	Palangas pilsētas pašvaldība
388	116	ee	Palanga linna omavalitsus
389	116	ru	Городское самоуправление г. Паланга
390	116	en	Palanga City Municipality
391	117	lt	Šilutės rajono savivaldybė
392	117	lv	Šilutes rajona pašvaldība
393	117	ee	Šilutė rajooni omavalitsus
394	117	ru	Самоуправление Шилутского района
395	117	en	Šilutė District Municipality
396	118	lt	Skuodo rajono savivaldybė
397	118	lv	Skuodas rajona pašvaldība
398	118	ee	Skuodas rajooni omavalitsus
399	118	ru	Самоуправление Скуодасского района
400	118	en	Skuodas District Municipality
401	119	lt	Kalvarijos savivaldybė
402	119	lv	Kalvarijas pašvaldība
403	119	ee	Kalvarija omavalitsus
404	119	ru	Самоуправление Калварии
405	119	en	Kalvarija Municipality
406	120	lt	Kazlų Rūdos savivaldybė
423	123	ee	Vilkaviškis rajooni omavalitsus
424	123	ru	Самоуправление Вилкавишкского района
425	123	en	Vilkaviškis District Municipality
426	124	lt	Biržų rajono savivaldybė
427	124	lv	Biržu rajona pašvaldība
428	124	ee	Biržai rajooni omavalitsus
429	124	ru	Самоуправление Биржайского района
430	124	en	Biržai District Municipality
431	125	lt	Kupiškio rajono savivaldybė
432	125	lv	Kupišķu rajona pašvaldība
433	125	ee	Kupiškis rajooni omavalitsus
434	125	ru	Самоуправление Купишкского района
435	125	en	Kupiškis District Municipality
436	126	lt	Panevėžio miesto savivaldybė
437	126	lv	Panevēžas pilsētas pašvaldība
438	126	ee	Panevėžys linna omavalitsus
439	126	ru	Городское самоуправление г. Паневежис
440	126	en	Panevėžys City Municipality
441	127	lt	Panevėžio rajono savivaldybė
442	127	lv	Panevēžas rajona pašvaldība
443	127	ee	Panevėžys rajooni omavalitsus
444	127	ru	Самоуправление Паневежского района
445	127	en	Panevėžys District Municipality
446	128	lt	Pasvalio rajono savivaldybė
447	128	lv	Pasvales rajona pašvaldība
448	128	ee	Pasvalys rajooni omavalitsus
449	128	ru	Самоуправление Пасвальского района
450	128	en	Pasvalys District Municipality
451	129	lt	Rokiškio rajono savivaldybė
452	129	lv	Rokišķu rajona pašvaldība
453	129	ee	Rokiškis rajooni omavalitsus
454	129	ru	Самоуправление Рокишкского района
455	129	en	Rokiškis District Municipality
456	130	lt	Akmenės rajono savivaldybė
457	130	lv	Akmenes rajona pašvaldība
458	130	ee	Akmenė rajooni omavalitsus
459	130	ru	Самоуправление Акменесского района
460	130	en	Akmenė District Municipality
461	131	lt	Joniškio rajono savivaldybė
462	131	lv	Jonišķu rajona pašvaldība
463	131	ee	Joniškis rajooni omavalitsus
464	131	ru	Самоуправление Йонишкского района
465	131	en	Joniškis District Municipality
466	132	lt	Kelmės rajono savivaldybė
467	132	lv	Kelmes rajona pašvaldība
468	132	ee	Kelmė rajooni omavalitsus
469	132	ru	Самоуправление Кельмеского района
470	132	en	Kelmė District Municipality
471	133	lt	Pakruojo rajono savivaldybė
472	133	lv	Pakrojas rajona pašvaldība
473	133	ee	Pakruojis rajooni omavalitsus
474	133	ru	Самоуправление Пакруойского района
475	133	en	Pakruojis District Municipality
476	134	lt	Radviliškio rajono savivaldybė
477	134	lv	Radvilišķu rajona pašvaldība
478	134	ee	Radviliškis rajooni omavalitsus
479	134	ru	Самоуправление Радвилишского района
480	134	en	Radviliškis District Municipality
481	135	lt	Šiaulių miesto savivaldybė
482	135	lv	Šauļu pilsētas pašvaldība
483	135	ee	Šiauliai linna omavalitsus
484	135	ru	Городское самоуправление г. Шяуляй
485	135	en	Šiauliai City Municipality
486	136	lt	Šiaulių rajono savivaldybė
487	136	lv	Šauļu rajona pašvaldība
488	136	ee	Šiauliai rajooni omavalitsus
489	136	ru	Самоуправление Шяуляйского района
490	136	en	Šiauliai District Municipality
491	137	lt	Jurbarko rajono savivaldybė
492	137	lv	Jurbarkas rajona pašvaldība
493	137	ee	Jurbarkas rajooni omavalitsus
494	137	ru	Самоуправление Юрбаркского района
495	137	en	Jurbarkas District Municipality
496	138	lt	Pagėgių savivaldybė
497	138	lv	Pagēģu pašvaldība
498	138	ee	Pagėgiai omavalitsus
499	138	ru	Самоуправление Пагегяй
500	138	en	Pagėgiai Municipality
501	139	lt	Šilalės rajono savivaldybė
502	139	lv	Šilales rajona pašvaldība
503	139	ee	Šilalė rajooni omavalitsus
504	139	ru	Самоуправление Шилалеского района
505	139	en	Šilalė District Municipality
506	140	lt	Tauragės rajono savivaldybė
507	140	lv	Taurages rajona pašvaldība
508	140	ee	Tauragė rajooni omavalitsus
509	140	ru	Самоуправление Таурагского района
510	140	en	Tauragė District Municipality
511	141	lt	Mažeikių rajono savivaldybė
512	141	lv	Mažeiķu rajona pašvaldība
513	141	ee	Mažeikiai rajooni omavalitsus
514	141	ru	Самоуправление Мажейкяйского района
515	141	en	Mažeikiai District Municipality
516	142	lt	Plungės rajono savivaldybė
517	142	lv	Pluņģes rajona pašvaldība
518	142	ee	Plungė rajooni omavalitsus
519	142	ru	Самоуправление Плунгеского района
520	142	en	Plungė District Municipality
521	143	lt	Rietavo savivaldybė
522	143	lv	Rietavas pašvaldība
523	143	ee	Rietavas omavalitsus
524	143	ru	Самоуправление Риетаваса
525	143	en	Rietavas Municipality
526	144	lt	Telšių rajono savivaldybė
527	144	lv	Telšu rajona pašvaldība
528	144	ee	Telšiai rajooni omavalitsus
529	144	ru	Самоуправление Тельшяйского района
530	144	en	Telšiai District Municipality
531	145	lt	Anykščių rajono savivaldybė
532	145	lv	Anīkšču rajona pašvaldība
533	145	ee	Anykščiai rajooni omavalitsus
534	145	ru	Самоуправление Аникщяйского района
535	145	en	Anykščiai District Municipality
536	146	lt	Ignalinos rajono savivaldybė
537	146	lv	Ignalinas rajona pašvaldība
538	146	ee	Ignalina rajooni omavalitsus
539	146	ru	Самоуправление Игналинского района
540	146	en	Ignalina District Municipality
541	147	lt	Molėtų rajono savivaldybė
542	147	lv	Moletu rajona pašvaldība
543	147	ee	Molėtai rajooni omavalitsus
544	147	ru	Самоуправление Молетского района
545	147	en	Molėtai District Municipality
546	148	lt	Utenos rajono savivaldybė
547	148	lv	Utenas rajona pašvaldība
548	148	ee	Utena rajooni omavalitsus
549	148	ru	Самоуправление Утенского района
550	148	en	Utena District Municipality
551	149	lt	Visagino savivaldybė
552	149	lv	Visaginas pašvaldība
553	149	ee	Visaginas omavalitsus
554	149	ru	Самоуправление Висагинаса
555	149	en	Visaginas Municipality
556	150	lt	Zarasų rajono savivaldybė
557	150	lv	Zarasu rajona pašvaldība
558	150	ee	Zarasai rajooni omavalitsus
559	150	ru	Самоуправление Зарасайского района
560	150	en	Zarasai District Municipality
561	151	lt	Elektrėnų savivaldybė
562	151	lv	Elektrēnu pašvaldība
563	151	ee	Elektrėnai omavalitsus
564	151	ru	Самоуправление Электренай
565	151	en	Elektrėnai Municipality
566	152	lt	Šalčininkų rajono savivaldybė
567	152	lv	Šalčininku rajona pašvaldība
568	152	ee	Šalčininkai rajooni omavalitsus
569	152	ru	Самоуправление Шальчининкского района
570	152	en	Šalčininkai District Municipality
571	153	lt	Širvintų rajono savivaldybė
572	153	lv	Širvintu rajona pašvaldība
573	153	ee	Širvintos rajooni omavalitsus
574	153	ru	Самоуправление Ширвинтоского района
575	153	en	Širvintos District Municipality
576	154	lt	Švenčionių rajono savivaldybė
577	154	lv	Švenčonu rajona pašvaldība
578	154	ee	Švenčionys rajooni omavalitsus
579	154	ru	Самоуправление Швенчёнского района
580	154	en	Švenčionys District Municipality
581	155	lt	Trakų rajono savivaldybė
582	155	lv	Traku rajona pašvaldība
583	155	ee	Trakai rajooni omavalitsus
584	155	ru	Самоуправление Тракайского района
585	155	en	Trakai District Municipality
586	156	lt	Ukmergės rajono savivaldybė
587	156	lv	Ukmerģes rajona pašvaldība
588	156	ee	Ukmergė rajooni omavalitsus
589	156	ru	Самоуправление Укмергеского района
590	156	en	Ukmergė District Municipality
591	157	lt	Vilniaus miesto savivaldybė
592	157	lv	Viļņas pilsētas pašvaldība
593	157	ee	Vilniuse linna omavalitsus
594	157	ru	Городское самоуправление г. Вильнюс
595	157	en	Vilnius City Municipality
596	158	lt	Vilniaus rajono savivaldybė
597	158	lv	Viļņas rajona pašvaldība
598	158	ee	Vilniuse rajooni omavalitsus
599	158	ru	Самоуправление Вильнюсского района
600	158	en	Vilnius District Municipality
601	159	lt	Talino miesto savivaldybė
602	159	lv	Tallinas pilsētas pašvaldība
603	159	ee	Tallinna linn
604	159	ru	город Таллин
605	159	en	Tallinn City Municipality
606	160	lt	Tartu miesto savivaldybė
607	160	lv	Tartu pilsētas pašvaldība
608	160	ee	Tartu linn
609	160	ru	город Тарту
610	160	en	Tartu City Municipality
611	161	lt	Narvos miesto savivaldybė
612	161	lv	Narvas pilsētas pašvaldība
613	161	ee	Narva linn
614	161	ru	город Нарва
615	161	en	Narva City Municipality
616	162	lt	Pernu miesto savivaldybė
617	162	lv	Pērnavas pilsētas pašvaldība
618	162	ee	Pärnu linn
619	162	ru	город Пярну
620	162	en	Pärnu City Municipality
621	163	lt	Kohtlos Jervės miesto savivaldybė
622	163	lv	Kohtla-Jervēs pilsētas pašvaldība
623	163	ee	Kohtla-Järve linn
624	163	ru	город Кохтла-Ярве
625	163	en	Kohtla-Järve City Municipality
626	164	lt	Viljandi miesto savivaldybė
627	164	lv	Viljandi pilsētas pašvaldība
628	164	ee	Viljandi linn
629	164	ru	город Вильянди
630	164	en	Viljandi City Municipality
631	165	lt	Rakverės miesto savivaldybė
632	165	lv	Rakveres pilsētas pašvaldība
633	165	ee	Rakvere linn
634	165	ru	город Раквере
635	165	en	Rakvere City Municipality
636	166	lt	Sillamės miesto savivaldybė
637	166	lv	Sillamē pilsētas pašvaldība
638	166	ee	Sillamäe linn
639	166	ru	город Силламяэ
640	166	en	Sillamäe City Municipality
641	167	lt	Kuresarės miesto savivaldybė
642	167	lv	Kuresāres pilsētas pašvaldība
643	167	ee	Kuressaare linn
644	167	ru	город Курессааре
645	167	en	Kuressaare City Municipality
651	169	lv	Veru pilsētas pašvaldība
652	169	lt	Voru miesto savivaldybė
653	169	ee	Võru linn
654	169	ru	город Выру
655	169	en	Võru City Municipality
656	170	lv	Hāpsalu pilsētas pašvaldība
657	170	lt	Haapsalu miesto savivaldybė
658	170	ee	Haapsalu linn
659	170	ru	город Хаапсалу
660	170	en	Haapsalu City Municipality
666	172	lv	Paides pilsētas pašvaldība
667	172	lt	Paidės miesto savivaldybė
668	172	ee	Paide linn
669	172	ru	город Паиде
670	172	en	Paide City Municipality
671	173	lv	Keilas pilsētas pašvaldība
672	173	lt	Keilos miesto savivaldybė
673	173	ee	Keila linn
674	173	ru	город Кейла
675	173	en	Keila City Municipality
676	174	lv	Alutaguses pašvaldība
677	174	lt	Alutagusės savivaldybė
678	174	ee	Alutaguse vald
679	174	ru	волость Алутагусе
680	174	en	Alutaguse Municipality
681	175	lv	Anijas pašvaldība
682	175	lt	Anijos savivaldybė
683	175	ee	Anija vald
684	175	ru	волость Ания
685	175	en	Anija Municipality
686	176	lv	Antslas pašvaldība
687	176	lt	Antslos savivaldybė
688	176	ee	Antsla vald
689	176	ru	волость Антсла
690	176	en	Antsla Municipality
691	177	lv	Elvas pašvaldība
692	177	lt	Elvos savivaldybė
693	177	ee	Elva vald
694	177	ru	волость Элва
695	177	en	Elva Municipality
696	178	lv	Haljalas pašvaldība
697	178	lt	Haljalos savivaldybė
698	178	ee	Haljala vald
699	178	ru	волость Хальяла
700	178	en	Haljala Municipality
701	179	lv	Harku pašvaldība
702	179	lt	Harku savivaldybė
703	179	ee	Harku vald
704	179	ru	волость Харку
705	179	en	Harku Municipality
706	180	lv	Hījumā pašvaldība
707	180	lt	Hiiumaa savivaldybė
708	180	ee	Hiiumaa vald
709	180	ru	волость Хийумаа
710	180	en	Hiiumaa Municipality
711	181	lv	Häädemeestes pašvaldība
712	181	lt	Häädemeestės savivaldybė
713	181	ee	Häädemeeste vald
714	181	ru	волость Хяэдеместе
715	181	en	Häädemeeste Municipality
716	182	lv	Jõelähtmes pašvaldība
717	182	lt	Jõelähtmės savivaldybė
718	182	ee	Jõelähtme vald
719	182	ru	волость Йыэляхтме
720	182	en	Jõelähtme Municipality
721	183	lv	Jõgevas pašvaldība
722	183	lt	Jõgevos savivaldybė
723	183	ee	Jõgeva vald
724	183	ru	волость Йыгева
725	183	en	Jõgeva Municipality
726	184	lv	Koses pašvaldība
727	184	lt	Kosės savivaldybė
728	184	ee	Kose vald
729	184	ru	волость Косе
730	184	en	Kose Municipality
731	185	lv	Kuusalus pašvaldība
732	185	lt	Kuusalos savivaldybė
733	185	ee	Kuusalu vald
734	185	ru	волость Куусалу
735	185	en	Kuusalu Municipality
736	186	lv	Lääne-Harju pašvaldība
737	186	lt	Lääne-Harju savivaldybė
738	186	ee	Lääne-Harju vald
739	186	ru	волость Ляэне-Харью
740	186	en	Lääne-Harju Municipality
741	187	lv	Lääne-Nigulas pašvaldība
742	187	lt	Lääne-Nigulos savivaldybė
743	187	ee	Lääne-Nigula vald
744	187	ru	волость Ляэне-Нигула
745	187	en	Lääne-Nigula Municipality
746	188	lv	Läänerannas pašvaldība
747	188	lt	Läänerannos savivaldybė
748	188	ee	Lääneranna vald
749	188	ru	волость Ляэнеранна
750	188	en	Lääneranna Municipality
751	189	lv	Lüganuses pašvaldība
752	189	lt	Lüganusės savivaldybė
753	189	ee	Lüganuse vald
754	189	ru	волость Люганузе
755	189	en	Lüganuse Municipality
756	190	lv	Luunjas pašvaldība
757	190	lt	Luunjos savivaldybė
758	190	ee	Luunja vald
661	171	lv	Jõhvi pašvaldība
662	171	lt	Jõhvi savivaldybė
663	171	ee	Jõhvi vald
664	171	ru	волость Йыхви
759	190	ru	волость Луунья
760	190	en	Luunja Municipality
761	191	lv	Muhus pašvaldība
762	191	lt	Muhu savivaldybė
763	191	ee	Muhu vald
764	191	ru	волость Муху
765	191	en	Muhu Municipality
766	192	lv	Mulgi pašvaldība
767	192	lt	Mulgi savivaldybė
768	192	ee	Mulgi vald
769	192	ru	волость Мульги
770	192	en	Mulgi Municipality
771	193	lv	Mustvēs pašvaldība
772	193	lt	Mustvės savivaldybė
773	193	ee	Mustvee vald
774	193	ru	волость Муствеэ
775	193	en	Mustvee Municipality
776	194	lv	Märjamaas pašvaldība
777	194	lt	Märjamaos savivaldybė
778	194	ee	Märjamaa vald
779	194	ru	волость Мярьямаа
780	194	en	Märjamaa Municipality
781	195	lv	Nõos pašvaldība
782	195	lt	Nõo savivaldybė
783	195	ee	Nõo vald
784	195	ru	волость Ныо
785	195	en	Nõo Municipality
786	196	lv	Otepääs pašvaldība
787	196	lt	Otepės savivaldybė
788	196	ee	Otepää vald
789	196	ru	волость Отепя
790	196	en	Otepää Municipality
791	197	lv	Peipsiääres pašvaldība
792	197	lt	Peipsiäärės savivaldybė
793	197	ee	Peipsiääre vald
794	197	ru	волость Пейпсиаэре
795	197	en	Peipsiääre Municipality
796	198	lv	Põhja-Pērnumā pašvaldība
797	198	lt	Põhja-Pärnumaa savivaldybė
798	198	ee	Põhja-Pärnumaa vald
799	198	ru	волость Пыхья-Пярнумаа
800	198	en	Põhja-Pärnumaa Municipality
801	199	lv	Põhja-Sakalas pašvaldība
802	199	lt	Põhja-Sakalos savivaldybė
803	199	ee	Põhja-Sakala vald
804	199	ru	волость Пыхья-Сакала
805	199	en	Põhja-Sakala Municipality
806	200	lv	Põltsamaas pašvaldība
807	200	lt	Põltsamaos savivaldybė
808	200	ee	Põltsamaa vald
809	200	ru	волость Пылтсамаа
810	200	en	Põltsamaa Municipality
811	201	lv	Põlvas pašvaldība
812	201	lt	Põlvos savivaldybė
813	201	ee	Põlva vald
814	201	ru	волость Пылва
815	201	en	Põlva Municipality
816	202	lv	Raasikus pašvaldība
817	202	lt	Raasiku savivaldybė
818	202	ee	Raasiku vald
819	202	ru	волость Раасику
820	202	en	Raasiku Municipality
821	203	lv	Raes pašvaldība
822	203	lt	Rae savivaldybė
823	203	ee	Rae vald
824	203	ru	волость Рае
825	203	en	Rae Municipality
826	204	lv	Rakveres pašvaldība
827	204	lt	Rakverės savivaldybė
828	204	ee	Rakvere vald
829	204	ru	волость Раквере
830	204	en	Rakvere Municipality
831	205	lv	Raplā pašvaldība
832	205	lt	Raplos savivaldybė
833	205	ee	Rapla vald
834	205	ru	волость Рапла
835	205	en	Rapla Municipality
836	206	lv	Rõuges pašvaldība
837	206	lt	Rõugės savivaldybė
838	206	ee	Rõuge vald
839	206	ru	волость Рыуге
840	206	en	Rõuge Municipality
841	207	lv	Räpinā pašvaldība
842	207	lt	Räpinės savivaldybė
843	207	ee	Räpina vald
844	207	ru	волость Ряпина
845	207	en	Räpina Municipality
846	208	lv	Ruhnu pašvaldība
847	208	lt	Ruhnu savivaldybė
848	208	ee	Ruhnu vald
849	208	ru	волость Рухну
850	208	en	Ruhnu Municipality
851	209	lv	Sakus pašvaldība
852	209	lt	Saku savivaldybė
853	209	ee	Saku vald
854	209	ru	волость Саку
855	209	en	Saku Municipality
856	210	lv	Saardes pašvaldība
857	210	lt	Saardės savivaldybė
858	210	ee	Saarde vald
859	210	ru	волость Саарде
860	210	en	Saarde Municipality
861	211	lv	Sāremā pašvaldība
862	211	lt	Saremos savivaldybė
863	211	ee	Saaremaa vald
864	211	ru	волость Сааремаа
865	211	en	Saaremaa Municipality
866	212	lv	Saues pašvaldība
867	212	lt	Saues savivaldybė
868	212	ee	Saue vald
869	212	ru	волость Сауэ
870	212	en	Saue Municipality
871	213	lv	Setomā pašvaldība
872	213	lt	Setomaos savivaldybė
873	213	ee	Setomaa vald
874	213	ru	волость Сетомаа
875	213	en	Setomaa Municipality
876	214	lv	Tapa pašvaldība
877	214	lt	Tapos savivaldybė
878	214	ee	Tapa vald
879	214	ru	волость Тапа
880	214	en	Tapa Municipality
881	215	lv	Tartu pašvaldība
882	215	lt	Tartu savivaldybė
883	215	ee	Tartu vald
884	215	ru	волость Тарту
885	215	en	Tartu Municipality
886	216	lv	Toila pašvaldība
887	216	lt	Toilos savivaldybė
888	216	ee	Toila vald
889	216	ru	волость Тойла
890	216	en	Toila Municipality
891	217	lv	Tori pašvaldība
892	217	lt	Torio savivaldybė
893	217	ee	Tori vald
894	217	ru	волость Тори
895	217	en	Tori Municipality
896	218	lv	Tõrva pašvaldība
897	218	lt	Tervos savivaldybė
898	218	ee	Tõrva vald
899	218	ru	волость Тырва
900	218	en	Tõrva Municipality
906	221	lv	Viljandi pašvaldība
907	221	lt	Viliandžio savivaldybė
908	221	ee	Viljandi vald
909	221	ru	волость Вильянди
910	221	en	Viljandi Municipality
911	222	lv	Vinni pašvaldība
912	222	lt	Vinnio savivaldybė
913	222	ee	Vinni vald
914	222	ru	волость Винни
915	222	en	Vinni Municipality
916	223	lv	Viru-Nigula pašvaldība
917	223	lt	Viru-Nigulos savivaldybė
918	223	ee	Viru-Nigula vald
919	223	ru	волость Виру-Нигула
920	223	en	Viru-Nigula Municipality
647	168	lv	Valga pašvaldība
646	168	lt	Valgos savivaldybė
648	168	ee	Valga vald
649	168	ru	волость Валга
650	168	en	Valga Municipality
926	224	lv	Viimsi pašvaldība
927	225	lv	Väike-Maarjas pašvaldība
928	226	lv	Vormsi pašvaldība
929	227	lv	Võru pašvaldība
930	224	lt	Viimsi savivaldybė
931	225	lt	Väike-Maarjos savivaldybė
932	226	lt	Vormsi savivaldybė
933	227	lt	Võru savivaldybė
934	224	ee	Viimsi vald
935	225	ee	Väike-Maarja vald
936	226	ee	Vormsi vald
937	227	ee	Võru vald
938	224	ru	волость Виймси
939	225	ru	волость Вяйке-Маарья
940	226	ru	волость Вормси
941	227	ru	волость Выру
942	224	en	Viimsi Municipality
943	225	en	Väike-Maarja Municipality
944	226	en	Vormsi Municipality
945	227	en	Võru Municipality
946	229	lv	Järva pašvaldība
947	229	lt	Järva savivaldybė
948	229	ee	Järva vald
949	229	ru	волость Ярва
950	229	en	Järva Municipality
951	230	lv	Kadrinas pašvaldība
952	230	lt	Kadrina savivaldybė
953	230	ee	Kadrina vald
954	230	ru	волость Кадрина
955	230	en	Kadrina Municipality
956	231	lv	Kambjas pašvaldība
957	231	lt	Kambja savivaldybė
958	231	ee	Kambja vald
959	231	ru	волость Камбья
960	231	en	Kambja Municipality
961	232	lv	Kanepi pašvaldība
962	232	lt	Kanepi savivaldybė
963	232	ee	Kanepi vald
964	232	ru	волость Канепи
965	232	en	Kanepi Municipality
966	233	lv	Kastres pašvaldība
967	233	lt	Kastre savivaldybė
968	233	ee	Kastre vald
969	233	ru	волость Кастре
970	233	en	Kastre Municipality
971	234	lv	Kehtnas pašvaldība
972	234	lt	Kehtna savivaldybė
973	234	ee	Kehtna vald
974	234	ru	волость Кехтна
975	234	en	Kehtna Municipality
976	235	lv	Kihnu pašvaldība
977	235	lt	Kihnu savivaldybė
978	235	ee	Kihnu vald
979	235	ru	волость Кихну
980	235	en	Kihnu Municipality
981	236	lv	Kiili pašvaldība
982	236	lt	Kiili savivaldybė
983	236	ee	Kiili vald
984	236	ru	волость Кийли
985	236	en	Kiili Municipality
986	237	lv	Kohilas pašvaldība
987	237	lt	Kohila savivaldybė
988	237	ee	Kohila vald
989	237	ru	волость Кохила
990	237	en	Kohila Municipality
665	171	en	Jõhvi Municipality
996	238	lv	Mārdu pilsētas pašvaldība
997	239	lv	Narvas-Jēsū pilsētas pašvaldība
998	238	lt	Maardu miesto savivaldybė
999	239	lt	Narva-Jõesuu miesto savivaldybė
1000	238	ee	Maardu linn
1001	239	ee	Narva-Jõesuu linn
1002	238	ru	город Маарду
1003	239	ru	город Нарва-Йыэсуу
1004	238	en	Maardu City Municipality
1005	239	en	Narva-Jõesuu City Municipality
901	219	lv	Türi pašvaldība
902	219	lt	Türi savivaldybė
903	219	ee	Türi vald
904	219	ru	волость Тюри
905	219	en	Türi Municipality
\.


ALTER TABLE public.municipality_translations ENABLE TRIGGER ALL;

--
-- Data for Name: notifications; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.notifications DISABLE TRIGGER ALL;

COPY public.notifications (id, user_id, type, title, content, source_type, source_id, source_user_id, metadata, read_at, created_at, updated_at) FROM stdin;
bc8102ea-0f94-43ae-ad15-af4b933c031a	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	new_message	New message	Raimunds: fff	\N	ced5a8bb-26f7-45b0-b94b-611ebfe86580	413d6728-bb68-4ebd-bd39-5b484d37312b	{}	2025-12-14 16:07:10.021+00	2025-12-06 12:22:35.078451+00	2025-12-14 16:07:09.365727+00
0807f407-ca38-43a9-b621-53dfda4314d4	37bc011e-0f0e-49b8-8b3e-e0f03ec8fd86	chat_created	New chat started	Raimunds started a conversation with you	equipment_listing	8b85e009-c7f4-4636-b613-87fba176cf48	413d6728-bb68-4ebd-bd39-5b484d37312b	{}	\N	2025-12-17 20:05:48.057859+00	2025-12-17 20:05:48.057859+00
f865f474-d298-4cc2-aeed-64c939d6face	37bc011e-0f0e-49b8-8b3e-e0f03ec8fd86	listing_favorited	Someone liked your listing!	Your equipment listing "Kivere" was added to favorites	equipment_listing	8b85e009-c7f4-4636-b613-87fba176cf48	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	{"listing_type": "equipment", "listing_title": "Kivere"}	\N	2025-12-20 17:10:37.86967+00	2025-12-20 17:10:37.86967+00
e68d4340-7ded-4ab1-9e4c-6b3a37fded82	413d6728-bb68-4ebd-bd39-5b484d37312b	listing_favorited	Someone favorited your listing	Raimunds favorited your listing: Saddles	equipment_listing	fc1d0aa5-1e37-4dab-8719-b60af8596334	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	{}	2025-12-20 17:55:22.377+00	2025-12-19 14:31:23.768557+00	2025-12-20 17:55:22.235938+00
d6644ead-a14d-416e-b091-9f3850202e07	413d6728-bb68-4ebd-bd39-5b484d37312b	listing_favorited	Someone favorited your listing	Raimunds favorited your listing: Saddles	equipment_listing	fc1d0aa5-1e37-4dab-8719-b60af8596334	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	{}	2025-12-20 17:55:26.84+00	2025-12-19 14:26:26.933505+00	2025-12-20 17:55:26.700995+00
c9a254b7-3843-4b0c-b925-8f9b81970c41	413d6728-bb68-4ebd-bd39-5b484d37312b	listing_favorited	Someone favorited your listing	Raimunds favorited your listing: ssssssssssd	horse_listing	292371aa-800e-4b73-8dd1-0a54e473e478	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	{}	2025-12-20 17:58:30.175+00	2025-12-20 17:57:50.090139+00	2025-12-20 17:58:30.062223+00
afd4c130-4d1f-4a9f-8de1-5ce3e51446dd	413d6728-bb68-4ebd-bd39-5b484d37312b	listing_favorited	Someone favorited your listing	Raimunds favorited your listing: Saddles	equipment_listing	fc1d0aa5-1e37-4dab-8719-b60af8596334	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	{}	2025-12-20 17:58:30.175+00	2025-12-20 17:58:21.461401+00	2025-12-20 17:58:30.062223+00
37da8912-c25d-4a4a-99ae-dbf4f9cd0c6d	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	new_message	New message	Raimunds: f	\N	7fab5ead-d37a-4e45-966e-359d10da8e16	413d6728-bb68-4ebd-bd39-5b484d37312b	{}	2025-12-20 17:58:38.503+00	2025-12-17 17:06:33.047779+00	2025-12-20 17:58:38.391409+00
c2b7d470-a792-49a6-8283-8b38be8b29fe	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	new_message	New message	Raimunds: fffffffff	\N	7fab5ead-d37a-4e45-966e-359d10da8e16	413d6728-bb68-4ebd-bd39-5b484d37312b	{}	2025-12-20 17:58:38.503+00	2025-12-17 18:04:41.974755+00	2025-12-20 17:58:38.391409+00
fe5ccb2b-f4b2-4b12-ac60-f1dd90c0d2b4	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	new_message	New message	Raimunds: ffffffffffffffffffffff	\N	7fab5ead-d37a-4e45-966e-359d10da8e16	413d6728-bb68-4ebd-bd39-5b484d37312b	{}	2025-12-20 17:58:38.503+00	2025-12-17 18:04:46.373875+00	2025-12-20 17:58:38.391409+00
d9acdef2-5c7d-4b04-b6b4-4a6793201351	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	new_message	New message	Raimunds: ffffffffffffffffffff	\N	7fab5ead-d37a-4e45-966e-359d10da8e16	413d6728-bb68-4ebd-bd39-5b484d37312b	{}	2025-12-20 17:58:38.503+00	2025-12-17 18:04:48.959776+00	2025-12-20 17:58:38.391409+00
6349f84c-1f32-4c31-b70b-87cef84c42fd	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	forum_reply	New reply to your comment	Raimunds V replied to your comment	forum_reply	11acb60b-09b6-4ce4-bad4-1d7db3820ccf	413d6728-bb68-4ebd-bd39-5b484d37312b	{"replyId": "f418026b-a178-49e0-9c0b-e32ca0efe98d", "topicId": "11acb60b-09b6-4ce4-bad4-1d7db3820ccf"}	2025-12-20 18:29:12.417+00	2025-12-20 18:07:53.527703+00	2025-12-20 18:29:12.290187+00
efe0640f-390b-4649-a6c4-0d6d167f4067	413d6728-bb68-4ebd-bd39-5b484d37312b	forum_reply	New reply on your topic	Raimunds Vanags replied to "rggggg"	forum_topic	11acb60b-09b6-4ce4-bad4-1d7db3820ccf	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	{"topicId": "11acb60b-09b6-4ce4-bad4-1d7db3820ccf", "topicTitle": "rggggg"}	2025-12-20 20:52:08.781+00	2025-12-20 17:59:02.298704+00	2025-12-20 20:52:08.722915+00
a762b759-e952-4996-b516-267a16862109	413d6728-bb68-4ebd-bd39-5b484d37312b	forum_reply	New reply on your topic	Raimunds Vanags replied to "rggggg"	forum_topic	11acb60b-09b6-4ce4-bad4-1d7db3820ccf	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	{"topicId": "11acb60b-09b6-4ce4-bad4-1d7db3820ccf", "topicTitle": "rggggg"}	2025-12-21 18:15:26.052+00	2025-12-21 17:32:57.615322+00	2025-12-21 18:15:26.434871+00
3882cf5d-e48a-4411-af55-d14069934dea	37bc011e-0f0e-49b8-8b3e-e0f03ec8fd86	new_message	new_message	raimis: jdjd	\N	85526295-6c52-40f8-8764-d64c2c0e9db9	413d6728-bb68-4ebd-bd39-5b484d37312b	{}	\N	2025-12-23 17:48:38.906249+00	2025-12-23 17:48:38.906249+00
09413498-fc28-4599-9a42-d1e3da96a92c	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	new_message	New message	Raimunds: grub	\N	df009bd0-42c1-4e3d-95ca-d14d89e5e2de	413d6728-bb68-4ebd-bd39-5b484d37312b	{}	2025-12-23 18:28:20.951+00	2025-12-21 16:20:47.183747+00	2025-12-23 18:28:21.492516+00
966f3c5b-87a1-4d55-ad3f-0e637f571fb5	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	chat_created	chat_created	raimis	equipment_listing	ade3d46e-f9c2-420b-b4e9-edc1e07843f4	413d6728-bb68-4ebd-bd39-5b484d37312b	{}	2025-12-23 18:28:20.951+00	2025-12-21 17:30:42.708869+00	2025-12-23 18:28:21.492516+00
48362656-9785-4cf2-a625-586baefb020e	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	new_message	new_message	raimis: bbbbbbbbbb	\N	df009bd0-42c1-4e3d-95ca-d14d89e5e2de	413d6728-bb68-4ebd-bd39-5b484d37312b	{}	2025-12-23 18:28:20.951+00	2025-12-21 17:30:53.605131+00	2025-12-23 18:28:21.492516+00
664b50f1-e66b-4b7a-bc89-622c0f776214	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	new_message	new_message	raimis: sssssssssssssssssssss	\N	2c19ee1d-7e28-41f8-9e2c-3a10209509ea	413d6728-bb68-4ebd-bd39-5b484d37312b	{}	2025-12-23 18:28:20.951+00	2025-12-21 18:03:51.677873+00	2025-12-23 18:28:21.492516+00
0cf38c3a-5ff0-42ab-82c6-090796edc41e	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	new_message	new_message	raimis: ddd	\N	917f3f8b-180a-421e-804d-730613cba2c1	413d6728-bb68-4ebd-bd39-5b484d37312b	{}	2025-12-23 18:28:20.951+00	2025-12-21 18:09:05.537272+00	2025-12-23 18:28:21.492516+00
d384df87-25fb-4ac1-b9b4-2a4111f78380	413d6728-bb68-4ebd-bd39-5b484d37312b	listing_favorited	Someone liked your listing!	Your equipment listing "Saddles" was added to favorites	equipment_listing	fc1d0aa5-1e37-4dab-8719-b60af8596334	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	{"listing_type": "equipment", "listing_title": "Saddles"}	2025-12-20 17:18:09.857+00	2025-12-19 14:31:23.911086+00	2025-12-20 17:18:09.706075+00
ffda1c5a-4ed4-4c74-b9d3-ad0b96a35c11	413d6728-bb68-4ebd-bd39-5b484d37312b	listing_favorited	Someone liked your listing!	Your equipment listing "Saddles" was added to favorites	equipment_listing	fc1d0aa5-1e37-4dab-8719-b60af8596334	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	{"listing_type": "equipment", "listing_title": "Saddles"}	2025-12-20 17:55:26.84+00	2025-12-19 14:26:27.131572+00	2025-12-20 17:55:26.700995+00
63cb1e68-48bb-4767-ac84-6d0227189e9e	413d6728-bb68-4ebd-bd39-5b484d37312b	trainer_favorited	Someone favorited your trainer profile	Raimunds favorited your trainer profile	trainer	8b8822db-eb82-4399-b063-5bf576dd4688	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	{}	2025-12-20 17:57:27.736+00	2025-12-20 17:56:48.972925+00	2025-12-20 17:57:27.576949+00
a1fbd3ed-0e43-44cf-ad37-ee1d8f6dc72b	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	new_message	New message	Raimunds: fff	\N	7fab5ead-d37a-4e45-966e-359d10da8e16	413d6728-bb68-4ebd-bd39-5b484d37312b	{}	2025-12-20 17:58:38.503+00	2025-12-17 17:06:29.473247+00	2025-12-20 17:58:38.391409+00
1bd6d1ab-e0a3-41b7-896d-181a4ae095b8	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	new_message	New message	Raimunds: ff	\N	7fab5ead-d37a-4e45-966e-359d10da8e16	413d6728-bb68-4ebd-bd39-5b484d37312b	{}	2025-12-20 17:58:38.503+00	2025-12-17 17:06:34.651142+00	2025-12-20 17:58:38.391409+00
34d85dfa-fc67-40e3-bc21-235e94e2e86f	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	new_message	New message	Raimunds: ffffffffffffffffffffffffffffffffffffffff	\N	7fab5ead-d37a-4e45-966e-359d10da8e16	413d6728-bb68-4ebd-bd39-5b484d37312b	{}	2025-12-20 17:58:38.503+00	2025-12-17 18:04:44.824622+00	2025-12-20 17:58:38.391409+00
615572b6-154b-495d-b0b3-807e651a574e	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	new_message	New message	Raimunds: ffffffffffffffffffffff	\N	7fab5ead-d37a-4e45-966e-359d10da8e16	413d6728-bb68-4ebd-bd39-5b484d37312b	{}	2025-12-20 17:58:38.503+00	2025-12-17 18:04:47.80176+00	2025-12-20 17:58:38.391409+00
01d4920c-f2d3-4d59-898b-a4e71b348d99	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	new_message	New message	Raimunds: 	\N	7fab5ead-d37a-4e45-966e-359d10da8e16	413d6728-bb68-4ebd-bd39-5b484d37312b	{}	2025-12-20 17:58:38.503+00	2025-12-17 21:17:43.749232+00	2025-12-20 17:58:38.391409+00
741ba037-9013-4f34-869c-0c3e0cff7806	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	new_message	New message	Raimunds: ddddddddddd	\N	917f3f8b-180a-421e-804d-730613cba2c1	413d6728-bb68-4ebd-bd39-5b484d37312b	{}	2025-12-20 17:58:38.503+00	2025-12-01 21:44:35.619774+00	2025-12-20 17:58:38.391409+00
347f4170-6c92-4617-ab95-3c6442e2fb43	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	new_message	New message	Raimunds: ddddddddddddddddddddddddddd	\N	917f3f8b-180a-421e-804d-730613cba2c1	413d6728-bb68-4ebd-bd39-5b484d37312b	{}	2025-12-20 17:58:38.503+00	2025-12-01 21:44:58.636932+00	2025-12-20 17:58:38.391409+00
50cb2c5d-3b55-4cc4-bda9-a763b5994089	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	chat_created	New chat started	Raimunds started a conversation with you	equipment_listing	72799f8c-e7af-4263-a526-d4b8ef11a83a	413d6728-bb68-4ebd-bd39-5b484d37312b	{}	2025-12-20 17:58:38.503+00	2025-12-06 11:12:53.213952+00	2025-12-20 17:58:38.391409+00
46d5c436-8948-4df6-8340-c955c25b26dd	37bc011e-0f0e-49b8-8b3e-e0f03ec8fd86	new_announcement	new_announcement	raimis|ddddddddddddddddd	announcement	6407e701-ec0b-4262-bffc-09aa1b44eb17	413d6728-bb68-4ebd-bd39-5b484d37312b	{}	\N	2025-12-21 18:14:27.832495+00	2025-12-21 18:14:27.832495+00
f4829537-aac9-45ab-9ae1-f53342641d8f	5e2d54d4-10bb-440a-a5c4-7e489a721625	new_announcement	new_announcement	raimis|ddddddddddddddddd	announcement	6407e701-ec0b-4262-bffc-09aa1b44eb17	413d6728-bb68-4ebd-bd39-5b484d37312b	{}	\N	2025-12-21 18:14:27.832495+00	2025-12-21 18:14:27.832495+00
46998888-2438-429d-a679-1ffc36d0a765	4a396c17-b4f4-4f7c-b86c-997c10b44d61	new_announcement	new_announcement	raimis|ddddddddddddddddd	announcement	6407e701-ec0b-4262-bffc-09aa1b44eb17	413d6728-bb68-4ebd-bd39-5b484d37312b	{}	\N	2025-12-21 18:14:27.832495+00	2025-12-21 18:14:27.832495+00
a4b365d1-c76a-4d47-be65-7841ed211296	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	new_announcement	new_announcement	raimis|ddddddddddddddddd	announcement	6407e701-ec0b-4262-bffc-09aa1b44eb17	413d6728-bb68-4ebd-bd39-5b484d37312b	{}	2025-12-21 18:15:00.445+00	2025-12-21 18:14:27.832495+00	2025-12-21 18:15:00.554501+00
31aca68b-ad5a-48dd-abaa-c48b656cc4ef	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	new_message	new_message	raimis: xxxxxxxx	\N	06de900c-01ce-408b-95ca-498a4a60b0e3	413d6728-bb68-4ebd-bd39-5b484d37312b	{}	2025-12-23 17:52:46.797+00	2025-12-21 18:23:37.038459+00	2025-12-23 17:52:47.461838+00
ab5e37eb-08b9-47df-8908-7164cfb4be10	37bc011e-0f0e-49b8-8b3e-e0f03ec8fd86	new_message	new_message	raimis: dddgg	\N	85526295-6c52-40f8-8764-d64c2c0e9db9	413d6728-bb68-4ebd-bd39-5b484d37312b	{}	\N	2025-12-23 18:14:32.561892+00	2025-12-23 18:14:32.561892+00
430c5d29-3975-4b78-860e-e4649217450c	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	chat_created	chat_created	raimis	service	d3cc6623-8753-40a2-9231-2568d1ba12b5	413d6728-bb68-4ebd-bd39-5b484d37312b	{}	2025-12-23 18:28:20.951+00	2025-12-21 18:21:02.817523+00	2025-12-23 18:28:21.492516+00
dcc8df09-ab58-4908-92bd-445560d0f49e	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	new_message	new_message	raimis: kkkkkkkk	\N	06de900c-01ce-408b-95ca-498a4a60b0e3	413d6728-bb68-4ebd-bd39-5b484d37312b	{}	2025-12-23 18:28:20.951+00	2025-12-21 18:21:06.694893+00	2025-12-23 18:28:21.492516+00
989cad75-7471-454a-b19b-2c6ade035065	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	listing_favorited	Someone favorited your listing	Raimunds Vanags favorited your listing: fffffffffffffff	equipment_listing	ade3d46e-f9c2-420b-b4e9-edc1e07843f4	413d6728-bb68-4ebd-bd39-5b484d37312b	{}	2025-12-23 18:28:20.951+00	2025-12-20 18:07:29.404648+00	2025-12-23 18:28:21.492516+00
7f3549fa-9c87-4ea5-931b-215518119ea6	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	new_message	New message	Raimunds: gribu	\N	917f3f8b-180a-421e-804d-730613cba2c1	413d6728-bb68-4ebd-bd39-5b484d37312b	{}	2025-12-23 18:28:20.951+00	2025-12-21 16:20:36.098269+00	2025-12-23 18:28:21.492516+00
353ec29c-985c-41d1-9a46-ac63747084f5	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	new_message	New message	Raimunds: nu nav	\N	637088c4-03bb-4a26-b5b1-8ceb0f2bd925	413d6728-bb68-4ebd-bd39-5b484d37312b	{}	2025-12-23 18:28:20.951+00	2025-12-21 16:49:32.124125+00	2025-12-23 18:28:21.492516+00
159ed6b4-b9af-4da8-bf94-e7209242aa95	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	new_message	new_message	raimis: zxfghj	\N	2c19ee1d-7e28-41f8-9e2c-3a10209509ea	413d6728-bb68-4ebd-bd39-5b484d37312b	{}	2025-12-23 18:28:20.951+00	2025-12-21 17:30:46.853921+00	2025-12-23 18:28:21.492516+00
4237f6d5-7110-4444-8256-1394edf3e7ac	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	forum_reply	New reply to your comment	Raimunds V replied to your comment	forum_reply	11acb60b-09b6-4ce4-bad4-1d7db3820ccf	413d6728-bb68-4ebd-bd39-5b484d37312b	{"replyId": "cb6967bc-6de8-4856-9abc-4b1bdefb55cf", "topicId": "11acb60b-09b6-4ce4-bad4-1d7db3820ccf"}	2025-12-23 18:28:20.951+00	2025-12-21 17:35:04.251737+00	2025-12-23 18:28:21.492516+00
e6332d31-f75c-4233-a6f6-3681d36372d7	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	listing_favorited	Someone liked your listing!	Your horse listing "dfffffffffsf" was added to favorites	horse_listing	ab8afe30-3614-4f52-9eb7-afea3d1a40b2	413d6728-bb68-4ebd-bd39-5b484d37312b	{"listing_type": "horse", "listing_title": "dfffffffffsf"}	2025-10-02 14:47:15.07+00	2025-09-25 20:19:26.279209+00	2025-10-02 14:47:15.119297+00
a00283d8-f249-4000-850a-96bf560de0bc	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	listing_favorited	Someone liked your listing!	Your horse listing "dfffffffffsf" was added to favorites	horse_listing	ab8afe30-3614-4f52-9eb7-afea3d1a40b2	413d6728-bb68-4ebd-bd39-5b484d37312b	{"listing_type": "horse", "listing_title": "dfffffffffsf"}	2025-10-02 14:47:15.07+00	2025-09-25 20:14:47.790707+00	2025-10-02 14:47:15.119297+00
cf2e2873-8e1a-402c-9e5c-761e6bb710c4	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	listing_favorited	Someone liked your listing!	Your horse listing "dfffffffffsf" was added to favorites	horse_listing	ab8afe30-3614-4f52-9eb7-afea3d1a40b2	413d6728-bb68-4ebd-bd39-5b484d37312b	{"listing_type": "horse", "listing_title": "dfffffffffsf"}	2025-10-02 14:47:15.07+00	2025-09-25 20:14:45.108796+00	2025-10-02 14:47:15.119297+00
779cf82e-dc74-4f9b-9d07-3daac4504d21	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	listing_favorited	Someone liked your listing!	Your equipment listing "fggggggggggggggggggggggggggggggg" was added to favorites	equipment_listing	ff3c6a5a-4579-4609-a5a2-b03ab9a33526	413d6728-bb68-4ebd-bd39-5b484d37312b	{"listing_type": "equipment", "listing_title": "fggggggggggggggggggggggggggggggg"}	2025-10-02 14:47:15.07+00	2025-09-25 20:07:51.263116+00	2025-10-02 14:47:15.119297+00
a2304131-dd78-42ab-b182-b23d8042858c	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	listing_favorited	Someone liked your listing!	Your equipment listing "ssssssssssssssssssssssssssssssssssssssssssss" was added to favorites	equipment_listing	62600565-ba8d-4453-b827-fadd7f64b686	413d6728-bb68-4ebd-bd39-5b484d37312b	{"listing_type": "equipment", "listing_title": "ssssssssssssssssssssssssssssssssssssssssssss"}	2025-10-02 14:47:15.07+00	2025-09-25 20:07:43.52289+00	2025-10-02 14:47:15.119297+00
1005fe0b-b5d2-4a4e-9463-3e3891155546	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	listing_favorited	Someone liked your listing!	Your equipment listing "ssssssssssssssssssssssssssssssssssssssssssss" was added to favorites	equipment_listing	62600565-ba8d-4453-b827-fadd7f64b686	413d6728-bb68-4ebd-bd39-5b484d37312b	{"listing_type": "equipment", "listing_title": "ssssssssssssssssssssssssssssssssssssssssssss"}	2025-10-02 14:47:15.07+00	2025-09-25 20:05:43.271262+00	2025-10-02 14:47:15.119297+00
dab7a9fd-26fb-42fc-8cc4-873ff2bfd568	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	listing_favorited	Someone liked your listing!	Your equipment listing "fggggggggggggggggggggggggggggggg" was added to favorites	equipment_listing	ff3c6a5a-4579-4609-a5a2-b03ab9a33526	413d6728-bb68-4ebd-bd39-5b484d37312b	{"listing_type": "equipment", "listing_title": "fggggggggggggggggggggggggggggggg"}	2025-10-02 14:47:15.07+00	2025-09-25 20:05:31.475178+00	2025-10-02 14:47:15.119297+00
374096e1-9136-49f5-abb9-8c8cd4387023	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	listing_favorited	Someone liked your listing!	Your equipment listing "fggggggggggggggggggggggggggggggg" was added to favorites	equipment_listing	ff3c6a5a-4579-4609-a5a2-b03ab9a33526	413d6728-bb68-4ebd-bd39-5b484d37312b	{"listing_type": "equipment", "listing_title": "fggggggggggggggggggggggggggggggg"}	2025-10-02 14:47:15.07+00	2025-09-25 19:52:26.280882+00	2025-10-02 14:47:15.119297+00
36e2646e-07be-4acb-b54c-86731d6df494	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	listing_favorited	Someone liked your listing!	Your equipment listing "ssssssssssssssssssssssssssssssssssssssssssss" was added to favorites	equipment_listing	62600565-ba8d-4453-b827-fadd7f64b686	413d6728-bb68-4ebd-bd39-5b484d37312b	{"listing_type": "equipment", "listing_title": "ssssssssssssssssssssssssssssssssssssssssssss"}	2025-10-02 14:47:15.07+00	2025-09-25 19:51:28.116963+00	2025-10-02 14:47:15.119297+00
7d863cb7-43e6-4549-9ce6-0968d39e7aa1	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	listing_favorited	Someone liked your listing!	Your equipment listing "fggggggggggggggggggggggggggggggg" was added to favorites	equipment_listing	ff3c6a5a-4579-4609-a5a2-b03ab9a33526	413d6728-bb68-4ebd-bd39-5b484d37312b	{"listing_type": "equipment", "listing_title": "fggggggggggggggggggggggggggggggg"}	2025-10-02 14:47:15.07+00	2025-09-25 19:45:10.253181+00	2025-10-02 14:47:15.119297+00
111a58e8-92fc-42c5-bc14-22e7c612bb4f	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	listing_favorited	Someone liked your listing!	Your equipment listing "fggggggggggggggggggggggggggggggg" was added to favorites	equipment_listing	ff3c6a5a-4579-4609-a5a2-b03ab9a33526	413d6728-bb68-4ebd-bd39-5b484d37312b	{"listing_type": "equipment", "listing_title": "fggggggggggggggggggggggggggggggg"}	2025-10-02 14:47:15.07+00	2025-09-25 19:40:59.462206+00	2025-10-02 14:47:15.119297+00
0283b62c-3d84-4a6f-ad43-0f63319575dc	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	listing_favorited	Someone liked your listing!	Your equipment listing "fggggggggggggggggggggggggggggggg" was added to favorites	equipment_listing	ff3c6a5a-4579-4609-a5a2-b03ab9a33526	413d6728-bb68-4ebd-bd39-5b484d37312b	{"listing_type": "equipment", "listing_title": "fggggggggggggggggggggggggggggggg"}	2025-10-02 14:47:15.07+00	2025-09-25 19:40:56.144543+00	2025-10-02 14:47:15.119297+00
5ee1a62c-7e0c-494e-b4f5-881439a19cd6	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	listing_favorited	Someone liked your listing!	Your equipment listing "fggggggggggggggggggggggggggggggg" was added to favorites	equipment_listing	ff3c6a5a-4579-4609-a5a2-b03ab9a33526	413d6728-bb68-4ebd-bd39-5b484d37312b	{"listing_type": "equipment", "listing_title": "fggggggggggggggggggggggggggggggg"}	2025-10-02 14:47:15.07+00	2025-09-25 19:39:56.078736+00	2025-10-02 14:47:15.119297+00
aaafe3c3-a96f-455e-a53a-9b44e4c5bc80	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	listing_favorited	Someone liked your listing!	Your equipment listing "fggggggggggggggggggggggggggggggg" was added to favorites	equipment_listing	ff3c6a5a-4579-4609-a5a2-b03ab9a33526	413d6728-bb68-4ebd-bd39-5b484d37312b	{"listing_type": "equipment", "listing_title": "fggggggggggggggggggggggggggggggg"}	2025-10-02 14:47:15.07+00	2025-09-25 19:34:43.870381+00	2025-10-02 14:47:15.119297+00
6cc62cb6-b9ee-40b6-8172-5bdc9390f7b5	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	listing_favorited	Someone liked your listing!	Your equipment listing "ssssssssssssssssssssssssssssssssssssssssssss" was added to favorites	equipment_listing	62600565-ba8d-4453-b827-fadd7f64b686	413d6728-bb68-4ebd-bd39-5b484d37312b	{"listing_type": "equipment", "listing_title": "ssssssssssssssssssssssssssssssssssssssssssss"}	2025-10-02 14:47:15.07+00	2025-09-25 19:34:11.548623+00	2025-10-02 14:47:15.119297+00
93a57203-00e1-425e-824d-e94433026878	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	listing_favorited	Someone liked your listing!	Your equipment listing "fggggggggggggggggggggggggggggggg" was added to favorites	equipment_listing	ff3c6a5a-4579-4609-a5a2-b03ab9a33526	413d6728-bb68-4ebd-bd39-5b484d37312b	{"listing_type": "equipment", "listing_title": "fggggggggggggggggggggggggggggggg"}	2025-10-02 14:47:15.07+00	2025-09-25 19:34:05.908425+00	2025-10-02 14:47:15.119297+00
80d39c8c-2817-4915-ba99-389e713610bc	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	listing_favorited	Someone liked your listing!	Your equipment listing "fggggggggggggggggggggggggggggggg" was added to favorites	equipment_listing	ff3c6a5a-4579-4609-a5a2-b03ab9a33526	413d6728-bb68-4ebd-bd39-5b484d37312b	{"listing_type": "equipment", "listing_title": "fggggggggggggggggggggggggggggggg"}	2025-10-02 14:47:15.07+00	2025-09-25 19:33:46.353032+00	2025-10-02 14:47:15.119297+00
bd371459-8f3a-47d4-8691-48cf60e1810f	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	listing_favorited	Someone liked your listing!	Your equipment listing "zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz" was added to favorites	equipment_listing	b3d2e7da-6e9b-4dec-9f3f-a168fc3fe607	413d6728-bb68-4ebd-bd39-5b484d37312b	{"listing_type": "equipment", "listing_title": "zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz"}	2025-10-02 14:47:15.07+00	2025-09-25 12:15:54.027738+00	2025-10-02 14:47:15.119297+00
9e61320f-0ff8-4146-b2d8-966081ad0162	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	listing_favorited	Someone liked your listing!	Your equipment listing "ssssssssssssssssssssssssssssssssssssssssssss" was added to favorites	equipment_listing	62600565-ba8d-4453-b827-fadd7f64b686	413d6728-bb68-4ebd-bd39-5b484d37312b	{"listing_type": "equipment", "listing_title": "ssssssssssssssssssssssssssssssssssssssssssss"}	2025-10-02 14:47:15.07+00	2025-09-25 10:24:41.470203+00	2025-10-02 14:47:15.119297+00
8c6eacad-6235-4e68-877e-79acd22dc20f	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	listing_favorited	Someone liked your listing!	Your equipment listing "ssssssssssssssssssssssssssssssssssssssssssss" was added to favorites	equipment_listing	62600565-ba8d-4453-b827-fadd7f64b686	413d6728-bb68-4ebd-bd39-5b484d37312b	{"listing_type": "equipment", "listing_title": "ssssssssssssssssssssssssssssssssssssssssssss"}	2025-10-02 14:47:15.07+00	2025-09-25 10:22:01.766689+00	2025-10-02 14:47:15.119297+00
f3f4d8bd-1459-4471-9864-4008ac950aaf	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	listing_favorited	Someone liked your listing!	Your equipment listing "zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz" was added to favorites	equipment_listing	b3d2e7da-6e9b-4dec-9f3f-a168fc3fe607	413d6728-bb68-4ebd-bd39-5b484d37312b	{"listing_type": "equipment", "listing_title": "zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz"}	2025-10-02 14:47:15.07+00	2025-09-25 10:20:22.913246+00	2025-10-02 14:47:15.119297+00
0bfada0f-2696-411c-b7ee-38f014fa9664	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	listing_favorited	Someone liked your listing!	Your equipment listing "fggggggggggggggggggggggggggggggg" was added to favorites	equipment_listing	ff3c6a5a-4579-4609-a5a2-b03ab9a33526	413d6728-bb68-4ebd-bd39-5b484d37312b	{"listing_type": "equipment", "listing_title": "fggggggggggggggggggggggggggggggg"}	2025-10-02 14:47:15.07+00	2025-09-25 10:18:25.555583+00	2025-10-02 14:47:15.119297+00
5392e16a-9a51-41d4-beef-664e132e6f65	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	listing_favorited	Someone liked your listing!	Your equipment listing "fggggggggggggggggggggggggggggggg" was added to favorites	equipment_listing	ff3c6a5a-4579-4609-a5a2-b03ab9a33526	413d6728-bb68-4ebd-bd39-5b484d37312b	{"listing_type": "equipment", "listing_title": "fggggggggggggggggggggggggggggggg"}	2025-10-02 14:47:15.07+00	2025-09-25 10:03:56.592618+00	2025-10-02 14:47:15.119297+00
44f85ae9-8961-4265-8f9c-f2540002c88a	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	listing_favorited	Someone liked your listing!	Your equipment listing "fggggggggggggggggggggggggggggggg" was added to favorites	equipment_listing	ff3c6a5a-4579-4609-a5a2-b03ab9a33526	413d6728-bb68-4ebd-bd39-5b484d37312b	{"listing_type": "equipment", "listing_title": "fggggggggggggggggggggggggggggggg"}	2025-10-02 14:47:15.07+00	2025-09-25 10:03:53.586324+00	2025-10-02 14:47:15.119297+00
027b90cf-58e3-4344-beba-9e7737324c6d	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	listing_favorited	Someone liked your listing!	Your equipment listing "zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz" was added to favorites	equipment_listing	b3d2e7da-6e9b-4dec-9f3f-a168fc3fe607	413d6728-bb68-4ebd-bd39-5b484d37312b	{"listing_type": "equipment", "listing_title": "zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz"}	2025-10-02 14:47:15.07+00	2025-09-25 10:03:51.128543+00	2025-10-02 14:47:15.119297+00
526ad239-7d93-48a7-9304-216f40fb138b	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	listing_favorited	Someone liked your listing!	Your horse listing "dfffffffffsf" was added to favorites	horse_listing	ab8afe30-3614-4f52-9eb7-afea3d1a40b2	413d6728-bb68-4ebd-bd39-5b484d37312b	{"listing_type": "horse", "listing_title": "dfffffffffsf"}	2025-10-02 14:47:15.07+00	2025-09-24 17:57:57.97317+00	2025-10-02 14:47:15.119297+00
a60f2833-8806-4f2d-80ab-a2013f4e3b71	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	listing_favorited	Someone liked your listing!	Your horse listing "dfffffffffsf" was added to favorites	horse_listing	ab8afe30-3614-4f52-9eb7-afea3d1a40b2	413d6728-bb68-4ebd-bd39-5b484d37312b	{"listing_type": "horse", "listing_title": "dfffffffffsf"}	2025-10-02 14:47:15.07+00	2025-09-23 20:39:35.582458+00	2025-10-02 14:47:15.119297+00
6dd90be2-591f-450f-8327-35d6ea5aca04	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	listing_favorited	Someone liked your listing!	Your horse listing "dfffffffffsf" was added to favorites	horse_listing	ab8afe30-3614-4f52-9eb7-afea3d1a40b2	413d6728-bb68-4ebd-bd39-5b484d37312b	{"listing_type": "horse", "listing_title": "dfffffffffsf"}	2025-10-02 14:47:15.07+00	2025-09-23 20:39:33.796231+00	2025-10-02 14:47:15.119297+00
02867faf-001b-4955-8187-3d01aa1f06ad	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	listing_favorited	Someone liked your listing!	Your horse listing "dfffffffffsf" was added to favorites	horse_listing	ab8afe30-3614-4f52-9eb7-afea3d1a40b2	413d6728-bb68-4ebd-bd39-5b484d37312b	{"listing_type": "horse", "listing_title": "dfffffffffsf"}	2025-10-02 14:47:15.07+00	2025-09-23 20:28:46.402177+00	2025-10-02 14:47:15.119297+00
87450237-291f-439c-a7da-3cf2c14cea39	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	listing_favorited	Someone liked your listing!	Your horse listing "dfffffffffsf" was added to favorites	horse_listing	ab8afe30-3614-4f52-9eb7-afea3d1a40b2	413d6728-bb68-4ebd-bd39-5b484d37312b	{"listing_type": "horse", "listing_title": "dfffffffffsf"}	2025-10-02 14:47:15.07+00	2025-09-23 20:28:40.475494+00	2025-10-02 14:47:15.119297+00
dd8fa09a-2248-4fb1-b4a2-9f15be7b14d2	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	listing_favorited	Someone liked your listing!	Your equipment listing "fggggggggggggggggggggggggggggggg" was added to favorites	equipment_listing	ff3c6a5a-4579-4609-a5a2-b03ab9a33526	413d6728-bb68-4ebd-bd39-5b484d37312b	{"listing_type": "equipment", "listing_title": "fggggggggggggggggggggggggggggggg"}	2025-10-02 14:47:15.07+00	2025-09-23 19:41:48.869564+00	2025-10-02 14:47:15.119297+00
bda4e3c8-e597-4410-932d-b30960a47d2e	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	listing_favorited	Someone liked your listing!	Your equipment listing "fggggggggggggggggggggggggggggggg" was added to favorites	equipment_listing	ff3c6a5a-4579-4609-a5a2-b03ab9a33526	413d6728-bb68-4ebd-bd39-5b484d37312b	{"listing_type": "equipment", "listing_title": "fggggggggggggggggggggggggggggggg"}	2025-10-02 14:47:15.07+00	2025-09-23 19:03:07.334803+00	2025-10-02 14:47:15.119297+00
9925d94e-689a-49ee-a8ed-4f8d94da82d0	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	listing_favorited	Someone liked your listing!	Your equipment listing "ssssssssssssssssssssssssssssssssssssssssssss" was added to favorites	equipment_listing	62600565-ba8d-4453-b827-fadd7f64b686	413d6728-bb68-4ebd-bd39-5b484d37312b	{"listing_type": "equipment", "listing_title": "ssssssssssssssssssssssssssssssssssssssssssss"}	2025-10-02 14:47:15.07+00	2025-09-23 17:26:48.698754+00	2025-10-02 14:47:15.119297+00
7829d448-654f-4417-908f-7ba2dc90fcc5	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	listing_favorited	Someone liked your listing!	Your equipment listing "ssssssssssssssssssssssssssssssssssssssssssss" was added to favorites	equipment_listing	62600565-ba8d-4453-b827-fadd7f64b686	413d6728-bb68-4ebd-bd39-5b484d37312b	{"listing_type": "equipment", "listing_title": "ssssssssssssssssssssssssssssssssssssssssssss"}	2025-10-02 14:47:15.07+00	2025-09-23 17:25:55.432785+00	2025-10-02 14:47:15.119297+00
85c1ec21-f694-485c-b3b6-1bf4441c97d0	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	listing_favorited	Someone liked your listing!	Your equipment listing "ssssssssssssssssssssssssssssssssssssssssssss" was added to favorites	equipment_listing	62600565-ba8d-4453-b827-fadd7f64b686	413d6728-bb68-4ebd-bd39-5b484d37312b	{"listing_type": "equipment", "listing_title": "ssssssssssssssssssssssssssssssssssssssssssss"}	2025-10-02 14:47:15.07+00	2025-09-23 17:25:48.812557+00	2025-10-02 14:47:15.119297+00
45283460-a30a-450f-b102-4d9bbc8931ce	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	listing_favorited	Someone liked your listing!	Your equipment listing "ssssssssssssssssssssssssssssssssssssssssssss" was added to favorites	equipment_listing	62600565-ba8d-4453-b827-fadd7f64b686	413d6728-bb68-4ebd-bd39-5b484d37312b	{"listing_type": "equipment", "listing_title": "ssssssssssssssssssssssssssssssssssssssssssss"}	2025-10-02 14:47:15.07+00	2025-09-23 17:25:47.005147+00	2025-10-02 14:47:15.119297+00
d74757f2-a254-4018-aeec-6f1866c1fa9f	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	listing_favorited	Someone liked your listing!	Your horse listing "dfffffffffsf" was added to favorites	horse_listing	ab8afe30-3614-4f52-9eb7-afea3d1a40b2	413d6728-bb68-4ebd-bd39-5b484d37312b	{"listing_type": "horse", "listing_title": "dfffffffffsf"}	2025-10-02 14:47:15.07+00	2025-09-23 16:57:23.855121+00	2025-10-02 14:47:15.119297+00
0e5682db-1772-4e1d-8557-e1b7fec4c210	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	listing_favorited	Someone liked your listing!	Your equipment listing "fggggggggggggggggggggggggggggggg" was added to favorites	equipment_listing	ff3c6a5a-4579-4609-a5a2-b03ab9a33526	413d6728-bb68-4ebd-bd39-5b484d37312b	{"listing_type": "equipment", "listing_title": "fggggggggggggggggggggggggggggggg"}	2025-10-02 14:47:15.07+00	2025-09-23 16:33:19.785519+00	2025-10-02 14:47:15.119297+00
8c26b8cb-48bc-4f6d-81d7-bbf5809bd7a5	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	listing_favorited	Someone liked your listing!	Your horse listing "dfffffffffsf" was added to favorites	horse_listing	ab8afe30-3614-4f52-9eb7-afea3d1a40b2	413d6728-bb68-4ebd-bd39-5b484d37312b	{"listing_type": "horse", "listing_title": "dfffffffffsf"}	2025-10-02 14:47:15.07+00	2025-09-23 16:31:02.027624+00	2025-10-02 14:47:15.119297+00
a6b867e8-cf25-4f93-9200-11e8e9fc39c8	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	listing_favorited	Someone liked your listing!	Your horse listing "dfffffffffsf" was added to favorites	horse_listing	ab8afe30-3614-4f52-9eb7-afea3d1a40b2	413d6728-bb68-4ebd-bd39-5b484d37312b	{"listing_type": "horse", "listing_title": "dfffffffffsf"}	2025-10-02 14:47:15.07+00	2025-09-23 16:30:57.324197+00	2025-10-02 14:47:15.119297+00
bc6d1b3f-777e-45d5-87c6-3ed98c4926a9	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	listing_favorited	Someone liked your listing!	Your horse listing "dfffffffffsf" was added to favorites	horse_listing	ab8afe30-3614-4f52-9eb7-afea3d1a40b2	413d6728-bb68-4ebd-bd39-5b484d37312b	{"listing_type": "horse", "listing_title": "dfffffffffsf"}	2025-10-02 14:47:15.07+00	2025-09-23 16:29:23.121844+00	2025-10-02 14:47:15.119297+00
9206afbb-06b6-461f-b5aa-a4a6b2c098bc	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	listing_favorited	Someone liked your listing!	Your equipment listing "fggggggggggggggggggggggggggggggg" was added to favorites	equipment_listing	ff3c6a5a-4579-4609-a5a2-b03ab9a33526	413d6728-bb68-4ebd-bd39-5b484d37312b	{"listing_type": "equipment", "listing_title": "fggggggggggggggggggggggggggggggg"}	2025-10-02 14:47:15.07+00	2025-09-23 16:22:58.061635+00	2025-10-02 14:47:15.119297+00
305efcca-e343-4c76-a219-bf2a2654d38d	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	listing_favorited	Someone liked your listing!	Your equipment listing "fggggggggggggggggggggggggggggggg" was added to favorites	equipment_listing	ff3c6a5a-4579-4609-a5a2-b03ab9a33526	413d6728-bb68-4ebd-bd39-5b484d37312b	{"listing_type": "equipment", "listing_title": "fggggggggggggggggggggggggggggggg"}	2025-10-02 14:47:15.07+00	2025-09-23 16:22:22.354342+00	2025-10-02 14:47:15.119297+00
68465f8a-4878-4a25-9f26-96e55e219dd5	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	listing_favorited	Someone liked your listing!	Your equipment listing "fggggggggggggggggggggggggggggggg" was added to favorites	equipment_listing	ff3c6a5a-4579-4609-a5a2-b03ab9a33526	413d6728-bb68-4ebd-bd39-5b484d37312b	{"listing_type": "equipment", "listing_title": "fggggggggggggggggggggggggggggggg"}	2025-10-02 14:47:15.07+00	2025-09-23 16:22:19.337496+00	2025-10-02 14:47:15.119297+00
13c36fb7-34e2-44ce-b4e1-e509a681cc37	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	listing_favorited	Someone liked your listing!	Your equipment listing "fggggggggggggggggggggggggggggggg" was added to favorites	equipment_listing	ff3c6a5a-4579-4609-a5a2-b03ab9a33526	413d6728-bb68-4ebd-bd39-5b484d37312b	{"listing_type": "equipment", "listing_title": "fggggggggggggggggggggggggggggggg"}	2025-10-02 14:47:15.07+00	2025-09-23 16:17:52.653083+00	2025-10-02 14:47:15.119297+00
372cc2d2-5991-46fe-a763-1e3a0d6e7e67	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	listing_favorited	Someone liked your listing!	Your equipment listing "fggggggggggggggggggggggggggggggg" was added to favorites	equipment_listing	ff3c6a5a-4579-4609-a5a2-b03ab9a33526	413d6728-bb68-4ebd-bd39-5b484d37312b	{"listing_type": "equipment", "listing_title": "fggggggggggggggggggggggggggggggg"}	2025-10-02 14:47:15.07+00	2025-09-23 16:16:17.443947+00	2025-10-02 14:47:15.119297+00
770ee611-442f-4323-aff3-f98a5d3148d4	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	listing_favorited	Someone liked your listing!	Your horse listing "dfffffffffsf" was added to favorites	horse_listing	ab8afe30-3614-4f52-9eb7-afea3d1a40b2	413d6728-bb68-4ebd-bd39-5b484d37312b	{"listing_type": "horse", "listing_title": "dfffffffffsf"}	2025-10-02 14:47:15.07+00	2025-09-23 16:00:58.683678+00	2025-10-02 14:47:15.119297+00
e45b7dfa-a820-4963-8b92-8bf3c631136f	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	listing_favorited	Someone liked your listing!	Your equipment listing "fggggggggggggggggggggggggggggggg" was added to favorites	equipment_listing	ff3c6a5a-4579-4609-a5a2-b03ab9a33526	413d6728-bb68-4ebd-bd39-5b484d37312b	{"listing_type": "equipment", "listing_title": "fggggggggggggggggggggggggggggggg"}	2025-10-02 14:47:15.07+00	2025-09-23 14:57:29.117327+00	2025-10-02 14:47:15.119297+00
ad2302d5-4857-4897-9741-44b7bdd766ad	37bc011e-0f0e-49b8-8b3e-e0f03ec8fd86	listing_favorited	Someone liked your listing!	Your equipment listing "Kivere" was added to favorites	equipment_listing	8b85e009-c7f4-4636-b613-87fba176cf48	413d6728-bb68-4ebd-bd39-5b484d37312b	{"listing_type": "equipment", "listing_title": "Kivere"}	\N	2025-11-10 22:55:00.145965+00	2025-11-10 22:55:00.145965+00
57812591-1ad9-4486-8258-9c2270ca5953	413d6728-bb68-4ebd-bd39-5b484d37312b	new_message	New message	Raimunds Vanags: nopirka	\N	48ab27cd-affd-4105-8628-a6354c76a3e2	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	{}	2025-12-06 11:15:59.243+00	2025-12-06 11:13:28.578577+00	2025-12-06 11:15:58.927129+00
7489d7eb-1729-4954-b3d2-f53c0f9e962a	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	listing_favorited	Someone liked your listing!	Your equipment listing "dddddddddddddd" was added to favorites	equipment_listing	d7d545a5-978f-4573-b2bb-543a3be160a4	413d6728-bb68-4ebd-bd39-5b484d37312b	{"listing_type": "equipment", "listing_title": "dddddddddddddd"}	2025-11-12 17:28:44.004+00	2025-11-10 22:55:01.261093+00	2025-11-12 17:28:44.135153+00
37d04be9-a10a-4dc7-bbb8-a10ab20f4ca1	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	new_message	New message	Raimunds: hmmm	\N	48ab27cd-affd-4105-8628-a6354c76a3e2	413d6728-bb68-4ebd-bd39-5b484d37312b	{}	2025-12-06 11:38:41.878+00	2025-12-06 11:12:57.129378+00	2025-12-06 11:38:41.55778+00
d5378d5a-b369-4550-9ad0-38bd4d2787f9	413d6728-bb68-4ebd-bd39-5b484d37312b	new_message	New message	Raimunds Vanags: h	\N	df009bd0-42c1-4e3d-95ca-d14d89e5e2de	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	{}	2025-12-14 16:06:39.166+00	2025-12-06 11:07:54.387376+00	2025-12-14 16:06:38.520942+00
add738a6-58db-4479-a880-5b39217e527b	413d6728-bb68-4ebd-bd39-5b484d37312b	new_message	New message	Raimunds Vanags: nope	\N	df009bd0-42c1-4e3d-95ca-d14d89e5e2de	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	{}	2025-12-14 16:06:47.925+00	2025-12-06 10:49:30.970588+00	2025-12-14 16:06:47.282991+00
e1567f8a-ba4d-406c-aa07-acbd590c85bd	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	new_message	New message	Raimunds: test	\N	c5d472c0-6fed-4acb-a280-9551c4928678	413d6728-bb68-4ebd-bd39-5b484d37312b	{}	2025-11-25 17:31:01.906+00	2025-11-25 17:24:44.11253+00	2025-11-25 17:31:02.062987+00
18dd7830-c48e-4a7f-8bd7-6b3aab1a91db	413d6728-bb68-4ebd-bd39-5b484d37312b	chat_created	New chat started	Raimunds Vanags started a conversation with you	service	968b60d1-6aac-44a1-ad9b-7b5892a3ad65	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	{}	2025-11-27 17:05:45.769+00	2025-11-26 21:28:35.376453+00	2025-11-27 17:05:45.36013+00
206ebf92-c357-4819-a098-4eed7a643a21	413d6728-bb68-4ebd-bd39-5b484d37312b	new_message	New message	Raimunds Vanags: test	\N	c5d472c0-6fed-4acb-a280-9551c4928678	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	{}	2025-11-27 17:05:56.896+00	2025-11-25 17:26:41.517608+00	2025-11-27 17:05:56.493541+00
7e63a8c6-654e-4964-bd93-c791d44b9dd7	413d6728-bb68-4ebd-bd39-5b484d37312b	new_message	New message	Raimunds Vanags: tet	\N	c5d472c0-6fed-4acb-a280-9551c4928678	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	{}	2025-11-27 17:20:18.262+00	2025-11-25 17:26:37.593491+00	2025-11-27 17:20:17.857711+00
c0d0ae31-29fe-4735-9fe5-93d847bba098	413d6728-bb68-4ebd-bd39-5b484d37312b	new_message	New message	Raimunds Vanags: ko	\N	c5d472c0-6fed-4acb-a280-9551c4928678	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	{}	2025-11-27 17:20:23.398+00	2025-11-25 17:26:25.954716+00	2025-11-27 17:20:22.99876+00
e72b8d8c-69f9-4683-9157-556b24050ee2	413d6728-bb68-4ebd-bd39-5b484d37312b	new_message	New message	Raimunds Vanags: kas i	\N	c5d472c0-6fed-4acb-a280-9551c4928678	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	{}	2025-11-27 17:54:07.933+00	2025-11-25 17:26:07.048973+00	2025-11-27 17:54:07.554181+00
9d8d79fc-ac69-44f0-9753-ee8c943e8cfd	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	chat_created	New chat started	Raimunds started a conversation with you	horse_listing	a68c747e-45a3-4d9b-b1ef-61394570a871	413d6728-bb68-4ebd-bd39-5b484d37312b	{}	2025-12-05 19:49:17.29+00	2025-12-04 18:49:13.886412+00	2025-12-05 19:49:16.968647+00
badbde73-1e62-430b-a1b4-12c2a2564a3a	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	new_message	New message	Raimunds: tttt	\N	917f3f8b-180a-421e-804d-730613cba2c1	413d6728-bb68-4ebd-bd39-5b484d37312b	{}	2025-12-18 22:05:45.487+00	2025-12-18 21:47:51.671043+00	2025-12-18 22:05:45.403692+00
c20b3a95-479f-46f3-abdd-9f8eeb5237a3	413d6728-bb68-4ebd-bd39-5b484d37312b	forum_reply	New reply on your topic	Raimunds Vanags replied to "sssss"	forum_topic	287d20a7-5eb3-4746-bece-3db28ef7e82d	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	{"topicId": "287d20a7-5eb3-4746-bece-3db28ef7e82d", "topicTitle": "sssss"}	2025-12-06 10:41:13.949+00	2025-12-05 20:05:56.689208+00	2025-12-06 10:41:13.611473+00
3694307c-d88a-484b-a95e-3130e9581c84	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	new_message	New message	Raimunds: pieejams?	\N	df009bd0-42c1-4e3d-95ca-d14d89e5e2de	413d6728-bb68-4ebd-bd39-5b484d37312b	{}	2025-12-06 10:49:35.591+00	2025-12-06 10:42:56.976269+00	2025-12-06 10:49:35.246324+00
5addb574-7125-46fa-a841-01bbbb85b463	37bc011e-0f0e-49b8-8b3e-e0f03ec8fd86	listing_favorited	Someone favorited your listing	Anna Marta Freimane favorited your listing: Kivere	equipment_listing	8b85e009-c7f4-4636-b613-87fba176cf48	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	{}	\N	2025-12-20 17:10:37.68696+00	2025-12-20 17:10:37.68696+00
1f2a41e2-f0c8-4a05-8dfb-c5e1cfecfe0d	413d6728-bb68-4ebd-bd39-5b484d37312b	forum_reply	New reply on your topic	Raimunds Vanags replied to "rggggg"	forum_topic	11acb60b-09b6-4ce4-bad4-1d7db3820ccf	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	{"topicId": "11acb60b-09b6-4ce4-bad4-1d7db3820ccf", "topicTitle": "rggggg"}	2025-12-20 17:55:26.84+00	2025-12-19 14:27:38.769979+00	2025-12-20 17:55:26.700995+00
16b83686-7e27-4154-9218-358e14f30583	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	new_message	New message	Raimunds: ggf	\N	df009bd0-42c1-4e3d-95ca-d14d89e5e2de	413d6728-bb68-4ebd-bd39-5b484d37312b	{}	2025-12-06 11:13:15.987+00	2025-12-06 10:50:39.326067+00	2025-12-06 11:13:15.651284+00
54f961c3-8d3f-4dcb-aec5-307465c6cab9	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	new_message	New message	Raimunds: toma toma?	\N	48ab27cd-affd-4105-8628-a6354c76a3e2	413d6728-bb68-4ebd-bd39-5b484d37312b	{}	2025-12-06 11:13:21.187+00	2025-12-06 11:13:04.056965+00	2025-12-06 11:13:20.844351+00
9a835987-21e1-42aa-82f4-d5ecd1e67b19	413d6728-bb68-4ebd-bd39-5b484d37312b	trainer_favorited	Someone favorited your trainer profile	Raimunds favorited your trainer profile	trainer	8b8822db-eb82-4399-b063-5bf576dd4688	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	{}	2025-12-20 17:57:27.736+00	2025-12-20 17:57:17.705876+00	2025-12-20 17:57:27.576949+00
505fe207-ee3a-4ee7-ae97-2cae145c0c28	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	new_message	New message	Raimunds: ff	\N	7fab5ead-d37a-4e45-966e-359d10da8e16	413d6728-bb68-4ebd-bd39-5b484d37312b	{}	2025-12-20 17:58:38.503+00	2025-12-17 17:06:30.682034+00	2025-12-20 17:58:38.391409+00
fc9c113a-848e-487b-a714-1abfebcce507	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	new_message	New message	Raimunds: FF	\N	7fab5ead-d37a-4e45-966e-359d10da8e16	413d6728-bb68-4ebd-bd39-5b484d37312b	{}	2025-12-20 17:58:38.503+00	2025-12-17 17:48:21.806305+00	2025-12-20 17:58:38.391409+00
df936715-0691-4395-a571-040f6f56ac53	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	new_message	New message	Raimunds: fffffffffffffffffffff	\N	7fab5ead-d37a-4e45-966e-359d10da8e16	413d6728-bb68-4ebd-bd39-5b484d37312b	{}	2025-12-20 17:58:38.503+00	2025-12-17 18:04:50.162286+00	2025-12-20 17:58:38.391409+00
d833403f-5966-420a-92c3-4083160ad16d	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	new_message	New message	Raimunds: ff	\N	7fab5ead-d37a-4e45-966e-359d10da8e16	413d6728-bb68-4ebd-bd39-5b484d37312b	{}	2025-12-20 17:58:38.503+00	2025-12-17 17:06:31.763316+00	2025-12-20 17:58:38.391409+00
b2fd30c4-4bec-41b1-b59c-2f323d455c3f	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	new_message	New message	Raimunds: FFF	\N	7fab5ead-d37a-4e45-966e-359d10da8e16	413d6728-bb68-4ebd-bd39-5b484d37312b	{}	2025-12-20 17:58:38.503+00	2025-12-17 17:48:25.317271+00	2025-12-20 17:58:38.391409+00
6752393e-dc81-4ff5-b16c-f0b4a1f3332c	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	forum_reply	New reply to your comment	Raimunds V replied to your comment	forum_reply	287d20a7-5eb3-4746-bece-3db28ef7e82d	413d6728-bb68-4ebd-bd39-5b484d37312b	{"replyId": "396c3b13-120f-44f0-9f6d-f4a0cde9a9dd", "topicId": "287d20a7-5eb3-4746-bece-3db28ef7e82d"}	2025-12-20 17:58:38.503+00	2025-12-17 18:43:05.857811+00	2025-12-20 17:58:38.391409+00
6fde70f3-194e-43ef-9f82-36b5bdcee1d1	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	new_message	New message	Raimunds: ddd	\N	917f3f8b-180a-421e-804d-730613cba2c1	413d6728-bb68-4ebd-bd39-5b484d37312b	{}	2025-12-20 17:58:38.503+00	2025-11-27 17:26:05.159544+00	2025-12-20 17:58:38.391409+00
681d6079-dcec-4787-84b4-d02039fd427e	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	new_message	New message	Raimunds: dddfd	\N	917f3f8b-180a-421e-804d-730613cba2c1	413d6728-bb68-4ebd-bd39-5b484d37312b	{}	2025-12-20 17:58:38.503+00	2025-12-01 21:27:31.002311+00	2025-12-20 17:58:38.391409+00
0d02181f-1559-44c2-9fdc-0072785580d3	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	new_message	new_message	raimis: d	\N	2c19ee1d-7e28-41f8-9e2c-3a10209509ea	413d6728-bb68-4ebd-bd39-5b484d37312b	{}	2025-12-23 18:28:20.951+00	2025-12-21 18:09:01.34729+00	2025-12-23 18:28:21.492516+00
1dc32003-a8a7-4376-9411-d23d5642c8f8	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	listing_favorited	listing_favorited	raimis	equipment_listing	ade3d46e-f9c2-420b-b4e9-edc1e07843f4	413d6728-bb68-4ebd-bd39-5b484d37312b	{}	2025-12-23 18:28:51.686+00	2025-12-23 18:28:43.677536+00	2025-12-23 18:28:52.218186+00
6c4bce44-564e-4540-9a34-db801db65677	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	new_message	new_message	raimis: bbbbbbbb	\N	2c19ee1d-7e28-41f8-9e2c-3a10209509ea	413d6728-bb68-4ebd-bd39-5b484d37312b	{}	\N	2025-12-23 18:53:42.814085+00	2025-12-23 18:53:42.814085+00
d03af4e0-99f2-4c4a-80af-62b13093730b	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	new_message	new_message	raimis: ggg	\N	637088c4-03bb-4a26-b5b1-8ceb0f2bd925	413d6728-bb68-4ebd-bd39-5b484d37312b	{}	\N	2025-12-23 20:39:01.313032+00	2025-12-23 20:39:01.313032+00
e261fc7c-722c-4f62-a407-2726804c6785	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	new_message	new_message	raimis: ddd	\N	2c19ee1d-7e28-41f8-9e2c-3a10209509ea	413d6728-bb68-4ebd-bd39-5b484d37312b	{}	\N	2025-12-23 20:59:42.706062+00	2025-12-23 20:59:42.706062+00
f26856ad-7c24-4c6c-b506-3c372edc9267	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	new_message	new_message	raimis: dd	\N	df009bd0-42c1-4e3d-95ca-d14d89e5e2de	413d6728-bb68-4ebd-bd39-5b484d37312b	{}	\N	2025-12-23 21:01:43.545603+00	2025-12-23 21:01:43.545603+00
e61c2a31-4581-4fb8-9d3e-8980eab99422	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	new_message	new_message	raimis: dd	\N	df009bd0-42c1-4e3d-95ca-d14d89e5e2de	413d6728-bb68-4ebd-bd39-5b484d37312b	{}	\N	2025-12-23 21:01:46.594318+00	2025-12-23 21:01:46.594318+00
06932341-25c4-4aac-ba90-307d34bb6297	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	new_message	new_message	raimis: dddddddd	\N	2c19ee1d-7e28-41f8-9e2c-3a10209509ea	413d6728-bb68-4ebd-bd39-5b484d37312b	{}	\N	2025-12-23 21:06:24.085056+00	2025-12-23 21:06:24.085056+00
ad34ddd5-f405-45d4-b9d6-fe37c123a85f	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	new_message	new_message	raimis: dddddd	\N	df009bd0-42c1-4e3d-95ca-d14d89e5e2de	413d6728-bb68-4ebd-bd39-5b484d37312b	{}	\N	2025-12-23 21:08:41.518326+00	2025-12-23 21:08:41.518326+00
ba1269e7-1930-47d0-97e5-aca1f7b0e3f0	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	listing_favorited	listing_favorited	raimis	equipment_listing	ade3d46e-f9c2-420b-b4e9-edc1e07843f4	413d6728-bb68-4ebd-bd39-5b484d37312b	{}	\N	2026-01-03 15:47:17.657025+00	2026-01-03 15:47:17.657025+00
4f6611cd-a60a-440d-917c-709c9bef2f6c	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	listing_favorited	listing_favorited	raimis	equipment_listing	ade3d46e-f9c2-420b-b4e9-edc1e07843f4	413d6728-bb68-4ebd-bd39-5b484d37312b	{}	\N	2026-01-03 17:40:29.578764+00	2026-01-03 17:40:29.578764+00
4cf53d49-1b9c-4df8-b969-96f6692b2d37	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	listing_favorited	listing_favorited	raimis	equipment_listing	d7d545a5-978f-4573-b2bb-543a3be160a4	413d6728-bb68-4ebd-bd39-5b484d37312b	{}	\N	2026-01-03 17:40:31.314968+00	2026-01-03 17:40:31.314968+00
13ccde3c-aed4-44a2-8966-f8fbd031588f	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	listing_favorited	listing_favorited	raimis	horse_listing	ce671880-e3f9-4851-aef3-621a76b21fed	413d6728-bb68-4ebd-bd39-5b484d37312b	{}	\N	2026-01-03 17:45:23.760633+00	2026-01-03 17:45:23.760633+00
49c85a51-f347-4931-addc-686bb2091f53	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	listing_favorited	listing_favorited	raimis	horse_listing	ce671880-e3f9-4851-aef3-621a76b21fed	413d6728-bb68-4ebd-bd39-5b484d37312b	{}	\N	2026-01-03 17:45:29.573822+00	2026-01-03 17:45:29.573822+00
edbd4a31-8ba4-4250-844f-c976002b1596	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	listing_favorited	listing_favorited	raimis	horse_listing	ce671880-e3f9-4851-aef3-621a76b21fed	413d6728-bb68-4ebd-bd39-5b484d37312b	{}	\N	2026-01-03 17:48:09.546773+00	2026-01-03 17:48:09.546773+00
d9aeba74-57a6-48a2-9ef2-774e326fbd57	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	service_favorited	Listing favorited	Raimunds V favorited your listing: dddddddddd	listing	ce671880-e3f9-4851-aef3-621a76b21fed	413d6728-bb68-4ebd-bd39-5b484d37312b	{}	\N	2026-01-03 17:48:09.759059+00	2026-01-03 17:48:09.759059+00
730833e6-a43c-4556-a8fe-e6179a8ba042	37bc011e-0f0e-49b8-8b3e-e0f03ec8fd86	listing_favorited	listing_favorited	raimis	equipment_listing	8b85e009-c7f4-4636-b613-87fba176cf48	413d6728-bb68-4ebd-bd39-5b484d37312b	{}	\N	2026-01-03 17:48:30.248276+00	2026-01-03 17:48:30.248276+00
bee5f33d-bed7-48ff-a40f-2ba17b09dfe3	37bc011e-0f0e-49b8-8b3e-e0f03ec8fd86	service_favorited	Listing favorited	Raimunds V favorited your listing: Kivere	listing	8b85e009-c7f4-4636-b613-87fba176cf48	413d6728-bb68-4ebd-bd39-5b484d37312b	{}	\N	2026-01-03 17:48:30.466892+00	2026-01-03 17:48:30.466892+00
dda37838-fbad-47ce-8e13-5781789f4c6c	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	listing_favorited	listing_favorited	raimis	equipment_listing	ade3d46e-f9c2-420b-b4e9-edc1e07843f4	413d6728-bb68-4ebd-bd39-5b484d37312b	{}	\N	2026-01-03 17:48:31.284223+00	2026-01-03 17:48:31.284223+00
3c5f05dc-580f-4071-b04a-9845529346a9	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	service_favorited	Listing favorited	Raimunds V favorited your listing: fffffffffffffff	listing	ade3d46e-f9c2-420b-b4e9-edc1e07843f4	413d6728-bb68-4ebd-bd39-5b484d37312b	{}	\N	2026-01-03 17:48:31.451477+00	2026-01-03 17:48:31.451477+00
afc0ae98-822e-4c20-bffc-ab682c8bd187	413d6728-bb68-4ebd-bd39-5b484d37312b	listing_favorited	listing_favorited	janis1	horse_listing	b312deef-53a4-487b-a0b0-761d22270f40	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	{}	\N	2026-01-05 16:17:57.865021+00	2026-01-05 16:17:57.865021+00
eb2e709f-6ab3-4607-9039-ea2935a65dee	413d6728-bb68-4ebd-bd39-5b484d37312b	service_favorited	Listing favorited	Rv Links favorited your listing: drrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr	listing	b312deef-53a4-487b-a0b0-761d22270f40	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	{}	\N	2026-01-05 16:17:57.965056+00	2026-01-05 16:17:57.965056+00
ea6e0de0-78d8-4a60-b2e8-6b9ba766b586	413d6728-bb68-4ebd-bd39-5b484d37312b	forum_reply	New reply on your topic	pagerlatvia replied to "dddddddddd"	forum_topic	fc75c6ca-291b-41f8-8f11-d7dc85912c86	e9d792ec-1edd-4905-8eef-b3a018d5de35	{"topicId": "fc75c6ca-291b-41f8-8f11-d7dc85912c86", "topicTitle": "dddddddddd"}	\N	2026-01-05 16:47:19.581034+00	2026-01-05 16:47:19.581034+00
67ea3af0-dc19-4558-878f-ec2062ab276d	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	new_message	new_message	raimis: huh	\N	637088c4-03bb-4a26-b5b1-8ceb0f2bd925	413d6728-bb68-4ebd-bd39-5b484d37312b	{}	\N	2026-01-05 20:06:42.142003+00	2026-01-05 20:06:42.142003+00
0204701b-3a1b-4bbc-8033-dddcdeb5d636	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	new_message	New message from Raimunds V	huh	chat	637088c4-03bb-4a26-b5b1-8ceb0f2bd925	413d6728-bb68-4ebd-bd39-5b484d37312b	{}	\N	2026-01-05 20:06:42.240231+00	2026-01-05 20:06:42.240231+00
3ddc5318-882e-42a0-9bda-0f76ec6064fc	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	new_message	new_message	raimis: jj	\N	917f3f8b-180a-421e-804d-730613cba2c1	413d6728-bb68-4ebd-bd39-5b484d37312b	{}	\N	2026-01-11 17:52:41.275416+00	2026-01-11 17:52:41.275416+00
b8ad474b-d59e-4e9d-9c27-69a527a678a8	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	new_message	New message from Raimunds V	jj	chat	917f3f8b-180a-421e-804d-730613cba2c1	413d6728-bb68-4ebd-bd39-5b484d37312b	{}	\N	2026-01-11 17:52:41.372419+00	2026-01-11 17:52:41.372419+00
57f1c747-3e6c-448b-be57-465845b631b4	413d6728-bb68-4ebd-bd39-5b484d37312b	new_message	New message from Rv Links	hey	chat	637088c4-03bb-4a26-b5b1-8ceb0f2bd925	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	{}	2026-01-11 17:53:06.399+00	2026-01-05 20:06:36.591733+00	2026-01-11 17:53:06.407547+00
\.


ALTER TABLE public.notifications ENABLE TRIGGER ALL;

--
-- Data for Name: pony_breed_translations; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.pony_breed_translations DISABLE TRIGGER ALL;

COPY public.pony_breed_translations (id, breed_id, lang_code, name) FROM stdin;
1	1	en	Shetland Pony
2	2	en	Welsh Pony
3	3	en	Connemara Pony
12	12	en	Norwegian Fjord
13	13	en	American Shetland
16	1	lv	Šetlendas Ponijs
17	2	lv	Velsiešu Ponijs
18	3	lv	Konemaras Ponijs
27	12	lv	Norvēģijas Fjords
28	13	lv	Amerikas Šetlendas
31	1	ee	Shetlandi poni
32	1	lt	Šetlendo ponis
33	1	ru	Шетлендский пони
34	2	ee	Welshi poni
35	2	lt	Velso ponis
36	2	ru	Валлийский пони
37	3	ee	Connemara poni
38	3	lt	Konemaros ponis
39	3	ru	Коннемарский пони
64	12	ee	Fjordi hobune
65	12	lt	Fiordo arklys
66	12	ru	Фьордская лошадь
67	13	ee	Ameerika Shetlandi poni
68	13	lt	Amerikos Šetlendo ponis
69	13	ru	Американский шетлендский пони
\.


ALTER TABLE public.pony_breed_translations ENABLE TRIGGER ALL;

--
-- Data for Name: services; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.services DISABLE TRIGGER ALL;

COPY public.services (id, user_id, full_name, bio, hourly_rate, specialty, regions_served, phone, profile_photo_url, visible, created_at, updated_at, views_count, favorites_count, pricing_type, specialties, custom_specialty) FROM stdin;
8766418a-efd3-4481-a73c-c68b5e87cf94	413d6728-bb68-4ebd-bd39-5b484d37312b	hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh	hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh	56.99	horse_breeder	[]	\N	https://qetsvjfknresvkogwlmi.supabase.co/storage/v1/object/public/service-profile-photos/413d6728-bb68-4ebd-bd39-5b484d37312b/1763931921360.webp	t	2025-11-23 21:05:22.305558+00	2025-11-23 21:05:22.305558+00	10	1	per_hour	{horse_breeder}	\N
968b60d1-6aac-44a1-ad9b-7b5892a3ad65	413d6728-bb68-4ebd-bd39-5b484d37312b	rrrrrrrrrrrrrr	rrrrrrrrrrrrrrrrrrrrrrrrfff	56.99	veterinarian	[]	\N	https://qetsvjfknresvkogwlmi.supabase.co/storage/v1/object/public/service-profile-photos/413d6728-bb68-4ebd-bd39-5b484d37312b/1765735633895.jpg	t	2025-11-23 21:05:33.722268+00	2025-11-23 21:05:33.722268+00	4	1	per_hour	{veterinarian,massage_therapist,blacksmith}	\N
28b786e5-83ba-4cdb-a114-79d16032e79d	413d6728-bb68-4ebd-bd39-5b484d37312b	Raimunds Vanags	wwwwwwwwwwwwwwwwwwwwwwwwwfffwwwwfffffwfffffffwwdd	56.99	saddle_fitter	[]	\N	https://qetsvjfknresvkogwlmi.supabase.co/storage/v1/object/public/service-profile-photos/413d6728-bb68-4ebd-bd39-5b484d37312b/1764440712520.jpg	t	2025-11-27 18:40:07.675885+00	2025-11-27 18:40:07.675885+00	14	1	per_job	{saddle_fitter}	\N
d3cc6623-8753-40a2-9231-2568d1ba12b5	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr	rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr	\N	massage_therapist	[]	1234	https://qetsvjfknresvkogwlmi.supabase.co/storage/v1/object/public/service-profile-photos/c82181b0-f29d-4ddc-aac1-2ac11ae9f361/1764005058931.webp	t	2025-11-24 17:24:19.670539+00	2025-11-24 17:24:19.670539+00	24	1	not_specified	{massage_therapist}	\N
\.


ALTER TABLE public.services ENABLE TRIGGER ALL;

--
-- Data for Name: service_favorites; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.service_favorites DISABLE TRIGGER ALL;

COPY public.service_favorites (id, user_id, service_id, created_at) FROM stdin;
ccc46e05-e9a0-42d3-b442-1d00e1a149e7	413d6728-bb68-4ebd-bd39-5b484d37312b	8766418a-efd3-4481-a73c-c68b5e87cf94	2025-11-24 17:28:46.17689+00
fd2ed07d-d9fb-486a-afa5-e439bc5f0cc1	413d6728-bb68-4ebd-bd39-5b484d37312b	d3cc6623-8753-40a2-9231-2568d1ba12b5	2025-11-24 17:28:53.278217+00
b4b2f316-6968-46b7-bd0d-b18a3476df73	413d6728-bb68-4ebd-bd39-5b484d37312b	28b786e5-83ba-4cdb-a114-79d16032e79d	2025-11-30 16:57:42.376739+00
f517b524-6c43-466a-86d5-cf2840aed437	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	d3cc6623-8753-40a2-9231-2568d1ba12b5	2025-12-19 14:30:42.673531+00
9bb95785-76e4-437f-93d7-729f22571f87	413d6728-bb68-4ebd-bd39-5b484d37312b	968b60d1-6aac-44a1-ad9b-7b5892a3ad65	2025-12-31 17:26:27.524359+00
\.


ALTER TABLE public.service_favorites ENABLE TRIGGER ALL;

--
-- Data for Name: service_specialties; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.service_specialties DISABLE TRIGGER ALL;

COPY public.service_specialties (specialty_key, created_at, id) FROM stdin;
blacksmith	2025-11-23 13:55:37.743857+00	1
massage_therapist	2025-11-23 13:55:37.743857+00	2
horse_breeder	2025-11-23 13:55:37.743857+00	3
farrier	2025-11-23 13:55:37.743857+00	4
veterinarian	2025-11-23 13:55:37.743857+00	5
saddle_fitter	2025-11-23 13:55:37.743857+00	7
horse_transporter	2025-11-23 13:55:37.743857+00	8
equine_dentist	2025-11-23 13:55:37.743857+00	9
\.


ALTER TABLE public.service_specialties ENABLE TRIGGER ALL;

--
-- Data for Name: service_specialty_translations; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.service_specialty_translations DISABLE TRIGGER ALL;

COPY public.service_specialty_translations (specialty_key, lang_code, name, created_at, id) FROM stdin;
blacksmith	lv	Kalējs	2025-11-23 13:55:37.743857+00	1
blacksmith	en	Blacksmith	2025-11-23 13:55:37.743857+00	2
blacksmith	lt	Kalvis	2025-11-23 13:55:37.743857+00	3
blacksmith	ee	Sepp	2025-11-23 13:55:37.743857+00	4
blacksmith	ru	Кузнец	2025-11-23 13:55:37.743857+00	5
massage_therapist	lv	Masieris	2025-11-23 13:55:37.743857+00	6
massage_therapist	en	Massage therapist	2025-11-23 13:55:37.743857+00	7
massage_therapist	lt	Masažo terapeutas	2025-11-23 13:55:37.743857+00	8
massage_therapist	ee	Massöör	2025-11-23 13:55:37.743857+00	9
massage_therapist	ru	Массажист	2025-11-23 13:55:37.743857+00	10
horse_breeder	lv	Zirgkopis	2025-11-23 13:55:37.743857+00	11
horse_breeder	en	Horse breeder	2025-11-23 13:55:37.743857+00	12
horse_breeder	lt	Žirgų augintojas	2025-11-23 13:55:37.743857+00	13
horse_breeder	ee	Hobusekasvataja	2025-11-23 13:55:37.743857+00	14
horse_breeder	ru	Коневод	2025-11-23 13:55:37.743857+00	15
farrier	lv	Pakavotājs	2025-11-23 13:55:37.743857+00	16
farrier	en	Farrier	2025-11-23 13:55:37.743857+00	17
farrier	lt	Arklių kalvis	2025-11-23 13:55:37.743857+00	18
farrier	ee	Kabjasepp	2025-11-23 13:55:37.743857+00	19
farrier	ru	Подковщик	2025-11-23 13:55:37.743857+00	20
veterinarian	lv	Veterinārārsts	2025-11-23 13:55:37.743857+00	21
veterinarian	en	Veterinarian	2025-11-23 13:55:37.743857+00	22
veterinarian	lt	Veterinaras	2025-11-23 13:55:37.743857+00	23
veterinarian	ee	Veterinaararst	2025-11-23 13:55:37.743857+00	24
veterinarian	ru	Ветеринар	2025-11-23 13:55:37.743857+00	25
saddle_fitter	en	Saddle fitter	2025-11-23 13:55:37.743857+00	32
saddle_fitter	lt	Balnų pritaikytojas	2025-11-23 13:55:37.743857+00	33
saddle_fitter	ee	Sadulapaigaldaja	2025-11-23 13:55:37.743857+00	34
saddle_fitter	ru	Седельный мастер	2025-11-23 13:55:37.743857+00	35
horse_transporter	lv	Zirgu pārvadātājs	2025-11-23 13:55:37.743857+00	36
horse_transporter	en	Horse transporter	2025-11-23 13:55:37.743857+00	37
horse_transporter	lt	Arklių transportuotojas	2025-11-23 13:55:37.743857+00	38
horse_transporter	ee	Hobutransportija	2025-11-23 13:55:37.743857+00	39
horse_transporter	ru	Перевозчик лошадей	2025-11-23 13:55:37.743857+00	40
equine_dentist	lv	Zirgu zobārsts	2025-11-23 13:55:37.743857+00	41
equine_dentist	en	Equine dentist	2025-11-23 13:55:37.743857+00	42
equine_dentist	lt	Arklių odontologas	2025-11-23 13:55:37.743857+00	43
equine_dentist	ee	Hobuse hambaarst	2025-11-23 13:55:37.743857+00	44
equine_dentist	ru	Лошадиный стоматолог	2025-11-23 13:55:37.743857+00	45
saddle_fitter	lv	Seglu pielāgotājs	2025-11-23 13:55:37.743857+00	31
\.


ALTER TABLE public.service_specialty_translations ENABLE TRIGGER ALL;

--
-- Data for Name: trainer_certifications; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.trainer_certifications DISABLE TRIGGER ALL;

COPY public.trainer_certifications (id, key) FROM stdin;
1	lv_category_a
2	lv_category_b
3	lv_category_c
4	lt_category_a
5	lt_category_b
6	lt_category_c
7	ee_level_i
8	ee_level_ii
9	ee_level_iii
10	ee_level_iv
11	ee_level_v
\.


ALTER TABLE public.trainer_certifications ENABLE TRIGGER ALL;

--
-- Data for Name: trainer_certification_translations; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.trainer_certification_translations DISABLE TRIGGER ALL;

COPY public.trainer_certification_translations (id, certification_id, lang_code, name) FROM stdin;
1	1	lv	A kategorija (sporta speciālists)
2	1	lt	A kategorija (sporto specialistas)
3	1	ee	A kategooria (spordispetsialist)
4	1	ru	Категория A (спортивный специалист)
5	1	en	Category A (Sports specialist)
6	2	lv	B kategorija (sporta speciālists)
7	2	lt	B kategorija (sporto specialistas)
8	2	ee	B kategooria (spordispetsialist)
9	2	ru	Категория B (спортивный специалист)
10	2	en	Category B (Sports specialist)
11	3	lv	C kategorija (sporta speciālists)
12	3	lt	C kategorija (sporto specialistas)
13	3	ee	C kategooria (spordispetsialist)
14	3	ru	Категория C (спортивный специалист)
15	3	en	Category C (Sports specialist)
16	4	lv	A kategorija (sporta speciālists)
17	4	lt	A kategorija (sporto specialistas)
18	4	ee	A kategooria (spordispetsialist)
19	4	ru	Категория A (спортивный специалист)
20	4	en	Category A (Sports specialist)
21	5	lv	B kategorija (sporta speciālists)
22	5	lt	B kategorija (sporto specialistas)
23	5	ee	B kategooria (spordispetsialist)
24	5	ru	Категория B (спортивный специалист)
25	5	en	Category B (Sports specialist)
26	6	lv	C kategorija (sporta speciālists)
27	6	lt	C kategorija (sporto specialistas)
28	6	ee	C kategooria (spordispetsialist)
29	6	ru	Категория C (спортивный специалист)
30	6	en	Category C (Sports specialist)
31	7	lv	I līmenis (trenera licences)
32	7	lt	I lygis (trenerio licencija)
33	7	ee	I tase (treeneri litsents)
34	7	ru	Уровень I (лицензия тренера)
35	7	en	Level I (Coach licence)
36	8	lv	II līmenis (trenera licences)
37	8	lt	II lygis (trenerio licencija)
38	8	ee	II tase (treeneri litsents)
39	8	ru	Уровень II (лицензия тренера)
40	8	en	Level II (Coach licence)
41	9	lv	III līmenis (trenera licences)
42	9	lt	III lygis (trenerio licencija)
43	9	ee	III tase (treeneri litsents)
44	9	ru	Уровень III (лицензия тренера)
45	9	en	Level III (Coach licence)
46	10	lv	IV līmenis (trenera licences)
47	10	lt	IV lygis (trenerio licencija)
48	10	ee	IV tase (treeneri litsents)
49	10	ru	Уровень IV (лицензия тренера)
50	10	en	Level IV (Coach licence)
51	11	lv	V līmenis (trenera licences)
52	11	lt	V lygis (trenerio licencija)
53	11	ee	V tase (treeneri litsents)
54	11	ru	Уровень V (лицензия тренера)
55	11	en	Level V (Coach licence)
\.


ALTER TABLE public.trainer_certification_translations ENABLE TRIGGER ALL;

--
-- Data for Name: trainers; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.trainers DISABLE TRIGGER ALL;

COPY public.trainers (id, user_id, name, photo_url, bio, specialties, years_experience, hourly_rate, currency, country, languages, certifications, website_url, phone, verified, age, created_at, updated_at, visible, favorites_count, views_count, city, municipality, lat, lon, certification_details, admin1_mapbox_id, admin1_name, admin1_iso_code, files, pricing_type) FROM stdin;
22ac7434-eaa0-4a0a-8f7b-6471191417df	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	dddddddd	https://qetsvjfknresvkogwlmi.supabase.co/storage/v1/object/public/trainers-profile-pics/trainers-profile-pics/c82181b0-f29d-4ddc-aac1-2ac11ae9f361.jpg	dddddddddddttttttttt	{Western,Dressage,"Show Jumping",Racing}	5	5.00	EUR	LV	{Russian,Finnish}	{}	\N	\N	f	18	2025-09-13 17:26:05.671526+00	2025-12-06 12:22:49.04334+00	f	0	15		\N	\N	\N	[]	\N	\N	\N	{}	per_hour
8b8822db-eb82-4399-b063-5bf576dd4688	413d6728-bb68-4ebd-bd39-5b484d37312b	ddddddddddd	https://qetsvjfknresvkogwlmi.supabase.co/storage/v1/object/public/trainers-profile-pics/trainers-profile-pics/413d6728-bb68-4ebd-bd39-5b484d37312b.jpg	dddddddddddddddddddddddd	{Racing,Vaulting,"Show Jumping",Dressage}	3	\N	EUR	\N	{Latvian,Lithuanian}	{lv_category_c,lv_category_b}	\N	+37127724276	f	33	2025-11-29 18:18:43.035245+00	2026-01-03 15:46:09.950121+00	t	2	20		\N	\N	\N	[{"name": "lv_category_c", "number": "34545"}, {"name": "lv_category_b", "number": "3455"}]	\N	\N	\N	{https://qetsvjfknresvkogwlmi.supabase.co/storage/v1/object/public/forum-files/trainer-files/413d6728-bb68-4ebd-bd39-5b484d37312b/egks1hy6r7g-1765729815545.pdf}	not_specified
\.


ALTER TABLE public.trainers ENABLE TRIGGER ALL;

--
-- Data for Name: trainer_chats; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.trainer_chats DISABLE TRIGGER ALL;

COPY public.trainer_chats (id, trainer_id, client_user_id, message, sender_id, created_at, read_at) FROM stdin;
\.


ALTER TABLE public.trainer_chats ENABLE TRIGGER ALL;

--
-- Data for Name: trainer_favorites; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.trainer_favorites DISABLE TRIGGER ALL;

COPY public.trainer_favorites (id, user_id, trainer_id, created_at) FROM stdin;
eff29b35-a5f2-46bd-b533-41e52b498b87	413d6728-bb68-4ebd-bd39-5b484d37312b	f895635e-e370-4a55-ae2e-32253325cd77	2025-11-11 16:24:31.719626+00
08902f27-cb47-4b03-9243-9b231c50f4ba	413d6728-bb68-4ebd-bd39-5b484d37312b	7e97dceb-c7be-48e2-a0f3-3ffb85cb6770	2025-11-23 16:04:31.522343+00
64f98301-2ac4-48a9-9a71-ef8e35be1c3a	c82181b0-f29d-4ddc-aac1-2ac11ae9f361	8b8822db-eb82-4399-b063-5bf576dd4688	2025-12-20 17:57:17.705876+00
d2cd2bbf-0ae8-44d6-9a77-5b5c4aa87cd9	413d6728-bb68-4ebd-bd39-5b484d37312b	8b8822db-eb82-4399-b063-5bf576dd4688	2026-01-03 15:46:09.950121+00
\.


ALTER TABLE public.trainer_favorites ENABLE TRIGGER ALL;

--
-- Data for Name: trainer_languages; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.trainer_languages DISABLE TRIGGER ALL;

COPY public.trainer_languages (id, key) FROM stdin;
1	English
2	Latvian
3	Russian
4	German
5	Estonian
6	Lithuanian
\.


ALTER TABLE public.trainer_languages ENABLE TRIGGER ALL;

--
-- Data for Name: trainer_language_translations; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.trainer_language_translations DISABLE TRIGGER ALL;

COPY public.trainer_language_translations (id, language_id, lang_code, name) FROM stdin;
1	1	lv	Angļu valoda
2	1	lt	Anglų kalba
3	1	ee	Inglise keel
4	1	ru	Английский язык
5	1	en	English
6	2	lv	Latviešu valoda
7	2	lt	Latvių kalba
8	2	ee	Läti keel
9	2	ru	Латышский язык
10	2	en	Latvian
11	3	lv	Krievu valoda
12	3	lt	Rusų kalba
13	3	ee	Vene keel
14	3	ru	Русский язык
15	3	en	Russian
16	4	lv	Vācu valoda
17	4	lt	Vokiečių kalba
18	4	ee	Saksa keel
19	4	ru	Немецкий язык
20	4	en	German
21	5	lv	Igauņu valoda
22	5	lt	Estų kalba
23	5	ee	Eesti keel
24	5	ru	Эстонский язык
25	5	en	Estonian
26	6	lv	Lietuviešu valoda
27	6	lt	Lietuvių kalba
28	6	ee	Leedu keel
29	6	ru	Литовский язык
30	6	en	Lithuanian
\.


ALTER TABLE public.trainer_language_translations ENABLE TRIGGER ALL;

--
-- Data for Name: trainer_specialties; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.trainer_specialties DISABLE TRIGGER ALL;

COPY public.trainer_specialties (id, key) FROM stdin;
1	Dressage
2	Show Jumping
3	Eventing
4	Western
5	Racing
6	Trail Riding
7	Natural Horsemanship
8	Vaulting
9	Driving
10	Other
\.


ALTER TABLE public.trainer_specialties ENABLE TRIGGER ALL;

--
-- Data for Name: trainer_specialty_translations; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.trainer_specialty_translations DISABLE TRIGGER ALL;

COPY public.trainer_specialty_translations (id, specialty_id, lang_code, name) FROM stdin;
1	1	lv	Iekšējā jāšana (Dresūra)
2	1	lt	Dresūra
3	1	ee	Koolisõit
4	1	ru	Выездка
5	1	en	Dressage
6	2	lv	Šķēršļu pārvarēšana
7	2	lt	Kliūčių šuoliai
8	2	ee	Takistussõit
9	2	ru	Преодоление препятствий
10	2	en	Show Jumping
11	3	lv	Daudzcīņa (Eventing)
12	3	lt	Triatlonas (Eventing)
13	3	ee	Kolmikalavõistlus
14	3	ru	Троеборье
15	3	en	Eventing
16	4	lv	Rietumu jāšanas stils
17	4	lt	Vakarietiškas jojimo stilius
18	4	ee	Western ratsutamine
19	4	ru	Вестерн стиль верховой езды
20	4	en	Western
21	5	lv	Zirgu skriešanās sacīkstes
22	5	lt	Žirgų lenktynės
23	5	ee	Võidusõit
24	5	ru	Скачки
25	5	en	Racing
26	6	lv	Izjādes dabā / pārgājieni ar zirgiem
27	6	lt	Jojimas gamtoje / žygiai su žirgais
28	6	ee	Metsamatkad / maastikusõit
29	6	ru	Прогулки и походы на лошадях
30	6	en	Trail Riding
31	7	lv	Dabiskā jāšanas māksla
32	7	lt	Natūralus bendravimas su žirgais
33	7	ee	Looduslik ratsutamine
34	7	ru	Естественная работа с лошадьми
35	7	en	Natural Horsemanship
36	8	lv	Voltižēšana
37	8	lt	Voltižavimas
38	8	ee	Voltžeerimine
39	8	ru	Вольтижировка
40	8	en	Vaulting
41	9	lv	Braukšana ar zirgiem
42	9	lt	Vežimų sportas
43	9	ee	Rakendisport
44	9	ru	Конный драйвинг / упряжка
45	9	en	Driving
46	10	lv	Cits
47	10	lt	Kita
48	10	ee	Muu
49	10	ru	Другое
50	10	en	Other
\.


ALTER TABLE public.trainer_specialty_translations ENABLE TRIGGER ALL;

--
-- Data for Name: user_roles; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.user_roles DISABLE TRIGGER ALL;

COPY public.user_roles (id, user_id, role, created_at) FROM stdin;
fba8b3fe-22e5-46a3-8332-e240442f8b10	413d6728-bb68-4ebd-bd39-5b484d37312b	super_admin	2025-09-05 12:19:11.300479+00
3218049d-5c99-486a-ad5e-3311ce217b3a	413d6728-bb68-4ebd-bd39-5b484d37312b	super_master	2025-09-18 19:08:06.798176+00
\.


ALTER TABLE public.user_roles ENABLE TRIGGER ALL;

--
-- Name: announcement_categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.announcement_categories_id_seq', 9, true);


--
-- Name: announcement_category_translations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.announcement_category_translations_id_seq', 60, true);


--
-- Name: cities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.cities_id_seq', 804, true);


--
-- Name: city_translations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.city_translations_id_seq', 5246, true);


--
-- Name: countries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.countries_id_seq', 3, true);


--
-- Name: country_translations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.country_translations_id_seq', 30, true);


--
-- Name: equipment_brands_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.equipment_brands_id_seq', 20, true);


--
-- Name: equipment_color_translations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.equipment_color_translations_id_seq', 100, true);


--
-- Name: equipment_colors_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.equipment_colors_id_seq', 19, true);


--
-- Name: equipment_condition_translations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.equipment_condition_translations_id_seq', 35, true);


--
-- Name: equipment_conditions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.equipment_conditions_id_seq', 5, true);


--
-- Name: equipment_material_translations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.equipment_material_translations_id_seq', 192, true);


--
-- Name: equipment_materials_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.equipment_materials_id_seq', 42, true);


--
-- Name: equipment_type_translations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.equipment_type_translations_id_seq', 392, true);


--
-- Name: equipment_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.equipment_types_id_seq', 88, true);


--
-- Name: forum_categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.forum_categories_id_seq', 1, false);


--
-- Name: forum_category_translations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.forum_category_translations_id_seq', 40, true);


--
-- Name: horse_breed_translations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.horse_breed_translations_id_seq', 145, true);


--
-- Name: horse_breeds_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.horse_breeds_id_seq', 24, true);


--
-- Name: horse_color_translations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.horse_color_translations_id_seq', 80, true);


--
-- Name: horse_colors_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.horse_colors_id_seq', 16, true);


--
-- Name: horse_discipline_translations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.horse_discipline_translations_id_seq', 60, true);


--
-- Name: horse_disciplines_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.horse_disciplines_id_seq', 12, true);


--
-- Name: horse_sex_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.horse_sex_id_seq', 3, true);


--
-- Name: horse_sex_translations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.horse_sex_translations_id_seq', 15, true);


--
-- Name: horse_temperament_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.horse_temperament_id_seq', 5, true);


--
-- Name: horse_temperament_translations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.horse_temperament_translations_id_seq', 25, true);


--
-- Name: municipalities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.municipalities_id_seq', 240, true);


--
-- Name: municipality_translations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.municipality_translations_id_seq', 1010, true);


--
-- Name: pony_breed_translations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.pony_breed_translations_id_seq', 75, true);


--
-- Name: pony_breeds_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.pony_breeds_id_seq', 15, true);


--
-- Name: service_specialties_id_int_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.service_specialties_id_int_seq', 9, true);


--
-- Name: service_specialty_translations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.service_specialty_translations_id_seq', 45, true);


--
-- Name: trainer_certification_translations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.trainer_certification_translations_id_seq', 40, true);


--
-- Name: trainer_language_translations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.trainer_language_translations_id_seq', 32, true);


--
-- Name: trainer_specialty_translations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.trainer_specialty_translations_id_seq', 40, true);


--
-- PostgreSQL database dump complete
--

\unrestrict KyNaziLaJC9yfohdqlf6qXCb4CtqzOI7aJAMJtozPdDRY25HX9wYYX7yc9Or1Yo

