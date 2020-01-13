<%@page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@ page contentType="text/html; charset=UTF-8" %><%
%><%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
%><% FicheArticle obj = (FicheArticle)request.getAttribute(PortalManager.PORTAL_PUBLICATION); %><%
%><%@ include file='/front/doFullDisplay.jspf' %><%
%><% 

    // Champs générés

    String lblFigure = "";
    if (Util.notEmpty(obj.getLegende())) lblFigure += obj.getLegende();
    if (Util.notEmpty(obj.getLegende()) && Util.notEmpty(obj.getCopyright())) lblFigure += " ";
    if (Util.notEmpty(obj.getCopyright())) lblFigure += glp("jcmsplugin.socle.symbol.copyright") + " " + obj.getCopyright();
%>
<main id="content" role="main">
    <article class="ds44-container-fluid">
        <%-- Sélection qui dépend de l'image principale et du champ "Type d'article --%>
        <jalios:select>
            <jalios:if predicate="<%= Util.isEmpty(obj.getImagePrincipale()) || !obj.getTypeSimple() %>">
                <%-- Include du gabarit onglet --%>
                <%@ include file="ficheArticleOnglets.jspf" %>
            </jalios:if>
            <jalios:default>
                <%-- Include du gabarit simple --%>
                <%@ include file="ficheArticleSimple.jspf" %>
            </jalios:default>
        </jalios:select>
        
        <%-- TODO : bloc des réseaux sociaux --%>
        
        <%-- TODO : bloc Je m'abonne --%>
        
        <%-- TODO : bloc "Sur le même thème --%>
    </article>
</main>
