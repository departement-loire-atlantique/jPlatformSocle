<%@page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="fr.cg44.plugin.socle.VideoUtils" %>
<%--    Génère une iframe de la vidéo incluse
        TODO : voir si on laisse comme ça ou si on génère l'iframe en JS via l'api Youtube mais 
        aujourd'hui le script plante si on insère plusieurs vidéo.
        
        TODO : rendre le chapitrage fonctionnel (hors sprint).
--%>
<%@ include file='/jcore/doInitPage.jspf' %>

<% Video obj = (Video)request.getAttribute(PortalManager.PORTAL_PUBLICATION); %>

<%
String uniqueIDiframe = UUID.randomUUID().toString();
String urlVideo = Util.decodeUrl(VideoUtils.buildYoutubeUrl(obj.getUrlVideo()));
String fichierTranscript = Util.notEmpty(obj.getFichierTranscript(userLang)) ? obj.getFichierTranscript().getDownloadUrl() : "";
String titleVideo = obj.getTitle(userLang);
if (Util.notEmpty(request.getAttribute("overrideVidTitle"))) {
  titleVideo = request.getAttribute("overrideVidTitle").toString();
  request.setAttribute("overrideVidTitle", null);
}

String chapoVideo = obj.getChapo(userLang);
if (Util.notEmpty(request.getAttribute("overrideVidChapo"))) {
  chapoVideo = request.getAttribute("overrideVidChapo").toString();
  request.setAttribute("overrideVidChapo", null);
}

boolean hideTitle = false;
if (Util.notEmpty(request.getAttribute("hideVideoTitle"))) {
  hideTitle = Boolean.parseBoolean(request.getAttribute("hideVideoTitle").toString());
  request.setAttribute("hideVideoTitle", false);
}

String heightIframe = "480px";
if (Util.notEmpty(request.getAttribute("forcedHeight"))) {
    heightIframe = request.getAttribute("forcedHeight").toString();
    request.setAttribute("hideVideoTitle", null);
  }

String videoId = VideoUtils.getYoutubeVideoId(obj.getUrlVideo()); // récupérer l'ID de la vidéo YT
// le JS se base sur cette ID et va alors forcer cette ID dans l'url de la vidéo. Utiliser un UID va casser l'affichage de la vidéo

%>

<jalios:if predicate="<%= Util.notEmpty(titleVideo) && !hideTitle %>">
    <h3 class="h3-like"><%= titleVideo %></h3>
</jalios:if>
<jalios:if predicate="<%= Util.notEmpty(chapoVideo) %>">
    <jalios:wysiwyg><%= chapoVideo %></jalios:wysiwyg>
</jalios:if>

<!-- <div class="ds44-js-youtube-video" data-video-id="<%= videoId %>"> -->
<div>
    <div class="ds44-cookie-overlay-container">
	    <div class="ds44-video-container">
			
			<iframe title='<%= HttpUtil.encodeForHTML(glp("jcmsplugin.socle.video.acceder", titleVideo)) %>' id="<%=uniqueIDiframe%>" class="ds44-hiddenPrint ds44-video-item" style="width: 100%; height: <%= heightIframe %>; border: none;" src="<%=urlVideo%>" frameborder="0" allowfullscreen="1" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"></iframe>
			<div class="ds44-media-overlay" style="display: none;">
		        <div class="ds44-msg-media-desactive">
		            <p><%= glp("jcmsplugin.socle.videodesactivee") %></p>
		            <p><%= glp("jcmsplugin.socle.devezaccepterdepotcookie") %></p>
		            <button class="ds44-btnStd ds44-btn--contextual" data-consent="accept-streaming-cookie">
                        <span class="ds44-btnInnerText"><%= JcmsUtil.glp(userLang, "jcmsplugin.socle.acceptercookies") %></span>
                        <i class="icon icon-long-arrow-right" aria-hidden="true"></i>
                    </button>
		        </div>
		    </div>
	    </div>
    </div>
</div>

        <jalios:if predicate="<%=Util.notEmpty(fichierTranscript)%>">
            <%
            String fileType = FileDocument.getExtension(obj.getFichierTranscript(userLang).getFilename()).toUpperCase();
            String fileSize = Util.formatFileSize(obj.getFichierTranscript(userLang).getSize());
            %>
            <p><a href="<%= fichierTranscript %>" target="_blank" title="<%= glp("jcmsplugin.socle.video.telecharger-transcript.title", obj.getFichierTranscript(userLang).getTitle(),fileSize,fileType) %>"><%= glp("jcmsplugin.socle.video.telecharger-transcript.label") %></a></p>
        </jalios:if>
        <!-- Désactivation temporaire des chapitres -> l'overlay est la proprité. Sera remis une fois le JS traité 
        <%@ include file="doVideoChapitres.jspf" %>  
        
        -->