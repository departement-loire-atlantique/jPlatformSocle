<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file='/jcore/doInitPage.jspf'%>

<script>
    window.GTM_UA = '<%=channel.getProperty("plugin.seo.gtm.id")%>';
    window.orejimeConfig = {
        privacyPolicy: '<%= channel.getProperty("jcmsplugin.socle.rgpd.privacyPolicy.url") %>',
        logo: '<%= channel.getProperty("jcmsplugin.socle.rgpd.notice.logo") %>',
        translations: {
            fr: {
                consentModal: {
                    title: '<%= HttpUtil.encodeForJavaScript(channel.getProperty("jcmsplugin.socle.rgpd.modale.titre")) %>',
                    description: '<%= HttpUtil.encodeForJavaScript(channel.getProperty("jcmsplugin.socle.rgpd.modale.description")) %>',
                    privacyPolicy: {
                        name: '<%= HttpUtil.encodeForJavaScript(channel.getProperty("jcmsplugin.socle.rgpd.privacyPolicy.name")) %>',
                        text: '<%= HttpUtil.encodeForJavaScript(channel.getProperty("jcmsplugin.socle.rgpd.privacyPolicy.text")) %> {privacyPolicy}'
                    }
                },
                consentNotice: {
                    description: '<%= HttpUtil.encodeForJavaScript(channel.getProperty("jcmsplugin.socle.rgpd.notice.description")) %>',
                    learnMore: '<%= HttpUtil.encodeForJavaScript(channel.getProperty("jcmsplugin.socle.rgpd.notice.learn-more")) %>',
                    privacyPolicy: {
                        name: '<%= HttpUtil.encodeForJavaScript(channel.getProperty("jcmsplugin.socle.rgpd.privacyPolicy.name")) %>',
                        text: '<%= HttpUtil.encodeForJavaScript(channel.getProperty("jcmsplugin.socle.rgpd.privacyPolicy.text")) %> {privacyPolicy}'
                    }
                },
                accept: '<%= HttpUtil.encodeForJavaScript(channel.getProperty("jcmsplugin.socle.rgpd.bouton.accept")) %>',
                acceptAll: '<%= HttpUtil.encodeForJavaScript(channel.getProperty("jcmsplugin.socle.rgpd.bouton.accept-all")) %>',
                decline: '<%= HttpUtil.encodeForJavaScript(channel.getProperty("jcmsplugin.socle.rgpd.bouton.decline")) %>',
                declineAll: '<%= HttpUtil.encodeForJavaScript(channel.getProperty("jcmsplugin.socle.rgpd.bouton.decline-all")) %>',
                purposes: {
                    analytics: 'Analyse'
                },
                "jsessionid":{
                    description: "Ce cookie est utilisé par le serveur pour identifier une session utilisateur et permettre une navigation correcte. Il est supprimé lors de la fin de la session de navigation ou à la fermeture du navigateur.",
                },
                "google-tag-manager":{
                    description: "description du cookie GTM...",
                },
                "orejime":{
                    description: "Ce cookie est utilisé par notre gestionnaire de cookies pour mémoriser vos préférences.",
                },                
            },
            en: {
                purposes: {
                    analytics: 'Analytics'
                }
            },
        },
        apps: [
            {
                name: 'google-tag-manager',
                title: 'Google Tag Manager',
                cookies: [
                    '_ga',
                    '_gat',
                    '_gid',
                    '__utma',
                    '__utmb',
                    '__utmc',
                    '__utmt',
                    '__utmz',
                    '_gat_gtag_' + GTM_UA,
                    '_gat_' + GTM_UA
                ],
                optOut: false,
                purposes: ['analytics']
            },
            {
                name: 'jsessionid',
                title: 'JSESSIONID',
                purposes: [],
                required: true
            },
            {
                name: 'orejime',
                title: 'orejime',
                purposes: [],
                required: true
            }
        ],
    };
</script>

<link rel="stylesheet" href="https://unpkg.com/orejime@1.2.3/dist/orejime.css" />
<script src="https://unpkg.com/orejime@1.2.3/dist/orejime.js"></script>