<%@page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@ page contentType="text/html; charset=UTF-8" %><%
%><%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%><%
%><%@ include file='/jcore/doInitPage.jspf' %>
<%@ page import="fr.cg44.plugin.socle.SocleUtils"%><%
%><% FicheAide obj = (FicheAide)request.getAttribute(PortalManager.PORTAL_PUBLICATION); 
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
        || Util.notEmpty(obj.getBesoinDaide());

boolean displayFaireDemande = Util.notEmpty(obj.getIntroFaireUneDemande())
        || Util.notEmpty(obj.getEdemarche(loggedMember))
        || Util.notEmpty(obj.getQuiContacter())
        || Util.notEmpty(obj.getDocumentsUtiles())
        || Util.notEmpty(obj.getDureeEdemarche());

boolean displaySuivreDemande = Util.notEmpty(obj.getIntroSuivreUneDemande()) && Util.notEmpty(obj.getEdemarche(loggedMember));

%>


<main role="main" id="content">

    <section class="ds44-container-large">
        <jalios:select> 
            <jalios:if predicate="<%=Util.notEmpty(obj.getImageBandeau()) && !clientBrowser.isSmallDevice() %>">
                <ds:titleBanner imagePath="<%= imageFile %>" mobileImagePath="<%= imageMobileFile %>" 
                		title="<%= title %>" legend="<%=legende %>" copyright="<%=copyright%>" breadcrumb="true"></ds:titleBanner>
            </jalios:if>        
            <jalios:default>
               <ds:titleNoBanner title="<%= title %>" breadcrumb="true"></ds:titleNoBanner>
            </jalios:default>
        </jalios:select>
        <section class="ds44-ongletsContainer">

            <div class="js-tabs ds44-tabs" data-existing-hx="h2" data-tabs-prefix-class="ds44" id="onglets">

                <nav role="navigation" aria-label='<%= glp("jcmsplugin.socle.navOnglet") %>' 
                		id="ligneOnglets" class="ds44-flex-container ds44-fg1 ds44-navOnglets ds44-theme">
                    <!-- Résumé / détail / FAQ -->
                    <ul class="ds44-tabs__list ds44-fg1 ds44-flex-container ds44-list js-tabs" id="tabs">
                        <jalios:if predicate="<%= displayEnResume %>">
                        <li class="ds44-tabs__item ds44-fg1" role="presentation" id="tabs__1">
                            <a href="<%= obj.getDisplayUrl(userLocale) %>#id_first" class="js-tablist__link ds44-tabs__link" 
                            		id="label_id_first" aria-current="true">
                            	<%= glp("jcmsplugin.socle.onglet.resume") %>
                            </a>
                        </li>
                        </jalios:if>
                        <jalios:if predicate="<%= displayDetails %>">
                        <li class="ds44-tabs__item ds44-fg1" role="presentation" id="tabs__2">
                            <a href="<%= obj.getDisplayUrl(userLocale) %>#id_second" class="js-tablist__link ds44-tabs__link" id="label_id_second">
                            	<%= glp("jcmsplugin.socle.onglet.detail") %>
                            </a>
                        </li>
                        </jalios:if>
                        <jalios:if predicate="<%= displayFaq %>">
                        <li class="ds44-tabs__item ds44-fg1" role="presentation" id="tabs__3">
                            <a href="<%= obj.getDisplayUrl(userLocale) %>#id_third" class="js-tablist__link ds44-tabs__link" id="label_id_third">
                            	<%= glp("jcmsplugin.socle.onglet.faq") %>
                            </a>
                        </li>
                        </jalios:if>
                    </ul>
                    
                    <!-- Contact / faire demande / suivre demande  -->
                    <ul class="ds44-flex-container ds44-fse ds44--l-padding-tb ds44-flex-grow1-large ds44-blocBtnOnglets ds44-list">
                        <jalios:if predicate="<%= displayQuiContacter %>">
                        <li class="mrs mls ds44-ongletsBtnItem">
                            <button class="ds44-btnStd ds44-btn--invert" type="button" 
                            		data-target="#overlay-qui-contacter" 
                            		data-js="ds44-modal" 
                            		data-open-overlay="true">
                            	<span class="ds44-btnInnerText"><%= glp("jcmsplugin.socle.demande.qui-contacter") %></span>
                            	<i class="icon icon-phone icon--sizeL" aria-hidden="true"></i>
                            </button>
                        </li>
                        </jalios:if>
                        <jalios:if predicate="<%= displayFaireDemande %>">
                        <li class="mrs ds44-ongletsBtnItem">
                            <button class="ds44-btnStd ds44-btn--invert" type="button" 
                            		data-target="#overlay-faire-demande" 
                            		data-js="ds44-modal" 
                            		data-open-overlay="true">
                            	<span class="ds44-btnInnerText"><%= glp("jcmsplugin.socle.demande.faire-demande") %></span>
                            	<i class="icon icon-file icon--sizeL" aria-hidden="true"></i>
                            </button>

                        </li>
                        </jalios:if>
                        <jalios:if predicate="<%= displaySuivreDemande %>">
                        <li class="mrs ds44-ongletsBtnItem">
                            <button class="ds44-btnStd ds44-btn--invert" type="button" 
                            		data-target="#overlay-suivre-demande" 
                            		data-js="ds44-modal" 
                            		data-open-overlay="true">
                            <span class="ds44-btnInnerText"><%= glp("jcmsplugin.socle.demande.suivre-demande") %></span>
                            <i class="icon icon-computer icon--sizeL" aria-hidden="true"></i>
                            </button>

                            
                        </li>
                        </jalios:if>
                    </ul>

                </nav>

                
                <!--  En résumé -->
                <jalios:if predicate="<%= displayEnResume %>">
                <div id="id_first" class="js-tabcontent ds44-tabs__content ds44-inner-container ds44-xl-margin-tb" role="tabpanel" aria-labelledby="label_id_first">

                    <div class="grid-12-small-1">
                        <div class="col-7">
                            <jalios:if predicate="<%= Util.notEmpty(obj.getChapo()) %>">
                                <div class="ds44-introduction"><jalios:wysiwyg><%= obj.getChapo() %></jalios:wysiwyg></div>
                            </jalios:if>
                            <jalios:if predicate="<%= Util.notEmpty(obj.getPourQui()) %>">
                                <h2 class="h2-like mtm" id="titre_remume_pour_qui"><%= glp("jcmsplugin.socle.titre.pour-qui") %></h2>
                                <jalios:wysiwyg><%= obj.getPourQui() %></jalios:wysiwyg>  
                            </jalios:if>                                      
                        </div>

                        <div class="col-1 grid-offset"></div>

                        <aside class="col-4">     
                            <%@ include file="doFicheAideEncadre.jspf" %>                     
                        </aside>
                        
                    </div>
                    
                    <p class="ds44-keyboard-show">
                    	<a href="<%= obj.getDisplayUrl(userLocale) %>#label_id_first">
                    		<%= glp("jcmsplugin.socle.revenirOnglet", glp("jcmsplugin.socle.onglet.resume")) %>
                    	</a>
                    </p>

                </div>
                </jalios:if>
 
                <!-- En détail -->
                <jalios:if predicate="<%= displayDetails %>">
                <div id="id_second" class="js-tabcontent ds44-tabs__content ds44-inner-container ds44-xl-margin-tb" role="tabpanel" 
                		aria-labelledby="label_id_second" 
                		aria-hidden="true" 
                		style="display: none; opacity: 0;">
                
                    <div class="grid-12-small-1">
                        <div class="col-7">
                            <jalios:if predicate="<%= Util.notEmpty(obj.getIntro()) %>">
                                <div class="ds44-introduction"><jalios:wysiwyg><%= obj.getIntro()%></jalios:wysiwyg></div>
                            </jalios:if>                         
                            <jalios:if predicate="<%= Util.notEmpty(obj.getEligibilite()) %>">
                                <section class="ds44-contenuArticle" id="section1">    
                                    <h2 class="h2-like" id="titre_detail_pour_qui"><%= glp("jcmsplugin.socle.titre.pour-qui") %></h2>
                                    <jalios:wysiwyg><%= obj.getEligibilite() %></jalios:wysiwyg>
                                </section>
                            </jalios:if>
                            
                            <jalios:if predicate="<%= Util.notEmpty(obj.getCestQuoi()) %>">
                                <section class="ds44-contenuArticle" id="section2">
                                    <h2 class="h2-like" id="titre_detail_pour_quoi"><%= glp("jcmsplugin.socle.titre.quoi") %></h2>
                                    <jalios:wysiwyg><%= obj.getCestQuoi() %></jalios:wysiwyg>
                                </section>
                            </jalios:if>
                            
                            <jalios:if predicate="<%= Util.notEmpty(obj.getCommentFaireUneDemande()) %>">
                                <section class="ds44-contenuArticle" id="section3">
                                    <h2 class="h2-like" id="titre_detail_comment_demande"><%= glp("jcmsplugin.socle.titre.comment-demande") %></h2>
                                    <jalios:wysiwyg><%= obj.getCommentFaireUneDemande() %></jalios:wysiwyg>
                                </section>
                            </jalios:if>
                            
                            <jalios:if predicate="<%= Util.notEmpty(obj.getQuelsDocumentsFournir()) %>">
                                <section class="ds44-contenuArticle" id="section4">
                                    <h2 class="h2-like" id="titre_detail_fournir_documents"><%= glp("jcmsplugin.socle.titre.fournir-documents") %></h2>
                                    <jalios:wysiwyg><%= obj.getQuelsDocumentsFournir() %></jalios:wysiwyg>
                                </section>
                            </jalios:if>
                        </div>

                        <div class="col-1 grid-offset"></div>
 
                        <aside class="col-4">                   
                            <%@ include file="doFicheAideEncadre.jspf" %>
                        </aside>

                    </div>
                    
                    <p class="ds44-keyboard-show">
                    	<a href="<%= obj.getDisplayUrl(userLocale) %>#label_id_second">
                    		<%= glp("jcmsplugin.socle.revenirOnglet", glp("jcmsplugin.socle.onglet.detail")) %>
                    	</a>
                    </p>
                    
                </div>
                </jalios:if>
 
                <!-- FAQ -->
                <jalios:if predicate="<%= displayFaq %>">
                <div id="id_third" class="js-tabcontent ds44-tabs__content ds44-inner-container ds44-xl-margin-tb" role="tabpanel" 
                		aria-labelledby="label_id_third" 
                		aria-hidden="true" 
                		style="display: none; opacity: 0;">
					<jalios:if predicate="<%= Util.notEmpty(obj.getFaq()) %>">
						<jalios:include pub="<%= obj.getFaq() %>" usage="full"/>
					</jalios:if>
                </div>
                </jalios:if>
 

            </div>

        </section>

    </section>

 


