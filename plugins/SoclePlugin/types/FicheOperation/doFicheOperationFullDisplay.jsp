<%@page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@ page contentType="text/html; charset=UTF-8" %><%
%><%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
%><% FicheOperation obj = (FicheOperation)request.getAttribute(PortalManager.PORTAL_PUBLICATION); %>
<%
String uid = ServletUtil.generateUniqueDOMId(request, "uid");
boolean hasImage = Util.notEmpty(obj.getImagePrincipale()) || Util.notEmpty(obj.getImageMobile());
%>
<jalios:buffer name="coloredSectionContent">
    <div class="grid-2-small-1 ds44-grid12-offset-1">
        <div class='col'>
            <%-- <div class="ds44-box-heading" role="heading" aria-level="3"><%= glp("jcmsplugin.socle.actuedu.infopratiques.label") %></div> --%>
            <jalios:if predicate="<%= Util.notEmpty(obj.getCommune()) %>">
                <p class="ds44-docListElem mts">
                    <i class="icon icon-marker ds44-docListIco" aria-hidden="true"></i>
                    <strong><%= glp("jcmsplugin.socle.actuedu.commune-s.label") %>:</strong> 
                    <jalios:foreach name="itCommune" type="City" array="<%= obj.getCommune() %>">
                        <span><jalios:link data="<%= itCommune %>"/><% if(itCounter<obj.getCommune().length){ %>,<% } %></span>
                    </jalios:foreach>
                </p>
            </jalios:if>
            <jalios:if predicate="<%= Util.notEmpty(obj.getPeriode(loggedMember)) %>">
                <p class="ds44-docListElem mts">
                    <i class="icon icon-historic ds44-docListIco" aria-hidden="true"></i> 
                    <strong><%= glp("jcmsplugin.socle.actuedu.periode-occupation.label") %>:</strong> 
                    <%= SocleUtils.formatCategories(obj.getPeriode(loggedMember)) %>
                </p>
            </jalios:if>
            <jalios:if predicate="<%= Util.notEmpty(obj.getResponsableDoperation()) %>">
                <p class="ds44-docListElem mts">
                    <i class="icon icon-user ds44-docListIco" aria-hidden="true"></i> 
                    <strong><%= glp("jcmsplugin.socle.actuedu.responsable.label") %>:</strong> 
                    <jalios:foreach name="itContact" type="Contact" array="<%= obj.getResponsableDoperation() %>">
                        <span>
	                        <jalios:link data="<%= itContact %>"><%= itContact.getPrenom()+" "+itContact.getNom() %></jalios:link>
	                        <% if(itCounter<obj.getCommune().length){ %>,<% } %>
                        </span>
                    </jalios:foreach>
                </p>
            </jalios:if>
            <jalios:if predicate="<%= Util.notEmpty(obj.getAmenageur(userLang)) %>">
                <p class="ds44-docListElem mts">
                    <i class="icon icon-directions ds44-docListIco" aria-hidden="true"></i> 
                    <span><strong><%= glp("jcmsplugin.socle.actuedu.amenageur.label") %>:</strong></span>
                    <%= obj.getAmenageur(userLang) %>
                </p>
            </jalios:if>
        </div>
        <div class="col ds44--xl-padding-l">
            <%-- <p class="ds44-box-heading" role="heading" aria-level="3"><%= glp("jcmsplugin.socle.actuedu.votrecontact.label") %></p> --%>
            <jalios:if predicate="<%= Util.notEmpty(obj.getRaisonDeLintervention(userLang)) %>">
                <p class="ds44-docListElem mts">
                    <i class="icon icon-document ds44-docListIco" aria-hidden="true"></i> 
                    <strong><%= glp("jcmsplugin.socle.actuedu.raison-intervention.label") %>:</strong> 
                    <div><%= obj.getRaisonDeLintervention(userLang) %></div>
                </p>
            </jalios:if>
            <jalios:if predicate="<%= Util.notEmpty(obj.getTypeDeChantier(loggedMember)) %>">
                <p class="ds44-docListElem mts">
                    <i class="icon icon-travaux ds44-docListIco" aria-hidden="true"></i> 
                    <strong><%= glp("jcmsplugin.socle.actuedu.type-chantier.label") %>:</strong> 
                    <%= SocleUtils.formatCategories(obj.getTypeDeChantier(loggedMember)) %>
                </p>
            </jalios:if>
            <jalios:if predicate="<%= Util.notEmpty(obj.getMotscles(loggedMember)) %>">
                <p class="ds44-docListElem mts">
                    <i class="icon icon-etudes ds44-docListIco" aria-hidden="true"></i> 
                    <strong><%= glp("jcmsplugin.socle.actuedu.mot-cle.label") %>:</strong> 
                    <%= SocleUtils.formatCategories(obj.getMotscles(loggedMember)) %>
                </p>
            </jalios:if>
        </div>
    </div>
