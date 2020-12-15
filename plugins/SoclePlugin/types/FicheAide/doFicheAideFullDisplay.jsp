<%@ page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%>
<%@ include file='/jcore/doInitPage.jspf'%>

<% 
	FicheAide obj = (FicheAide)request.getAttribute(PortalManager.PORTAL_PUBLICATION); 
	String imageFile = obj.getImageBandeau() ;
	String imageMobileFile = obj.getImageMobile();
	String title = obj.getTitle();
	String legende = obj.getLegende(userLang);
	String copyright = obj.getCopyright(userLang);
	
	boolean displayEnResume = Util.notEmpty(obj.getChapo()) || Util.notEmpty(obj.getPourQui());
	
	boolean displayDetails = Util.notEmpty(obj.getIntro())
								|| Util.notEmpty(obj.getEligibilite())
								|| Util.notEmpty(obj.getCestQuoi())
								|| Util.notEmpty(obj.getCommentFaireUneDemande())
								|| Util.notEmpty(obj.getQuelsDocumentsFournir());
	
	boolean displayFaq = Util.notEmpty(obj.getFaq());
	
	request.setAttribute("contactfaq", obj.getContactFAQ(userLang));
	
	boolean displayQuiContacter = Util.notEmpty(obj.getQuiContacter())
									|| Util.notEmpty(obj.getIntroContact())
									|| Util.notEmpty(obj.getComplementContact())
									|| Util.notEmpty(obj.getBesoinDaide())
									|| (Util.notEmpty(obj.getTypeDeLieu()) && obj.getInstructionDelegation());
	
	boolean hasContactCol = false;
	
	boolean displayFaireDemande = ( Util.notEmpty(obj.getEdemarche(loggedMember)) && Util.notEmpty(obj.getUrlEdemarche(userLang)) )  
									|| ( Util.isEmpty(obj.getEdemarche(loggedMember)) && Util.notEmpty(obj.getDocumentsUtiles()) ) 
									|| Util.notEmpty(obj.getIntroFaireUneDemande());
	
	Category publikCat = channel.getCategory("$jcmsplugin.socle.ficheaide.publik.root");
	
	boolean displaySuivreDemande = Util.notEmpty(obj.getIntroSuivreUneDemande()) || ((Util.notEmpty(obj.getUrlSuiviEdemarche()) || obj.hasCategory(publikCat)));
%>