</main>

<jalios:if predicate="<%= displayFaireDemande %>">
	<section class="ds44-modal-container" id="overlay-faire-demande" aria-hidden="true" role="dialog">
	    <div class="ds44-modal-box">
	        <button class="ds44-btnOverlay--modale ds44-btnOverlay--closeOverlay" type="button" 
	        		aria-label='<%= glp("jcmsplugin.socle.ficheaide.fermerboitedialogue.label", glp("jcmsplugin.socle.demande.faire-demande")) %>' 
	        		data-js="ds44-modal-action-close">
	        	<i class="icon icon-cross icon--xlarge" aria-hidden="true"></i>
	        	<span class="ds44-btnInnerText--bottom"><%= glp("jcmsplugin.socle.fermer") %></span>
	        </button>
	
	        <h1 class="h2-like" id="titre-modale-faire-demande"><%= glp("jcmsplugin.socle.demande.faire-demande") %></h1>
	
	        <div class="ds44-modal-gab">
	
	            <p><%= HtmlUtil.html2text(obj.getIntroFaireUneDemande(userLang)) %></p>
	
	            <div class="ds44-mt3 grid-12-small-1">
	                <div class='col-<%= Util.notEmpty(obj.getEdemarche(loggedMember)) || Util.notEmpty(obj.getQuiContacter()) ? "6" : "12" %> ds44-modal-column'>
	                    <h2 class="h4-like" id="titre_documents_utiles"><%= glp("jcmsplugin.socle.ficheaide.docutils.label") %></h2>
	
	                    <jalios:select>
	                        <jalios:if predicate="<%= Util.isEmpty(obj.getDocumentsUtiles()) %>">
	                            <p><%= glp("jcmsplugin.socle.ficheaide.nodoc.label") %></p>
	                        </jalios:if>
	                        <jalios:default>
	                            <ul class="ds44-list">
	                                <jalios:foreach name="itDoc" type="FileDocument" collection="<%= Arrays.asList(obj.getDocumentsUtiles()) %>">
	                                    <li class="mts">
	                                        <% 
		                                        // Récupérer l'extension du fichier
		                                        String fileType = FileDocument.getExtension(itDoc.getFilename()).toUpperCase();
		                                        // Récupérer la taille du fichier
		                                        String fileSize = Util.formatFileSize(itDoc.getSize(), userLocale);
	                                        %>
	                                        <p class="ds44-docListElem">
	                                        	<i class="icon icon-file ds44-docListIco" aria-hidden="true"></i>
	                                        	<% String titleModalFaireDemande = itDoc.getTitle() + " - " + fileType + " - " + fileSize + " - " + glp("jcmsplugin.socle.accessibily.newTabLabel"); %>
	                                        	<a href="<%= itDoc.getDownloadUrl() %>" target="_blank" title='<%= titleModalFaireDemande %>'>
	                                        		<%= itDoc.getTitle() %>
	                                        	</a>
	                                        	<span class="ds44-cardFile"><%= fileType %> - <%= fileSize %></span>
	                                        </p>
	                                    </li>
	                                </jalios:foreach>
	                            </ul>
	                        </jalios:default>
	                    </jalios:select>
	
	                </div>
	                <jalios:if predicate="<%= Util.notEmpty(obj.getEdemarche(loggedMember)) %>">
	                    <div class="col-6 ds44-modal-column">
	
	                        <h2 class="h3-like" id="titre_en_ligne"><%= glp("jcmsplugin.socle.ficheaide.enligne.label") %></h2>
	
	                        <p><a class="ds44-btnStd ds44-btn--invert" href="<%= obj.getUrlEdemarche(userLang)  %>" 
	                        		title='<%= glp("jcmsplugin.socle.ficheaide.fairedemandelignelink.label") %> <%= glp("jcmsplugin.socle.accessibily.newTabLabel") %>'
	                        		target="_blank">
	                        	<span class="ds44-btnInnerText"><%= glp("jcmsplugin.socle.ficheaide.fairedemandeligne.label") %></span>
	                        	<i class="icon icon-computer icon--sizeL" aria-hidden="true"></i>
	                        </a></p>
	                        <p><%= glp("jcmsplugin.socle.ficheaide.duree.label") %> <%= obj.getDureeEdemarche() %></p>
	                    </div>
	                </jalios:if>
	                <jalios:if predicate="<%= Util.isEmpty(obj.getEdemarche(loggedMember)) && Util.notEmpty(obj.getQuiContacter()) %>">
	                    <div class="col-6 ds44-modal-column">
	                    
							<h2 class="h4-like" id="titre_envoie_dossier"><%= glp("jcmsplugin.socle.ficheaide.adresseenvoiedossier.label") %></h2>
							
							<jalios:foreach name="itFicheLieu" type="FicheLieu" array='<%= obj.getQuiContacter() %>' counter="lieuCounter">
								
								<p class="ds44-docListElem mts">
									<i class="icon icon-user ds44-docListIco" aria-hidden="true"></i>
									<strong><%= itFicheLieu.getTitle() %></strong>
								</p>
								
								<% String adresseEcrire = SocleUtils.formatAdresseEcrire(itFicheLieu); %>
								<jalios:if predicate='<%= Util.notEmpty(adresseEcrire) %>'>
									<p class="ds44-docListElem mts">
										<i class="icon icon-marker ds44-docListIco" aria-hidden="true"></i>
										<%= adresseEcrire %>
									</p>
								</jalios:if>
								
								<jalios:if predicate='<%= Util.notEmpty(itFicheLieu.getTelephone()) %>'>
									<div class="ds44-docListElem mts">
										<i class="icon icon-phone ds44-docListIco" aria-hidden="true"></i>

										<jalios:if predicate='<%= itFicheLieu.getTelephone().length == 1 %>'>
											<ds:phone number="<%= itFicheLieu.getTelephone()[0] %>"/>
										</jalios:if>

										<jalios:if predicate='<%= itFicheLieu.getTelephone().length > 1 %>'>
											<ul class="ds44-list">
												<jalios:foreach name="numTel" type="String" array="<%= itFicheLieu.getTelephone() %>">
													<li>
														<ds:phone number="<%= numTel %>"/>
													</li>
												</jalios:foreach>
											</ul>
										</jalios:if>

									</div>
								</jalios:if>
								
								<jalios:if predicate='<%=Util.notEmpty(itFicheLieu.getEmail())%>'>
									<div class="ds44-docListElem mts">
										<i class="icon icon-mail ds44-docListIco" aria-hidden="true"></i>
	
										<jalios:if predicate='<%= itFicheLieu.getEmail().length == 1 %>'>
											<% String email = itFicheLieu.getEmail()[0]; %>
											<a href='<%= "mailto:"+email %>' title='<%= HttpUtil.encodeForHTMLAttribute(glp("jcmsplugin.socle.ficheaide.contacter-x-par-mail.label", itFicheLieu.getTitle(), email)) %>'> 
												<%=  glp("jcmsplugin.socle.ficheaide.contacter-par-mail.label")  %>
											</a>
										</jalios:if>
	
										<jalios:if predicate='<%= itFicheLieu.getEmail().length > 1 %>'>
											<ul class="ds44-list">
												<jalios:foreach name="email" type="String" array='<%= itFicheLieu.getEmail() %>'>
													<li>
														<a href='<%= "mailto:"+email %>' title='<%= HttpUtil.encodeForHTMLAttribute(glp("jcmsplugin.socle.ficheaide.contacter-x-par-mail.label", itFicheLieu.getTitle(), email)) %>'> 
															<%= email %>
														</a>
													</li>
												</jalios:foreach>
											</ul>
										</jalios:if>
	
									</div>
								</jalios:if>
								<jalios:if predicate="<%= lieuCounter != obj.getQuiContacter().length %>">
									<hr class="mtm mbm" />
								</jalios:if>
							</jalios:foreach>
						</div>
	                </jalios:if>
	            </div>
	        </div>
	    </div>  
	</section>
