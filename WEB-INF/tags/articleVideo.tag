<%@tag import="com.jalios.jcms.context.JcmsContext"%>
<%@tag import="com.jalios.util.Browser"%>
<%@ taglib uri="jcms.tld" prefix="jalios" %>
<%@ tag 
    pageEncoding="UTF-8"
    description="Video Article" 
    body-content="scriptless" 
    import="com.jalios.jcms.Channel, generated.Video, com.jalios.util.Util"
%>
<%@ attribute name="video"
    required="true"
    fragment="false"
    rtexprvalue="true"
    type="generated.Video"
    description="Video"
%>
<%@ attribute name="title"
    required="false"
    fragment="false"
    rtexprvalue="true"
    type="String"
    description="Titre"
%>
<%@ attribute name="intro"
    required="false"
    fragment="false"
    rtexprvalue="true"
    type="String"
    description="Introduction"
%>
<%
String titreVideo = title;
if (Util.isEmpty(titreVideo)) titreVideo = video.getTitle();
request.setAttribute("overrideVidTitle", titreVideo);
%>
<section id="contentVideo" class="ds44-contenuArticle">
	<div class="ds44-inner-container ds44-mtb3">
		<div class="ds44-grid12-offset-2">
		    <jalios:if predicate="<%= Util.notEmpty(titreVideo) %>">
			    <h3 class="h3-like" id="titreVideo"><%= titreVideo %></h3>
			</jalios:if>
            <jalios:if predicate="<%= Util.notEmpty(intro) %>">
                <jalios:wysiwyg><%= intro %></jalios:wysiwyg>
            </jalios:if>
			<jalios:media data='<%= video %>' />
		</div>
	</div>
</section>
