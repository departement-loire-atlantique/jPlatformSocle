<%@ page contentType="text/html; charset=UTF-8" %><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
%><% AccueilAnnuaireAgenda obj = (AccueilAnnuaireAgenda)request.getAttribute(PortalManager.PORTAL_PUBLICATION); %><%
%>
<jalios:select>
    <jalios:if predicate="<%= obj.getTypeAnnuaire() %>">
        <%-- Affichage annuaire --%>
        <jalios:include pub="<%= obj %>" usage="annuaire"/>
    </jalios:if>
    <jalios:default>
        <%-- Affichage agenda --%>
        <jalios:include pub="<%= obj %>" usage="agenda"/>
    </jalios:default>
</jalios:select>