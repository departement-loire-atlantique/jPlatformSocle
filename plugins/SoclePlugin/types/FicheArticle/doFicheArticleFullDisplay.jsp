<%@page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@ page import="fr.cg44.plugin.socle.VideoUtils" %>
<%@ page contentType="text/html; charset=UTF-8" %><%
%><%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
%><% FicheArticle obj = (FicheArticle)request.getAttribute(PortalManager.PORTAL_PUBLICATION); %><%
%><%@ include file='/front/doFullDisplay.jspf' %>

<main id="content" role="main">
    <article class="ds44-container-large">
        <%-- Sélection qui dépend de l'image principale et du champ "Type d'article --%>
        <jalios:select>
            <jalios:if predicate="<%=Util.notEmpty(obj.getSideportlets())%>">
                <%-- Include du gabarit technique (formulaire contact par ex) --%>
                <%@ include file="ficheArticleTechnique.jspf" %>
            </jalios:if>
            <jalios:if predicate="<%= Util.notEmpty(obj.getImagePrincipale()) || obj.getTypeSimple() %>">
                <%-- Include du gabarit simple --%>
                <%@ include file="ficheArticleSimple.jspf" %>
            </jalios:if>
            <jalios:default>
                <%-- Include du gabarit onglet --%>
                <%@ include file="ficheArticleOnglets.jspf" %>
            </jalios:default>
        </jalios:select>
        
        <%-- TODO : bloc des réseaux sociaux --%>
        
        <%-- TODO : bloc Je m'abonne --%>
        
        <%-- TODO : bloc "Sur le même thème --%>
        
        <%-- Portlets bas --%>
	    <jalios:if predicate="<%= Util.notEmpty(obj.getBottomportlets()) %>">
	        <jalios:foreach name="itPortlet" array="<%= obj.getBottomportlets() %>" type="com.jalios.jcms.portlet.PortalElement">
	           <section>
	               <jalios:include id="<%= itPortlet.getId() %>" />
                </section>
	        </jalios:foreach>
	    </jalios:if>
        
    </article>
</main>
