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

String videoId = obj.getUrlVideo().substring(obj.getUrlVideo().indexOf("?v=") + 3); // récupérer l'ID de la vidéo YT
// le JS se base sur cette ID et va alors forcer cette ID dans l'url de la vidéo. Utiliser un UID va casser l'affichage de la vidéo 

%>

<jalios:if predicate="<%= Util.notEmpty(titleVideo) && !hideTitle %>">
    <h3 class="h3-like"><%= titleVideo %></h3>
</jalios:if>
<jalios:if predicate="<%= Util.notEmpty(chapoVideo) %>">
    <jalios:wysiwyg><%= chapoVideo %></jalios:wysiwyg>
</jalios:if>

<div class="ds44-js-youtube-video" data-video-id="<%= videoId %>">
    <div class="ds44-video-container">
		
		<iframe title='<%= HttpUtil.encodeForHTML(glp("jcmsplugin.socle.video.acceder", titleVideo)) %>' id="<%=uniqueIDiframe%>" class="ds44-hiddenPrint ds44-video-item" style="width: 100%; height: <%= heightIframe %>; border: none;" src="<%=urlVideo%>" frameborder="0" allowfullscreen="1" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"></iframe>
			
    </div>
</div>

        <jalios:if predicate="<%=Util.notEmpty(fichierTranscript)%>">
            <%
            String fileType = FileDocument.getExtension(obj.getFichierTranscript(userLang).getFilename()).toUpperCase();
            String fileSize = Util.formatFileSize(obj.getFichierTranscript(userLang).getSize());
            %>
            <p><a href="<%= fichierTranscript %>" target="_blank" title="<%= glp("jcmsplugin.socle.video.telecharger-transcript.title", obj.getFichierTranscript(userLang).getTitle(),fileSize,fileType) %>"><%= glp("jcmsplugin.socle.video.telecharger-transcript.label") %></a></p>
        </jalios:if>
        
        <jalios:if predicate="<%= Util.notEmpty(obj.getChapitre(userLang)) && Util.notEmpty(obj.getTimecode(userLang)) && Util.notEmpty(obj.getLibelleTimecode(userLang)) %>">
            <%
            List<String> chapitres = Arrays.asList(obj.getChapitre(userLang));
            String[] timecodes = obj.getTimecode(userLang);
            String[] libellestimecodes = obj.getLibelleTimecode(userLang);
            String tmpChapitre = "";
            %>
            
            <p class="h4-like mtl" aria-level="4" role="heading"><%= glp("jcmsplugin.socle.video.leschapitres") %></p>
            
            <%
            boolean gotChapterTitle = false;
            %>

            <ul class="ds44-list ds44-list--video">
            <jalios:foreach name="itChapitre" type="String" array="<%=obj.getChapitre(userLang)%>">
                <jalios:if predicate="<%=Util.notEmpty(itChapitre) && !itChapitre.equals(tmpChapitre) %>">
                    <jalios:if predicate="<%= gotChapterTitle %>">
                    </ul>
                    </jalios:if>
                    <% tmpChapitre = itChapitre; %>
                    <p aria-level="5" role="heading"><%=itChapitre %></p>
                    <jalios:if predicate="<%= gotChapterTitle %>">
                    <ul class="ds44-list ds44-list--video">
                    </jalios:if>
                    <% gotChapterTitle = true; %>
                </jalios:if>

                <%-- TODO : ouverture et fermeture UL --%>
                <%
                String uniqueID = UUID.randomUUID().toString();
                String timecode = "";
                String libelletimecode = "";
                try {
                    if (Util.notEmpty(timecodes[itCounter-1]) && Util.notEmpty(libellestimecodes[itCounter-1])) {
                        timecode = timecodes[itCounter-1];
                        libelletimecode = libellestimecodes[itCounter-1];
                        int seekAtVideo = SocleUtils.getTimeInSecondsFromHhMmSs(timecode);
                        %>
                        <li>
                            <a id="#video<%=uniqueID%>" href="#<%= uniqueIDiframe %>" role="button" class="ds44-js-video-seek-to" data-video-id="<%= videoId %>" data-seek-to="<%= seekAtVideo %>" title='<%= HttpUtil.encodeForHTMLAttribute(glp("jcmsplugin.socle.video.title.chapitrelink", timecode, itChapitre)) %>'><%= itChapitre %></a>
                        </li>
                        <%
                        }
                    } catch (IndexOutOfBoundsException e) {
                        timecode = "";
                        libelletimecode = "";
                    }
               
              %>
            </jalios:foreach>
            </ul>
        
        </jalios:if>