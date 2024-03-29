<%@tag import="fr.cg44.plugin.socle.SocleUtils"%>
<%@tag import="fr.cg44.plugin.socle.VideoUtils"%>
<%@ taglib prefix="ds" tagdir="/WEB-INF/tags" %><%
%><%@ taglib uri="jcms.tld" prefix="jalios" %><%
%><%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%><%
%><%@ tag 
    pageEncoding="UTF-8"
    description="Titre du header simple" 
    body-content="scriptless" 
    import="com.jalios.jcms.Channel, com.jalios.util.ServletUtil, com.jalios.util.Util, com.jalios.jcms.JcmsUtil, 
        com.jalios.jcms.taglib.ThumbnailTag, com.jalios.io.ImageFormat, generated.Video, com.jalios.jcms.FileDocument,
        com.jalios.jcms.Publication, com.jalios.jcms.HttpUtil"
%>
<%@ attribute name="title"
    required="true"
    fragment="false"
    rtexprvalue="true"
    type="String"
    description="Le titre affiché sur l'image"
%>
<%@ attribute name="pub"
    required="false"
    fragment="false"
    rtexprvalue="true"
    type="Publication"
    description="La publication dont on récupère l'image"
%>
<%@ attribute name="chapo"
    required="false"
    fragment="false"
    rtexprvalue="true"
    type="String"
    description="Le chapô de l'article"
%>
<%@ attribute name="imagePath"
    required="false"
    fragment="false"
    rtexprvalue="true"
    type="String"
    description="Le chemin du fichier image"
%>
<%@ attribute name="mobileImagePath"
    required="false"
    fragment="false"
    rtexprvalue="true"
    type="String"
    description="Le chemin du fichier image mobile"
%>
<%@ attribute name="video"
    required="false"
    fragment="false"
    rtexprvalue="true"
    type="generated.Video"
    description="Video"
%>
<%@ attribute name="alt"
    required="false"
    fragment="false"
    rtexprvalue="true"
    type="String"
    description="Texte alternatif de l'image"
%>
<%@ attribute name="legend"
    required="false"
    fragment="false"
    rtexprvalue="true"
    type="String"
    description="Légende de l'image"
%>
<%@ attribute name="copyright"
    required="false"
    fragment="false"
    rtexprvalue="true"
    type="String"
    description="Copyright de l'image"
%>
<%@ attribute name="subtitle"
    required="false"
    fragment="false"
    rtexprvalue="true"
    type="String"
    description="Sous-titre"
%>
<%@ attribute name="date"
    required="false"
    fragment="false"
    rtexprvalue="true"
    type="String"
    description="Date de publication"
%>
<%@ attribute name="breadcrumb"
    required="false"
    fragment="false"
    rtexprvalue="true"
    type="Boolean"
    description="Indique si le fil d'ariane doit être affiché"
%>
<%@ attribute name="backButton"
    required="false"
    fragment="false"
    rtexprvalue="true"
    type="Boolean"
    description="Indique si le bouton de retour doit être affiché (si on arrive du moteur de recherche à facettes)"
%>

<%
String userLang = Channel.getChannel().getCurrentUserLang();
String uid = ServletUtil.generateUniqueDOMId(request, "uid");

boolean hasFigcaption = Util.notEmpty(legend) || Util.notEmpty(copyright);
boolean retour = Util.notEmpty(backButton) && backButton;

//Récupération des infos de vidéo, dans la cas d'une fiche article ou actu
String titreVideo = "";
String urlVideo = "";
String fichierTranscriptVideo = "";
String typeFichierTranscript = "";
String tailleFichierTranscript = "";
String videoId = "";
if(Util.notEmpty(video)) {
    titreVideo = video.getTitle();
    urlVideo = Util.decodeUrl(VideoUtils.buildYoutubeUrl(video.getUrlVideo()));
    videoId = VideoUtils.getYoutubeVideoId(video.getUrlVideo()); // récupérer l'ID de la vidéo YT
    // Récupération des infos du fichier de transcription
    if(Util.notEmpty(video.getFichierTranscript(userLang))){
        fichierTranscriptVideo = video.getFichierTranscript(userLang).getDownloadUrl();
        typeFichierTranscript = FileDocument.getExtension(video.getFichierTranscript().getFilename()).toUpperCase();
        tailleFichierTranscript = Util.formatFileSize(video.getFichierTranscript().getSize());
    }
}

%>