<main role="main" id="content">

	<jalios:include target="SOCLE_ALERTE" />

	<section class="ds44-container-large">
		<jalios:select>
			<jalios:if predicate="<%=Util.notEmpty(obj.getImageBandeau()) && !clientBrowser.isSmallDevice() %>">
				<ds:titleBanner pub="<%= obj %>" imagePath="<%= imageFile %>" mobileImagePath="<%= imageMobileFile %>" title="<%= title %>" legend="<%=legende %>"
						copyright="<%=copyright%>" breadcrumb="true"></ds:titleBanner>
			</jalios:if>
			<jalios:default>
				<ds:titleNoBanner title="<%= title %>" breadcrumb="true"></ds:titleNoBanner>
			</jalios:default>
		</jalios:select>
		<section class="ds44-ongletsContainer">

			<div class="ds44-tabs" data-existing-hx="h2" data-tabs-prefix-class="ds44" id="onglets">
				<div class="ds44-theme ds44-flex-container ds44-flex-wrap-large">
					<nav role="navigation" aria-label='<%= glp("jcmsplugin.socle.navOnglet") %>' id="ligneOnglets"
						class="ds44-flex-container ds44-fg1 ds44-navOnglets ds44-hiddenPrint">
						<!-- Résumé / détail / FAQ -->
						<ul class="ds44-tabs__list ds44-fg1 ds44-flex-container ds44-list js-tabs" id="tabs">
							<jalios:if predicate="<%= displayEnResume %>">
								<li class="ds44-tabs__item ds44-fg1" id="tabs__1">
									<a href="#id_first" class="js-tablist__link ds44-tabs__link" id="label_id_first" aria-current="true"> 
										<%= glp("jcmsplugin.socle.onglet.resume") %>
									</a>
								</li>
							</jalios:if>
							<jalios:if predicate="<%= displayDetails %>">
								<li class="ds44-tabs__item ds44-fg1" id="tabs__2">
									<a href="#id_second" class="js-tablist__link ds44-tabs__link" id="label_id_second" aria-disabled="true"> 
										<%= glp("jcmsplugin.socle.onglet.detail") %>
									</a>
								</li>
							</jalios:if>
							<jalios:if predicate="<%= displayFaq %>">
								<li class="ds44-tabs__item ds44-fg1" id="tabs__3">
									<a href="#id_third" class="js-tablist__link ds44-tabs__link" id="label_id_third" aria-disabled="true"> 
										<%= glp("jcmsplugin.socle.onglet.faq") %>
									</a>
								</li>
							</jalios:if>
						</ul>
					</nav>

					<div class="ds44-flex-container ds44-flex-grow1-large ds44-fse">
						<!-- Contact / faire demande / suivre demande  -->
						<ul class="ds44-flex-container ds44--l-padding-tb ds44-blocBtnOnglets ds44-list">
							<jalios:if predicate="<%= displayQuiContacter %>">
								<li class="mrs mls ds44-ongletsBtnItem">
									<button class="ds44-btnStd ds44-btn--invert" type="button" data-target="#overlay-qui-contacter" 
											data-js="ds44-modal" data-open-overlay="true">
										<span class="ds44-btnInnerText"><%= glp("jcmsplugin.socle.demande.qui-contacter") %></span> 
										<i class="icon icon-phone icon--sizeL" aria-hidden="true"></i>
									</button>
								</li>
							</jalios:if>
							<jalios:if predicate="<%= displayFaireDemande %>">
								<li class="mrs ds44-ongletsBtnItem">
									<button class="ds44-btnStd ds44-btn--invert" type="button" data-target="#overlay-faire-demande" 
											data-js="ds44-modal" data-open-overlay="true">
										<span class="ds44-btnInnerText"><%= glp("jcmsplugin.socle.demande.faire-demande") %></span> 
										<i class="icon icon-file icon--sizeL" aria-hidden="true"></i>
									</button>
								</li>
							</jalios:if>
							<jalios:if predicate="<%= displaySuivreDemande %>">
								<li class="mrs ds44-ongletsBtnItem">
									<button class="ds44-btnStd ds44-btn--invert" type="button" data-target="#overlay-suivre-demande" 
											data-js="ds44-modal" data-open-overlay="true">
										<span class="ds44-btnInnerText"><%= glp("jcmsplugin.socle.demande.suivre-demande") %></span> 
										<i class="icon icon-computer icon--sizeL" aria-hidden="true"></i>
									</button>
								</li>
							</jalios:if>
						</ul>
					</div>
				</div>

				<!--  En résumé -->
				<jalios:if predicate="<%= displayEnResume %>">
					<div id="id_first" class="js-tabcontent ds44-tabs__content ds44-inner-container ds44-xl-margin-tb" 
							aria-labelledby="label_id_first">
						<a name="onglet-1" id="onglet-1"></a>
						<h2 class="visually-hidden" tabindex="-1"><%= glp("jcmsplugin.socle.ficheaide.premier-onglet.label") %></h2>
						<div class="grid-12-small-1">
							<div class="col-7">
								<jalios:if predicate="<%= Util.notEmpty(obj.getChapo()) %>">
									<div class="ds44-introduction">
										<jalios:wysiwyg><%= obj.getChapo() %></jalios:wysiwyg>
									</div>
								</jalios:if>
								<jalios:if predicate="<%= Util.notEmpty(obj.getPourQui()) %>">
									<h2 class="h2-like mtm"><%= glp("jcmsplugin.socle.titre.pour-qui") %></h2>
									<jalios:wysiwyg><%= obj.getPourQui() %></jalios:wysiwyg>
								</jalios:if>
							</div>

							<div class="col-1 grid-offset ds44-hide-tiny-to-medium"></div>

							<aside class="col-4">
								<%@ include file="doFicheAideEncadre.jspf"%>
							</aside>

						</div>

						<p class="ds44-keyboard-show">
							<a href="#label_id_first"> 
								<%= glp("jcmsplugin.socle.revenirOnglet", glp("jcmsplugin.socle.onglet.resume")) %>
							</a>
						</p>

					</div>
				</jalios:if>

				<!-- En détail -->
				<jalios:if predicate="<%= displayDetails %>">
					<div id="id_second" class="js-tabcontent ds44-tabs__content ds44-inner-container ds44-xl-margin-tb" 
							aria-labelledby="label_id_second" aria-hidden="true">
						<a name="onglet-2" id="onglet-2"></a>
						<h2 class="visually-hidden" tabindex="-1"><%= glp("jcmsplugin.socle.ficheaide.deuxieme-onglet.label") %></h2>
						<div class="grid-12-small-1">
							<div class="col-7">
								<jalios:if predicate="<%= Util.notEmpty(obj.getIntro()) %>">
									<div class="ds44-introduction">
										<jalios:wysiwyg><%= obj.getIntro()%></jalios:wysiwyg>
									</div>
								</jalios:if>
								<jalios:if predicate="<%= Util.notEmpty(obj.getEligibilite()) %>">
									<section id="section1" class="ds44-contenuArticle">
										<h2 class="h2-like"><%= glp("jcmsplugin.socle.titre.pour-qui") %></h2>
										<jalios:wysiwyg><%= obj.getEligibilite() %></jalios:wysiwyg>
									</section>
								</jalios:if>

								<jalios:if predicate="<%= Util.notEmpty(obj.getCestQuoi()) %>">
									<section id="section2" class="ds44-contenuArticle">
										<h2 class="h2-like"><%= glp("jcmsplugin.socle.titre.quoi") %></h2>
										<jalios:wysiwyg><%= obj.getCestQuoi() %></jalios:wysiwyg>
									</section>
								</jalios:if>

								<jalios:if predicate="<%= Util.notEmpty(obj.getCommentFaireUneDemande()) %>">
									<section id="section3" class="ds44-contenuArticle">
										<h2 class="h2-like"><%= glp("jcmsplugin.socle.titre.comment-demande") %></h2>
										<jalios:wysiwyg><%= obj.getCommentFaireUneDemande() %></jalios:wysiwyg>
									</section>
								</jalios:if>

								<jalios:if predicate="<%= Util.notEmpty(obj.getQuelsDocumentsFournir()) %>">
									<section id="section4" class="ds44-contenuArticle">
										<h2 class="h2-like"><%= glp("jcmsplugin.socle.titre.fournir-documents") %></h2>
										<jalios:wysiwyg><%= obj.getQuelsDocumentsFournir() %></jalios:wysiwyg>
									</section>
								</jalios:if>
							</div>

							<div class="col-1 grid-offset ds44-hide-tiny-to-medium"></div>

							<aside class="col-4">
								<%@ include file="doFicheAideEncadre.jspf"%>
							</aside>

						</div>

						<p class="ds44-keyboard-show">
							<a href="#label_id_second"> 
								<%= glp("jcmsplugin.socle.revenirOnglet", glp("jcmsplugin.socle.onglet.detail")) %>
							</a>
						</p>

					</div>
				</jalios:if>

				<!-- FAQ -->
				<jalios:if predicate="<%= displayFaq %>">
					<div id="id_third" class="js-tabcontent ds44-tabs__content ds44-inner-container ds44-xl-margin-tb" 
							aria-labelledby="label_id_third" aria-hidden="true">
						<a name="onglet-3" id="onglet-3"></a>
						<h2 class="visually-hidden" tabindex="-1"><%= glp("jcmsplugin.socle.ficheaide.troisieme-onglet.label") %></h2>
						<jalios:if predicate="<%= Util.notEmpty(obj.getFaq()) %>">
							<% 
								ServletUtil.backupAttribute(pageContext, PortalManager.PORTAL_PUBLICATION);
								request.setAttribute("pubParent",obj);
							%>
							<jalios:include pub="<%= obj.getFaq() %>" usage="full" />
							<% ServletUtil.restoreAttribute(pageContext, PortalManager.PORTAL_PUBLICATION); %>
						</jalios:if>

						<p class="ds44-keyboard-show">
							<a href="#label_id_third"> 
								<%= glp("jcmsplugin.socle.revenirOnglet", glp("jcmsplugin.socle.onglet.faq")) %>
							</a>
						</p>
					</div>
				</jalios:if>


			</div>

			<%-- Partagez cette page --%>
			<%@ include file="/plugins/SoclePlugin/jsp/portal/socialNetworksShare.jspf"%>

		</section>

	</section>

	<%-- Page utile --%>
	<jsp:include page="/plugins/SoclePlugin/types/PageUtileForm/editFormPageUtileForm.jsp" />

