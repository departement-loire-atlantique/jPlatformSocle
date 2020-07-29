<%@tag import="fr.cg44.plugin.socle.SocleUtils"%>
<%@ taglib prefix="ds" tagdir="/WEB-INF/tags" %><%
%><%@ taglib uri="jcms.tld" prefix="jalios" %><%
%><%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%><%
%><%@ tag 
    pageEncoding="UTF-8"
    description="Bannière push" 
    body-content="scriptless" 
    import="com.jalios.jcms.Channel, com.jalios.util.ServletUtil, com.jalios.util.Util, com.jalios.jcms.JcmsUtil, com.jalios.jcms.HttpUtil"
%>
<%@ attribute name="title"
    required="true"
    fragment="false"
    rtexprvalue="true"
    type="String"
    description="Le titre"
%>
<%@ attribute name="subtitle"
    required="false"
    fragment="false"
    rtexprvalue="true"
    type="String"
    description="Le sous-titre"
%>
<%@ attribute name="linkLabel"
    required="false"
    fragment="false"
    rtexprvalue="true"
    type="String"
    description="Le libellé du lien"
%>
<%@ attribute name="linkUrl"
    required="false"
    fragment="false"
    rtexprvalue="true"
    type="String"
    description="L'URL du lien"
%>
<%@ attribute name="linkTitle"
    required="false"
    fragment="false"
    rtexprvalue="true"
    type="String"
    description="Le titre du lien (attribut 'title')"
%>
<%@ attribute name="newTab"
    required="false"
    fragment="false"
    rtexprvalue="true"
    type="Boolean"
    description="Indique si le lien sur la carte s'ouvre dans un nouvel onglet"
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
<%@ attribute name="bgstyle"
    required="true"
    fragment="false"
    rtexprvalue="true"
    type="String"
    description="Le style de fond à appliquer (triangle|circle|wave)"
%>

<%
String userLang = Channel.getChannel().getCurrentUserLang();
String targetAttr = "";
String titleAttr = "";
String background = "";

switch (bgstyle) {
	case "triangle":
		background = "ds44-bgTriangle-left";
		break;
	case "circle":
		background = "ds44-bgCircle";
		break;
	case "wave":
		background = "ds44-wave-white";
		break;
}

// Accessibilité : on place un attribut "title" sur le lien uniquement si il s'ouvre dans une nouvelle fenêtre
if (newTab == true) {
	targetAttr = "target=\"_blank\"";

	if (Util.notEmpty(linkTitle)) {
		titleAttr = " title=\"" + HttpUtil.encodeForHTMLAttribute(linkTitle) + "\" ";
	}
}
%>


<div class="ds44-box ds44-theme <%= background %>">
    <div class="ds44-flex-container ds44-flex-container--colMed ds44-flex-container--colMed--colRev">
        <jalios:if predicate="<%= Util.notEmpty(imagePath) || Util.notEmpty(mobileImagePath) %>">
            <picture class="ds44-boxPushPic ds44-boxPushPic--horizontal">
                <jalios:if predicate="<%= Util.notEmpty(mobileImagePath) %>">
                    <source media="(max-width: 36em)" srcset="<%=mobileImagePath%>">
                </jalios:if>
                <jalios:if predicate="<%= Util.notEmpty(imagePath) %>">
                    <source media="(min-width: 36em)" srcset="<%=imagePath%>">
                    <img src="<%= imagePath %>" alt="">
                </jalios:if>
            </picture>
        </jalios:if>
        <div class="ds44-boxPushContent ds44-boxPushContent--fluid">
            <div class="ds44-titlePushH"><p class="ds44-pushTitle" role="heading" aria-level="2"><%= title %></p></div>
            <jalios:if predicate="<%= Util.notEmpty(subtitle) %>">
                <div class="ds44-contentPushH"><div class="txtcenter"><%= subtitle %></div></div>
            </jalios:if>
            <jalios:if predicate="<%= Util.notEmpty(linkUrl) %>">
                <div class="ds44-contentPushH">
                    <p>
                        <a class="ds44-btnStd" href="<%= linkUrl %>" <%= targetAttr %> <%= titleAttr %>>
                            <span class="ds44-btnInnerText"><%= linkLabel %></span>
                            <i class="icon icon-long-arrow-right" aria-hidden="true"></i>
                        </a>
                    </p>
                </div>
            </jalios:if>
        </div>
    </div>
</div>