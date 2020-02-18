<%@ taglib uri="jcms.tld" prefix="jalios" %>
<%@ tag 
    pageEncoding="UTF-8"
    description="Carrousel à quatre tuiles (En ce moment...)" 
    body-content="scriptless" 
    import="com.jalios.jcms.Channel, com.jalios.util.ServletUtil, com.jalios.util.Util, com.jalios.jcms.Content,
    generated.PortletQueryForeach, com.jalios.jcms.context.JcmsContext, com.jalios.jcms.context.JcmsJspContext,
    com.jalios.jcms.TypeTemplateEntry"
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
    type="PortletQueryForeach"
    description="Portlet Carrousel"
%>
<%@ attribute name="gabarit"
    required="false"
    fragment="false"
    rtexprvalue="true"
    type="String"
    description="Déclaration du gabarit pour le carrousel"
%>
<jalios:select>
    <jalios:if predicate="<%= (Util.isEmpty(pubArray) && Util.isEmpty(carrouselPortlet)) || (Util.notEmpty(pubArray) && Util.notEmpty(carrouselPortlet)) %>">
        <%-- Ne rien afficher --%>
    </jalios:if>
    <jalios:if predicate="<%= Util.notEmpty(carrouselPortlet) %>">
        <%-- Afficher la portlet --%>
        <jalios:include pub="<%= carrouselPortlet %>"/>
    </jalios:if>
    <jalios:if predicate="<%= Util.notEmpty(pubArray) && Util.notEmpty(gabarit) %>">
        <%-- Afficher la liste de données en dessous --%>
        <%
        
        PortletQueryForeach tmpPortlet = new PortletQueryForeach();
        tmpPortlet.setTemplate(gabarit);
        tmpPortlet.setFirstPublications(pubArray);
        %>
        <jalios:include pub="<%= tmpPortlet %>"/>
    </jalios:if>
</jalios:select>