</jalios:if>

<jalios:if predicate="<%= displaySuivreDemande %>">
	<section class="ds44-modal-container" id="overlay-suivre-demande" aria-hidden="true" role="dialog">
	    <div class="ds44-modal-box">
	        <button class="ds44-btnOverlay--modale ds44-btnOverlay--closeOverlay" type="button" 
	        		title='<%= glp("jcmsplugin.socle.ficheaide.fermerboitedialogue.label", glp("jcmsplugin.socle.ficheaide.suivre.label")) %>' 
	        		data-js="ds44-modal-action-close">
	        	<i class="icon icon-cross icon--xlarge" aria-hidden="true"></i>
	        	<span class="ds44-btnInnerText--bottom"><%= glp("jcmsplugin.socle.fermer") %></span>
	        </button>
	
	        <h1 class="h2-like" id="titre-suivre-demande"><%= glp("jcmsplugin.socle.ficheaide.suivre.label") %></h1>
	
	        <div class="ds44-modal-gab">
	            <p><%= HtmlUtil.html2text(obj.getIntroSuivreUneDemande(userLang)) %></p>
	
	            <div class="ds44-mt3 grid-12-small-1">
	                
	                <div class="col-6 ds44-modal-column">
	                    <h2 class="h4-like" id="titre_a_code_suivi"><%= glp("jcmsplugin.socle.ficheaide.modal.suivredemande.acodesuivi") %></h2>
	
	                    <p id="desc-pour-input-suivre-demande"><%= glp("jcmsplugin.socle.ficheaide.modal.suivredemande.saisiscodesuivi") %></p>
	
						<form action="<%= obj.getUrlSuiviEdemarche() %>">
							<% String idFormElement = ServletUtil.generateUniqueDOMId(request, "form-element"); %>
							<div class="ds44-form__container">
								<label for="<%= idFormElement %>" class="ds44-formLabel">
									<span class="ds44-labelTypePlaceholder">
										<%= glp("jcmsplugin.socle.ficheaide.modal.suivredemande.codesuivi") %>
										<sup aria-hidden="true">*</sup>
									</span> 
									<span id="explanation-<%= idFormElement %>" class="ds44-labelTypeInfoComp">
										<%= glp("jcmsplugin.socle.ficheaide.modal.suivredemande.exemplecodesuivi") %>
									</span> 
									<input type="text" id="<%= idFormElement %>" 
											name="<%= idFormElement %>" 
											class="ds44-inpStd" 
											title='<%= glp("jcmsplugin.socle.ficheaide.modal.suivredemande.codesuivi") %> - <%= glp("jcmsplugin.socle.obligatoire") %>' 
											required
											aria-required="true" 
											aria-describedby="explanation-<%= idFormElement %>" />
									<button class="ds44-reset" type="button">
										<i class="icon icon-cross icon--sizeL" aria-hidden="true"></i>
										<span class="visually-hidden">
											<%= glp("jcmsplugin.socle.facette.effacer-contenu-champ", glp("jcmsplugin.socle.ficheaide.modal.suivredemande.codesuivi")) %>
										</span>
									</button> 
								</label>
								<div class="ds44-errorMsg-container hidden" aria-live="polite"></div>
							</div>
							<button class="ds44-btnStd ds44-btn--invert" title='<%= glp("jcmsplugin.socle.ficheaide.modal.suivredemande.validercodesuivi") %>'>
								<span class="ds44-btnInnerText"><%= glp("jcmsplugin.socle.valider") %></span>
								<i class="icon icon-long-arrow-right" aria-hidden="true"></i>
							</button>
						</form>
					</div>
	                <div class="col-6 ds44-modal-column">
	
	                    <h2 class="h4-like" id="titre_a_pas_code_suivi"><%= glp("jcmsplugin.socle.ficheaide.modal.suivredemande.apascodesuivi") %></h2>
	
	                    <p class="ds44-mt-std">
	                    	<p><a class="ds44-btnStd ds44-btn--invert" href="<%= obj.getUrlEdemarche(userLang)  %>" 
	                        		title='<%= glp("jcmsplugin.socle.ficheaide.fairedemandelignelink.label") %> <%= glp("jcmsplugin.socle.accessibily.newTabLabel") %>'
	                        		target="_blank">
	                        	<span class="ds44-btnInnerText"><%= glp("jcmsplugin.socle.ficheaide.modal.suivredemande.connectezvous") %></span>
	                        	<i class="icon icon-computer icon--sizeL" aria-hidden="true"></i>
	                        </a></p>
	                    </p>
	
	                </div>
	            </div>
	        </div>
	    </div>   
	</section>
