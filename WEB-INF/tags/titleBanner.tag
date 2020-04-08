<%@tag import="fr.cg44.plugin.socle.SocleUtils"%>
<%@ taglib uri="jcms.tld" prefix="jalios" %>
<%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%>
<%@ tag 
    pageEncoding="UTF-8"
    description="Titre du header avec image" 
    body-content="scriptless" 
    import="com.jalios.jcms.Channel, com.jalios.util.ServletUtil, com.jalios.util.Util"
%>
<%@ attribute name="pubId"
    required="true"
    fragment="false"
    rtexprvalue="true"
    type="String"
    description="L'ID de la publication courante"
%>
<%@ attribute name="title"
    required="true"
    fragment="false"
    rtexprvalue="true"
    type="String"
    description="Le titre affiché sur l'image"
%>
<%@ attribute name="imagePath"
    required="true"
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
<%@ attribute name="breadcrumb"
    required="false"
    fragment="false"
    rtexprvalue="true"
    type="Boolean"
    description="Indique si le fil d'ariane doit être affiché"
%>

<%
String uid = ServletUtil.generateUniqueDOMId(request, "uid");
boolean hasFigcaption = Util.notEmpty(legend) || Util.notEmpty(copyright);

String formattedImagePath = SocleUtils.getUrlOfFormattedImageBandeau(imagePath);
String formattedMobilePath = SocleUtils.getUrlOfFormattedImageMobile(mobileImagePath);
if (Util.isEmpty(formattedMobilePath)) {
  formattedMobilePath = SocleUtils.getUrlOfFormattedImageMobile(imagePath);
}
%>

<div class="ds44-pageHeaderContainer">
    <ds:figurePicture figureCss="ds44-pageHeaderContainer__pictureContainer" pictureCss="ds44-pageHeaderContainer__pictureContainer" imgCss="ds44-headerImg"
        legend="<%= legend %>" copyright="<%= copyright %>" alt="<%= title %>" pub="<%= Channel.getChannel().getPublication(pubId) %>" imageMobile="<%= mobileImagePath %>" format="bandeau" />
    
    <div class="ds44-titleContainer">
        <div class="ds44-alphaGradient ds44-alphaGradient--header">
            <!-- Fil d'ariane -->
            <jalios:if predicate='<%=breadcrumb && Util.notEmpty(Channel.getChannel().getProperty("jcmsplugin.socle.portlet.filariane.id")) %>'>
                <%request.setAttribute("textColor","invert"); %>
                <jalios:include id='<%=Channel.getChannel().getProperty("jcmsplugin.socle.portlet.filariane.id") %>'/>
            </jalios:if>
            <h1 class="h1-like ds44-text--colorInvert"><%=title %></h1>
        </div>
    </div>
</div>