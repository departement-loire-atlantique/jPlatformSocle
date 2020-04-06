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
<section id="contentVideo" class="ds44-contenuArticle">
	<div class="ds44-inner-container ds44-mtb3">
		<div class="ds44-grid12-offset-2">
			<jalios:select>
				<jalios:if predicate="<%= Util.notEmpty(title) %>">
					<h3 class="h3-like" id="titreVideo"><%= title %></h2>
				</jalios:if>
				<jalios:if predicate="<%= Util.notEmpty(video.getTitle()) %>">
					<h3 class="h3-like" id="titreVideo"><%= video.getTitle() %></h3>
				</jalios:if>
			</jalios:select>
            <jalios:if predicate="<%= Util.notEmpty(intro) %>">
                <jalios:wysiwyg><%= intro %></jalios:wysiwyg>
            </jalios:if>
			<jalios:media data='<%= video %>' />
		</div>
	</div>
</section>