</jalios:buffer>


<main id="content" role="main">

<jalios:include target="SOCLE_ALERTE"/>

    <article class="ds44-container-large">
    
        <ds:titleNoImage title="<%= obj.getTitle(userLang) %>" breadcrumb="true" coloredSection="<%= coloredSectionContent %>"></ds:titleNoImage>
      
        <section id="imageChapo" class="ds44-contenuArticle">
            <div class="ds44-inner-container ds44-mtb3">
                <div class="ds44-grid12-offset-1">
                    <div class="grid-<%= hasImage ? "2" : "1" %>-small-1">
                        <jalios:if predicate="<%= hasImage %>">
                        <div class='col mrl mbs<%= Util.isEmpty(obj.getImageMobile()) ? " ds44-hide-mobile" : ""%>'>
                           <ds:figurePicture imgCss="ds44-w100 ds44-imgRatio" pictureCss="ds44-legendeContainer ds44-container-imgRatio" format="principale" 
                             pub="<%= obj %>" imageMobile="<%= obj.getImageMobile() %>" alt="<%= obj.getTexteAlternatif(userLang) %>" 
                             copyright="<%= obj.getCopyright(userLang) %>" legend="<%= obj.getLegende(userLang) %>"/>
                        </div>
                        </jalios:if>
                        <div class='col <%= hasImage ? "mll" : "" %> mbs'>
                            <jalios:if predicate="<%= Util.notEmpty(obj.getAvancement(loggedMember)) %>">
				                <p role="heading" aria-level="2" class="ds44-wsg-exergue">
	                                <i class="icon icon-tag" aria-hidden="true"></i> 
	                                <%= obj.getAvancement(loggedMember).first().getName(userLang) %> 
	                                <jalios:if predicate="<%= Util.notEmpty(obj.getAnneeDebutEtFin(loggedMember)) %>">
					                    – <%= SocleUtils.formatCategories(obj.getAnneeDebutEtFin(loggedMember), " – ") %>
						            </jalios:if>
	                            </p>
				            </jalios:if>
                            
                            <div class="ds44-mb-std"></div>
                            <div class="ds44-introduction"><jalios:wysiwyg><%= obj.getChapo(userLang) %></jalios:wysiwyg></div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        
        <%-- Boucler sur les paragraphes --%>
		<jalios:foreach name="itParagraphe" type="String" counter="itCounter" array="<%=obj.getContenuDetails(userLang)%>">
		    <section id="sectionDetails<%=itCounter%>" class="ds44-contenuArticle">
		        <div class="ds44-inner-container ds44-mtb3">
		            <div class="ds44-grid12-offset-2">
		                <jalios:if predicate="<%= Util.notEmpty(obj.getTitreDetails(userLang)) && itCounter <= obj.getTitreDetails(userLang).length && Util.notEmpty(obj.getTitreDetails(userLang)[itCounter - 1]) && Util.notEmpty(itParagraphe)%>">
		                    <h2 id="titreParagraphe<%=itCounter%>"><%=obj.getTitreDetails(userLang)[itCounter - 1]%></h2>
		                </jalios:if>
		                <jalios:if predicate="<%= Util.notEmpty(itParagraphe) %>">
		                  <jalios:wysiwyg><%=itParagraphe%></jalios:wysiwyg>
		                </jalios:if>
		            </div>
		        </div>
		    </section>
		</jalios:foreach>
        
        <%-- Partagez cette page --%>
        <%@ include file="/plugins/SoclePlugin/jsp/portal/socialNetworksShare.jspf" %>

    </article>
    
    <%-- Page utile --%>
    <jsp:include page="/plugins/SoclePlugin/types/PageUtileForm/editFormPageUtileForm.jsp"/>
    
</main>