</main>

<jalios:if predicate="<%= displayFaireDemande %>">
	<section class="ds44-modal-container" id="overlay-faire-demande" aria-hidden="true" role="dialog" aria-modal="true" 
			aria-labelledby="overlay-faire-demande-title">
		<div class="ds44-modal-box">
			<button class="ds44-btnOverlay--modale ds44-btnOverlay--closeOverlay" type="button"
					aria-label='<%= glp("jcmsplugin.socle.ficheaide.fermerboitedialogue.label", glp("jcmsplugin.socle.demande.faire-demande")) %>'
					data-js="ds44-modal-action-close">
				<i class="icon icon-cross icon--xlarge" aria-hidden="true"></i> 
				<span class="ds44-btnInnerText--bottom"><%= glp("jcmsplugin.socle.fermer") %></span>
			</button>

			<h1 id="overlay-faire-demande-title" class="h2-like"><%= glp("jcmsplugin.socle.demande.faire-demande") %></h1>

			<div class="ds44-modal-gab">

				<jalios:wysiwyg><%= obj.getIntroFaireUneDemande(userLang) %></jalios:wysiwyg>

				<div class="ds44-mt3 grid-12-small-1">
					<jalios:if predicate="<%= Util.notEmpty(obj.getDocumentsUtiles()) %>">
						<% 
							boolean is6col = Util.notEmpty(obj.getEdemarche(loggedMember)) 
											|| Util.notEmpty(obj.getQuiContacter()) 
											|| (obj.getInstructionDelegation() && Util.notEmpty(obj.getTypeDeLieu())); 
						%>
						<div class='col-<%= is6col ? "6 ds44-modal-column" : "12" %> '>
							<h2 class="h4-like" id="titre_documents_utiles"><%= glp("jcmsplugin.socle.ficheaide.docutils.label") %></h2>
							<ul class="ds44-list">
								<jalios:foreach name="itDoc" type="FileDocument" collection="<%= Arrays.asList(obj.getDocumentsUtiles()) %>">
									<li class="mts">
										<% 
											// Récupérer l'extension du fichier
											String fileType = FileDocument.getExtension(itDoc.getFilename()).toUpperCase();
											// Récupérer la taille du fichier
											String fileSize = Util.formatFileSize(itDoc.getSize(), userLocale);
											
											String fileUrl = ServletUtil.getBaseUrl(request) + itDoc.getDownloadUrl(); 
										%>
										<p class="ds44-docListElem">
											<i class="icon icon-file ds44-docListIco" aria-hidden="true"></i>
											<% String titleModalFaireDemande = itDoc.getTitle() + " - " + fileType + " - " + fileSize + " - " + glp("jcmsplugin.socle.accessibily.newTabLabel"); %>
											<a href="<%= itDoc.getDownloadUrl() %>" target="_blank" title='<%= HttpUtil.encodeForHTMLAttribute(titleModalFaireDemande) %>'
											   data-statistic='{"name": "declenche-evenement","category": "Téléchargement","action": "<%= fileUrl %>","label": "Faire une demande"}'>
												<%= itDoc.getTitle() %>
											</a> 
											<span class="ds44-cardFile"><%= fileType %> - <%= fileSize %></span>
										</p>
									</li>
								</jalios:foreach>
							</ul>
						</div>
					</jalios:if>

					<jalios:select>

						<jalios:if predicate="<%= Util.notEmpty(obj.getEdemarche(loggedMember)) %>">
							<div class='col-<%= Util.notEmpty(obj.getDocumentsUtiles()) ? "6 ds44-modal-column" : "12" %>'>

								<h2 class="h4-like" id="titre_en_ligne"><%= glp("jcmsplugin.socle.ficheaide.enligne.label") %></h2>

								<p>
									<a class="ds44-btnStd ds44-btn--invert mts" href="<%= obj.getUrlEdemarche(userLang)  %>"
											title='<%= glp("jcmsplugin.socle.ficheaide.fairedemandelignelink.label") %> <%= glp("jcmsplugin.socle.accessibily.newTabLabel") %>'
											data-statistic='{"name": "declenche-evenement","category": "Demande en ligne","action": "Clic","label": "Faire une demande"}'
											target="_blank"> 
										<span class="ds44-btnInnerText"><%= glp("jcmsplugin.socle.ficheaide.fairedemandeligne.label") %></span> 
										<i class="icon icon-computer icon--sizeL" aria-hidden="true"></i>
									</a>
								</p>
								<jalios:if predicate="<%= Util.notEmpty(obj.getDureeEdemarche()) %>">
									<p><%= glp("jcmsplugin.socle.ficheaide.duree.label") %> <%= obj.getDureeEdemarche() %></p>
								</jalios:if>
							</div>
						</jalios:if>

						<%-- Faire une demande recherche par sectorisation --%>
						<jalios:if predicate="<%= Util.isEmpty(obj.getEdemarche(loggedMember)) && obj.getInstructionDelegation() && Util.notEmpty(obj.getTypeDeLieu()) %>">
							<div class='col-<%= Util.notEmpty(obj.getDocumentsUtiles()) ? "6 ds44-modal-column" : "12" %>'>

								<div id="rechercheDemande">
									<h2 class="h4-like" id="titre_envoie_dossier"><%= glp("jcmsplugin.socle.ficheaide.adresseenvoiedossier.label") %></h2>
									<%
										String idFormCommune = "demande-commune";
										String idFormAdresse = "demande-adresse";
										String idResultInLine = "demandeResult";
									%>
									<%@ include file="/plugins/SoclePlugin/types/FicheAide/doFicheAideFormSectorisation.jspf"%>
								</div>
								<div id="<%= idResultInLine %>"></div>

							</div>
						</jalios:if>


						<jalios:if predicate="<%= Util.isEmpty(obj.getEdemarche(loggedMember)) && Util.notEmpty(obj.getQuiContacter()) %>">
							<div class='col-<%= Util.notEmpty(obj.getDocumentsUtiles()) ? "6 ds44-modal-column" : "12" %>'>

								<h2 class="h4-like" id="titre_envoie_dossier">
									<jalios:select>
										<jalios:if predicate='<%= Util.isEmpty(obj.getDocumentsUtiles()) %>'>
											<%= glp("jcmsplugin.socle.ficheaide.modal.quicontacter") %>
										</jalios:if>
										<jalios:default>
											<%= glp("jcmsplugin.socle.ficheaide.adresseenvoiedossier.label") %>
										</jalios:default>
									</jalios:select>
								</h2>

								<jalios:foreach name="itFicheLieu" type="FicheLieu" array='<%= obj.getQuiContacter() %>' counter="lieuCounter">

									<jalios:media data="<%= itFicheLieu %>" template="contact" />

									<jalios:if predicate="<%= lieuCounter != obj.getQuiContacter().length %>">
										<hr />
									</jalios:if>

								</jalios:foreach>
							</div>
						</jalios:if>
					</jalios:select>
				</div>
			</div>
		</div>
	</section>
