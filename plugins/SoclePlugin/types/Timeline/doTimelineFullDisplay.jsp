<%@ page contentType="text/html; charset=UTF-8" %><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
%><% Timeline obj = (Timeline)request.getAttribute(PortalManager.PORTAL_PUBLICATION); %><%
%><%@ include file='/front/doFullDisplay.jspf' %>

<section class="ds44-container-large">

    <header class="txtcenter ds44--xxl-padding-b">
        <h2 class="h2-like center">Titre timeline</h2>
    </header>

    <nav class="ds44-theme txtcenter ds44--xl-padding ds44-timeline_index ds44-mtb5" aria-label="Barre de navigation secondaire">
        <p class="inbl">Aller à :</p>
        <ul class="ds44-list">
            <%-- générer automatiquement sur la liste des éléments --%>
            <li><a href="#time_elem1">Contexte</a></li>
            <li><a href="#time_elem2">Étude</a></li>
            <li><a href="#time_elem3">Aménagement</a></li>
        </ul>
    </nav>

    <div class="ds44-inner-container">

        <div class="ds44-timeline_container">

            <%-- Affichage des éléments --%>

        </div>

    </div>
</section>