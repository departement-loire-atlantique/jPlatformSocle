<%@ page contentType="text/html; charset=UTF-8" %><%
%><%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
%><% AccueilAnnuaireAgenda obj = (AccueilAnnuaireAgenda)request.getAttribute(PortalManager.PORTAL_PUBLICATION); %><%
%>

<main id="content" role="main">
    <section class="ds44-container-large">
        <ds:titleBanner imagePath="<%= obj.getImageBandeau() %>" mobileImagePath="<%= obj.getImageMobile() %>" title="<%= obj.getTitle() %>"
            legend="<%= obj.getLegende() %>" copyright="<%= obj.getLegende() %>" breadcrumb="true"></ds:titleBanner>
    </section>
</main>