</jalios:if>

<jalios:if predicate="<%= displaySuivreDemande %>">
	<section class="ds44-modal-container" id="overlay-suivre-demande" aria-hidden="true" role="dialog" aria-modal="true" 
			aria-labelledby="overlay-suivre-demande-title">
		<div class="ds44-modal-box">
			<button class="ds44-btnOverlay--modale ds44-btnOverlay--closeOverlay" type="button"
				title='<%= glp("jcmsplugin.socle.ficheaide.fermerboitedialogue.label", glp("jcmsplugin.socle.ficheaide.suivre.label")) %>'
				data-js="ds44-modal-action-close">
				<i class="icon icon-cross icon--xlarge" aria-hidden="true"></i> 
				<span class="ds44-btnInnerText--bottom"><%= glp("jcmsplugin.socle.fermer") %></span>
			</button>

			<h1 id="overlay-suivre-demande-title" class="h2-like"><%= glp("jcmsplugin.socle.ficheaide.suivre.label") %></h1>

			<div class="ds44-modal-gab">
				<jalios:if predicate="<%= Util.notEmpty(obj.getIntroSuivreUneDemande()) %>">
					<jalios:wysiwyg><%= obj.getIntroSuivreUneDemande() %></jalios:wysiwyg>
				</jalios:if>


				<jalios:if predicate="<%= Util.notEmpty(obj.getEdemarche(loggedMember)) && (Util.notEmpty(obj.getUrlSuiviEdemarche()) || obj.hasCategory(publikCat))  %>">
					<div class="ds44-mt3 grid-12-small-1">


						<%-- Formulaire de suivi vers le site demarche.loire-altantique.fr --%>
						<jalios:if predicate="<%= Util.isEmpty(obj.getUrlSuiviEdemarche()) && obj.hasCategory(publikCat) %>">

							<div class="col-6 ds44-modal-column">
								<h2 class="h4-like" id="titre_a_code_suivi"><%= glp("jcmsplugin.socle.ficheaide.modal.suivredemande.acodesuivi") %></h2>

								<p id="desc-pour-input-suivre-demande"><%= glp("jcmsplugin.socle.ficheaide.modal.suivredemande.saisiscodesuivi") %></p>

								<form action='plugins/SoclePlugin/types/FicheAide/redirectDemandeCodeSuivi.jsp' target="_blank">
									<% String idFormElement = ServletUtil.generateUniqueDOMId(request, "form-element"); %>
									<div class="ds44-form__container">

										<div class="ds44-posRel">

											<label for="<%= idFormElement %>" class="ds44-formLabel">
												<span class="ds44-labelTypePlaceholder">
													<span>
														<%= glp("jcmsplugin.socle.ficheaide.modal.suivredemande.codesuivi") %>
														<sup aria-hidden="true"><%= glp("jcmsplugin.socle.facette.asterisque") %></sup>
													</span>
												</span>
											</label> 

											<input type="text" id="<%= idFormElement %>" name="<%= idFormElement %>" class="ds44-inpStd"
												title='<%= glp("jcmsplugin.socle.ficheaide.modal.suivredemande.codesuivi") %> - <%= glp("jcmsplugin.socle.obligatoire") %>' 
												required aria-describedby="explanation-<%= idFormElement %>" />
											<button class="ds44-reset" type="button">
												<i class="icon icon-cross icon--sizeL" aria-hidden="true"></i>
												<span class="visually-hidden"><%= glp("jcmsplugin.socle.facette.effacer-contenu-champ", glp("jcmsplugin.socle.ficheaide.modal.suivredemande.codesuivi")) %></span>
											</button>
										</div>

										<div class="ds44-field-information" aria-live="polite">
											<ul class="ds44-field-information-list ds44-list">
												<li id="explanation-<%= idFormElement %>" class="ds44-field-information-explanation"><%= glp("jcmsplugin.socle.ficheaide.modal.suivredemande.exemplecodesuivi") %></li>
											</ul>
										</div>

									</div>


									<button class="ds44-btnStd ds44-btn--invert" title='<%= glp("jcmsplugin.socle.ficheaide.modal.suivredemande.validercodesuivi") %>'>
										<span class="ds44-btnInnerText"><%= glp("jcmsplugin.socle.valider") %></span> 
										<i class="icon icon-long-arrow-right" aria-hidden="true"></i>
									</button>

								</form>
							</div>

						</jalios:if>


						<div class='col-<%=  Util.notEmpty(obj.getUrlSuiviEdemarche()) ? "12" : "6 ds44-modal-column" %>'>
							<%
								String SuivreDemandetitre = Util.notEmpty(obj.getUrlSuiviEdemarche()) ? glp("jcmsplugin.socle.ficheaide.modal.suivredemande.suivrevotredemande") : glp("jcmsplugin.socle.ficheaide.modal.suivredemande.apascodesuivi");
								String urlSuivreDemande = Util.notEmpty(obj.getUrlSuiviEdemarche()) ? obj.getUrlSuiviEdemarche() : glp("jcmsplugin.socle.ficheaide.demarche.login.url");
							%>

							<h2 class="h4-like" id="titre_a_pas_code_suivi"><%= SuivreDemandetitre %></h2>

							<p class="ds44-mt-std">
								<a class="ds44-btnStd ds44-btn--invert" href='<%= HttpUtil.encodeForHTMLAttribute(urlSuivreDemande) %>'
										title='<%= glp("jcmsplugin.socle.ficheaide.fairedemandelignelink.label") %> <%= glp("jcmsplugin.socle.accessibily.newTabLabel") %>'
										target="_blank"> 
									<span class="ds44-btnInnerText"><%= glp("jcmsplugin.socle.ficheaide.modal.suivredemande.connectezvous") %></span> 
									<i class="icon icon-computer icon--sizeL" aria-hidden="true"></i>
								</a>
							</p>

						</div>

					</div>
				</jalios:if>


			</div>
		</div>
	</section>
