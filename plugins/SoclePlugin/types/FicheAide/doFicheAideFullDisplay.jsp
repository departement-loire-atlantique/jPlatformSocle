<%@ page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%>
<%@ include file='/jcore/doInitPage.jspf'%>

<% 
	FicheAide obj = (FicheAide)request.getAttribute(PortalManager.PORTAL_PUBLICATION); 
	String imageFile = obj.getImageBandeau() ;
	String imageMobileFile = obj.getImageMobile();
	String title = obj.getTitle(userLang);
	String legende = obj.getLegende(userLang);
	String copyright = obj.getCopyright(userLang);
	
	boolean displayEnResume = Util.notEmpty(obj.getPourQui(userLang)) || Util.notEmpty(obj.getEligibilite(userLang));
	
	boolean displayFaq = Util.notEmpty(obj.getFaq());
	
	request.setAttribute("contactfaq", obj.getContactFAQ(userLang));
	
	boolean displayQuiContacter = Util.notEmpty(obj.getQuiContacter())
									|| Util.notEmpty(obj.getIntroContact(userLang))
									|| Util.notEmpty(obj.getComplementContact(userLang))
									|| Util.notEmpty(obj.getBesoinDaide(userLang))
									|| (Util.notEmpty(obj.getTypeDeLieu(userLang)) && obj.getInstructionDelegation());
	
	boolean hasContactCol = false;
	
	boolean displayFaireDemande = ( Util.notEmpty(obj.getEdemarche(loggedMember)) && Util.notEmpty(obj.getUrlEdemarche(userLang)) )  
									|| ( Util.isEmpty(obj.getEdemarche(loggedMember)) && Util.notEmpty(obj.getDocumentsUtiles()) ) 
									|| Util.notEmpty(obj.getIntroFaireUneDemande(userLang));
	
	Category publikCat = channel.getCategory("$jcmsplugin.socle.ficheaide.publik.root");
	
	boolean displaySuivreDemande = Util.notEmpty(obj.getIntroSuivreUneDemande(userLang)) || ((Util.notEmpty(obj.getUrlSuiviEdemarche(userLang)) || obj.hasCategory(publikCat)));
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
				
		<section class="ds44-container-large">
		   <div class="ds44-mt3 ds44--xl-padding-t">
		      <div class="ds44-inner-container">
		         <div class="grid-12-medium-1 grid-12-small-1">
		            <aside class="col-4 ds44-hide-tinyToLarge ds44-js-aside-summary">
		               <section class="ds44-box ds44-theme" style="position: static;">
		                  <div class="ds44-innerBoxContainer">
		                     <p role="heading" aria-level="2" class="ds44-box-heading"><%= glp("jcmsplugin.socle.dossier.sommaire") %></p>
		                     <ul class="ds44-list ds44-list--puces">
		                        <jalios:if predicate="<%= displayEnResume %>">
		                        <li><a href="#sectionPourQui"><%= glp("jcmsplugin.socle.titre.pour-qui") %></a></li>
		                        </jalios:if>
		                        <jalios:if predicate="<%= Util.notEmpty(obj.getCestQuoi(userLang)) %>">
		                        <li><a href="#sectionCestQuoi" class=""><%= glp("jcmsplugin.socle.titre.quoi") %></a></li>
		                        </jalios:if>
		                        <jalios:if predicate="<%= Util.notEmpty(obj.getQuelsDocumentsFournir(userLang)) %>">
		                        <li><a href="#sectionDocuments" class=""><%= glp("jcmsplugin.socle.titre.fournir-documents") %></a></li>
		                        </jalios:if>
		                        <jalios:if predicate="<%= displayFaireDemande %>">
		                        <li><a href="#sectionFaireDemande" class=""><%= glp("jcmsplugin.socle.titre.comment-demande") %></a></li>
		                        </jalios:if>
		                        <jalios:if predicate="<%= displaySuivreDemande %>">
		                        <li><a href="#sectionSuivreDemande" class=""><%= glp("jcmsplugin.socle.titre.suivre-demande") %></a></li>
		                        </jalios:if>
		                        <jalios:if predicate="<%= displayQuiContacter %>">
		                        <li><a href="#sectionContact" class=""><%= glp("jcmsplugin.socle.ficheaide.modal.quicontacter") %></a></li>
		                        </jalios:if>
		                        <jalios:if predicate="<%= displayFaq %>">
		                        <li><a href="#sectionFaq" class=""><%= glp("jcmsplugin.socle.recherche.type.FaqAccueil") %></a></li>
		                        </jalios:if>
		                     </ul>
		                  </div>
		               </section>
		            </aside>
		            <div class="col-1 grid-offset ds44-hide-tinyToLarge"></div>
		            <article class="col-7 ds44-contenuDossier">
		               <jalios:if predicate="<%= Util.notEmpty(obj.getChapo(userLang)) %>">
			               <div class="ds44-introduction">
			                  <jalios:wysiwyg><%= obj.getChapo(userLang) %></jalios:wysiwyg>
			               </div>
		               </jalios:if>
		               <jalios:if predicate="<%= Util.notEmpty(obj.getIntro(userLang)) %>">
                           <jalios:wysiwyg><%= obj.getIntro(userLang) %></jalios:wysiwyg> 		               
		               </jalios:if>
		               <jalios:if predicate="<%= displayEnResume %>">
			               <section class="ds44-contenuArticle" id="sectionPourQui" tabindex="-1">
			                  <h2 id="idTitre2"><%= glp("jcmsplugin.socle.titre.pour-qui") %></h2>
			                  <jalios:if predicate="<%= Util.notEmpty(obj.getPourQui(userLang)) %>">
                                 <jalios:wysiwyg><%= obj.getPourQui(userLang) %></jalios:wysiwyg>
                              </jalios:if>
                              <jalios:if predicate="<%= Util.notEmpty(obj.getEligibilite(userLang)) %>">
                                 <jalios:wysiwyg><%= obj.getEligibilite(userLang) %></jalios:wysiwyg>
                              </jalios:if>
			               </section>
		               </jalios:if>
		               <jalios:if predicate="<%= Util.notEmpty(obj.getCestQuoi(userLang)) %>">
		               <section class="ds44-contenuArticle" id="sectionCestQuoi" tabindex="-1">
		                  <h2 id="idTitre3"><%= glp("jcmsplugin.socle.titre.quoi") %></h2>
		                  <jalios:wysiwyg><%= obj.getCestQuoi(userLang) %></jalios:wysiwyg>
		               </section>
		               </jalios:if>
		               <jalios:if predicate="<%= Util.notEmpty(obj.getQuelsDocumentsFournir(userLang)) %>">
		               <section class="ds44-contenuArticle" id="sectionDocuments" tabindex="-1">
		                  <h2 id="idTitre4"><%= glp("jcmsplugin.socle.titre.fournir-documents") %></h2>
		                  <jalios:wysiwyg><%= obj.getQuelsDocumentsFournir(userLang) %></jalios:wysiwyg>
		               </section>
		               </jalios:if>
		               <jalios:if predicate="<%= displayFaireDemande %>">
		               <section class="ds44-contenuArticle" id="sectionFaireDemande" tabindex="-1">
		                  <h2 id="idTitre5"><%= glp("jcmsplugin.socle.titre.comment-demande") %></h2>
		                  <jalios:wysiwyg>
		                      <%= obj.getCommentFaireUneDemande(userLang) %>
		                  </jalios:wysiwyg>
		                  <div class="ds44-mt3 grid-12-small-1">
		                    <jalios:if predicate="<%= Util.notEmpty(obj.getDocumentsUtiles()) %>">
		                        <% 
		                            boolean is6col = Util.notEmpty(obj.getEdemarche(loggedMember)) 
		                                            || Util.notEmpty(obj.getQuiContacter()) 
		                                            || Util.notEmpty(obj.getLieuInstructionDemande())
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
		                                            String fileSize = Util.formatFileSize(itDoc.getSize());
		                                            
		                                            String fileUrl = ServletUtil.getBaseUrl(request) + itDoc.getDownloadUrl(); 
		                                        %>
		                                        <p class="ds44-docListElem">
		                                            <i class="icon icon-file ds44-docListIco" aria-hidden="true"></i>
		                                            <% String titleModalFaireDemande = itDoc.getTitle() + " - " + fileType + " - " + fileSize + " " + glp("jcmsplugin.socle.accessibily.newTabLabel"); %>
		                                            <a href="<%= itDoc.getDownloadUrl() %>" target="_blank" title='<%= HttpUtil.encodeForHTMLAttribute(titleModalFaireDemande) %>'
		                                               data-statistic='{"name": "declenche-evenement","category": "Faire une demande","action": "Téléchargement","label": "<%= HttpUtil.encodeForHTMLAttribute(obj.getTitle()) %>"}'>
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
		                                            title='<%= glp("jcmsplugin.socle.ficheaide.fairedemandeligne.label") %> <%= glp("jcmsplugin.socle.accessibily.newTabLabel") %>'
		                                            data-statistic='{"name": "declenche-evenement","category": "Faire une demande","action": "Demande en ligne","label": "<%= HttpUtil.encodeForHTMLAttribute(obj.getTitle()) %>"}'
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
		                        <jalios:if predicate="<%= Util.isEmpty(obj.getEdemarche(loggedMember)) && obj.getInstructionDelegationDemande() && (Util.notEmpty(obj.getTypeDeLieu()) || Util.notEmpty(obj.getTypeDeLieuDemande())) %>">
		                            <div class='col-<%= Util.notEmpty(obj.getDocumentsUtiles()) ? "6 ds44-modal-column" : "12" %>'>
		
		                                <div id="rechercheDemande">
		                                    <h2 class="h4-like" id="titre_envoie_dossier"><%= glp("jcmsplugin.socle.ficheaide.adresseenvoiedossier.label") %></h2>
		                                    <%
		                                        String idFormCommune = "demande-commune";
		                                        String idFormAdresse = "demande-adresse";
		                                        String idResultInLine = "demandeResult";
		                                    %>
		                                    <% 
		                                    // Si il existe un type de lieu pour la demande alors utiliser champ lieu demande et lieu secondaire demande
		                                    String typeLieu = Util.notEmpty(obj.getTypeDeLieuDemande()) ? obj.getTypeDeLieuDemande() : obj.getTypeDeLieu();
		                                    String typeLieuSecondaire = Util.notEmpty(obj.getTypeDeLieuDemande()) ? obj.getTypeDeLieuSecondaireDemande() : obj.getTypeDeLieuSecondaire();
		                                    %>
		                                    <%@ include file="/plugins/SoclePlugin/types/FicheAide/doFicheAideFormSectorisation.jspf"%>
		                                </div>
		                                <div id="<%= idResultInLine %>"></div>
		
		                            </div>
		                        </jalios:if>
		
		
		                        <jalios:if predicate="<%= Util.isEmpty(obj.getEdemarche(loggedMember)) && (Util.notEmpty(obj.getQuiContacter()) || Util.notEmpty(obj.getLieuInstructionDemande())) %>">
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
		
		                                <%
		                                Content[] contentArray = Util.notEmpty(obj.getLieuInstructionDemande()) ? obj.getLieuInstructionDemande() : obj.getQuiContacter();
		                                %>
		                                <jalios:foreach name="itContent" type="Content" array='<%= contentArray %>' counter="lieuCounter">
		                                    
			                                <jalios:media data="<%= itContent %>" template="contact" />

 		                                    <jalios:if predicate="<%= lieuCounter != contentArray.length %>">
		                                        <hr />
		                                    </jalios:if>
		
		                                </jalios:foreach>
		                            </div>
		                        </jalios:if>
		                    </jalios:select>
		                  </div>
		               </section>
		               </jalios:if>
		               <jalios:if predicate="<%= displaySuivreDemande %>">
		               <section class="ds44-contenuArticle" id="sectionSuivreDemande" tabindex="-1">
		                  <h2 id="idTitre6"><%= glp("jcmsplugin.socle.titre.suivre-demande") %></h2>
		                  <jalios:wysiwyg>
		                     <%= obj.getIntroSuivreUneDemande(userLang) %>
		                  </jalios:wysiwyg>
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
		               </section>
		               </jalios:if>
		               <jalios:if predicate="<%= displayQuiContacter %>">
		               <section class="ds44-contenuArticle" id="sectionContact" tabindex="-1">
		                  <h2 id="idTitre7"><%= glp("jcmsplugin.socle.ficheaide.modal.quicontacter") %></h2>
		                  <jalios:wysiwyg>
                             <%= obj.getIntroContact(userLang) %>
		                  </jalios:wysiwyg>
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
		                                    <% 
		                                    String typeLieu = obj.getTypeDeLieu();
		                                    String typeLieuSecondaire = obj.getTypeDeLieuSecondaire();
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
		                                    <jalios:foreach name="itContent" type="Content" array="<%= obj.getQuiContacter() %>" counter="lieuCounter">
		
	                                            <jalios:media data="<%= itContent %>" template="contact" />
		
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
		                        </div>
		                    </jalios:if>
		                  </div>
		               </section>
		               </jalios:if>
		            </article>
		         </div>
		         
		         <jalios:if predicate="<%= displayFaq %>">
		         <section class="ds44-mt3" id="sectionFaq" tabindex="-1">
		            <section class="ds44--xxl-padding-tb">
		               <jalios:if predicate="<%= Util.notEmpty(obj.getFaq()) %>">
                            <% 
                                ServletUtil.backupAttribute(pageContext, PortalManager.PORTAL_PUBLICATION);
                                request.setAttribute("pubParent",obj);
                            %>
                            <jalios:include pub="<%= obj.getFaq() %>" usage="full" />
                            <% ServletUtil.restoreAttribute(pageContext, PortalManager.PORTAL_PUBLICATION); %>
                        </jalios:if>
		            </section>
		         </section>
		         </jalios:if>
		         
		         <%-- Partagez cette page --%>
                 <%@ include file="/plugins/SoclePlugin/jsp/portal/socialNetworksShare.jspf" %>
		         
		      </div>
		   </div>
		</section>	
		
	</section>

	<%-- Page utile --%>
	<jsp:include page="/plugins/SoclePlugin/types/PageUtileForm/editFormPageUtileForm.jsp" />

</main>