<div class="ds44-lightBG <%= retour ? "ds44-posRel" : "" %>">

    <jalios:if predicate='<%= retour %>'>
        <%@ include file="/plugins/SoclePlugin/jsp/facettes/doRetourListe.jspf" %>
    </jalios:if>
    
    <div class="ds44-inner-container ds44--xl-padding-t ds44--m-padding-b ds44-tablet-augment-pt">
        <div class="ds44-grid12-offset-2">
            <jalios:if predicate='<%=breadcrumb && Util.notEmpty(Channel.getChannel().getProperty("jcmsplugin.socle.portlet.filariane.id")) %>'>
                <jalios:include id='<%=Channel.getChannel().getProperty("jcmsplugin.socle.portlet.filariane.id") %>'/>
            </jalios:if>
            <h1 class="h1-like mbs mts ds44-mobile-reduced-mb ds44-mobile-reduced-mt" id="titreActualite"><%=title%></h1>
            <jalios:if predicate="<%= Util.notEmpty(subtitle) %>">
                <h2 id="sousTitre" class="h2-like"><%= subtitle %></h2>
            </jalios:if>
            <jalios:if predicate="<%= Util.notEmpty(date) %>">
                <p class="ds44-textLegend"><%= JcmsUtil.glp(userLang, "jcmsplugin.socle.publiele", date) %></p>
            </jalios:if>
            <%-- Si vidéo au lieu de l'image, alors le chapo apparait au-dessus de la vidéo --%>
            <jalios:if predicate='<%=Util.notEmpty(urlVideo) && Util.notEmpty(chapo) %>'>
                <div class="ds44-introduction">
                    <jalios:wysiwyg><%=chapo%></jalios:wysiwyg>
                </div>
            </jalios:if>
        </div>
    </div>
</div>
<jalios:select>
   <jalios:if predicate="<%=Util.notEmpty(urlVideo)%>">
      <div class="ds44-img50">
         <div class="ds44-inner-container">
            <div class="ds44-grid12-offset-1">
               <!-- <div class="ds44-js-youtube-video" data-video-id="<%= videoId %>"> -->
               <div>
                  <div class="ds44-cookie-overlay-container">
                     <div class="ds44-video-container">
                        <iframe type="opt-in" data-name="streaming-video" data-src="<%= urlVideo %>" title='<%= HttpUtil.encodeForHTMLAttribute(JcmsUtil.glp(userLang, "jcmsplugin.socle.video.acceder", titreVideo)) %>' style="width: 100%; height: 480px; border: none;" allowfullscreen></iframe>
                     </div>
                     <div class="ds44-media-overlay" style="display: none;">
		               <div class="ds44-msg-media-desactive">
		                  <p><%= JcmsUtil.glp(userLang, "jcmsplugin.socle.videodesactivee") %></p>
		                  <p><%= JcmsUtil.glp(userLang, "jcmsplugin.socle.devezaccepterdepotcookie") %></p>
		                  <button class="ds44-btnStd ds44-btn--contextual" data-consent="accept-streaming-cookie">
		                      <span class="ds44-btnInnerText"><%= JcmsUtil.glp(userLang, "jcmsplugin.socle.acceptercookies") %></span>
		                      <i class="icon icon-long-arrow-right" aria-hidden="true"></i>
		                  </button>
		               </div>
		            </div>
                  </div>
                  <jalios:if predicate="<%=Util.notEmpty(fichierTranscriptVideo)%>">
                     <p><a href="<%= fichierTranscriptVideo %>" target="_blank" title="<%= HttpUtil.encodeForHTMLAttribute(JcmsUtil.glp(userLang, "jcmsplugin.socle.video.telecharger-transcript.title", titreVideo,typeFichierTranscript,tailleFichierTranscript)) %>"><%= JcmsUtil.glp(userLang,"jcmsplugin.socle.video.telecharger-transcript.label") %></a></p>
                  </jalios:if>
               </div>
            </div>
         </div>
      </div>
   </jalios:if>
   <jalios:if predicate="<%=Util.notEmpty(imagePath)%>">
      <div class="ds44-img50">
         <div class="ds44-inner-container">
            <div class="ds44-grid12-offset-1">
               <ds:figurePicture pub="<%= pub %>" imgCss="ds44-w100 ds44-imgRatio" pictureCss="ds44-legendeContainer ds44-container-imgRatio" format="principale" image="<%= imagePath %>" imageMobile="<%= mobileImagePath %>" alt="<%= alt %>" copyright="<%= copyright %>" legend="<%= legend %>"/>
            </div>
         </div>
      </div>
   </jalios:if>
</jalios:select>