<%@page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@ page import="fr.cg44.plugin.socle.VideoUtils" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%>
<%@ include file='/jcore/doInitPage.jspf' %>
<% Video obj = (Video)request.getAttribute(PortalManager.PORTAL_PUBLICATION); %>
<%@ include file='/front/doFullDisplay.jspf' %>

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
                    <%-- TODO : en attente maquette et implémentation du JS pour piloter la vidéo. --%>
                    <jalios:if predicate="<%= obj.getHasChapters() && Util.notEmpty(obj.getChapitre(userLang)) && Util.notEmpty(obj.getTimecode(userLang)) && Util.notEmpty(obj.getLibelleTimecode(userLang)) %>">
                        <%
                        List<String> chapitres = Arrays.asList(obj.getChapitre(userLang));
                        String[] timecodes = obj.getTimecode(userLang);
                        String[] libellestimecodes = obj.getLibelleTimecode(userLang);
                        String tmpChapitre = "";
                        %>
                        <%-- Si plusieurs chapitres du même nom, on n'affiche le nom du chapitre qu'une fois. On classe les timecodes par chapitre. --%>
                        <jalios:foreach name="itChapitre" type="String" array="<%=obj.getChapitre(userLang)%>">
                            <jalios:if predicate="<%=Util.notEmpty(itChapitre) && !itChapitre.equals(tmpChapitre) %>">
                                <% tmpChapitre = itChapitre; %>
                                <p><strong><%=itChapitre %></strong></p>
                            </jalios:if>
                            <%
                            String uniqueID = UUID.randomUUID().toString();
                            String timecode = "";
                            String libelletimecode = "";
                            try {
                                if (Util.notEmpty(timecodes[itCounter-1]) && Util.notEmpty(libellestimecodes[itCounter-1])) {
                                    timecode = timecodes[itCounter-1];
                                    libelletimecode = libellestimecodes[itCounter-1]; %>
                                    <p><a id="#video<%=uniqueID%>" class="lienChapitre" href="#" data-videoId="#video<%=uniqueID%>" data-videoTime="<%=VideoUtils.getSecondesByTimecode(timecode)%>" title="Aller à <%=timecode %>, chapitre concernant : <%=itChapitre %>"><p class=\"paragrapheChapitre\"><%=libelletimecode%></a> / <%= timecode %> / <%=VideoUtils.getSecondesByTimecode(timecode) %></p>
                                    <%
                                    }
                                } catch (IndexOutOfBoundsException e) {
                                    timecode = "";
                                    libelletimecode = "";
                                    }
                           
                          %>
                        </jalios:foreach>
                    </jalios:if>                   
                    
                </div>
            </div>
        </section>

    </article>
</main>
