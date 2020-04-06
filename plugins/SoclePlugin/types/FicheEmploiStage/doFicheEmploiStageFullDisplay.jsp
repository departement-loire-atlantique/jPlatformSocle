<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%>
<%@ include file='/jcore/doInitPage.jspf'%>
<%
    FicheEmploiStage obj = (FicheEmploiStage) request.getAttribute(PortalManager.PORTAL_PUBLICATION);
%>
<%@ include file='/front/doFullDisplay.jspf'%>
<%@ page import="fr.cg44.plugin.socle.SocleUtils"%>
<main role="main" id="content">
    <article class="ds44-container-large">

	    <div class="ds44-lightBG ds44-posRel">
	        <%-- TODO bouton Retour a la liste --%>
	        <%-- <a class="ds44-btnStd ds44-btnStd--retourPage" title='<%= HttpUtil.encodeForHTMLAttribute(glp("jcmsplugin.socle.retourALaListeLieux")) %>'> 
	            <i class="icon icon-long-arrow-left" aria-hidden="true"></i> 
	            <span class="ds44-btnInnerText"><%= glp("jcmsplugin.socle.retourALaListe") %></span>
	        </a> --%>
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
                                       <jalios:if predicate='<%= !obj.getDirectiondelegation(loggedMember).contains(channel.getCategory("$jcmsplugin.socle.emploiStage.delegationService")) %>'>
                                           <%= SocleUtils.formatCategories(obj.getDirectiondelegation(loggedMember)) %>
                                           <br/>                                
                                       </jalios:if>
                                       <%= obj.getService() %>
                                       <jalios:if predicate='<%= obj.getDirectiondelegation(loggedMember).contains(channel.getCategory("$jcmsplugin.socle.emploiStage.delegationService")) %>'>
                                           <br/>
                                           <%
                                           SortedSet<Category> catsWithoutServices = obj.getDirectiondelegation(loggedMember);
                                           catsWithoutServices.remove(channel.getCategory("$jcmsplugin.socle.emploiStage.delegationService"));
                                           %>
                                           <%= SocleUtils.formatCategories(catsWithoutServices) %>
                                       </jalios:if>
                                       <jalios:if predicate="<%= Util.notEmpty(obj.getPositionHierarchique()) %>">
                                       <br/>
                                       <%= obj.getPositionHierarchique() %>
                                       </jalios:if>
                                   </p>
                               </div>
	                           <div class="col">
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
	                               <a href="#" class="ds44-btnStd ds44-btn--invert">
	                                   <span class="ds44-btnInnerText"><%= glp("jcmsplugin.socle.ficheemploi.label.envoicandidature") %></span>
	                                   <i class="icon icon-computer" aria-hidden="true"></i>
	                               </a>
	                           </div>
	                       </div>
	                       
	                       <%-- Répondre à cette offre --%>
	                       
	                       <%-- Bouton qui ouvre un formulaire --%>
	                       <%-- TODO : uniquement le lien pour le moment. Traiter l'ouverture du formulaire plus tard --%>
	                   </div>
	               </section>
	           </div>
	       </div>
	    </div>
	    
	    <%-- Texte en-tête --%>
	    <jalios:if predicate="<%= Util.notEmpty(obj.getTexteentete()) || Util.notEmpty(obj.getImage()) %>">
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
		                    
		                    <jalios:if predicate="<%= Util.notEmpty(obj.getTexteentete()) %>">
	                           <div class='col <%= Util.notEmpty(obj.getImage()) ? "mll" : "" %> mbs'>
	                               <div class="ds44-introduction">
	                                   <jalios:wysiwyg><%= obj.getTexteentete() %></jalios:wysiwyg>
	                                </div>
	                           </div>
	                       </jalios:if>
	                   </div>
	                </div>
	            </div>
		    </section>
	    </jalios:if>
	    
	    <%-- Vos missions --%>
	    <section id="blocmissions" class="ds44-contenuArticle">
            <div class="ds44-inner-container ds44-mtb3">
                <div class="ds44-grid12-offset-2">
                    <h3 id="titreblocmissions"><%= glp("jcmsplugin.socle.ficheemploi.label.vosmissions") %></h3>
                    <jalios:wysiwyg><%= obj.getMissions() %></jalios:wysiwyg>
                </div>
            </div>
        </section>
	    
	    <%-- Activités --%>
	    <section id="blocactivites" class="ds44-contenuArticle">
            <div class="ds44-inner-container ds44-mtb3">
                <div class="ds44-grid12-offset-2">
                    <h3 id="titreblocactivites"><%= glp("jcmsplugin.socle.ficheemploi.label.activites") %></h3>
                    <jalios:wysiwyg><%= obj.getActivites() %></jalios:wysiwyg>
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
	    
	    <%-- Conditions à remplir --%>
	    <jalios:if predicate="<%= Util.notEmpty(obj.getConditionsARemplir()) %>">
            <section id="blocconditions" class="ds44-contenuArticle">
                <div class="ds44-inner-container ds44-mtb3">
                    <div class="ds44-grid12-offset-2">
                        <h3 id="titreblocconditions"><%= glp("jcmsplugin.socle.ficheemploi.label.conditions") %></h3>
                        <jalios:wysiwyg><%= obj.getConditionsARemplir() %></jalios:wysiwyg>
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
		                  <jalios:if predicate="<%= Util.notEmpty(obj.getModalitesDeCandidature()) %>">
		                      <jalios:wysiwyg><%= obj.getModalitesDeCandidature() %></jalios:wysiwyg>
		                  </jalios:if>
		                  <jalios:default>
		                      <% SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy"); %>
		                      <%= glp("jcmsplugin.socle.ficheemploi.txt.modalites", obj.getNumeroDePoste(), sdf.format(obj.getDateLimiteDeDepot()), obj.getCategorieDemploi(loggedMember).first()) %>
		                  </jalios:default>
		               </jalios:select>
		               <p class="h4-like ds44-mtb1"><%= glp("jcmsplugin.socle.ficheemploi.label.repondresite") %></p>
		               <%-- La partie suivante est en dur faute à des specs incomplètes sur le sujet --%>
		               <a href="#" class="ds44-btnStd ds44-btn--invert">
	                       <span class="ds44-btnInnerText"><%= glp("jcmsplugin.socle.ficheemploi.label.envoicandidature") %></span>
	                       <i class="icon icon-computer" aria-hidden="true"></i>
                       </a>
                       <p class="h4-like ds44-mtb1"><%= glp("jcmsplugin.socle.ficheemploi.label.repondrecourrier") %></p>
                       <jalios:wysiwyg>
                           <%= glp("jcmsplugin.socle.ficheemploi.html.contact") %>
                       </jalios:wysiwyg>
                       
                       <%-- Fin du bloc en dur --%>
		           </div>
                </div>
		    </div>
		</section>
	    
	    <%
	    boolean hasContactRH = Util.notEmpty(obj.getContactRH()) || Util.notEmpty(obj.getUniteOrgaContactRH()) || Util.notEmpty(obj.getTelContactRH());
	    boolean hasContactMetier = Util.notEmpty(obj.getContactMetier()) || Util.notEmpty(obj.getUniteOrgaContactMetier()) || Util.notEmpty(obj.getTelContactMetier());
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
	                               <div class="col">
	                                   <jalios:if predicate="<%= Util.notEmpty(obj.getContactRH()) || Util.notEmpty(obj.getUniteOrgaContactRH()) %>">
			                               <p class="ds44-docListElem mts">
			                                   <i class="icon icon-user ds44-docListIco" aria-hidden="true"></i>
			                                   <jalios:if predicate="<%= Util.notEmpty(obj.getContactRH()) %>">
		                                           <%= obj.getContactRH() %>
		                                       </jalios:if>
		                                       <jalios:if predicate="<%= Util.notEmpty(obj.getUniteOrgaContactRH()) %>">
		                                           <jalios:if predicate="<%= Util.notEmpty(obj.getContactRH()) %>">
		                                           <br/>
		                                           </jalios:if>
		                                           <%= obj.getUniteOrgaContactRH() %>
		                                       </jalios:if>
			                               </p>
		                               </jalios:if>
		                               <jalios:if predicate="<%= Util.notEmpty(obj.getTelContactRH()) %>">
		                                    <p class="ds44-docListElem mts">
			                                    <i class="icon icon-phone ds44-docListIco" aria-hidden="true"></i>
			                                    <%= obj.getTelContactRH() %>
		                                    </p>
		                               </jalios:if>
	                               </div>
	                               </jalios:if>
	                               <jalios:if predicate="<%= hasContactMetier %>">
                                   <div class="col">
                                       <jalios:if predicate="<%= Util.notEmpty(obj.getContactMetier()) || Util.notEmpty(obj.getUniteOrgaContactMetier()) %>">
                                           <p class="ds44-docListElem mts">
                                               <i class="icon icon-user ds44-docListIco" aria-hidden="true"></i>
                                               <jalios:if predicate="<%= Util.notEmpty(obj.getContactMetier()) %>">
                                                   <%= obj.getContactMetier() %>
                                               </jalios:if>
                                               <jalios:if predicate="<%= Util.notEmpty(obj.getUniteOrgaContactMetier()) %>">
                                                   <jalios:if predicate="<%= Util.notEmpty(obj.getContactMetier()) %>">
                                                   <br/>
                                                   </jalios:if>
                                                   <%= obj.getUniteOrgaContactMetier() %>
                                               </jalios:if>
                                           </p>
                                       </jalios:if>
                                       <jalios:if predicate="<%= Util.notEmpty(obj.getTelContactMetier()) %>">
                                            <p class="ds44-docListElem mts">
                                                <i class="icon icon-phone ds44-docListIco" aria-hidden="true"></i>
                                                <%= obj.getTelContactMetier() %>
                                            </p>
                                       </jalios:if>
                                   </div>
                                   </jalios:if>
	                           </div>
	                       </div>
	               </div>
	           </div>
	       </section>
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
			                        String fileSize = Util.formatFileSize(itDoc.getSize(), userLocale);
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
