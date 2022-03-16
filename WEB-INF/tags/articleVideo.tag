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
<%@ attribute name="hideChapitrage"
    required="false"
    fragment="false"
    rtexprvalue="true"
    type="Boolean"
    description="Cache le chapitrage si true"
%>
<%@ attribute name="noOffset"
    required="false"
    fragment="false"
    rtexprvalue="true"
    type="Boolean"
    description="Ne pas ajouter un bloc 'grid' si à true"
%>
<%@ attribute name="noChapo"
    required="false"
    fragment="false"
    rtexprvalue="true"
    type="Boolean"
    description="Ne pas ajouter le chapo si à true"
%>
<%@ attribute name="forcedHeight"
    required="false"
    fragment="false"
    rtexprvalue="true"
    type="String"
    description="Valeur forcée pour le height du iframe"
%>
<%@ attribute name="offsetLevel"
    required="false"
    fragment="false"
    rtexprvalue="true"
    type="Integer"
    description="Valeur custom pour le offset du conteneur"
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
if (Util.notEmpty(hideChapitrage)) {
    request.setAttribute("hideChapitrage", hideChapitrage);
}
if (Util.notEmpty(forcedHeight)) {
    request.setAttribute("forcedHeight", forcedHeight);
}
if (Util.notEmpty(noChapo)) {
    request.setAttribute("noChapo", noChapo);
}
boolean addOffest = Util.notEmpty(noOffset) ? !noOffset : true;

String offsetContainerClass = "ds44-grid12-offset-2";
if (Util.notEmpty(offsetLevel)) {
    offsetContainerClass = "ds44-grid12-offset-" + offsetLevel;
}
%>
<section class="ds44-contenuMedia">
	<div class="ds44-inner-container ds44-mtb3">
	    <jalios:if predicate="<%= addOffest %>">
		<div class="<%= offsetContainerClass %>">
		</jalios:if>
			<jalios:media data='<%= video %>' />
        <jalios:if predicate="<%= addOffest %>">
		</div>
		</jalios:if>
	</div>
</section>
