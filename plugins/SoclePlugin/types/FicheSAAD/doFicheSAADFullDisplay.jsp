<%@page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@ page contentType="text/html; charset=UTF-8" %><%
%><%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
%><% FicheSAAD obj = (FicheSAAD)request.getAttribute(PortalManager.PORTAL_PUBLICATION); %><%
%><%@ include file='/front/doFullDisplay.jspf' %>

<%-- On met en buffer le contenu HTML dela partie colorée du titre, avant de le passer au tag --%>
<%
String longitude = obj.getExtraData("extra.FicheSAAD.plugin.tools.geolocation.longitude");
String latitude = obj.getExtraData("extra.FicheSAAD.plugin.tools.geolocation.latitude");
String localisation = SocleUtils.formatOpenStreetMapLink(latitude, longitude);

%>

<jalios:buffer name="coloredSectionContent">
	<div class="grid-2-small-1 ds44-grid12-offset-1">
		<%-- Col gauche --%>
		<div class="col">
			<p class="ds44-docListElem mts"><i class="icon icon-tag ds44-docListIco" aria-hidden="true"></i><%= obj.getTypesDeService(loggedMember).first().getName() %></p>
			<div class="ds44-docListElem mts"><i class="icon icon-marker ds44-docListIco" aria-hidden="true"></i><jalios:wysiwyg><%= obj.getAdresse() %></jalios:wysiwyg></div>
			
            <jalios:if predicate='<%= Util.notEmpty(localisation) %>'>
                <p class="ds44-docListElem mts">
                    <i class="icon icon-map ds44-docListIco" aria-hidden="true"></i>
                    <a href='<%= localisation%>' 
                        title='<%= HttpUtil.encodeForHTMLAttribute(glp("jcmsplugin.socle.ficheaide.localiser-carte.label")+" : " + obj.getTitle(userLang) + " " + glp("jcmsplugin.socle.accessibily.newTabLabel"))%>' 
                        target="_blank"
                        data-statistic='{"name": "declenche-evenement","category": "BlocContact","action": "Localiser","label": "<%= HttpUtil.encodeForHTMLAttribute(obj.getTitle()) %>"}'> 
                        
                        <%= glp("jcmsplugin.socle.ficheaide.localiser-carte.label") %> 
                    </a>
                </p>
            </jalios:if>

		</div>
		
		<%-- Col droite --%>
		<div class="col ds44--xl-padding-l">
		
	        <div class="ds44-docListElem mts">
	            <i class="icon icon-phone ds44-docListIco" aria-hidden="true"></i>
                <% String numTel = obj.getTelephone(); %>
                <ds:phone number="<%= numTel %>"/>
	        </div>

            <div class="ds44-docListElem mts">
                <i class="icon icon-mail ds44-docListIco" aria-hidden="true"></i>
                <%
                String email = obj.getAdresseMail();
                String emailTitle = HttpUtil.encodeForHTMLAttribute(glp("jcmsplugin.socle.contactmail", obj.getTitle(), email));
                %>
                 
                <a href='<%= "mailto:"+email %>' title='<%= emailTitle %>'><%= glp("jcmsplugin.socle.contactmail.label") %></a>
            </div>
            
            <div class="ds44-docListElem mts">
                <i class="icon icon-link ds44-docListIco" aria-hidden="true"></i>
                <%
                String site = obj.getSiteInternet();
                String siteTitle = HttpUtil.encodeForHTMLAttribute(glp("jcmsplugin.socle.lien.site.nouvelonglet", obj.getTitle()));
                %>
                <a href='<%= SocleUtils.parseUrl(site) %>' title='<%= siteTitle %>' target="_blank">
                    <%= glp("jcmsplugin.socle.ficheaide.visiter-site.label") %>
                </a>
            </div>
		
        </div>
    </div>
</jalios:buffer>

<main id="content" role="main">
    <article class="ds44-container-large">
    
        <ds:titleNoImage title="<%= obj.getTitle(userLang) %>" breadcrumb="true" coloredSection="<%= coloredSectionContent %>"></ds:titleNoImage>
      
		<section class="ds44-contenuArticle" id="section1">
            <div class="ds44-inner-container">
                <div class="ds44-grid12-offset-2">
                    <div class="grid-2-small-1">
                    
                        <div class="col mrs ds44-mtb3">
                            <h2 class="h3-like" id="idTitre-list1"><%= glp("jcmsplugin.socle.fichesaad.prestations") %></h2>
							<ul class="ds44-uList">
							     <%-- TODO 10/04/2020 : Gestion des infobulles : en cours de validation sur le DS--%>
                                <jalios:foreach collection="<%= obj.getPrestations(loggedMember) %>" type="Category" name="itCategory" >
                                    <li><%= itCategory.getName() %></a></li>
                                </jalios:foreach>
							</ul>
                        </div>
                        
			            <div class="col mls ds44-mtb3">
			              <h2 class="h3-like" id="idTitre-list2"><%= glp("jcmsplugin.socle.fichesaad.detail") %></h2>
			              <ul class="ds44-uList">
			                <li><strong><%= glp("jcmsplugin.socle.fichesaad.statut") %></strong> <ds:categoryList categories="<%= obj.getStatutJuridique(loggedMember) %>" tooltip="true" /></li>
			                <li><strong><%= glp("jcmsplugin.socle.fichesaad.plageintervention") %></strong> <ds:categoryList categories="<%= obj.getPlagesDintervention(loggedMember) %>" tooltip="true" /></li>
			                <li><strong><%= glp("jcmsplugin.socle.fichesaad.typeaide") %></strong> <ds:categoryList categories="<%= obj.getTypeDaide(loggedMember) %>" tooltip="true" /></li>
			                <li><strong><%= glp("jcmsplugin.socle.fichesaad.modalitespaiement") %></strong> <ds:categoryList categories="<%= obj.getModalitesDePaiement(loggedMember) %>" tooltip="true" /></li>
			                <li><strong><%= glp("jcmsplugin.socle.fichesaad.modesintervention") %></strong> <ds:categoryList categories="<%= obj.getModesDintervention(loggedMember) %>" tooltip="true" /></li>
			                <li><strong><%= glp("jcmsplugin.socle.fichesaad.modetarification") %></strong> <ds:categoryList categories="<%= obj.getModeDeTarification(loggedMember) %>" tooltip="true" /></li>
			              </ul>
			            </div>
			            
		          </div>
                </div>
            </div>
        </section>
        
        <%-- TODO : bloc des réseaux sociaux --%>

    </article>
</main>
