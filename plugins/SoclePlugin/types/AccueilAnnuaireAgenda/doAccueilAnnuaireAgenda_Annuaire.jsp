<%@ page contentType="text/html; charset=UTF-8" %><%
%><%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
%><% AccueilAnnuaireAgenda obj = (AccueilAnnuaireAgenda)request.getAttribute(PortalManager.PORTAL_PUBLICATION); %><%
%>

<main id="content" role="main">
    <section class="ds44-container-large">
        <jalios:select>
            <jalios:if predicate="<%= Util.notEmpty(obj.getImageBandeau()) %>">
                <ds:titleBanner imagePath="<%= obj.getImageBandeau() %>" mobileImagePath="<%= obj.getImageMobile() %>" title="<%= obj.getTitle() %>"
                   legend="<%= obj.getLegende() %>" copyright="<%= obj.getCopyright() %>" breadcrumb="true"></ds:titleBanner>
            </jalios:if>
            <jalios:default>
                <ds:titleSimple mobileImagePath="<%= obj.getImageMobile() %>" title="<%= obj.getTitle() %>"
                   legend="<%= obj.getLegende() %>" copyright="<%= obj.getCopyright() %>" breadcrumb="true"></ds:titleSimple>
            </jalios:default>
        </jalios:select>
        
    </section>
    
    <section class="ds44-container-large">
        <div class='<%= Util.notEmpty(obj.getPortletsBas()) ? "ds44-mt3" : "ds44-mtb3" %> ds44--xl-padding-tb'>
            <jalios:if predicate="<%= Util.notEmpty(obj.getPortletRecherche()) %>">
                <div class="ds44-loader-text visually-hidden" tabindex="-1" aria-live="polite"></div>
                <div class="ds44-loader hidden">
                    <div class="ds44-loader-body">
                        <svg class="ds44-loader-circular" focusable="false" aria-hidden="true">
                            <circle class="ds44-loader-path" cx="30" cy="30" r="20" fill="none" stroke-width="5" stroke-miterlimit="10"></circle>
                        </svg>
                    </div>
                </div>
                <jalios:include pub="<%= obj.getPortletRecherche() %>"/>
            </jalios:if>
            
            <div class="ds44-inner-container ds44-mt3 ds44--l-padding-t">
                <div class="grid-12-small-1">
                    <div class='col-<%= Util.isEmpty(obj.getContenusEncadresLibres()) && Util.isEmpty(obj.getPortletsEncadres()) ? "12" : "7" %>'>
                        <jalios:if predicate="<%= Util.notEmpty(obj.getChapo()) %>">
                            <section id="sectionChapo"
                              class="ds44-contenuArticle">
                                <div class="ds44-inner-container ds44-mtb3 ds44-introduction">
                                    <jalios:wysiwyg><%=obj.getChapo()%></jalios:wysiwyg>
                                </div>
                            </section>
                        </jalios:if>
                        <%-- On part du principe qu'au moins un paragraphe est rédigé --%>
                        <jalios:foreach name="itParagraphe" type="String" counter="itCounter"
                          array="<%=obj.getContenuParagraphe()%>">
                            <section id="section<%=itCounter%>"
                              class="ds44-contenuArticle">
                                <div class="ds44-inner-container ds44-mtb3">
                                    <jalios:if predicate="<%= Util.notEmpty(obj.getTitreParagraphe())
                                      && itCounter <= obj.getTitreParagraphe().length && Util.notEmpty(obj.getTitreParagraphe()[itCounter - 1]) %>">
                                        <h2 class="h2-like" id="titreParagraphe<%=itCounter%>"><%=obj.getTitreParagraphe()[itCounter - 1]%></h2>
                                    </jalios:if>
                                    <jalios:wysiwyg><%=itParagraphe%></jalios:wysiwyg>
                                </div>
                            </section>
                        </jalios:foreach>
                    </div>
                    
                    <jalios:if predicate="<%= Util.notEmpty(obj.getContenusEncadresLibres()) || Util.notEmpty(obj.getPortletsEncadres()) %>">
                        <div class="col-1 grid-offset ds44-hide-tiny-to-medium"></div>

                        <aside class="col-4 asideCards">
                            <jalios:foreach array="<%=obj.getContenusEncadresLibres()%>" type="String"
                                name="itContenu" counter="itCounter">
                                <%
                                boolean afficheTitre = Util.notEmpty(obj.getTitreEncadresLibres()) && obj.getTitreEncadresLibres().length > itCounter-1 && Util.notEmpty(obj.getTitreEncadresLibres()[itCounter - 1]);
                                %>
                                <jalios:if predicate="<%= afficheTitre %>">
                                    <section class="ds44-box ds44-theme mbm">
                                        <div class="ds44-innerBoxContainer">
                                            <p class="ds44-box-heading" role="heading" aria-level="2"><%=obj.getTitreEncadresLibres()[itCounter - 1]%></p>
                                </jalios:if>
                                
                                <div class="mbm"><jalios:wysiwyg><%= itContenu %></jalios:wysiwyg></div>
                                        
                                <jalios:if predicate="<%= afficheTitre %>">
                                        </div>
                                    </section>
                                </jalios:if>                                        

                            </jalios:foreach>
                            
                            <jalios:foreach array="<%=obj.getPortletsEncadres()%>" type="PortalElement" name="itPortalElem">
                                <jalios:include pub="<%= itPortalElem %>" />
                            </jalios:foreach>
                        </aside>
                    </jalios:if>
                </div>
            </div>
        </div>
    </section>
    
    <jalios:if predicate="<%= Util.notEmpty(obj.getPortletsBas()) %>">
        <jalios:foreach name="itPortletBas" type="PortalElement" array="<%= obj.getPortletsBas() %>">
            <jalios:if predicate="<%= itPortletBas instanceof PortletPush %>">
            <section class="ds44-container-fluid ds44--l-padding">
            </jalios:if>
            <jalios:include pub="<%= itPortletBas %>"/>
            <jalios:if predicate="<%= itPortletBas instanceof PortletPush %>">
            </section>
            </jalios:if>
        </jalios:foreach>
    </jalios:if>
    
    <jalios:if predicate="<%= Util.notEmpty(obj.getFaq()) %>">
        <section class="ds44-container-fluid ds44-lightBG ds44-wave-white ds44--xxl-padding-tb">
            <jalios:include pub="<%= obj.getFaq() %>"/>
        </section>
    </jalios:if>
 
</main>