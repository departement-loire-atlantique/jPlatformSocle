<%@page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@ page import="fr.cg44.plugin.socle.VideoUtils" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%>
<%@ include file='/jcore/doInitPage.jspf' %>
<% Video obj = (Video)request.getAttribute(PortalManager.PORTAL_PUBLICATION); %>
<%@ include file='/front/doFullDisplay.jspf' %>

<%
String uniqueIDiframe = UUID.randomUUID().toString();
String videoId = obj.getUrlVideo().substring(obj.getUrlVideo().indexOf("?v=") + 3); // récupérer l'ID de la vidéo YT
//le JS se base sur cette ID et va alors forcer cette ID dans l'url de la vidéo. Utiliser un UID va casser l'affichage de la vidéo 
%>

<main id="content" role="main">

<jalios:include target="SOCLE_ALERTE"/>

    <article class="ds44-container-large">
        <ds:titleSimple pub="<%= obj %>" video="<%= obj %>" title="<%= obj.getTitle(userLang) %>" chapo="<%= obj.getChapo(userLang) %>"
            legend="<%= obj.getLegende(userLang) %>" copyright="<%= obj.getCopyright(userLang) %>" breadcrumb="true">
        </ds:titleSimple>
        <section class="ds44-contenuArticle">
            <div class="ds44-inner-container ds44-mtb3">
                <div class="ds44-grid12-offset-2">
                    <jalios:if predicate="<%= Util.notEmpty(obj.getDescription(userLang)) %>">
                        <jalios:foreach name="itDesc" type="String" array='<%= obj.getDescription(userLang) %>'>
                        <div>
                            <jalios:if predicate='<%= Util.notEmpty(obj.getTitreDescription(userLang)) && itCounter <= obj.getTitreDescription(userLang).length
                                && Util.notEmpty(obj.getTitreDescription(userLang)[itCounter-1]) %>'>
                                <h2 id="titreDesc_<%= itCounter %>"><%= obj.getTitreDescription(userLang)[itCounter-1] %></h2>
                            </jalios:if>
                            <jalios:wysiwyg><%= itDesc %></jalios:wysiwyg>
                        </div>
                        </jalios:foreach>
                        
                    </jalios:if>
                    
                    <%-- Chapitres --%>
                    <%@ include file="doVideoChapitres.jspf" %>   
                    
                </div>
            </div>
        </section>

    </article>
</main>
