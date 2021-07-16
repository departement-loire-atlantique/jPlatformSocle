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
                    title: '<%= HttpUtil.encodeForJavaScript(glp("jcmsplugin.socle.rgpd.modale.titre")) %>',
                    description: '<%= HttpUtil.encodeForJavaScript(channel.getProperty("fr.jcmsplugin.socle.rgpd.description-modale")) %>',
                    privacyPolicy: {
                        name: '<%= HttpUtil.encodeForJavaScript(glp("jcmsplugin.socle.rgpd.privacyPolicy.name")) %>',
                        text: '<%= HttpUtil.encodeForJavaScript(glp("jcmsplugin.socle.rgpd.privacyPolicy.text")) %> {privacyPolicy}'
                    }
                },
                consentNotice: {
                    description: '<%= HttpUtil.encodeForJavaScript(channel.getProperty("fr.jcmsplugin.socle.rgpd.description-notice")) %>',
                    learnMore: '<%= HttpUtil.encodeForJavaScript(glp("jcmsplugin.socle.rgpd.notice.learn-more")) %>',
                    privacyPolicy: {
                        name: '<%= HttpUtil.encodeForJavaScript(glp("jcmsplugin.socle.rgpd.privacyPolicy.name")) %>',
                        text: '<%= HttpUtil.encodeForJavaScript(glp("jcmsplugin.socle.rgpd.privacyPolicy.text")) %> {privacyPolicy}'
                    }
                },
                accept: '<%= HttpUtil.encodeForJavaScript(glp("jcmsplugin.socle.rgpd.bouton.accept")) %>',
                acceptAll: '<%= HttpUtil.encodeForJavaScript(glp("jcmsplugin.socle.rgpd.bouton.accept-all")) %>',
                decline: '<%= HttpUtil.encodeForJavaScript(glp("jcmsplugin.socle.rgpd.bouton.decline")) %>',
                declineAll: '<%= HttpUtil.encodeForJavaScript(glp("jcmsplugin.socle.rgpd.bouton.decline-all")) %>',
                purposes: {
                    analytics: 'Analyse'
                },
                "jsessionid":{
                    description: "<%= HttpUtil.encodeForJavaScript(glp("jcmsplugin.socle.rgpd.cookie.jsessionid.descr")) %>",
                },
                "google-tag-manager":{
                    description: "<%= HttpUtil.encodeForJavaScript(glp("jcmsplugin.socle.rgpd.cookie.google.descr")) %>",
                },
                "orejime":{
                    description: "<%= HttpUtil.encodeForJavaScript(glp("jcmsplugin.socle.rgpd.cookie.orejime.descr")) %>",
                },
            },
            en: {
                consentModal: {
                    title: '<%= HttpUtil.encodeForJavaScript(glp("jcmsplugin.socle.rgpd.modale.titre")) %>',
                    description: '<%= HttpUtil.encodeForJavaScript(channel.getProperty("en.jcmsplugin.socle.rgpd.description-modale")) %>',
                    privacyPolicy: {
                        name: '<%= HttpUtil.encodeForJavaScript(glp("jcmsplugin.socle.rgpd.privacyPolicy.name")) %>',
                        text: '<%= HttpUtil.encodeForJavaScript(glp("jcmsplugin.socle.rgpd.privacyPolicy.text")) %> {privacyPolicy}'
                    }
                },
                consentNotice: {
                    description: '<%= HttpUtil.encodeForJavaScript(channel.getProperty("en.jcmsplugin.socle.rgpd.description-notice")) %>',
                    learnMore: '<%= HttpUtil.encodeForJavaScript(glp("jcmsplugin.socle.rgpd.notice.learn-more")) %>',
                    privacyPolicy: {
                        name: '<%= HttpUtil.encodeForJavaScript(glp("jcmsplugin.socle.rgpd.privacyPolicy.name")) %>',
                        text: '<%= HttpUtil.encodeForJavaScript(glp("jcmsplugin.socle.rgpd.privacyPolicy.text")) %> {privacyPolicy}'
                    }
                },
                accept: '<%= HttpUtil.encodeForJavaScript(glp("jcmsplugin.socle.rgpd.bouton.accept")) %>',
                acceptAll: '<%= HttpUtil.encodeForJavaScript(glp("jcmsplugin.socle.rgpd.bouton.accept-all")) %>',
                decline: '<%= HttpUtil.encodeForJavaScript(glp("jcmsplugin.socle.rgpd.bouton.decline")) %>',
                declineAll: '<%= HttpUtil.encodeForJavaScript(glp("jcmsplugin.socle.rgpd.bouton.decline-all")) %>',
                purposes: {
                    analytics: 'analytics'
                },
                "jsessionid":{
                    description: "<%= HttpUtil.encodeForJavaScript(glp("jcmsplugin.socle.rgpd.cookie.jsessionid.descr")) %>",
                },
                "google-tag-manager":{
                    description: "<%= HttpUtil.encodeForJavaScript(glp("jcmsplugin.socle.rgpd.cookie.google.descr")) %>",
                },
                "orejime":{
                    description: "<%= HttpUtil.encodeForJavaScript(glp("jcmsplugin.socle.rgpd.cookie.orejime.descr")) %>",
                },                
            },
        },
        apps: [
            {
                name: 'google-tag-manager',
                title: 'Google Analytics et Tag Manager',
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
                optOut: true,
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