<%@page import="com.jalios.jcms.handler.QueryHandler"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%>
<%@ include file='/jcore/doInitPage.jspf'%>
<%
	Dossier obj = (Dossier) request.getAttribute(PortalManager.PORTAL_PUBLICATION);
%>
<%@ include file='/front/doFullDisplay.jspf'%>
<%@ page import="fr.cg44.plugin.socle.SocleUtils"%>

<main role="main" id="content">

    <jalios:include target="SOCLE_ALERTE"/>

	<section class="ds44-container-large">
		<ds:titleBanner pub="<%= obj %>" imagePath="<%= obj.getImageBandeau() %>" mobileImagePath="<%= obj.getImageMobile() %>" title="<%= obj.getTitle(userLang) %>"
				legend="<%= obj.getLegende(userLang) %>" copyright="<%= obj.getCopyright(userLang) %>" breadcrumb="true"></ds:titleBanner>
	</section>

	<section class="ds44-container-large">
		<div class="ds44-mt3 ds44--xl-padding-t">
			<div class="ds44-inner-container">
				<div class="grid-12-medium-1 grid-12-small-1">

					<aside class="col-4 ds44-hide-tiny-to-medium ds44-js-aside-summary">
						<section class="ds44-box ds44-theme">
							<div class="ds44-innerBoxContainer">
								<p role="heading" aria-level="2" class="ds44-box-heading"><%= glp("jcmsplugin.socle.dossier.sommaire") %></p>
								<ul class="ds44-list ds44-list--puces">
									<jalios:foreach type="String" name="itTitreRubrique" array="<%= obj.getTitreRubrique(userLang) %>">
									   <jalios:if predicate="<%= Util.notEmpty(obj.getTitreRubrique(userLang)[itCounter-1])%>">
										  <li><a href="#section<%= itCounter %>"><%= itTitreRubrique %></a></li>
										</jalios:if>
									</jalios:foreach>
								</ul>
							</div>
						</section>
					</aside>

					<div class="col-1 grid-offset ds44-hide-tinyToLarge"></div>

					<article class="col-7 ds44-contenuDossier">
						<jalios:if predicate="<%= Util.notEmpty(obj.getDate()) %>">
							<p class="ds44-textLegend"><%= glp("jcmsplugin.socle.publiele", SocleUtils.formatDate("dd/MM/yy", obj.getDate())) %></p>
						</jalios:if>
						<jalios:if predicate="<%= Util.notEmpty(obj.getChapo(userLang)) %>">
							<div class="ds44-introduction">
								<jalios:wysiwyg><%= obj.getChapo(userLang) %></jalios:wysiwyg>
							</div>
						</jalios:if>
						
						<jalios:foreach type="String" name="itParagrapheRubrique" array="<%= obj.getParagrapheRubrique(userLang) %>">
							<section class="ds44-contenuArticle" id="section<%= itCounter %>" tabindex="-1">
								<jalios:if predicate="<%= obj.getTitreRubrique(userLang).length >= itCounter && Util.notEmpty(obj.getTitreRubrique(userLang)[itCounter-1])%>">
									<h2 id="idTitre<%= itCounter+1 %>"><%= obj.getTitreRubrique(userLang)[itCounter-1] %></h2>
								</jalios:if>
								<jalios:wysiwyg><%= itParagrapheRubrique %></jalios:wysiwyg>
							</section>
						</jalios:foreach>

					</article>
				</div>
			</div>
		</div>
	</section>

	<%-- Partagez cette page --%>
    <%@ include file="/plugins/SoclePlugin/jsp/portal/socialNetworksShare.jspf" %>

	<%-- TODO : bloc Je m'abonne --%>
	<jalios:if predicate='<%=Util.notEmpty(channel.getProperty("jcmsplugin.socle.portletPush.ficheactu.id"))%>'>
		<jalios:include id='<%=channel.getProperty("jcmsplugin.socle.portletPush.ficheactu.id")%>' />
	</jalios:if>

	<%-- Sur le même thème
         Affichage de contenus catégorisés sous "Mise en  avant > En ce moment" et ayant au moins un catégorie commune parmi
         les catégories de navigation du dossier (branche "Navigation des espaces")
        --%>
        <%
        // Récupération des catégories de navigation
        Category navigationDesEspacesCat = channel.getCategory(channel.getProperty("jcmsplugin.socle.site.menu.cat.root"));
        Set<Category> navCat = new TreeSet<Category>();
        if(Util.notEmpty(obj.getCategorieDeNavigation(loggedMember))){
	        for(Category itCat:obj.getCategorieDeNavigation(loggedMember)){
	            if(itCat.hasAncestor(navigationDesEspacesCat)){
	                navCat.add(itCat);
	            }
	        }
        }
        %>
        
        <jalios:if predicate='<%= !navCat.isEmpty() && Util.notEmpty(channel.getProperty("$jcmsplugin.socle.category.enCeMoment.root"))%>'>
            <% 
            // Récupération des publications catégorisées dans "En ce moment"
            QueryHandler qhEnCeMoment = new QueryHandler();
            qhEnCeMoment.setCids(channel.getProperty("$jcmsplugin.socle.category.enCeMoment.root"));
            qhEnCeMoment.setLoggedMember(loggedMember);
            qhEnCeMoment.setTypes("Content");
            QueryResultSet resultEnCeMomentSet = qhEnCeMoment.getResultSet();
            SortedSet<Publication> listPubsEnCeMomentSet = resultEnCeMomentSet.getAsSortedSet(Publication.getPdateComparator());
            
            // Récupération des publication catégorisées dans au moins une des thématiques du communiqué courant.
            QueryHandler qhThemes= new QueryHandler();
            String[] themeCids = JcmsUtil.dataArrayToStringArray(navCat.toArray(new Data[navCat.size()]));
            qhThemes.setCatMode("or");
            qhThemes.setCids(themeCids);
            qhThemes.setLoggedMember(loggedMember);
            qhThemes.setTypes("Content");
            QueryResultSet resultThemesSet = qhThemes.getResultSet();
            SortedSet<Publication> listPubsThemesSet = resultThemesSet.getAsSortedSet(Publication.getPdateComparator());
            
            // Intersection des 2 sets
            Set<Publication> sameThemePubSet = new TreeSet<Publication>(Publication.getPdateComparator()); 
            sameThemePubSet.addAll(Util.interSet(listPubsEnCeMomentSet, listPubsThemesSet));
            
            // Suppression de la pub courante
            sameThemePubSet.remove(obj);
            %>
    
            <jalios:if predicate='<%= !sameThemePubSet.isEmpty() %>'>
                <%
                // Transfo du set en tableau pour passer au carrousel
                Content[] sameThemePubArray = sameThemePubSet.toArray(new Content[sameThemePubSet.size()]);
                
                // Instanciation de la portlet carrousel avec les pubs de même thème
                PortletCarousel carouselEnCeMoment = new PortletCarousel();
                carouselEnCeMoment.setTitreDuBloc(glp("jcmsplugin.socle.memetheme"));
                carouselEnCeMoment.setTemplate("box.sliderQuatre");
                carouselEnCeMoment.setSelectionDuTheme("tuileVerticaleLight");
                carouselEnCeMoment.setPositionTitre("bl");
                carouselEnCeMoment.setFirstPublications(sameThemePubArray);
                %>
                
                <jalios:include pub="<%= carouselEnCeMoment %>"/>
                
            </jalios:if>
            
        </jalios:if>
        

