<%@page import="fr.cg44.plugin.socle.GeolocalisationUtil"%>
<%@ page import="fr.cg44.plugin.socle.SocleUtils" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="ds" tagdir="/WEB-INF/tags" %>
<%@ include file='/jcore/doInitPage.jspf' %>
<%@ page import="fr.cg44.plugin.socle.SocleUtils" %>
<% SeniorCitizensEstablishment obj = (SeniorCitizensEstablishment)request.getAttribute(PortalManager.PORTAL_PUBLICATION); %>

<jalios:buffer name="coloredSectionContent">
	<div class="grid-2-small-1 ds44-grid12-offset-1">
		<div class="col">
			<%
				String separator = ", ";
				StringBuffer sbfTypeStruct = new StringBuffer();
				String typeStruct = "";
				for(Category itCat : obj.getStructureType(loggedMember)) {
					if(Util.notEmpty(typeStruct)) {
						sbfTypeStruct.append(separator);
					}
					sbfTypeStruct.append(itCat.getName());
				}
			%>
			<p class="ds44-docListElem mts">
				<i class="icon icon-tag ds44-docListIco" aria-hidden="true"></i>
				<%= sbfTypeStruct.toString() %>
			</p>
			<%
				StringBuffer sbfAdresse = new StringBuffer();
				
				sbfAdresse.append(obj.getAddress())
					.append("<br/>");
				
				if(Util.notEmpty(obj.getPostalBox())) {
					sbfAdresse.append(obj.getPostalBox())
						.append(" ");
				}
				
				sbfAdresse.append(obj.getZipCode())
					.append(" ")
					.append(obj.getCommune().getTitle());
			%>
			<p class="ds44-docListElem mts">
				<i class="icon icon-marker ds44-docListIco" aria-hidden="true"></i>
				<%= sbfAdresse.toString() %>
			</p>
			<%
				String longitude = obj.getExtraData("extra.SeniorCitizensEstablishment.plugin.tools.geolocation.longitude");
				String latitude = obj.getExtraData("extra.SeniorCitizensEstablishment.plugin.tools.geolocation.latitude");
				String localisation = SocleUtils.formatOpenStreetMapLink(latitude, longitude);
			%>
			<jalios:if predicate='<%= Util.notEmpty(localisation) %>'>
				<p class="ds44-docListElem mts">
					<i class="icon icon-map ds44-docListIco" aria-hidden="true"></i>
					<a href='<%= localisation%>' 
						title='<%= HttpUtil.encodeForHTMLAttribute(glp("jcmsplugin.socle.ficheaide.localiser-carte.label")+" : " + obj.getTitle() + " " + glp("jcmsplugin.socle.accessibily.newTabLabel"))%>' 
						target="_blank"
						data-statistic='{"name": "declenche-evenement","category": "BlocNousContacter","action": "Localiser","label": "<%= HttpUtil.encodeForHTMLAttribute(obj.getTitle()) %>"}'> 
						
						<%= glp("jcmsplugin.socle.ficheaide.localiser-carte.label") %> 
					</a>
				</p>
			</jalios:if>
		</div>
		<jalios:if predicate="<%= Util.notEmpty(obj.getPhones()) || Util.notEmpty(obj.getMails()) || Util.notEmpty(obj.getWebsites()) %>">
			<div class="col ds44--xl-padding-l">
			
				<jalios:if predicate='<%=Util.notEmpty(obj.getPhones())%>'>
					<div class="ds44-docListElem mts">
						<i class="icon icon-phone ds44-docListIco" aria-hidden="true"></i>

						<jalios:if predicate='<%= obj.getPhones().length == 1 %>'>
							<% String numTel = obj.getPhones()[0]; %>
							<ds:phone number="<%= numTel %>" pubTitle="<%= obj.getTitle() %>"/>
						</jalios:if>

						<jalios:if predicate='<%= obj.getPhones().length > 1 %>'>
							<ul class="ds44-list">
								<jalios:foreach name="numTel" type="String" array="<%= obj.getPhones() %>">
									<li>
										<ds:phone number="<%= numTel %>" pubTitle="<%= obj.getTitle() %>"/>
									</li>
								</jalios:foreach>
							</ul>
						</jalios:if>

					</div>
				</jalios:if>

				<jalios:if predicate='<%=Util.notEmpty(obj.getMails())%>'>
					<div class="ds44-docListElem mts">
						<i class="icon icon-mail ds44-docListIco" aria-hidden="true"></i>

						<jalios:if predicate='<%= obj.getMails().length == 1 %>'>
							<% String email = obj.getMails()[0]; %>
							<a href='<%= "mailto:"+email %>' title='<%= HttpUtil.encodeForHTMLAttribute(glp("jcmsplugin.socle.ficheaide.contacter-x-par-mail.label", obj.getTitle(), email)) %>'
							   data-statistic='{"name": "declenche-evenement","category": "BlocNousContacter","action": "Mailto","label": "<%=HttpUtil.encodeForHTMLAttribute(obj.getTitle())%>"}'> 
								<%= glp("jcmsplugin.socle.ficheaide.contacter-par-mail.label")  %>
							</a>
						</jalios:if>

						<jalios:if predicate='<%= obj.getMails().length > 1 %>'>
							<ul class="ds44-list">
								<jalios:foreach name="email" type="String" array='<%= obj.getMails() %>'>
									<li>
										<a href='<%= "mailto:"+email %>' title='<%= HttpUtil.encodeForHTMLAttribute(glp("jcmsplugin.socle.ficheaide.contacter-x-par-mail.label", obj.getTitle(), email)) %>'
										   data-statistic='{"name": "declenche-evenement","category": "BlocNousContacter","action": "Mailto","label": "<%=HttpUtil.encodeForHTMLAttribute(obj.getTitle())%>"}'> 
											<%= email %>
										</a>
									</li>
								</jalios:foreach>
							</ul>
						</jalios:if>

					</div>
				</jalios:if>

				<jalios:if predicate='<%=Util.notEmpty(obj.getWebsites())%>'>
					<div class="ds44-docListElem mts">
						<i class="icon icon-link ds44-docListIco" aria-hidden="true"></i>

						<jalios:if predicate='<%= obj.getWebsites().length == 1 %>'>
							<% String site = obj.getWebsites()[0]; %>
							<a href='<%= SocleUtils.parseUrl(site) %>' title='<%= glp("jcmsplugin.socle.lien.site.nouvelonglet", obj.getTitle()) %>' target="_blank"
							   data-statistic='{"name": "declenche-evenement","category": "BlocNousContacter","action": "Site web","label": "<%=HttpUtil.encodeForHTMLAttribute(obj.getTitle())%>"}'>
								<%= glp("jcmsplugin.socle.ficheaide.visiter-site.label") %>
							</a>
						</jalios:if>

						<jalios:if predicate='<%= obj.getWebsites().length > 1 %>'>
							<ul class="ds44-list">
								<jalios:foreach name="site" type="String" array='<%= obj.getWebsites() %>'>
									<li>
										<a href='<%= SocleUtils.parseUrl(site) %>' title='<%= glp("jcmsplugin.socle.lien.site.nouvelonglet", site) %>' target="_blank"
										   data-statistic='{"name": "declenche-evenement","category": "BlocNousContacter","action": "Site web","label": "<%=HttpUtil.encodeForHTMLAttribute(obj.getTitle())%>"}'> 
											<%= SocleUtils.parseUrl(site) %>
										</a>
									</li>
								</jalios:foreach>
							</ul>
						</jalios:if>

					</div>
				</jalios:if>
			</div>
		</jalios:if>
	</div>
