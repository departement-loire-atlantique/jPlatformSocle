<%@ taglib uri="jcms.tld" prefix="jalios" %>
<%@ tag 
    pageEncoding="UTF-8"
    description="Card" 
    body-content="scriptless" 
    import="com.jalios.jcms.Channel, com.jalios.util.ServletUtil, com.jalios.util.Util"
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
<%@ attribute name="breadcrumb"
    required="false"
    fragment="false"
    rtexprvalue="true"
    type="Boolean"
    description="Indique si le fil d'ariane doit être affiché"
%>

<div class="ds44-pageHeaderContainer">
    <picture class="ds44-pageHeaderContainer__pictureContainer">
        <jalios:if predicate="<%= Util.notEmpty(imagePath) %>">
            <source media="(max-width: 36em)" srcset="<%=mobileImagePath%>">
            <source media="(min-width: 36em)" srcset="<%=imagePath%>">
            <img src="<%=imagePath%>" alt="" class="ds44-headerImg" />
        </jalios:if>
    </picture>
    
    <div class="ds44-titleContainer">
        <div class="ds44-alphaGradient ds44--xl-padding">
            <!-- Fil d'ariane -->
            <jalios:if predicate='<%=breadcrumb && Util.notEmpty(Channel.getChannel().getProperty("jcmsplugin.socle.portlet.filariane.id")) %>'>
                <jalios:include id='<%=Channel.getChannel().getProperty("jcmsplugin.socle.portlet.filariane.id") %>'/>
            </jalios:if>
            <h1 class="h1-like ds44-text--colorInvert"><%=title %></h1>
        </div>
    </div>
</div>