</main>

<button class="ds44-btnStd ds44-btn--invert ds44-fullWBtn ds44-btn-fixed ds44-show-tinyToLarge ds44-hide-large" id="ds44-summary-button" type="button"
	data-target="#navSommaire">
	<span class="ds44-btnInnerText"><%= glp("jcmsplugin.socle.dossier.sommaire") %></span><i class="icon icon-summary" aria-hidden="true"></i>
</button>

<section id="summaryMenu" class="ds44-overlay ds44-overlay--navFromBottom" aria-modal="true" role="dialog" aria-label='<%= glp("jcmsplugin.socle.dossier.sommaire") %>' aria-hidden="true"
	aria-labelledby="titreSommaire">
	<div class="ds44-container-menuBackLink">
		<p role="heading" aria-level="1" class="ds44-menuBackLink" id="titreRechercher"><%= glp("jcmsplugin.socle.dossier.sommaire") %></p>
	</div>
	<button type="button" class="ds44-btnOverlay ds44-btnOverlay--closeOverlay" aria-label='<%= glp("jcmsplugin.socle.dossier.fermer-menu-sommaire") %>'>
		<i class="icon icon-cross icon--xlarge" aria-hidden="true"></i><span class="ds44-btnInnerText--bottom"><%= glp("jcmsplugin.socle.fermer") %></span>
	</button>
	<p id="titreSommaire" role="heading" aria-level="1" class="visually-hidden"><%= glp("jcmsplugin.socle.dossier.menu-sommaire") %></p>
	<div class="ds44-flex-container ds44-flex-valign-center ds44-flex-align-center ds44-hv100 ds44-container-large ds44-tiny-to-med-atop ds44-ttl-pt9">
		<div class="ds44-grid-valign-center ds44-w100">
			<ul class="ds44-list ds44-list--puces">
				<jalios:foreach type="String" name="itTitreRubrique" array="<%= obj.getTitreRubrique() %>">
					<li><a href="#section<%= itCounter %>"><%= itTitreRubrique %></a></li>
				</jalios:foreach>
			</ul>
		</div>
	</div>

</section>