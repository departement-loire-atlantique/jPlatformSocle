<%@page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@ page contentType="text/html; charset=UTF-8" %><%
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
	    <div class="ds44-alternate-container">
	        <div class="ds44--xl-padding-t pbs large-w66 mauto">
	            <%-- TODO : intégrer le fil d'ariane --%>
	            <h1 class="h1-like mbm mtm" id="titreActualite"><%= obj.getTitle() %></h1>
	            <p class="ds44-textLegend"><%= glp("jcmsplugin.socle.publiele", SocleUtils.formatDate("dd/MM/yy", obj.getDateActu())) %></p>
	        </div>
	    </div>
	    <%-- TODO : voir comment se gèrent les images mobiles --%>
	    <div class="ds44-alternate-container ds44-img50">
	       <div class="large-w75 mauto">
	           <figure class="ds44-legendeContainer ds44-container-imgRatio" role="figure" aria-label="<%= lblFigure %>">
	               <img class="ds44-w100 ds44-imgRatio" src="<%= obj.getImagePrincipale() %>" alt="<%= obj.getTexteAlternatif() %>"/>
	               <jalios:if predicate="<%= Util.notEmpty(lblFigure) %>">
	               <figcaption class="ds44-imgCaption"><%= lblFigure %></figcaption>
	               </jalios:if>
	           </figure>
	       </div>
	    </div>
	    <section class="ds44-contenuArticle large-w66">
	       <p class="ds44-introduction">
	           <%= HtmlUtil.html2text(obj.getChapo()) %>
	       </p>
	    </section>
	    <%-- Boucler sur les paragraphes --%>
	    <jalios:foreach name="itTitle" type="String" counter="itCounter" array="<%= obj.getTitreParagraphe() %>">
	       <section id="section<%= itCounter %>" class="ds44-contenuArticle large-w66">
	       <jalios:if predicate="<%= Util.notEmpty(itTitle) %>">
	           <h2 id="titreParagraphe<%= itCounter %>"><%= itTitle %></h2>
	       </jalios:if>
	       <%= obj.getContenuParagraphe()[itCounter-1] %>
	       </section>
	    </jalios:foreach>
	    
	    <%-- TODO : bloc des réseaux sociaux --%>
	    
	    <%-- TODO : bloc Je m'abonne --%>
	    
	    <%-- TODO : bloc "Sur le même thème --%>
	</article>
</main>
