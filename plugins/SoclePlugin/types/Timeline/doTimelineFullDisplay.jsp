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
	            <jalios:foreach array="<%= obj.getElementsTimelines() %>" name="itElement" type="Lien" counter="counterTimeline">
	            <%
	            String titleLink = titleLink = obj.getLibelleElementsTimeline(userLang)[counterTimeline-1];
	            %>
	            <li><a href="#time_elem_<%= itElement.getId() %>"><%= titleLink %></a></li>
	            </jalios:foreach>
	        </ul>
	    </nav>
	
	    <div class="ds44-inner-container">
	
	        <div class="ds44-timeline_container">
	
	            <%-- Affichage des éléments --%>
	            <jalios:foreach array="<%= obj.getElementsTimelines() %>" name="itElement" type="Lien" counter="counterTimeline">
                <%
                String titleElement = obj.getLibelleElementsTimeline(userLang)[counterTimeline-1];
                %>
                
                <section id="time_elem_<%= itElement.getId() %>" class="ds44-timeline_elem">
                   <div class="ds44-timeline_elem_body aos-init aos-animate" data-aos="fade-up">
                      <header class="ds44-timeline_elem__header">
                         <h2 class="h2-like" id="titreTimeline<%= itElement.getId() %>"><%= titleElement %></h2>
                      </header>
                      <jalios:if predicate="<%= Util.notEmpty(itElement.getDateDebut()) %>">
                      <%
                      SimpleDateFormat sdf = new SimpleDateFormat("dd MMMM yyyy");
                      %>
                      <h3 class="h4-like ds44-mt5"><%= sdf.format(itElement.getDateDebut()) %><jalios:if predicate="<%= Util.notEmpty(itElement.getDateFin()) %>"> - <%= sdf.format(itElement.getDateFin()) %></jalios:if></h3>
                      </jalios:if>
                      <jalios:select>
                        <jalios:if predicate="<%= Util.notEmpty(itElement.getVideo()) %>">
                            <ds:articleVideo video="<%= itElement.getVideo() %>" hideTitle="<%= true %>"/>
                        </jalios:if>
                        <jalios:if predicate="<%= Util.notEmpty(itElement.getImagePrincipale()) %>">
                            <ds:figurePicture format="custom" width="510" height="327" image="<%= itElement.getImagePrincipale() %>"></ds:figurePicture>
                        </jalios:if>
                        <jalios:if predicate="<%= Util.notEmpty(itElement.getImageMobile()) %>">
                          <picture>
                            <ds:figurePicture format="custom" width="510" height="327" image="<%= itElement.getImageMobile() %>"></ds:figurePicture>
                          </picture>
                        </jalios:if>
                      </jalios:select>
                      <h4 class="h3-like" id="titreTimeline<%= itElement.getId() %>_2"><%= itElement.getTitle() %></h4>
                      <jalios:wysiwyg><%= itElement.getDescription(userLang) %></jalios:wysiwyg>
                      </div>
                </section>
                
                </jalios:foreach>
	
	        </div>
	
	    </div>
	</section>

</main>