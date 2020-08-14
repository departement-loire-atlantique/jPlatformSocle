<%@page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@ page import="fr.cg44.plugin.socle.VideoUtils" %>
<%@ page contentType="text/html; charset=UTF-8" %><%
%><%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
%><% FicheActu obj = (FicheActu)request.getAttribute(PortalManager.PORTAL_PUBLICATION); %><%
%><%@ include file='/front/doFullDisplay.jspf' %>

<main id="content" role="main">
    <article class="ds44-container-large">

        <%@ include file='titreActu.jspf' %>
			
		<%-- Boucler sur les paragraphes --%>
		<jalios:foreach name="itParagraphe" type="String" counter="itCounter" array="<%=obj.getContenuParagraphe()%>">
		    <section id="section<%=itCounter%>" class="ds44-contenuArticle">
		        <div class="ds44-inner-container ds44-mtb3">
		            <div class="ds44-grid12-offset-2">
		                <jalios:if predicate="<%= Util.notEmpty(obj.getTitreParagraphe()) && itCounter <= obj.getTitreParagraphe().length && Util.notEmpty(obj.getTitreParagraphe()[itCounter - 1]) && Util.notEmpty(itParagraphe)%>">
		                    <h2 id="titreParagraphe<%=itCounter%>"><%=obj.getTitreParagraphe()[itCounter - 1]%></h2>
		                </jalios:if>
		                <jalios:if predicate="<%= Util.notEmpty(itParagraphe) %>">
                            <jalios:wysiwyg><%=itParagraphe%></jalios:wysiwyg>
		                </jalios:if>
		            </div>
		        </div>
		    </section>
		</jalios:foreach>        
        
        <%-- TODO : bloc des réseaux sociaux --%>
        
        <%-- TODO : bloc Je m'abonne --%>
        <jalios:if predicate='<%= Util.notEmpty(channel.getProperty("jcmsplugin.socle.portletPush.ficheactu.id")) %>'>
           <jalios:include id='<%= channel.getProperty("jcmsplugin.socle.portletPush.ficheactu.id") %>'/>
        </jalios:if>
        
        <%-- TODO : bloc "Sur le même thème --%>
    </article>
</main>
