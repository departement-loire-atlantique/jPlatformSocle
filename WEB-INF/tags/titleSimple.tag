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
        com.jalios.jcms.taglib.ThumbnailTag, com.jalios.io.ImageFormat, generated.Video, com.jalios.jcms.FileDocument"
%>
<%@ attribute name="title"
    required="true"
    fragment="false"
    rtexprvalue="true"
    type="String"
    description="Le titre affiché sur l'image"
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
    required="true"
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

<%
String userLang = Channel.getChannel().getCurrentUserLang();
String uid = ServletUtil.generateUniqueDOMId(request, "uid");

boolean hasFigcaption = Util.notEmpty(legend) || Util.notEmpty(copyright);

//Récupération des infos de vidéo, dans la cas d'une fiche article ou actu
String titreVideo = "";
String urlVideo = "";
String fichierTranscriptVideo = "";
String typeFichierTranscript = "";
String tailleFichierTranscript = "";
if(Util.notEmpty(video)) {
	titreVideo = video.getTitle();
	urlVideo = Util.decodeUrl(VideoUtils.buildYoutubeUrl(video.getUrlVideo()));
	
	// Récupération des infos du fichier de transcription
	if(Util.notEmpty(video.getFichierTranscript())){
		fichierTranscriptVideo = video.getFichierTranscript().getDownloadUrl();
		typeFichierTranscript = FileDocument.getExtension(video.getFichierTranscript().getFilename()).toUpperCase();
		tailleFichierTranscript = Util.formatFileSize(video.getFichierTranscript().getSize());
	}
}

%>

<div class="ds44-lightBG">
    <div class="ds44-inner-container ds44--xl-padding-t ds44--m-padding-b ds44-mobile-reduced-pt">
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
	                <iframe title="<%= titreVideo %>" style="width: 100%; height: 480px; border: none;" src="<%= urlVideo %>" allowfullscreen></iframe>
                    <jalios:if predicate="<%=Util.notEmpty(fichierTranscriptVideo)%>">
				        <a href="<%= fichierTranscriptVideo %>" target="_blank" title="<%= JcmsUtil.glp(userLang, "jcmsplugin.socle.video.telecharger-transcript.title", titreVideo,typeFichierTranscript,tailleFichierTranscript) %>"><%= JcmsUtil.glp(userLang,"jcmsplugin.socle.video.telecharger-transcript.label") %></a>
				    </jalios:if>
                </div>
	        </div>
	    </div>
	</jalios:if>
	<jalios:if predicate="<%=Util.notEmpty(imagePath)%>">
	    <div class="ds44-img50">
	        <div class="ds44-inner-container">
	            <div class="ds44-grid12-offset-1">
	                <ds:figurePicture imgCss="ds44-w100 ds44-imgRatio" pictureCss="ds44-legendeContainer ds44-container-imgRatio" format="bandeau" 
	                   pub="<%= Channel.getChannel().getPublication(uid) %>" imageMobile="<%= mobileImagePath %>" alt="<%= alt %>" copyright="<%= copyright %>" legend="<%= legend %>"/>
				</div>
	        </div>
	    </div>
	</jalios:if>
</jalios:select>