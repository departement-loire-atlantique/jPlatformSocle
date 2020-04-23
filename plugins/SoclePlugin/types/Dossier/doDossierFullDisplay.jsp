<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%>
<%@ include file='/jcore/doInitPage.jspf'%>
<%
	Dossier obj = (Dossier) request.getAttribute(PortalManager.PORTAL_PUBLICATION);
%>
<%@ include file='/front/doFullDisplay.jspf'%>
<%@ page import="fr.cg44.plugin.socle.SocleUtils"%>

<main role="main" id="content">

	<section class="ds44-container-large">
		<ds:titleBanner imagePath="<%= obj.getImageBandeau() %>" mobileImagePath="<%= obj.getImageMobile() %>" title="<%= obj.getTitle() %>"
				legend="<%= obj.getLegende() %>" copyright="<%= obj.getCopyright() %>" breadcrumb="true"></ds:titleBanner>
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
									<jalios:foreach type="String" name="itTitreRubrique" array="<%= obj.getTitreRubrique() %>">
										<li><a href="#section<%= itCounter %>"><%= itTitreRubrique %></a></li>
									</jalios:foreach>
								</ul>
							</div>
						</section>
					</aside>

					<div class="col-1 grid-offset ds44-hide-tinyToLarge"></div>

					<article class="col-7">
						<jalios:if predicate="<%= Util.notEmpty(obj.getDate()) %>">
							<p class="ds44-textLegend"><%= glp("jcmsplugin.socle.publieele", SocleUtils.formatDate("dd/MM/yy", obj.getDate())) %></p>
						</jalios:if>
						<jalios:if predicate="<%= Util.notEmpty(obj.getChapo()) %>">
							<p class="ds44-introduction"><%= obj.getChapo() %></p>
						</jalios:if>
						
						<jalios:foreach type="String" name="itParagrapheRubrique" array="<%= obj.getParagrapheRubrique() %>">
							<section class="ds44-contenuArticle" id="section<%= itCounter %>">
								<jalios:if predicate="<%= obj.getTitreRubrique().length >= itCounter && Util.notEmpty(obj.getTitreRubrique()[itCounter-1])%>">
									<h2 id="idTitre<%= itCounter+1 %>"><%= obj.getTitreRubrique()[itCounter-1] %></h2>
								</jalios:if>
								<jalios:wysiwyg><%= itParagrapheRubrique %></jalios:wysiwyg>
							</section>
						</jalios:foreach>

					</article>
				</div>
			</div>
		</div>
	</section>

	<%-- TODO : bloc des réseaux sociaux --%>

	<%-- TODO : bloc Je m'abonne --%>
	<jalios:if predicate='<%=Util.notEmpty(channel.getProperty("jcmsplugin.socle.portletPush.ficheactu.id"))%>'>
		<jalios:include id='<%=channel.getProperty("jcmsplugin.socle.portletPush.ficheactu.id")%>' />
	</jalios:if>

	<%-- TODO : bloc "Sur le même thème --%>

</main>

<button class="ds44-btnStd ds44-btn--invert ds44-fullWBtn ds44-btn-fixed ds44-show-tinyToLarge ds44-hide-large" id="ds44-summary-button" type="button"
	data-target="#navSommaire">
	<span class="ds44-btnInnerText"><%= glp("jcmsplugin.socle.dossier.sommaire") %></span><i class="icon icon-summary" aria-hidden="true"></i>
</button>

<section id="summaryMenu" class="ds44-overlay ds44-overlay--navFromBottom" role="dialog" aria-label='<%= glp("jcmsplugin.socle.dossier.sommaire") %>' aria-hidden="true"
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