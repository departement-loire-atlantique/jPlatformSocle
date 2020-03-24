<%@ taglib uri="jcms.tld" prefix="jalios" %>
<%@ tag 
    pageEncoding="UTF-8"
    description="Carrousel à quatre tuiles (En ce moment...)" 
    body-content="scriptless" 
    import="com.jalios.jcms.Channel, com.jalios.util.ServletUtil, com.jalios.util.Util, com.jalios.jcms.Content,
    generated.PortletCarousel, com.jalios.jcms.context.JcmsContext, com.jalios.jcms.context.JcmsJspContext,
    com.jalios.jcms.TypeTemplateEntry"
%>
<%@ attribute name="promotedPubArray"
    required="false"
    fragment="false"
    rtexprvalue="true"
    type="Content[]"
    description="Liste de publications mises en avant pour le carrousel"
%>
<%@ attribute name="pubArray"
    required="false"
    fragment="false"
    rtexprvalue="true"
    type="Content[]"
    description="Liste de publications pour le carrousel"
%>
<%@ attribute name="carrouselPortlet"
    required="false"
    fragment="false"
    rtexprvalue="true"
    type="PortletCarousel"
    description="Portlet Carrousel"
%>
<%@ attribute name="gabarit"
    required="false"
    fragment="false"
    rtexprvalue="true"
    type="String"
    description="Déclaration du gabarit pour le carrousel"
%>
<%@ attribute name="theme"
    required="false"
    fragment="false"
    rtexprvalue="true"
    type="String"
    description="Déclaration du theme pour le carrousel"
%>
<jalios:select>
    <jalios:if predicate="<%= Util.notEmpty(carrouselPortlet) && Util.isEmpty(pubArray) %>">
        <%
        // Surcharger les contenus mis en avant
        if (Util.notEmpty(promotedPubArray)) {
          carrouselPortlet.setContenusEnAvant(promotedPubArray);
        }
        %>
    
        <%-- Afficher la portlet --%>
        <jalios:include pub="<%= carrouselPortlet %>"/>
    </jalios:if>
    <jalios:if predicate="<%= Util.notEmpty(pubArray) && Util.notEmpty(gabarit) %>">
        <%-- Afficher la liste de données en dessous --%>
        <%
        
        String themeCarousel = Util.notEmpty(theme) ? theme : "darkContext";
        
        PortletCarousel tmpPortlet = new PortletCarousel();
        tmpPortlet.setTemplate(gabarit);
        tmpPortlet.setFirstPublications(pubArray);
        tmpPortlet.setSelectionDuTheme(themeCarousel);
        
        if (Util.notEmpty(promotedPubArray)) {
          tmpPortlet.setContenusEnAvant(promotedPubArray);
        }
        %>
        <jalios:include pub="<%= tmpPortlet %>"/>
    </jalios:if>
</jalios:select>