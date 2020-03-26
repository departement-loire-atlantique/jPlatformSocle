<%@tag import="fr.cg44.plugin.socle.SocleUtils"%>
<%@ taglib prefix="ds" tagdir="/WEB-INF/tags" %><%
%><%@ taglib uri="jcms.tld" prefix="jalios" %><%
%><%@ tag 
    pageEncoding="UTF-8"
    description="Titre du header simple" 
    body-content="scriptless" 
    import="com.jalios.jcms.Channel, com.jalios.util.ServletUtil, com.jalios.util.Util, com.jalios.jcms.JcmsUtil, 
        com.jalios.jcms.taglib.ThumbnailTag, com.jalios.io.ImageFormat"
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
<%@ attribute name="urlVideo"
    required="false"
    fragment="false"
    rtexprvalue="true"
    type="String"
    description="L'URL de la vidéo"
%>
<%@ attribute name="titreVideo"
    required="false"
    fragment="false"
    rtexprvalue="true"
    type="String"
    description="Le titre la vidéo"
%>
<%@ attribute name="fichierTranscript"
    required="false"
    fragment="false"
    rtexprvalue="true"
    type="String"
    description="Le chemin du fichier de transcription"
%>
<%@ attribute name="typeFichierTranscript"
    required="false"
    fragment="false"
    rtexprvalue="true"
    type="String"
    description="Le format du fichier de transcription"
%>
<%@ attribute name="tailleFichierTranscript"
    required="false"
    fragment="false"
    rtexprvalue="true"
    type="String"
    description="La taille du fichier de transcription"
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
                    <jalios:if predicate="<%=Util.notEmpty(fichierTranscript)%>">
				        <a href="<%= fichierTranscript %>" target="_blank" title="<%= JcmsUtil.glp(userLang, "jcmsplugin.socle.video.telecharger-transcript.title", titreVideo,typeFichierTranscript,tailleFichierTranscript) %>"><%= JcmsUtil.glp(userLang,"jcmsplugin.socle.video.telecharger-transcript.label") %></a>
				    </jalios:if>
                </div>
	        </div>
	    </div>
	</jalios:if>
	<jalios:if predicate="<%=Util.notEmpty(imagePath)%>">
	<% 
	String formattedImagePath = SocleUtils.getUrlOfFormattedImageBandeau(imagePath);
	String formattedMobilePath = SocleUtils.getUrlOfFormattedImageMobile(mobileImagePath);;
	if (Util.isEmpty(formattedMobilePath)) {
	  formattedMobilePath = SocleUtils.getUrlOfFormattedImageMobile(imagePath);
	}
	%>
	    <div class="ds44-img50">
	        <div class="ds44-inner-container">
	            <div class="ds44-grid12-offset-1">
	                <jalios:if predicate="<%= hasFigcaption%>">
	                    <figure role="figure">
	                </jalios:if>
		            <picture class="ds44-legendeContainer ds44-container-imgRatio" role="figure" aria-label='<%= legend %> <%= JcmsUtil.glp(userLang, "jcmsplugin.socle.symbol.copyright") %> <%= copyright %>'>
				        <jalios:if predicate="<%= Util.notEmpty(formattedMobilePath) %>">
				            <source media="(max-width: 36em)" srcset="<%=formattedMobilePath%>">
				        </jalios:if>
				        <source media="(min-width: 36em)" srcset="<%=formattedImagePath%>">
				        <img src="<%=formattedImagePath%>" alt='<%= Util.isEmpty(alt) ? JcmsUtil.glp(userLang, "jcmsplugin.socle.illustration") : alt %>' class="ds44-w100 ds44-imgRatio" id="<%=uid%>"/>
	                </picture>
	                <jalios:if predicate="<%= hasFigcaption%>">
	                    <figcaption class="ds44-imgCaption">
	                        <jalios:if predicate="<%= Util.notEmpty(legend)%>">
	                            <%=legend%>
	                        </jalios:if>
	                        <jalios:if predicate="<%= Util.notEmpty(copyright)%>">
	                            © <%=copyright%>
	                        </jalios:if>
	                    </figcaption>
	                  </figure>
	                </jalios:if>
				</div>
	        </div>
	    </div>
	</jalios:if>
</jalios:select>