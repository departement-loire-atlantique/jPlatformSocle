<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file='/jcore/doInitPage.jsp'%>

<section class="ds44-modal-container" id="overlay-sites-applis" aria-hidden="true" role="dialog" aria-labelledby="titre-modale-sites-applis">
    <div class="ds44-modal-box">
        <button class="ds44-btnOverlay--modale ds44-btnOverlay--closeOverlay" type="button" title="<%= glp("jcmsplugin.socle.ficheaide.fermerboitedialogue.label", glp("jcmsplugin.socle.sitesapplis")) %>" data-js="ds44-modal-action-close"><i class="icon icon-cross icon--xlarge" aria-hidden="true"></i><span class="ds44-btnInnerText--bottom"><%= glp("jcmsplugin.socle.fermer") %></span></button>
        <h1 class="h2-like" id="titre-modale-sites-applis"><%= glp("jcmsplugin.socle.sitesapplis") %></h1>
        <div class="ds44-modal-gab">
            <%@include file="sitesEtApplis.jspf" %>
        </div>
    </div>
</section>
        