<%@ page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%>
<%@ include file='/jcore/doInitPage.jspf'%>
<%
FicheEmploiStage obj = (FicheEmploiStage) request.getAttribute(PortalManager.PORTAL_PUBLICATION);

// Génération du lien vers le formulaire de réponse à l'offre (Fiche article embarquant le formulaire + titre article spécifique)
Publication formulaireCandidature = channel.getPublication("$jcmsplugin.socle.form.candidature.idArticle");
String titreFormulaireCandidature = glp("jcmsplugin.socle.form.candidature.titreArticle",obj.getTitle(userLang));
String urlFormulaireCandidature = formulaireCandidature.getDisplayUrl(userLocale)+"?idFiche="+obj.getId()+"&t="+Util.encodeBASE64(titreFormulaireCandidature);

boolean afficherBouton = !obj.getMasquerBouton();
boolean afficherMentions = !obj.getMasquerMentions();

%>
<%@ include file='/front/doFullDisplay.jspf'%>

<main role="main" id="content">

<jalios:include target="SOCLE_ALERTE"/>

    <article class="ds44-container-large">

        <div class='<%= Util.notEmpty(request.getAttribute("isSearchFacetPanel")) ? "ds44-js-results-card" : "ds44-lightBG ds44-posRel"%>'>
            <%-- bouton Retour a la liste --%>
            <%@ include file="/plugins/SoclePlugin/jsp/facettes/doRetourListe.jspf" %>
            
            <div class="ds44-inner-container ds44--xl-padding-t ds44--m-padding-b ds44-tablette-reduced-pt">
                <div class="ds44-grid12-offset-2">
                    <jalios:if predicate='<%=Util.notEmpty(Channel.getChannel().getProperty("jcmsplugin.socle.portlet.filariane.id"))%>'>
                        <jalios:include id='<%=Channel.getChannel().getProperty("jcmsplugin.socle.portlet.filariane.id")%>' />
                    </jalios:if>
                    <h1 class="h1-like mbs mts " id="idTitre1"><%=obj.getTitle()%></h1>
                    <jalios:if predicate='<%=Util.notEmpty(obj.getCommune())%>'>
                        <h2 class="h2-like" id="idTitre0"><%=obj.getCommune()%></h2>
                    </jalios:if>
                </div>
            </div>
        </div>
        
        <div class="ds44-img50 ds44--l-padding-tb">
           <div class="ds44-inner-container">
               <div class="ds44-grid12-offset-1">
                   <section class="ds44-box ds44-theme">
                       <div class="ds44-innerBoxContainer">
                           <div class="grid-2-small-1 ds44-grid12-offset-1">
                               <div class="col">
                                  <p class="ds44-box-heading" role="heading" aria-level="3"><%= glp("jcmsplugin.socle.ficheemploi.label.informations") %></p>
                                  <p class="ds44-docListElem mts">
                                       <i class="icon icon-tag ds44-docListIco" aria-hidden="true"></i>
                                       <%= glp("jcmsplugin.socle.publieele", SocleUtils.formatDate("dd/MM/yy", obj.getPdate())) %>
                                       <br/>
                                       <%= glp("jcmsplugin.socle.ficheemploi.label.reference", obj.getNumeroDePoste()) %>
                                       <jalios:if predicate='<%= Util.notEmpty(obj.getDuree()) && !obj.getTypeDoffre(loggedMember).first().equals(channel.getCategory("$jcmsplugin.socle.emploiStage.emploiPermanent")) %>'>
                                       <br/>
                                       <%-- Type d'offre est obligatoire et monovalué, pas besoin de faire de vérification --%>
                                       <%= obj.getTypeDoffre(loggedMember).first()%> - <%= obj.getDuree() %>
                                       </jalios:if>
                                   </p>
                                   <p class="ds44-docListElem mts">
                                       <i class="icon icon-marker ds44-docListIco" aria-hidden="true"></i>
                                       <jalios:if predicate="<%= Util.notEmpty(obj.getLieuDeTravail()) %>">
                                       <%= obj.getLieuDeTravail() %><br/>
                                       </jalios:if>
                                       <jalios:if predicate="<%= Util.notEmpty(obj.getRue()) %>">
                                       <%= obj.getRue() %><br/>
                                       </jalios:if>
                                       <%= obj.getCommune() %>
                                   </p>
                                   <p class="ds44-docListElem mts">
                                       <i class="icon icon-tag ds44-docListIco" aria-hidden="true"></i>
                                       <jalios:if predicate='<%= !obj.getDirectiondelegation(loggedMember).contains(channel.getCategory("$jcmsplugin.socle.emploiStage.delegation.servicescentraux")) %>'>
                                           <%= SocleUtils.formatCategories(obj.getDirectiondelegation(loggedMember)) %>
                                           <br/>                                
                                       </jalios:if>
                                       <%= obj.getService() %>
                                       <jalios:if predicate='<%= obj.getDirectiondelegation(loggedMember).contains(channel.getCategory("$jcmsplugin.socle.emploiStage.delegation.servicescentraux")) %>'>
                                           <%
                                           SortedSet<Category> catsWithoutServices = obj.getDirectiondelegation(loggedMember);
                                           catsWithoutServices.remove(channel.getCategory("$jcmsplugin.socle.emploiStage.delegation.servicescentraux"));
                                           %>
                                           <jalios:if predicate="<%= Util.notEmpty(catsWithoutServices) %>">
                                               <br/>
                                               <%= SocleUtils.formatCategories(catsWithoutServices) %>
                                           </jalios:if>
                                       </jalios:if>
                                       <jalios:if predicate="<%= Util.notEmpty(obj.getPositionHierarchique()) %>">
                                       <br/>
                                       <%= obj.getPositionHierarchique() %>
                                       </jalios:if>
                                   </p>
                               </div>
                               <div class="col ds44--xl-padding-l">
                                   <jalios:if predicate="<%= 
                                       Util.notEmpty(obj.getFiliere(loggedMember))
                                       ||Util.notEmpty(obj.getCategorieDemploi(loggedMember))
                                       || Util.notEmpty(obj.getGrade())
                                       || Util.notEmpty(obj.getReserveAgentsColleges(loggedMember)) %>">
                                       <% boolean addLinebreak = false; %>
                                       <p class="ds44-box-heading" role="heading" aria-level="3"><%= glp("jcmsplugin.socle.ficheemploi.label.profil") %></p>
                                       <div class="ds44-docListElem mts">
                                           <i class="icon icon-user ds44-docListIco" aria-hidden="true"></i>
                                           <jalios:if predicate="<%= Util.notEmpty(obj.getFiliere(loggedMember)) %>">
                                               <jalios:foreach name="itFiliere" type="Category" collection="<%= obj.getFiliere(loggedMember) %>">
                                               <jalios:if predicate="<%= addLinebreak %>"><br/></jalios:if>
                                               <%= glp("jcmsplugin.socle.ficheemploi.label.filiere", itFiliere.getName()) %>
                                               <% addLinebreak = true; %>
                                               </jalios:foreach>
                                           </jalios:if>
                                           <jalios:if predicate="<%= Util.notEmpty(obj.getCategorieDemploi(loggedMember)) %>">
                                               <jalios:if predicate="<%= addLinebreak %>"><br/></jalios:if>
                                               <%= glp("jcmsplugin.socle.ficheemploi.label.catemploi", obj.getCategorieDemploi(loggedMember).first()) %>
                                               <% addLinebreak = true; %>
                                           </jalios:if>
                                           <jalios:if predicate="<%= Util.notEmpty(obj.getGrade()) %>">
                                               <jalios:if predicate="<%= addLinebreak %>"><br/></jalios:if>
                                               <jalios:wysiwyg>
                                               <%= obj.getGrade().replaceFirst("<p>", "<p>" + glp("jcmsplugin.socle.ficheemploi.label.grade") + " ") %>
                                               </jalios:wysiwyg>
                                               <% addLinebreak = true; %>
                                           </jalios:if>
                                           <jalios:if predicate="<%= Util.notEmpty(obj.getReserveAgentsColleges(loggedMember)) %>">
                                               <%= glp("jcmsplugin.socle.ficheemploi.label.reserveagents") %>
                                           </jalios:if>
                                       </div>
                                   </jalios:if>
                                   
                                   <p class="ds44-box-heading ds44-mtb1" role="heading" aria-level="3"><%= glp("jcmsplugin.socle.ficheemploi.label.repondre") %></p>
                                   <p class="ds44-docListElem mts">
                                       <i class="icon icon-date ds44-docListIco" aria-hidden="true"></i>
                                       <%= glp("jcmsplugin.socle.ficheemploi.label.datelimite", SocleUtils.formatDate("dd/MM/yy", obj.getDateLimiteDeDepot())) %>
                                   </p>
                                   
                                   <jalios:if predicate="<%= afficherBouton %>"> 
                                    <%@ include file='boutonCandidature.jspf' %>
                                   </jalios:if>

                               </div>
                           </div>

                       </div>
                   </section>
               </div>
           </div>
        </div>
        
        <%-- Texte en-tête --%>
        <section id="chapoFiche" class="ds44-contenuArticle">
           <div class="ds44-inner-container ds44-mtb3">
                <div class="ds44-grid12-offset-1">
                   <div class="grid-<%= Util.notEmpty(obj.getImage()) ? "2" : "1" %>-small-1">
                       <jalios:if predicate='<%=Util.notEmpty(obj.getImage())%>'>
                            <div class="col mrl mbs">
                                <figure class="ds44-legendeContainer ds44-container-imgRatio" role="figure" aria-label='<%= obj.getTitle() %>'>
                                    <img src='<%= SocleUtils.getUrlOfFormattedImagePrincipale(obj.getImage()) %>' alt="" class="ds44-w100 ds44-imgRatio">
                                </figure>
                            </div>
                        </jalios:if>
                        
                        <div class='col <%= Util.notEmpty(obj.getImage()) ? "mll" : "" %> mbs'>
                            <div class="ds44-introduction">
                                <jalios:wysiwyg><%= obj.getTexteentete() %></jalios:wysiwyg>
                            </div>
                        </div>
                    </div>
                 </div>
             </div>
         </section>
        
        <%-- Vos missions --%>
        <section id="blocmissions" class="ds44-contenuArticle">
            <div class="ds44-inner-container ds44-mtb3">
                <div class="ds44-grid12-offset-2">
                    <h3 id="titreblocmissions"><%= glp("jcmsplugin.socle.ficheemploi.label.vosmissions") %></h3>
                    <jalios:wysiwyg><%= obj.getMissions() %></jalios:wysiwyg>
                </div>
            </div>
        </section>
        
        <%-- Compétences attendues --%>
        <jalios:if predicate="<%= Util.notEmpty(obj.getConnaissancesEtExperiences()) %>">
            <section id="bloccompetencesattendues" class="ds44-contenuArticle">
                <div class="ds44-inner-container ds44-mtb3">
                    <div class="ds44-grid12-offset-2">
                        <h3 id="titrebloccompetencesattendues"><%= glp("jcmsplugin.socle.ficheemploi.label.competencesattendues") %></h3>
                        <jalios:wysiwyg><%= obj.getConnaissancesEtExperiences() %></jalios:wysiwyg>
                    </div>
                </div>
            </section>
        </jalios:if>
        
        <%-- Avantages sociaux liés au poste --%>
        <jalios:if predicate="<%= Util.notEmpty(obj.getAvantagesSociauxLiesAuPoste()) %>">
            <section id="blocavantagessociaux" class="ds44-contenuArticle">
                <div class="ds44-inner-container ds44-mtb3">
                    <div class="ds44-grid12-offset-2">
                        <h3 id="titreblocavantagessociaux"><%= glp("jcmsplugin.socle.ficheemploi.label.avantagessociaux") %></h3>
                        <jalios:wysiwyg><%= obj.getAvantagesSociauxLiesAuPoste() %></jalios:wysiwyg>
                    </div>
                </div>
            </section>
        </jalios:if>
        
        <%-- Spécificités du poste --%>
        <jalios:if predicate="<%= Util.notEmpty(obj.getSpecificitesDuPoste()) %>">
            <section id="blocspecificites" class="ds44-contenuArticle">
                <div class="ds44-inner-container ds44-mtb3">
                    <div class="ds44-grid12-offset-2">
                        <h3 id="titreblocspecificites" class="h4-like ds44-wsg-exergue"><%= glp("jcmsplugin.socle.ficheemploi.label.specificites") %></h3>
                        <jalios:wysiwyg><%= obj.getSpecificitesDuPoste() %></jalios:wysiwyg>
                    </div>
                </div>
            </section>
        </jalios:if>
        
        <%-- Bloc modalités --%>
        <section id="blocmodalites" class="ds44-contenuArticle">
            <div class="ds44-inner-container ds44-mtb3">
               <div class="ds44-grid12-offset-2">
                   <div class="ds44-wsg-encadreContour">
                       <p class="ds44-box-heading" role="heading" aria-level="2"><%= glp("jcmsplugin.socle.ficheemploi.label.modalites") %></p>
                       
                       <jalios:select>
	                       <jalios:if predicate="<%= Util.notEmpty(obj.getIntroModalitesDeCandidature()) %>">
	                          <jalios:wysiwyg data='<%= obj %>' field='introModalitesDeCandidature'><%= obj.getIntroModalitesDeCandidature() %></jalios:wysiwyg>
	                       </jalios:if>
	                       
	                        <jalios:if predicate="<%= afficherMentions %>">
		                        <div class="mts">
		                            <% SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy"); %>
		                            <%= glp("jcmsplugin.socle.ficheemploi.txt.modalites", obj.getNumeroDePoste(), sdf.format(obj.getDateLimiteDeDepot())) %>
		                        </div>
	                        </jalios:if>
                        </jalios:select>
                       
                       <jalios:if predicate="<%= afficherBouton %>"> 
                           <p class="h4-like ds44-mtb1"><%= glp("jcmsplugin.socle.ficheemploi.label.repondresite") %></p>
	                        <% request.setAttribute("margin", "true"); %>
	                        <%@ include file='boutonCandidature.jspf' %>
	                        <% request.removeAttribute("margin"); %>
                       </jalios:if>

						<jalios:select>
							<!-- Cas 1 modalités remplies : on les affiche -->
							<jalios:if
								predicate="<%= Util.notEmpty(obj.getModalitesDeCandidature()) %>">
								<jalios:wysiwyg><%= obj.getModalitesDeCandidature() %></jalios:wysiwyg>
							</jalios:if>
							
                            <!-- Cas 2 modalités pas remplies, alors on les génère :
                                - si fiche emploi rattachée au siège (services centraux) affichage de propriétés
                                - si fiche emploi rattachée à une Délégation alors on affiche l'adresse du service ressource de la Délégation (via Fiche lieu)
                            -->	
                            <jalios:if predicate="<%= afficherMentions %>">						
								<jalios:select>
	                               
	                                <!-- Sièges -->
									<jalios:if predicate='<%=obj.getDirectiondelegation(loggedMember).contains(channel.getCategory("$jcmsplugin.socle.emploiStage.delegation.servicescentraux"))
									    && afficherMentions%>'>
										<p class="h4-like ds44-mtb1"><%=glp("jcmsplugin.socle.ficheemploi.label.repondrecourrier")%></p>
										<jalios:wysiwyg>
											<%=glp("jcmsplugin.socle.ficheemploi.html.contact")%>
										</jalios:wysiwyg>
									</jalios:if>
	
									<!-- Délégations -->
									<jalios:default>
										<p class="h4-like ds44-mtb1"><%=glp("jcmsplugin.socle.ficheemploi.label.repondrecourrier2")%></p>
										<jalios:foreach name="itCatDelegation" type="Category" collection="<%= obj.getDirectiondelegation(loggedMember) %>">
		                                    <%
		                                    FicheLieu itServiceRessources = SocleUtils.getServiceRessources(itCatDelegation);
		                                    %>
		                                    <jalios:if predicate="<%= Util.notEmpty(itServiceRessources) %>">
                                                <div class="mts">
			                                        <%= itCatDelegation.getName() %><br>
			                                        <%= glp("jcmsplugin.socle.ficheemploi.label.serviceRessources") %><br>
			                                        <%= SocleUtils.formatAdressePhysique(itServiceRessources) %>
		                                        </div>
		                                    </jalios:if>
										</jalios:foreach>
									</jalios:default>
	
								</jalios:select>
							</jalios:if>

						</jalios:select>

					</div>
                </div>
            </div>
        </section>
        
        <%
                  boolean hasContactRH = Util.notEmpty(obj.getContactRH()) || Util.notEmpty(obj.getUniteOrgaContactRH());
                  boolean hasContactMetier = Util.notEmpty(obj.getContactMetier()) || Util.notEmpty(obj.getUniteOrgaContactMetier());

                  int nbContactsRH = Math.max(null != obj.getContactRH() ? obj.getContactRH().length : 0,
                      null != obj.getUniteOrgaContactRH() ? obj.getUniteOrgaContactRH().length : 0);
                  int nbContactsMetier = Math.max(null != obj.getContactMetier() ? obj.getContactMetier().length : 0,
                      null != obj.getUniteOrgaContactMetier() ? obj.getUniteOrgaContactMetier().length : 0);
                %>
        
        <%-- Bloc vos contacts --%>
        <jalios:if predicate="<%= hasContactRH || hasContactMetier %>">
           <section id="bloccontacts" class="ds44-contenuArticle">
               <div class="ds44-inner-container ds44-mtb3">
                   <div class="ds44-grid12-offset-2">
                       <div class="ds44-wsg-encadreApplat">
                            <p class="ds44-box-heading" role="heading" aria-level="2"><%= glp("jcmsplugin.socle.ficheemploi.label.contacts") %></p>
                            <div class="grid-<%= hasContactRH && hasContactMetier ? '2' : '1' %>-small-1">

                                <jalios:if predicate="<%= hasContactRH %>">
                                    <div class="col ds44--xl-padding-l ds44-TtL-noPad">
                                    

                                        <%-- On boucle sur le nombre de contacts RH --%> 
                                        <%
                                        for(int cptContactRH = 0; cptContactRH < nbContactsRH ; cptContactRH++){
                                          String libelleContactRH = "";
                                          String libelleEmailContactRH = "";
                                        %>
                                            <div class='ds44-docListElem <%= cptContactRH == 0 ? "mts" : "mtm" %>'>
                                                <i class="icon icon-user ds44-docListIco" aria-hidden="true"></i>
                                                
                                                <jalios:if predicate="<%= Util.notEmpty(obj.getContactRH()) && cptContactRH < obj.getContactRH().length && Util.notEmpty(obj.getContactRH()[cptContactRH]) %>">
                                                    <% libelleContactRH = obj.getContactRH()[cptContactRH]; %>
                                                    <%= libelleContactRH %>
                                                </jalios:if>
                                                
                                                <jalios:if predicate="<%= Util.notEmpty(obj.getUniteOrgaContactRH()) && cptContactRH < obj.getUniteOrgaContactRH().length && Util.notEmpty(obj.getUniteOrgaContactRH()[cptContactRH]) %>">
                                                    <jalios:if predicate="<%= cptContactRH < obj.getContactRH().length && Util.notEmpty(obj.getContactRH()[cptContactRH]) %>">
                                                        <br/>
                                                    </jalios:if>
                                                    <%= obj.getUniteOrgaContactRH()[cptContactRH] %>
                                                </jalios:if>
                                                
                                            </div>

                                            <jalios:if predicate='<%= Util.notEmpty(obj.getTelContactRH()) && cptContactRH < obj.getTelContactRH().length && Util.notEmpty(obj.getTelContactRH()[cptContactRH]) %>'>
                                                <div class="ds44-docListElem mts">
                                                    <i class="icon icon-phone ds44-docListIco" aria-hidden="true"></i>
                                                    <ds:phone number="<%= obj.getTelContactRH()[cptContactRH] %>" pubTitle="<%= obj.getTitle() %>"></ds:phone>
                                                </div>
                                            </jalios:if>

                                            <jalios:if predicate='<%= Util.notEmpty(obj.getEmailContactRH()) && cptContactRH < obj.getEmailContactRH().length && Util.notEmpty(obj.getEmailContactRH()[cptContactRH]) %>'>
                                                <div class="ds44-docListElem mts">
                                                    <i class="icon icon-mail ds44-docListIco" aria-hidden="true"></i>
                                                    <%
                                                    if(Util.notEmpty(libelleContactRH)){
                                                      libelleEmailContactRH = libelleContactRH; 
                                                    }
                                                    
                                                    String email = obj.getEmailContactRH()[cptContactRH]; %>
                                                    <a href='<%= "mailto:"+email %>'
                                                       title='<%= HttpUtil.encodeForHTMLAttribute(glp("jcmsplugin.socle.ficheaide.contacter-x-par-mail.label", libelleEmailContactRH, email)) %>'
                                                       data-statistic='{"name": "declenche-evenement","category": "BlocNousContacter","action": "Mailto","label": "<%= HttpUtil.encodeForHTMLAttribute(obj.getTitle()) %>"}'> 
                                                        <%=  glp("jcmsplugin.socle.ficheaide.contacter-par-mail.label")  %>
                                                    </a>
                                                </div>
                                            </jalios:if>

                                       <%} %>
                                    </div>
                                </jalios:if>
                                   
                                <jalios:if predicate="<%= hasContactMetier %>">
                                    <div class="col">
                                        <%-- On boucle sur le nombre de contacts Métiers --%>
                                        <%
                                        for(int cptContactMetier = 0; cptContactMetier < nbContactsMetier ; cptContactMetier++) {
                                          String libelleContactMetier = "";
                                          String libelleEmailContactMetier = "";
                                        %>
                                                <div class='ds44-docListElem <%= cptContactMetier == 0 ? "mts" : "mtm" %>'>
                                                    <i class="icon icon-user ds44-docListIco" aria-hidden="true"></i>
                                                    
                                                    <jalios:if predicate="<%= Util.notEmpty(obj.getContactMetier()) && cptContactMetier < obj.getContactMetier().length && Util.notEmpty(obj.getContactMetier()[cptContactMetier]) %>">
                                                        <% libelleContactMetier = obj.getContactMetier()[cptContactMetier]; %>
                                                        <%= libelleContactMetier %>
                                                    </jalios:if>
                                                    
                                                    <jalios:if predicate="<%= Util.notEmpty(obj.getUniteOrgaContactMetier()) && cptContactMetier < obj.getUniteOrgaContactMetier().length && Util.notEmpty(obj.getUniteOrgaContactMetier()[cptContactMetier]) %>">
                                                        <jalios:if predicate="<%= Util.notEmpty(obj.getContactMetier()) && cptContactMetier < obj.getContactMetier().length && Util.notEmpty(obj.getContactMetier()[cptContactMetier]) %>">
                                                            <br/>
                                                        </jalios:if>
                                                        <%= obj.getUniteOrgaContactMetier()[cptContactMetier] %>
                                                    </jalios:if>
                                                    
                                                </div>

                                                <jalios:if predicate='<%= Util.notEmpty(obj.getTelContactMetier()) && cptContactMetier < obj.getTelContactMetier().length && Util.notEmpty(obj.getTelContactMetier()[cptContactMetier]) %>'>
                                                    <div class="ds44-docListElem mts">
                                                        <i class="icon icon-phone ds44-docListIco" aria-hidden="true"></i>
                                                        <ds:phone number="<%= obj.getTelContactMetier()[cptContactMetier] %>" pubTitle="<%= obj.getTitle() %>"></ds:phone>
                                                    </div>
                                                </jalios:if>

	                                            <jalios:if predicate='<%= Util.notEmpty(obj.getEmailContactMetier()) && cptContactMetier < obj.getEmailContactMetier().length && Util.notEmpty(obj.getEmailContactMetier()[cptContactMetier]) %>'>
	                                                <div class="ds44-docListElem mts">
	                                                    <i class="icon icon-mail ds44-docListIco" aria-hidden="true"></i>
	                                                    <% 
	                                                    if(Util.notEmpty(libelleContactMetier)){
	                                                      libelleEmailContactMetier = libelleContactMetier; 
	                                                    }
	                                                    
	                                                    String email = obj.getEmailContactMetier()[cptContactMetier];
	                                                    
	                                                    %>
	                                                    <a href='<%= "mailto:"+email %>'
	                                                       title='<%= HttpUtil.encodeForHTMLAttribute(glp("jcmsplugin.socle.ficheaide.contacter-x-par-mail.label", libelleEmailContactMetier, email)) %>'
	                                                       data-statistic='{"name": "declenche-evenement","category": "BlocNousContacter","action": "Mailto","label": "<%= HttpUtil.encodeForHTMLAttribute(obj.getTitle()) %>"}'> 
	                                                        <%=  glp("jcmsplugin.socle.ficheaide.contacter-par-mail.label")  %>
	                                                    </a>
	                                                </div>
	                                            </jalios:if>
                                                                                            
                                        <%} %>
                                    </div>
                                </jalios:if>                                   


                            </div>
                        </div>
                   </div>
               </div>
           </section>
        </jalios:if>
        
        <%-- Partagez cette page --%>
        <%@ include file="/plugins/SoclePlugin/jsp/portal/socialNetworksShare.jspf" %>
        
        <%-- Bloc Portlet Push --%>
        <jalios:if predicate='<%=Util.notEmpty(channel.getProperty("jcmsplugin.socle.portletPush.ficheemploi.id"))%>'>
            <jalios:include id='<%=channel.getProperty("jcmsplugin.socle.portletPush.ficheemploi.id")%>' />
        </jalios:if>
        
        
        <%-- Bloc documents utiles --%>
        <jalios:if predicate="<%= Util.notEmpty(obj.getDocumentsMultiple()) %>">
        <section id="blocdocuments" class="ds44-contenuArticle">
            <div class="ds44-inner-container ds44-mtb3">
                <div class="ds44-grid12-offset-2">
                    <div class="ds44-bgGray">
                        <div class="ds44-innerBoxContainer">
                        <p class="ds44-box-heading" role="heading" aria-level="2"><%= glp("jcmsplugin.socle.ficheemploi.label.docsutiles") %></p>
                            <ul class="ds44-list">
                                <jalios:foreach name="itDoc" type="FileDocument" array="<%= obj.getDocumentsMultiple() %>" counter="itCounter">
                                    <%
                                    String docTitle = itDoc.getFilename();
                                    if (Util.notEmpty(obj.getTitreEncartDocument()) && itCounter <= obj.getTitreEncartDocument().length && Util.notEmpty(obj.getTitreEncartDocument()[itCounter-1])) {
                                        docTitle = obj.getTitreEncartDocument()[itCounter-1];
                                    }
                                    // Récupérer l'extension du fichier
                                    String fileType = FileDocument.getExtension(itDoc.getFilename()).toUpperCase();
                                    // Récupérer la taille du fichier
                                    String fileSize = Util.formatFileSize(itDoc.getSize());
                                    %>
                                    <li class="mts">
                                        <p class="ds44-docListElem"><i class="icon icon-file ds44-docListIco" aria-hidden="true"></i><a href="<%= itDoc.getDownloadUrl() %>" target="_blank" title='<%= HttpUtil.encodeForHTMLAttribute(itDoc.getTitle()) %> <%= glp("jcmsplugin.socle.accessibily.newTabLabel") %>'><%= itDoc.getTitle() %></a><span class="ds44-cardFile"><%= fileType %> - <%= fileSize %></span></p>
                                    </li>
                                </jalios:foreach>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        </jalios:if>
        
        <%-- Bas de page --%>
        
    </article>
</main>