</jalios:if>

<jalios:if predicate="<%= displayQuiContacter %>">
	<section class="ds44-modal-container" id="overlay-qui-contacter" aria-hidden="true" role="dialog" aria-modal="true" 
			aria-labelledby="overlay-qui-contacter-title">
		<div class="ds44-modal-box">
			<button class="ds44-btnOverlay--modale ds44-btnOverlay--closeOverlay" type="button"
					title='<%= HttpUtil.encodeForHTMLAttribute(glp("jcmsplugin.socle.ficheaide.fermerboitedialogue.label", glp("jcmsplugin.socle.demande.qui-contacter"))) %>'
					data-js="ds44-modal-action-close">
				<i class="icon icon-cross icon--xlarge" aria-hidden="true"></i>
				<span class="ds44-btnInnerText--bottom"><%= glp("jcmsplugin.socle.fermer") %></span>
			</button>
			<h1 id="overlay-qui-contacter-title" class="h2-like"><%= glp("jcmsplugin.socle.ficheaide.modal.quicontacter") %></h1>
			<div class="ds44-modal-gab">
				<jalios:if predicate="<%= Util.notEmpty(obj.getIntroContact()) %>">
					<jalios:wysiwyg><%= obj.getIntroContact() %></jalios:wysiwyg>
				</jalios:if>

				<div class="ds44-mt3 grid-12-small-1">


					<jalios:select>
						<%-- Contact faire une recherche par sectorisation --%>
						<jalios:if predicate="<%= obj.getInstructionDelegation() && Util.notEmpty(obj.getTypeDeLieu()) %>">
							<% hasContactCol = true; %>
							<div class='col-<%= Util.isEmpty(obj.getBesoinDaide()) ? "12" : "6 ds44-modal-column" %>'>
								<div id="rechercheContact">
									<h2 class="h4-like" id="modal-contact-title"><%= glp("jcmsplugin.socle.contact.trouver-contact") %></h2>
									<%
										String idFormCommune = "contact-commune";
										String idFormAdresse = "contact-adresse";
										String idResultInLine = "aideContactResult";
									%>
									<%@ include file="/plugins/SoclePlugin/types/FicheAide/doFicheAideFormSectorisation.jspf"%>
								</div>
								<div id="<%= idResultInLine %>"></div>

							</div>

						</jalios:if>

						<jalios:default>

							<jalios:if predicate="<%= Util.notEmpty(obj.getQuiContacter()) || Util.notEmpty(obj.getComplementContact()) %>">
								<% hasContactCol = true; %>
								<div class='col-<%= Util.isEmpty(obj.getBesoinDaide()) ? "12" : "6 ds44-modal-column" %>'>

									<jalios:if predicate="<%= Util.notEmpty(obj.getComplementContact()) %>">
										<jalios:wysiwyg><%= obj.getComplementContact() %></jalios:wysiwyg>
									</jalios:if>
									<div class="ds44-mt1"></div>
									<jalios:foreach name="itLieu" type="FicheLieu" array="<%= obj.getQuiContacter() %>" counter="lieuCounter">

										<jalios:media data="<%= itLieu %>" template="contact" />

										<jalios:if predicate="<%= lieuCounter != obj.getQuiContacter().length %>">
											<hr />
										</jalios:if>

									</jalios:foreach>

								</div>
							</jalios:if>

						</jalios:default>
					</jalios:select>





					<jalios:if predicate="<%= Util.notEmpty(obj.getBesoinDaide()) %>">
						<div class='col-<%= !hasContactCol ? "12" : "6 ds44-modal-column" %>'>
							<h2 class="h3-like" id="titre_besoin_aide"><%= glp("jcmsplugin.socle.ficheaide.modal.besoinaide") %></h2>
							<jalios:wysiwyg>
								<%= obj.getBesoinDaide() %>
							</jalios:wysiwyg>
							</p>
						</div>
					</jalios:if>
				</div>


			</div>
		</div>

	</section>
</jalios:if>