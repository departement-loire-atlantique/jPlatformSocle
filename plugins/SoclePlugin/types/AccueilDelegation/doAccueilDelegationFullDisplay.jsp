<%@ page contentType="text/html; charset=UTF-8" %><%
%><%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
%><% AccueilDelegation obj = (AccueilDelegation)request.getAttribute(PortalManager.PORTAL_PUBLICATION); %><%
%><%@ include file='/front/doFullDisplay.jspf' %>

<main id="content" role="main">

    <ds:titleDelegation copyright="<%= obj.getCopyright() %>" legend="<%= obj.getLegende() %>" imagePath="<%= obj.getImagePrincipale() %>" mobileImagePath="<%= obj.getImageMobile() %>" title="<%= obj.getTitle() %>" alt="<%= obj.getTexteAlternatif() %>" breadcrumb="true" delegation="<%= obj.getDelegation() %>" cartePath="<%= obj.getImageCarte() %>"/>
            
    <%-- Rechercher contact ou aide --%>
    <%-- TODO --%>
    <jalios:if predicate="<%= Util.notEmpty(obj.getTitreAnnuaire()) || Util.notEmpty(obj.getIntroAnnuaire()) %>">
    <section class="ds44-container-fluid ds44-mtb3 ds44--xl-padding-tb">
        <div class="ds44-inner-container">
            <header class="txtcenter">
                <jalios:if predicate="<%= Util.notEmpty(obj.getTitreAnnuaire()) %>">
                <h2 class="h2-like center"><%= obj.getTitreAnnuaire() %></h2>
                </jalios:if>
                <jalios:if predicate="<%= Util.notEmpty(obj.getIntroAnnuaire()) %>">
                <div class="ds44-component-chapo ds44-centeredBlock"><jalios:wysiwyg><%= obj.getIntroAnnuaire() %></jalios:wysiwyg></h2>
                </jalios:if>
            </header>
        </div>
    </section>
    </jalios:if>
    
    
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
    
    <jalios:include pub="<%= obj.getPortletCarrouselAgenda() %>" usage="box"/>
</main>