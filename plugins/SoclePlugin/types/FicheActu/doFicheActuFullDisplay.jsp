<%@page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@ page contentType="text/html; charset=UTF-8" %><%
%><%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
%><% FicheActu obj = (FicheActu)request.getAttribute(PortalManager.PORTAL_PUBLICATION); %><%
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
	    <ds:titleSimple imagePath="<%= obj.getImagePrincipale() %>" mobileImagePath="<%= obj.getImageMobile() %>" 
		    title="<%= obj.getTitle() %>" legend="<%= obj.getLegende() %>" 
		    copyright="<%= obj.getCopyright() %>" date='<%= SocleUtils.formatDate("dd/MM/yy", obj.getDateActu()) %>' 
		    userLang="<%= userLang %>" alt="<%= obj.getTexteAlternatif() %>" breadcrumb="true"></ds:titleSimple>
	    <section class="ds44-contenuArticle large-w66">
	       <jalios:if predicate="<%= Util.notEmpty(obj.getChapo()) %>">
                <div class="ds44-introduction"><jalios:wysiwyg><%= obj.getChapo() %></jalios:wysiwyg></div>
           </jalios:if>
	    </section>
	    <%-- Boucler sur les paragraphes --%>
	    <jalios:foreach name="itTitle" type="String" counter="itCounter" array="<%= obj.getTitreParagraphe() %>">
	       <section id="section<%= itCounter %>" class="ds44-contenuArticle large-w66">
	       <jalios:if predicate="<%= Util.notEmpty(itTitle) %>">
	           <h2 id="titreParagraphe<%= itCounter %>" class="h2-like"><%= itTitle %></h2>
	       </jalios:if>
	       <%= obj.getContenuParagraphe()[itCounter-1] %>
	       </section>
	    </jalios:foreach>
	    
	    <%-- TODO : bloc des réseaux sociaux --%>
	    
	    <%-- TODO : bloc Je m'abonne --%>
	    
	    <%-- TODO : bloc "Sur le même thème --%>
	</article>
</main>
