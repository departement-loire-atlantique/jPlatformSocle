<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file='/jcore/doInitPage.jspf'%>
<%-- Gabarit utilisé pour l'insertion unifiée, pour insérer un seul contact.
    Génère le contact et son conteneur HTML (section/ div)--%>
    
<% FicheLieu obj = (FicheLieu) request.getAttribute(PortalManager.PORTAL_PUBLICATION);%>

<section class="ds44-box">
    <jalios:media data="<%=obj %>" template="contact"/>
</section>

