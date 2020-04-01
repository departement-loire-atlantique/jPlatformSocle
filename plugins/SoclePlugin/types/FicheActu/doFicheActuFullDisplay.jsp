<%@page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@ page import="fr.cg44.plugin.socle.VideoUtils" %>
<%@ page contentType="text/html; charset=UTF-8" %><%
%><%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
%><% FicheActu obj = (FicheActu)request.getAttribute(PortalManager.PORTAL_PUBLICATION); %><%
%><%@ include file='/front/doFullDisplay.jspf' %>

<main id="content" role="main">
    <article class="ds44-container-large">
    
    <%@ include file='../FicheArticle/commonTitreArticleActu.jspf' %>
			
        <%-- Boucler sur les paragraphes --%>
        <jalios:foreach name="itTitle" type="String" counter="itCounter" array="<%= obj.getTitreParagraphe() %>">
           <jalios:if predicate="<%= itCounter <= obj.getContenuParagraphe().length && Util.notEmpty(obj.getContenuParagraphe()[itCounter-1]) %>">
           <section id="section<%= itCounter %>" class="ds44-contenuArticle">
               <div class="ds44-inner-container ds44-mtb3">
                   <div class="ds44-grid12-offset-2">
                       <jalios:if predicate="<%= Util.notEmpty(itTitle) %>">
                           <h2 id="titreParagraphe<%= itCounter %>"><%= itTitle %></h2>
                       </jalios:if>
                       <jalios:wysiwyg><%= obj.getContenuParagraphe()[itCounter-1] %></jalios:wysiwyg>
                   </div>
               </div>
           </section>
           </jalios:if>
        </jalios:foreach>
        
        <%-- TODO : bloc des réseaux sociaux --%>
        
        <%-- TODO : bloc Je m'abonne --%>
        <jalios:if predicate='<%= Util.notEmpty(channel.getProperty("jcmsplugin.socle.portletPush.ficheactu.id")) %>'>
           <jalios:include id='<%= channel.getProperty("jcmsplugin.socle.portletPush.ficheactu.id") %>'/>
        </jalios:if>
        
        <%-- TODO : bloc "Sur le même thème --%>
    </article>
</main>