</jalios:if>

<jalios:if predicate="<%= displayQuiContacter %>">
<section class="ds44-modal-container" id="overlay-qui-contacter" aria-hidden="true" role="dialog" aria-labelledby="titre-modale-qui-contacter" data-bkp-aria-hidden="true">
    
    <div class="ds44-modal-box">
        <button class="ds44-btnOverlay--modale ds44-btnOverlay--closeOverlay" type="button" title="Fermer la boite de dialogue : qui contacter" data-js="ds44-modal-action-close" data-bkp-tabindex="" tabindex="-1">
            <i class="icon icon-cross icon--xlarge" aria-hidden="true"></i><span class="ds44-btnInnerText--bottom">Fermer</span>
        </button>
        <h1 class="h2-like" id="titre-modale-qui-contacter"><%= glp("jcmsplugin.socle.ficheaide.modal.quicontacter") %></h1>
        <div class="ds44-modal-gab">
            <jalios:if predicate="<%= Util.notEmpty(obj.getIntroContact()) %>">
            <div><jalios:wysiwyg><%= obj.getIntroContact() %></jalios:wysiwyg></div>
            
            <div class="ds44-mtb2"></div>           
            <div class="grid-12-small-1">
            
            
                <jalios:select>
                     <%-- Instruction délégation --%>
	                <jalios:if predicate="<%= obj.getInstructionDelegation() && Util.notEmpty(obj.getTypeDeLieu()) %>">
	                <div class='col-<%= Util.isEmpty(obj.getBesoinDaide()) ? "12" : "6  ds44-modal-column" %>'>    
	                    <div id="step1">
	                        <h2 class="h4-like" id="modal-contact-title">Trouvez le bon contact près de chez vous :</h2>
	                        <form>                      
	                            <div class="ds44-form__container">                                                    
	                                <div class="ds44-posRel">
	                                
	                                
	                                
	                                    <label for="form-element-56145" class="ds44-formLabel"><span class="ds44-labelTypePlaceholder"><span>Votre adresse<sup aria-hidden="true">*</sup></span></span></label>
	                                    <input type="text" id="form-element-56145" name="commune" class="ds44-inpStd" role="combobox" aria-autocomplete="list" autocomplete="off" aria-expanded="false" title="Votre adresse - obligatoire" data-url="plugins/SoclePlugin/jsp/facettes/acSearchCommune.jsp" data-mode="select-only" required   aria-describedby="modal-contact-title" /><button class="ds44-reset" type="button" ><i class="icon icon-cross icon--sizeL" aria-hidden="true"></i><span class="visually-hidden">Effacer le contenu saisi dans le champ : Votre adresse</span></button>
	                                    <div class="ds44-autocomp-container hidden">
	                                        <div class="ds44-autocomp-list">
	                                            <ul class="ds44-list" role="listbox"></ul>
	                                        </div>
	                                    </div>   
	                                    
	                                    
	                                      
	                                </div>
	                                
	                                
	                                <div class="ds44-errorMsg-container hidden" aria-live="polite"></div>
	                            </div>
	
	                    
	                            <button class="ds44-btnStd ds44-btn--invert" title="Valider votre adresse">
	                                <span class="ds44-btnInnerText">Valider</span><i class="icon icon-long-arrow-right" aria-hidden="true"></i>
	                            </button>  
	                            
	                            <jalios:if predicate="<%= Util.notEmpty(obj.getTypeDeLieu()) && Util.notEmpty(channel.getCategory(obj.getTypeDeLieu())) %>">
	                               <input type="hidden" name="cid" value="<%= channel.getCategory(obj.getTypeDeLieu()).getId() %>" />
	                            </jalios:if>	                            
	                            <input type="hidden" name="redirectUrl" value="plugins/SoclePlugin/jsp/facettes/displayFicheLieuSecrorisation.jsp" />
	                                           
	                        </form>
	                    </div>
	                     
	                        
	                    <%-- 
	                    <div id="step2">
	                        <p class="ds44-docListElem ds44-mt-std">
	                            <i class="icon icon-marker ds44-docListIco" aria-hidden="true"></i>Service Habitat<br />3 quai Ceineray<br /> CS 94109 44041 Nantes
	                        </p>
	                        <p class="ds44-docListElem ds44-mt-std">
	                            <i class="icon icon-phone ds44-docListIco" aria-hidden="true"></i>02 40 99 12 82 - 02 40 99 19 10
	                        </p>
	                        <p class="ds44-docListElem ds44-mt-std">
	                            <i class="icon icon-mail ds44-docListIco" aria-hidden="true"></i><a href="mailto:contact@loire-atlantique.fr" title="Contacter par mail : contact@loire-atlantique.fr">contact@loire-atlantique.fr</a>
	                        </p>
	                    </div>   
	                    --%> 
	                                    
                    </div>  
	                
	                </jalios:if>
            
	                <jalios:default>
	            
		                <jalios:if predicate="<%= Util.notEmpty(obj.getQuiContacter()) || Util.notEmpty(obj.getComplementContact()) %>">
		                <div class='col-<%= Util.isEmpty(obj.getBesoinDaide()) ? "12" : "6  ds44-modal-column" %>'>		                    	                    
		                    
		                    <jalios:if predicate="<%= Util.notEmpty(obj.getComplementContact()) %>">
		                        <jalios:wysiwyg><%= obj.getComplementContact() %></jalios:wysiwyg>
		                    </jalios:if>
		                    <div class="ds44-mt1"></div>
		                    <jalios:foreach name="itLieu" type="FicheLieu" array="<%= obj.getQuiContacter() %>" counter="lieuCounter">
		                        <jalios:if predicate="<%= lieuCounter > 1 %>">
		                            <div class="ds44-mt2"></div>
		                        </jalios:if>
		                        <p class="ds44-docListElem"><i class="icon icon-marker ds44-docListIco" aria-hidden="true"></i><b><%= itLieu.getTitle() %></b></p>
		                        <p class="ds44-docListElem">
		                           <%= SocleUtils.formatAdresseEcrire(itLieu) %>
		                        </p>
		                        <jalios:if predicate="<%= Util.notEmpty(itLieu.getTelephone()) %>">
		                        <p class="ds44-docListElem mtm"><i class="icon icon-phone ds44-docListIco" aria-hidden="true"></i>
		                        <jalios:foreach name="itPhone" type="String" array="<%= itLieu.getTelephone() %>" counter="itCounter">
		                           <ds:phone number="<%= itPhone %>"/>
		                           <jalios:if predicate="<%= itCounter < itLieu.getTelephone().length %>">
		                            - 
		                           </jalios:if>
		                        </jalios:foreach>
		                        </p>
		                        </jalios:if>
		                        <jalios:if predicate="<%= Util.notEmpty(itLieu.getEmail()) %>">
		                            <p class="ds44-docListElem mtm"><i class="icon icon-mail ds44-docListIco" aria-hidden="true"></i>
		                            <jalios:foreach name="itMail" type="String" array="<%= itLieu.getEmail() %>">
		                               <jalios:select>
		                                   <jalios:if predicate="<%= itLieu.getEmail().length > 1 %>">
		                                   <a href="mailto:<%= itMail %>" title='<%= HttpUtil.encodeForHTMLAttribute(glp("jcmsplugin.socle.ficheaide.contacter-x-par-mail.label", itLieu.getTitle(), itMail)) %>' data-bkp-tabindex="" tabindex="-1"><%= itMail %></a>
		                                   </jalios:if>
		                                   <jalios:default>
		                                   <a href="mailto:<%= itMail %>" title='<%= HttpUtil.encodeForHTMLAttribute(glp("jcmsplugin.socle.ficheaide.contacter-x-par-mail.label", itLieu.getTitle(), itMail)) %> : <%= itMail %>' data-bkp-tabindex="" tabindex="-1"><%= glp("jcmsplugin.socle.ficheaide.contacter-par-mail.label") %></a>
		                                   </jalios:default>
		                               </jalios:select>
		                            </jalios:foreach>
		                            </p>
		                        </jalios:if>
								<jalios:if predicate="<%= lieuCounter != obj.getQuiContacter().length %>">
									<hr class="mtm mbm" />
								</jalios:if>
		                    </jalios:foreach>
	                    
		                </div>
		                </jalios:if>
	                
	                </jalios:default>
                </jalios:select>
                
                
                
                
                
                <jalios:if predicate="<%= Util.notEmpty(obj.getBesoinDaide()) %>">
                    <div class='col-<%= Util.isEmpty(obj.getQuiContacter()) && Util.isEmpty(obj.getComplementContact()) ? "12" : "6  ds44-modal-column" %>'>
                        <h2 class="h3-like" id="titre_besoin_aide"><%= glp("jcmsplugin.socle.ficheaide.modal.besoinaide") %></h2>
                        <jalios:wysiwyg>
                            <%= obj.getBesoinDaide() %>
                        </jalios:wysiwyg>
                        </p>
                    </div>
                </jalios:if>
            </div>
            </jalios:if>
            <%-- Fin instruction délégation à faux --%>
            
            
        </div>
    </div>
    
</section>
</jalios:if>