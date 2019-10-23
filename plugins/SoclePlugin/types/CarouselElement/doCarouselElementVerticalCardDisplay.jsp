<%@ page contentType="text/html; charset=UTF-8" %><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
%><%@ include file='/jcore/media/mediaTemplateInit.jspf' %><%
%><%
CarouselElement obj = (CarouselElement)request.getAttribute(PortalManager.PORTAL_PUBLICATION); %><%
%>

<%-- Affichage en tuile verticale
    L'affichage en contexte "fond sombre" est géré via un attribut de requête positionné par le parent
    (portlet décoration par ex). 
--%>
<%
// Détermination du contexte d'affichage
String cardStyle="";
if("dark".equals(request.getAttribute("background-style"))){
    cardStyle="ds44-darkContext";
}
%>
<%@include file="doCarouselElement.jspf" %>

<section class="ds44-card ds44-card--verticalPicture <%=cardStyle %>">
    <jalios:if predicate="<%=Util.notEmpty(urlCard)%>">
        <a href="<%= urlCard %>" class="ds44-card__globalLink" title="<%= title.toString() %>" <%=target%>>
    </jalios:if>
    <jalios:if predicate='<%=Util.notEmpty(obj.getDataImage()) %>'>
        <picture>
            <img src="<%=obj.getDataImage() %>" alt="<%= altValue.toString() %>" />
        </picture>
    </jalios:if>
    <div class="ds44-card__section">
        <p role="heading" aria-level="2" class="ds44-card__title"><%=obj.getTitle()%></p>
            
     <jalios:if predicate="<%=Util.notEmpty(obj.getSummary()) %>">
         <p><%=obj.getSummary()%></p>
     </jalios:if>        
     <jalios:if predicate="<%=obj.getInternalLink() instanceof FileDocument %>">
         <% FileDocument fd = (FileDocument) obj.getInternalLink();%>
         <p class="ds44-cardFile"><%=fd.getGenericContentType().toUpperCase()%> - <%= Util.formatFileSize(fd.getSize(), userLocale) %></p>
     </jalios:if>
    </div>
    <jalios:if predicate="<%=Util.notEmpty(urlCard)%>">
        </a>
    </jalios:if>
</section>