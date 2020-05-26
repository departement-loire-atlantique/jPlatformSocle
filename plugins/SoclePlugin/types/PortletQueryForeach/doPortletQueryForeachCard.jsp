<%@ include file="/jcore/doInitPage.jspf" %>
<%@ include file="/jcore/portal/doPortletParams.jspf" %>
<% PortletQueryForeach box = (PortletQueryForeach) portlet;  %>

<%@ include file="/types/PortletQueryForeach/doQuery.jspf" %>
<%@ include file="/types/PortletQueryForeach/doSort.jspf" %>

<%@ include file="/types/PortletQueryForeach/doForeachHeader.jspf" %>

<%-- POUR RECETTE DE GABARITS "CARD" UNIQUEMENT !!!

    Présente les contenus selon leur gabarit "card" : card / cardFull / cardFocus
    Si un gabarit n'a pas été défini pour un type de contenu, rien ne s'affiche.
    On défini pour cela un gabarit vide pour le type "Publication", sinon
    JCMS affiche un gabarit par défaut.
    
    media.data-template.card.Publication: /plugins/SoclePlugin/jsp/cards/doEmptyCard.jsp    
 --%>
<%=itPub.getTypeLabel(userLang) %>
<div style="max-width:300px;"><jalios:media data='<%=itPub %>' template='card' /></div>
<div style="max-width:300px;"><jalios:media data='<%=itPub %>' template='cardFull' /></div>
<div style="max-width:300px;"><jalios:media data='<%=itPub %>' template='cardFocus' /></div>
<div style="max-width:370px;"><jalios:media data='<%=itPub %>' template='tuileHorizontaleGrey' /></div>

<%@ include file="/types/PortletQueryForeach/doForeachFooter.jspf" %>
<%@ include file="/types/PortletQueryForeach/doPager.jspf" %>
