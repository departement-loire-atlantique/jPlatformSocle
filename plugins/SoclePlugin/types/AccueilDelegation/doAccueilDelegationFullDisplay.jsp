<%@ page contentType="text/html; charset=UTF-8" %><%
%><%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
%><% AccueilDelegation obj = (AccueilDelegation)request.getAttribute(PortalManager.PORTAL_PUBLICATION); %><%
%><%@ include file='/front/doFullDisplay.jspf' %>

<main id="content" role="main">


    <ds:titleDelegation imagePath="<%= obj.getImagePrincipale() %>" mobileImagePath="<%= obj.getImageMobile() %>" 
            title="<%= obj.getTitle() %>" legend="<%= obj.getLegende() %>" 
            copyright="<%= obj.getCopyright() %>" alt="<%= obj.getTexteAlternatif() %>" breadcrumb="true"></ds:titleDelegation>
            
    <%-- Rechercher contact ou aide --%>
    <%-- TODO --%>
    
    <%-- En ce moment --%>
    <%
    PortletCarousel carouselEnCeMoment = new PortletCarousel();
    carouselEnCeMoment.setTitreDuBloc(obj.getTitreActus());
    carouselEnCeMoment.setSoustitreDuBloc(obj.getIntroActus());
    carouselEnCeMoment.setFirstPublications(obj.getCarrouselActualites());
    carouselEnCeMoment.setContenusEnAvant(obj.getAlaUne());
    carouselEnCeMoment.setTemplate("box.sliderQuatre");
    carouselEnCeMoment.setSelectionDuTheme("darkContext");
    %>
    <jalios:include pub="<%= carouselEnCeMoment %>"/>
    
    <%-- TODO vos rendez-vous --%>
</main>