</jalios:buffer>

<main id="content" role="main">

<jalios:include target="SOCLE_ALERTE"/>

	<article class="ds44-container-large">
	
		<ds:titleNoImage title="<%= obj.getTitle(userLang) %>" breadcrumb="true" coloredSection="<%= coloredSectionContent %>"></ds:titleNoImage>
	
		<jalios:if predicate="<%= Util.notEmpty(obj.getDescription()) || Util.notEmpty(obj.getLifeEnvironmentText()) 
				|| Util.notEmpty(obj.getSafeServiceText()) || Util.notEmpty(obj.getSocialLifeText()) || Util.notEmpty(obj.getAnimationsText()) %>">
			<section class="ds44-contenuArticle" id="section1">
				<div class="ds44-inner-container">
					<div class="ds44-grid12-offset-2">
						<div class="grid-2-small-1">
							<jalios:if predicate="<%= Util.notEmpty(obj.getDescription()) %>">
								<div class="col col-2 mrs ds44-mtb2">
									<div class="ds44-introduction">
										<jalios:wysiwyg><%= obj.getDescription() %></jalios:wysiwyg>
									</div>
								</div>
							</jalios:if>
							<jalios:if predicate="<%= Util.notEmpty(obj.getLifeEnvironmentText()) %>">
								<div class="col mls ds44-mtb2">
									<h2 class="h3-like" id="idTitre-list2"><%= glp("jcmsplugin.socle.etablissementpersonnesagees.cadredevie") %></h2>
									<jalios:wysiwyg><%= obj.getLifeEnvironmentText() %></jalios:wysiwyg>
								</div>
							</jalios:if>
							<jalios:if predicate="<%= Util.notEmpty(obj.getSafeServiceText()) %>">
								<div class="col mrs ds44-mtb2">
									<h2 class="h3-like" id="idTitre-list3"><%= glp("jcmsplugin.socle.etablissementpersonnesagees.services") %></h2>
									<jalios:wysiwyg><%= obj.getSafeServiceText() %></jalios:wysiwyg>
								</div>
							</jalios:if>
							<jalios:if predicate="<%= Util.notEmpty(obj.getSocialLifeText()) %>">
								<div class="col mrs ds44-mtb2">
									<h2 class="h3-like" id="idTitre-list4"><%= glp("jcmsplugin.socle.etablissementpersonnesagees.viesociale") %></h2>
									<jalios:wysiwyg><%= obj.getSocialLifeText() %></jalios:wysiwyg>
								</div>
							</jalios:if>
							<jalios:if predicate="<%= Util.notEmpty(obj.getAnimationsText()) %>">
								<div class="col mrs ds44-mtb2">
									<h2 class="h3-like" id="idTitre-list5"><%= glp("jcmsplugin.socle.etablissementpersonnesagees.animations") %></h2>
									<jalios:wysiwyg><%= obj.getAnimationsText() %></jalios:wysiwyg>
								</div>
							</jalios:if>
						</div>
					</div>
				</div>
			</section>
		</jalios:if>
	
		<section class="ds44-contenuArticle" id="section2">
			<div class="ds44-inner-container ds44-mtb3">
				<div class="ds44-grid12-offset-2">
					
					<jalios:if predicate="<%= Util.notEmpty(obj.getContractText()) || Util.notEmpty(obj.getConventionsCostText()) %>">
						<section class="ds44-box ds44-theme">
							<div class="ds44-innerBoxContainer">
								<p role="heading" aria-level="2" class="ds44-box-heading"><%= glp("jcmsplugin.socle.etablissementpersonnesagees.tarifsconventions") %></p>
								<jalios:if predicate="<%= Util.notEmpty(obj.getContractText()) %>">
									<jalios:wysiwyg><%= obj.getContractText() %></jalios:wysiwyg>
								</jalios:if>
								<jalios:if predicate="<%= Util.notEmpty(obj.getConventionsCostText()) %>">
									<jalios:wysiwyg><%= obj.getConventionsCostText() %></jalios:wysiwyg>
								</jalios:if>
							</div>
						</section>
					</jalios:if>
	
					<jalios:if predicate="<%= Util.notEmpty(obj.getRemarkText()) %>">
						<h2 class="h3-like ds44-mt3 ds44-mb2" id="idTitre2"><%= glp("jcmsplugin.socle.etablissementpersonnesagees.remarquessupplementaires") %></h2>
						<jalios:wysiwyg><%= obj.getRemarkText() %></jalios:wysiwyg>
					</jalios:if>
	
	
	               
	
					
					<%
					List<FicheLieu> lieuAssocie = new ArrayList<FicheLieu>();
					
					// Si aucun CLIC n'est associé, c'est le CLIC le plus proche de l'établissement qui est affiché
					FicheLieu[] clicAssocie = obj.getClics();
					Category clicRootCat = channel.getCategory("$jcmsplugin.socle.type.sectorisation.clic.cat");
					if(Util.isEmpty(obj.getClics()) && Util.notEmpty(clicRootCat)) {
						Set<Publication> listCLIC = clicRootCat.getPublicationSet(Publication.class, loggedMember) ;
						FicheLieu clic = (FicheLieu) GeolocalisationUtil.getClosenessDistancePublications((Publication) obj, listCLIC);
						clicAssocie = new FicheLieu[]{clic};
					}
					lieuAssocie.addAll(Arrays.asList(clicAssocie));
					
					// Fiche paph associé
					Category paphRootCat = channel.getCategory("$jcmsplugin.socle.type.sectorisation.paph.cat");
                    if(Util.notEmpty(paphRootCat)){
                        // Recherche de la fiche lieu paph de la meme commune de délégation que la fiche d'etablissement
                        Set<FicheLieu> listPAPH = paphRootCat.getPublicationSet(FicheLieu.class, loggedMember);
                        if(Util.notEmpty(listPAPH)) {
	                        FicheLieu placePAPH = null ;
	                        for(FicheLieu place : listPAPH){                            
	                            if(obj.getCommune() != null && obj.getCommune().getDelegation() != null && JcmsUtil.isSameId(place.getCommune(), obj.getCommune().getDelegation().getCommune())){
	                                placePAPH = place ;
	                                break;
	                            }
	                        }
	                        lieuAssocie.add(placePAPH);
                        }
                    }                                  					
					%>
					
					
					<jalios:if predicate="<%= Util.notEmpty(lieuAssocie) %>">
						<div class="ds44-mtb3">
							<section class="ds44-innerBoxContainer ds44-borderContainer">
								<h2 id="idTitreBox2col-1" class="h2-like"><%= glp("jcmsplugin.socle.etablissementpersonnesagees.questionconseil") %></h2>
		
								<div class="grid-12-small-1">
								
						            
										<jalios:foreach name="itFicheLieu" type="FicheLieu" collection="<%= Util.cleanCollection(lieuAssocie) %>">
											<% 
												String style = itCounter == 0 ? "ds44-mb3" : "ds44-medToXlarge-pl3";
											%>
											<div class="col col-6 <%= style %>">
												<p role="heading" aria-level="3" class="h3-like"><%= itFicheLieu.getTitle() %></p>
												
												<% String adressEcrire =  SocleUtils.formatAdresseEcrire(itFicheLieu); %>
												<jalios:if predicate="<%= Util.notEmpty(adressEcrire) %>">
													<p class="ds44-docListElem mts">
														<i class="icon icon-marker ds44-docListIco" aria-hidden="true"></i>
														<%= adressEcrire %>
													</p>
												</jalios:if>
												
												<jalios:if predicate='<%=Util.notEmpty(itFicheLieu.getTelephone())%>'>
													<div class="ds44-docListElem mts">
														<i class="icon icon-phone ds44-docListIco" aria-hidden="true"></i>
		
														<jalios:if predicate='<%= itFicheLieu.getTelephone().length == 1 %>'>
															<% String numTel = itFicheLieu.getTelephone()[0]; %>
															<ds:phone number="<%= numTel %>" pubTitle="<%= obj.getTitle() %>"/>
														</jalios:if>
		
														<jalios:if predicate='<%= itFicheLieu.getTelephone().length > 1 %>'>
															<ul class="ds44-list">
																<jalios:foreach name="numTel" type="String" array="<%= itFicheLieu.getTelephone() %>">
																	<li>
																		<ds:phone number="<%= numTel %>" pubTitle="<%= obj.getTitle() %>"/>
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
												<p>
													<a class="ds44-btnStd ds44-mt3" href='<%= itFicheLieu.getDisplayUrl(userLocale) %>' 
															title="<%= glp("jcmsplugin.socle.etablissementpersonnesagees.savoirplussur", itFicheLieu.getTitle()) %>">
														<span class="ds44-btnInnerText"><%= glp("jcmsplugin.socle.etablissementpersonnesagees.savoirplus") %></span>
														<i class="icon icon-long-arrow-right" aria-hidden="true"></i>
													</a>
												</p>
											</div>
										</jalios:foreach>
	
								     
								     
								     						
								</div>
		
							</section>
						</div>
					</jalios:if>
	
				</div>
			</div>
		</section>

        <%-- Partagez cette page --%>
        <%@ include file="/plugins/SoclePlugin/jsp/portal/socialNetworksShare.jspf" %> 
		
	</article>
	
    <%-- Page utile --%>
    <jsp:include page="/plugins/SoclePlugin/types/PageUtileForm/editFormPageUtileForm.jsp"/>
    	
</main>