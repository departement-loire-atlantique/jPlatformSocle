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
<%@ attribute name="hideTitle"
    required="false"
    fragment="false"
    rtexprvalue="true"
    type="Boolean"
    description="Cache le titre si true"
%>
<%@ attribute name="noOffset"
    required="false"
    fragment="false"
    rtexprvalue="true"
    type="Boolean"
    description="Ne pas ajouter un bloc 'grid' si à true"
%>
<%
if (Util.notEmpty(title)) {
  request.setAttribute("overrideVidTitle", title);
}

if (Util.notEmpty(intro)) {
  request.setAttribute("overrideVidIntro", intro);
}
if (Util.notEmpty(hideTitle)) {
  request.setAttribute("hideVideoTitle", hideTitle);
}
%>
<section id="contentVideo" class="ds44-contenuArticle">
	<div class="ds44-inner-container ds44-mtb3">
	    <jalios:if predicate="<%= !noOffset %>">
		<div class="ds44-grid12-offset-2">
		</jalios:if>
			<jalios:media data='<%= video %>' />
        <jalios:if predicate="<%= !noOffset %>">
		</div>
		</jalios:if>
	</div>
</section>
