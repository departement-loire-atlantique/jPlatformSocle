<%@ page contentType="text/html; charset=UTF-8" %><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
%><%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%><%
%><% Timeline obj = (Timeline)request.getAttribute(PortalManager.PORTAL_PUBLICATION); %><%
%><%@ include file='/front/doFullDisplay.jspf' %>
<%

boolean hasImage = Util.notEmpty(obj.getVisuel());
boolean hasDesc = Util.notEmpty(obj.getDescription(userLang));

%>
<main role="main" id="content">

<jalios:include target="SOCLE_ALERTE"/>

	<section class="ds44-container-large">
	
	   <ds:titleNoImage title="<%= obj.getTitle(userLang) %>" breadcrumb="true" subtitle="<%= obj.getSoustitre(userLang) %>"></ds:titleNoImage>
	   
	   <jalios:if predicate="<%= hasImage || hasDesc %>">
	   <section id="imageChapo" class="ds44-contenuArticle">
            <div class="ds44-inner-container ds44-mtb3">
                <div class="ds44-grid12-offset-1">
                    <div class="grid-<%= hasImage && hasDesc ? "2" : "1" %>-small-1">
                        <jalios:if predicate="<%= hasImage %>">
                        <div class='col mrl mbs'>
                           <ds:figurePicture imgCss="ds44-w100 ds44-imgRatio" pictureCss="ds44-legendeContainer ds44-container-imgRatio" format="principale" 
                             pub="<%= obj %>" image="<%= obj.getVisuel() %>"/>
                        </div>
                        </jalios:if>
                        <jalios:if predicate="<%= hasDesc %>">
                        <div class='col <%= hasImage ? "mll" : "" %> mbs'>
                            <div class="ds44-introduction"><jalios:wysiwyg><%= obj.getDescription(userLang) %></jalios:wysiwyg></div>
                        </div>
                        </jalios:if>
                    </div>
                </div>
            </div>
        </section>
        </jalios:if>
	
	    <nav class="ds44-theme txtcenter ds44--xl-padding ds44-timeline_index ds44-mtb5" aria-label='<%= glp("jcmsplugin.socle.barrenavsecondaire") %>'>
	        <p class="inbl"><%= glp("jcmsplugin.socle.goto") %></p>
	        <ul class="ds44-list">
	            <%-- générer automatiquement sur la liste des éléments --%>
	            <jalios:foreach array="<%= obj.getElementsTimelines() %>" name="itElement" type="Publication" counter="counterTimeline">
	            <%
	            String titleLink = counterTimeline <= obj.getLibelleElementsTimeline(userLang).length ? obj.getLibelleElementsTimeline(userLang)[counterTimeline-1] : "";
	            %>
	            <jalios:if predicate="<%= Util.notEmpty(titleLink) %>">
	            <li><a href="#time_elem_<%= itElement.getId() %>"><%= titleLink %></a></li>
	            </jalios:if>
	            </jalios:foreach>
	        </ul>
	    </nav>
	
	    <div class="ds44-inner-container">
	
	        <div class="ds44-timeline_container">
	
	            <%-- Affichage des éléments --%>
	            <jalios:foreach array="<%= obj.getElementsTimelines() %>" name="itElement" type="Publication" counter="counterTimeline">
                <%
                String titleElement = counterTimeline <= obj.getLibelleElementsTimeline(userLang).length ? obj.getLibelleElementsTimeline(userLang)[counterTimeline-1] : "";
                %>
                
                <section id="time_elem_<%= itElement.getId() %>" class="ds44-timeline_elem">
                   <div class="ds44-timeline_elem_body aos-init aos-animate" data-aos="fade-up">
                      <jalios:if predicate="<%= Util.notEmpty(titleElement) %>">
                      <header class="ds44-timeline_elem__header">
                         <h2 class="h2-like" id="titreTimeline<%= itElement.getId() %>"><%= titleElement %></h2>
                      </header>
                      </jalios:if>
                      <%
                      SimpleDateFormat sdf = new SimpleDateFormat("dd MMMM yyyy");
                      %>
                      
                      <jalios:if predicate="<%= itElement instanceof Lien %>">
                          <%
                          Lien itLienElem = (Lien) itElement;
                          %>
	                      <jalios:if predicate="<%= Util.notEmpty(itLienElem.getDateDebut()) %>">
		                    <h3 class="h4-like ds44-mt5"><%= sdf.format(itLienElem.getDateDebut()) %><jalios:if predicate="<%= Util.notEmpty(itLienElem.getDateFin()) %>"> - <%= sdf.format(itLienElem.getDateFin()) %></jalios:if></h3>
		                  </jalios:if>
                      </jalios:if>
                      
                      <jalios:select>
                        <%-- Le contenu est un Lien --%>
                        <jalios:if predicate="<%= itElement instanceof Lien %>">
                            <%
                            Lien itLienElem = (Lien) itElement;
                            %>
                            <jalios:select>
		                        <jalios:if predicate="<%= Util.notEmpty(itLienElem.getVideo()) %>">
		                            <ds:articleVideo video="<%= itLienElem.getVideo() %>" hideTitle="<%= true %>" forcedHeight='<%= "327px" %>' offsetLevel='<%= 1 %>'/>
		                        </jalios:if>
		                        <jalios:if predicate="<%= Util.notEmpty(itLienElem.getImagePrincipale()) %>">
		                            <ds:figurePicture format="custom" width="510" height="327" image="<%= itLienElem.getImagePrincipale() %>"></ds:figurePicture>
		                        </jalios:if>
		                        <jalios:if predicate="<%= Util.notEmpty(itLienElem.getImageMobile()) %>">
		                          <picture>
		                            <ds:figurePicture format="custom" width="510" height="327" image="<%= itLienElem.getImageMobile() %>"></ds:figurePicture>
		                          </picture>
		                        </jalios:if>
	                        </jalios:select>
	                        
	                        <jalios:select>
	                            <jalios:if predicate="<%= Util.notEmpty(itLienElem.getLienInterne()) %>">
	                                <h4 class="h3-like" id="titreTimeline<%= itLienElem.getId() %>_2"><a class="ds44-card__globalLink" href="<%= itLienElem.getLienInterne().getDisplayUrl(userLocale) %>"><%= itLienElem.getTitle() %></a></h4>
	                            </jalios:if>
	                            <jalios:if predicate="<%= Util.notEmpty(itLienElem.getLienExterne()) %>">
	                                <h4 class="h3-like" id="titreTimeline<%= itLienElem.getId() %>_2"><a class="ds44-card__globalLink" href="<%= itLienElem.getLienExterne() %>" target="_blank"><%= itLienElem.getTitle() %></a></h4>
	                            </jalios:if>
	                            <jalios:default>
	                                <h4 class="h3-like" id="titreTimeline<%= itLienElem.getId() %>_2"><%= itLienElem.getTitle() %></h4>
	                            </jalios:default>
	                       </jalios:select>
	                       <jalios:wysiwyg><%= itLienElem.getDescription(userLang) %></jalios:wysiwyg>
                        </jalios:if>
                        <jalios:default>
                            <%-- Le contenu n'est pas un lien, on récupère la valeur du champ 'chapo' pour l'afficher --%>
                            <%
                            String displayedText = "";
                            try {
                                displayedText = (String) itElement.getFieldValue("chapo", userLang);
                            } catch (Exception e) {
                                logger.warn("Erreur doTimelineFullDisplay : contenu " + itElement.getId() + " n'a pas de champ 'chapo'.");
                            }
                            %>
                            
                            <h4 class="h3-like" id="titreTimeline<%= itElement.getId() %>_2"><a class="ds44-card__globalLink" href="<%= itElement.getDisplayUrl(userLocale) %>"><%= itElement.getTitle() %></a></h4>
                            <jalios:if predicate="<%= Util.notEmpty(displayedText) %>">
                                <jalios:wysiwyg><%= displayedText %></jalios:wysiwyg>
                            </jalios:if>
                        </jalios:default>
                      </jalios:select>
                      
                      </div>
                </section>
                
                </jalios:foreach>
	
	        </div>
	
	    </div>
	</section>

</main>