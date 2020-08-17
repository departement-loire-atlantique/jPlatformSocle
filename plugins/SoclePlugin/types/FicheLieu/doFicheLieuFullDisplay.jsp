<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%>
<%@ include file='/jcore/doInitPage.jspf'%>
<%
	FicheLieu obj = (FicheLieu) request.getAttribute(PortalManager.PORTAL_PUBLICATION);

%>
<%@ include file='/front/doFullDisplay.jspf'%>
<%@ page import="fr.cg44.plugin.socle.SocleUtils"%>
<main role="main" id="content">

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
				<jalios:if predicate='<%=Util.notEmpty(obj.getSoustitre())%>'>
					<h2 class="h2-like" id="idTitre0"><%=obj.getSoustitre()%></h2>
				</jalios:if>
			</div>
		</div>
	</div>
	<div class="ds44-img50 ds44--l-padding-tb">
		<div class="ds44-inner-container">
			<div class="ds44-grid12-offset-1">
				<%
					String longitude = obj.getExtraData("extra.FicheLieu.plugin.tools.geolocation.longitude");
					String latitude = obj.getExtraData("extra.FicheLieu.plugin.tools.geolocation.latitude");
					String localisation = SocleUtils.formatOpenStreetMapLink(latitude, longitude);

					String commune = Util.notEmpty(obj.getCommune()) ? obj.getCommune().getTitle() : "";
					String adresse = SocleUtils.formatAdressePhysique(obj);

					String adresseEcrire = SocleUtils.formatAdresseEcrire(obj);
				%>
				<jalios:if
					predicate='<%=Util.notEmpty(obj.getComplementTypeDacces()) || Util.notEmpty(adresse)
						|| Util.notEmpty(obj.getPlanDacces())
						|| Util.notEmpty(localisation)
						|| Util.notEmpty(obj.getTelephone()) || Util.notEmpty(obj.getEmail())
						|| Util.notEmpty(obj.getSiteInternet()) || Util.notEmpty(adresseEcrire)%>'>
					<section class="ds44-box ds44-theme">
						<div class="ds44-innerBoxContainer">

							<jalios:if predicate='<%=Util.notEmpty(obj.getComplementTypeDacces())%>'>
								<div class="ds44-grid12-offset-1">
									<div class="ds44--l-padding ds44-lightBG ds44-mb3">
										<p class="ds44-docListElem mts">
											<strong> 
												<i class="icon icon-attention ds44-docListIco" aria-hidden="true"></i> 
												<%=obj.getComplementTypeDacces()%>
											</strong>
										</p>
									</div>
								</div>
							</jalios:if>

							<div class="grid-2-small-1 ds44-grid12-offset-1">
								<div class="col">

									<jalios:if predicate='<%=Util.notEmpty(adresse) || Util.notEmpty(obj.getPlanDacces()) || Util.notEmpty(localisation) %>'>
										<p role="heading" aria-level="3" class="ds44-box-heading"><%=Util.notEmpty(obj.getServiceDuDepartement(loggedMember)) ? glp("jcmsplugin.socle.ficheaide.nousRencontrer")+" :" : glp("jcmsplugin.socle.ficheaide.adresse")+" :"%></p>

										<jalios:if predicate='<%=Util.notEmpty(adresse)%>'>
											<p class="ds44-docListElem mts">
												<i class="icon icon-marker ds44-docListIco" aria-hidden="true"></i>
												<%=adresse%>
											</p>
										</jalios:if>

										<%--  TODO api google adresse pour horaire ouverture/fermeture --%>
										<%--  <p class="ds44-docListElem mts">
												<i class="icon icon-time ds44-docListIco" aria-hidden="true"></i>
												Ferme bientôt : 12h15 - Ouvre à 14h
											</p> --%>

										<jalios:if predicate='<%= Util.notEmpty(obj.getPlanDacces()) %>'>
												<div class="ds44-docListElem mts">
													<i class="icon icon-pdf ds44-docListIco" aria-hidden="true"></i> 
													
													<% 
														StringBuffer sbfAriaLabelPlanDacces = new StringBuffer();
														sbfAriaLabelPlanDacces.append(glp("jcmsplugin.socle.fichelieu.telecharger-plan-acces.label"))
															.append(" : ")
															.append(obj.getTitle())
															.append(" ")
															.append(glp("jcmsplugin.socle.accessibily.newTabLabel"));
														String strAriaLabelPlanDacces =  HttpUtil.encodeForHTMLAttribute(sbfAriaLabelPlanDacces.toString());
													%>
													<jalios:if predicate='<%= obj.getPlanDacces().length == 1 %>'>
														<% FileDocument planDacces = obj.getPlanDacces()[0]; %>
														<a href='<%= planDacces.getDownloadUrl() %>' 
															target="_blank"
															download='<%= HttpUtil.encodeForHTMLAttribute(planDacces.getDownloadName(userLang)) %>' 
															title='<%= strAriaLabelPlanDacces %>'
															data-statistic='{"name": "declenche-evenement","category": "BlocNousContacter","action": "Plan accès","label": "<%= HttpUtil.encodeForHTMLAttribute(obj.getTitle()) %>"}'> 
															
															<%= glp("jcmsplugin.socle.fichelieu.telecharger-plan-acces.label") %>
														</a>
													</jalios:if>
													
													<jalios:if predicate='<%= obj.getPlanDacces().length > 1 %>'>
														<ul class="ds44-list">
															<jalios:foreach name="planDacces" type="FileDocument" array='<%= obj.getPlanDacces() %>'>
																<li>
																	<a href='<%= planDacces.getDownloadUrl() %>' 
																		target="_blank"
																		download='<%= HttpUtil.encodeForHTMLAttribute(planDacces.getDownloadName(userLang)) %>' 
																		title='<%= strAriaLabelPlanDacces %>'
																		data-statistic='{"name": "declenche-evenement","category": "BlocNousContacter","action": "Plan accès","label": "<%= HttpUtil.encodeForHTMLAttribute(obj.getTitle()) %>"}'> 
																		
																		<%= planDacces.getDataName(userLang) %>
																	</a>
																</li>
															</jalios:foreach>
														</ul>
													</jalios:if>
												</div>
										</jalios:if>

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

										<%--  TODO infos accessibilite --%>
										<%-- <p role="heading" aria-level="3" class="ds44-box-heading mtl"><%= glp("jcmsplugin.socle.ficheaide.accessibilite-lieu.titre") %></p>
										<p class="ds44-docListElem mts">
											<i class="icon icon-right ds44-docListIco" aria-hidden="true"></i> 
											<a href="#" aria-label='<%= glp("jcmsplugin.socle.ficheaide.info-accessibilite.label") + " : " + obj.getTitle()%>'>
												<%= glp("jcmsplugin.socle.ficheaide.info-accessibilite.label") %>
											</a>
										</p> --%>

									</jalios:if>

								</div>
								<div class="col ds44--xl-padding-l">

									<jalios:if predicate='<%=Util.notEmpty(obj.getTelephone()) || Util.notEmpty(obj.getEmail())
												|| Util.notEmpty(obj.getSiteInternet())%>'>
										<p role="heading" aria-level="3" class="ds44-box-heading">
											<%=Util.notEmpty(obj.getServiceDuDepartement(loggedMember)) ? glp("jcmsplugin.socle.ficheaide.nousContacter")+" :" : glp("jcmsplugin.socle.ficheaide.contact")+" :"%>
										</p>

										<jalios:if predicate='<%=Util.notEmpty(obj.getTelephone())%>'>
											<div class="ds44-docListElem mts">
												<i class="icon icon-phone ds44-docListIco" aria-hidden="true"></i>

												<jalios:if predicate='<%= obj.getTelephone().length == 1 %>'>
													<% String numTel = obj.getTelephone()[0]; %>
													<ds:phone number="<%= numTel %>"/>
												</jalios:if>

												<jalios:if predicate='<%= obj.getTelephone().length > 1 %>'>
													<ul class="ds44-list">
														<jalios:foreach name="numTel" type="String" array="<%= obj.getTelephone() %>">
															<li>
																<ds:phone number="<%= numTel %>"/>
															</li>
														</jalios:foreach>
													</ul>
												</jalios:if>

											</div>
										</jalios:if>

										<jalios:if predicate='<%=Util.notEmpty(obj.getEmail())%>'>
											<div class="ds44-docListElem mts">
												<i class="icon icon-mail ds44-docListIco" aria-hidden="true"></i>

												<jalios:if predicate='<%= obj.getEmail().length == 1 %>'>
													<% String email = obj.getEmail()[0]; %>
													<a href='<%= "mailto:"+email %>'
													   title='<%= HttpUtil.encodeForHTMLAttribute(glp("jcmsplugin.socle.ficheaide.contacter-x-par-mail.label", obj.getTitle(), email)) %>'
													   data-statistic='{"name": "declenche-evenement","category": "BlocNousContacter","action": "Mailto","label": "<%= HttpUtil.encodeForHTMLAttribute(obj.getTitle()) %>"}'> 
														<%=  glp("jcmsplugin.socle.ficheaide.contacter-par-mail.label")  %>
													</a>
												</jalios:if>

												<jalios:if predicate='<%= obj.getEmail().length > 1 %>'>
													<ul class="ds44-list">
														<jalios:foreach name="email" type="String" array='<%= obj.getEmail() %>'>
															<li>
																<a href='<%= "mailto:"+email %>'
																    title='<%= HttpUtil.encodeForHTMLAttribute(glp("jcmsplugin.socle.ficheaide.contacter-x-par-mail.label", obj.getTitle(), email)) %>'
																    data-statistic='{"name": "declenche-evenement","category": "BlocNousContacter","action": "Mailto","label": "<%= HttpUtil.encodeForHTMLAttribute(obj.getTitle()) %>"}'> 
																	<%= email %>
																</a>
															</li>
														</jalios:foreach>
													</ul>
												</jalios:if>

											</div>
										</jalios:if>

										<jalios:if predicate='<%=Util.notEmpty(obj.getSiteInternet())%>'>
											<div class="ds44-docListElem mts">
												<i class="icon icon-link ds44-docListIco" aria-hidden="true"></i>

												<jalios:if predicate='<%= obj.getSiteInternet().length == 1 %>'>
													<% String site = obj.getSiteInternet()[0]; %>
													<a href='<%= SocleUtils.parseUrl(site) %>'
													   title='<%= glp("jcmsplugin.socle.lien.site.nouvelonglet", obj.getTitle()) %>' target="_blank"
													   data-statistic='{"name": "declenche-evenement","category": "BlocNousContacter","action": "Site web","label": "<%= HttpUtil.encodeForHTMLAttribute(obj.getTitle()) %>"}'>
														<%= glp("jcmsplugin.socle.ficheaide.visiter-site.label") %>
													</a>
												</jalios:if>

												<jalios:if predicate='<%= obj.getSiteInternet().length > 1 %>'>
													<ul class="ds44-list">
														<jalios:foreach name="site" type="String" array='<%= obj.getSiteInternet() %>'>
															<li>
																<a href='<%= SocleUtils.parseUrl(site) %>'
																   title='<%= glp("jcmsplugin.socle.lien.site.nouvelonglet", obj.getTitle()) %>' target="_blank"
																   data-statistic='{"name": "declenche-evenement","category": "BlocNousContacter","action": "Site web","label": "<%= HttpUtil.encodeForHTMLAttribute(obj.getTitle()) %>"}'> 
																	<%= SocleUtils.parseUrl(site) %>
																</a>
															</li>
														</jalios:foreach>
													</ul>
												</jalios:if>

											</div>
										</jalios:if>

									</jalios:if>

									<jalios:if predicate='<%=Util.notEmpty(adresseEcrire)%>'>
										<p role="heading" aria-level="3" class="ds44-box-heading mtl">
											<%=Util.notEmpty(obj.getServiceDuDepartement(loggedMember)) ? glp("jcmsplugin.socle.ficheaide.nousEcrire") + " :" : glp("jcmsplugin.socle.ficheaide.ecrireA") + " :"%>
										</p>
										<p class="ds44-docListElem mts">
											<i class="icon icon-marker ds44-docListIco" aria-hidden="true"></i>
											<%=adresseEcrire%>
										</p>
									</jalios:if>
									<jalios:if predicate="<%= Util.notEmpty(obj.getLienDeLaPageFacebook()) || Util.notEmpty(obj.getLienDeLaPageInstagram()) %>">
										<section class="ds44-partage ds44-flex-container ds44-mt-std">
	                                        <ul class="ds44-list ds44-flex-container ds44-flex-align-center ds44-fse">
	                                            <jalios:if predicate="<%= Util.notEmpty(obj.getLienDeLaPageFacebook()) %>">
	                                                <li><a href="<%= obj.getLienDeLaPageFacebook() %>" target="_blank" class="ds44-rsLink" title='<%= glp("jcmsplugin.socle.socialnetwork.retrouver.facebook.nouvellefenetre", obj.getTitle()) %>' data-statistic='{"name": "declenche-evenement","category": "Partage page","action": "Facebook"}'><i class="icon icon-facebook icon--sizeL" aria-hidden="true"></i><span class="visually-hidden"><%= glp("jcmsplugin.socle.socialnetwork.retrouver.facebook", obj.getTitle()) %></span></a></li>
	                                            </jalios:if>
	                                            <jalios:if predicate="<%= Util.notEmpty(obj.getLienDeLaPageInstagram()) %>">
	                                               <li><a href="<%= obj.getLienDeLaPageInstagram() %>" target="_blank" class="ds44-rsLink" title='<%= glp("jcmsplugin.socle.socialnetwork.retrouver.instagram.nouvellefenetre", obj.getTitle()) %>'" data-statistic='{"name": "declenche-evenement","category": "Partage page","action": "Instagram"}'><i class="icon icon-instagram icon--sizeL" aria-hidden="true"></i><span class="visually-hidden"><%= glp("jcmsplugin.socle.socialnetwork.retrouver.instagram", obj.getTitle()) %></span></a></li>
	                                            </jalios:if>
	                                        </ul>
                                    </section>
                                    </jalios:if>
								</div>
							</div>
						</div>
					</section>
				</jalios:if>
			</div>
		</div>
	</div>

	<section class="ds44-contenuArticle" id="section1">
		<div class='ds44-inner-container <%= Util.notEmpty(obj.getImagePrincipale()) ? "ds44-mtb3" : "ds44-mb3"%>'>
			<div class="ds44-grid12-offset-1">
				<div class="grid-<%= Util.notEmpty(obj.getImagePrincipale()) ? "2" : "1" %>-small-1">
					
					<jalios:if predicate='<%=Util.notEmpty(obj.getImagePrincipale())%>'>
						<div class="col mrl mbs">
							<%
								StringBuffer sbfLegendeCopyright = new StringBuffer();
								if(Util.notEmpty(obj.getLegende())) {
									sbfLegendeCopyright.append(obj.getLegende());
								}
								if(Util.notEmpty(obj.getCopyright())) {
									sbfLegendeCopyright.append(" ")
										.append(JcmsUtil.glp(userLang, "jcmsplugin.socle.symbol.copyright"))
										.append(" ")
										.append(obj.getCopyright());
								}
							%>
							<figure class="ds44-legendeContainer ds44-container-imgRatio" role="figure" 
									<%= Util.notEmpty(sbfLegendeCopyright.toString()) ? "aria-label='"+ HttpUtil.encodeForHTMLAttribute(sbfLegendeCopyright.toString())+"'" : "" %>>
								<img src='<%= SocleUtils.getUrlOfFormattedImagePrincipale(obj.getImagePrincipale()) %>' class="ds44-w100 ds44-imgRatio"
										<%= Util.notEmpty(obj.getTexteAlternatif(userLang)) ? "alt='"+ HttpUtil.encodeForHTMLAttribute(obj.getTexteAlternatif(userLang))+"'" : "" %>>
								<jalios:if predicate='<%= Util.notEmpty(sbfLegendeCopyright.toString()) %>'>
									<figcaption class="ds44-imgCaption"><%= sbfLegendeCopyright.toString() %></figcaption>
								</jalios:if>
							</figure>
						</div>
					</jalios:if>

					<jalios:if
						predicate='<%=Util.notEmpty(obj.getChapo()) || Util.notEmpty(obj.getPlusDeDetailInterne())
						|| Util.notEmpty(obj.getPlusDeDetailExterne())%>'>
						<div class='col <%= Util.notEmpty(obj.getImagePrincipale()) ? "mll" : "" %> mbs'>

							<jalios:if predicate='<%=Util.notEmpty(obj.getChapo())%>'>
								<div class="ds44-introduction"><%= obj.getChapo() %></div>
							</jalios:if>

							<jalios:if predicate='<%=Util.notEmpty(obj.getPlusDeDetailInterne()) || Util.notEmpty(obj.getPlusDeDetailExterne())%>'>
								<%
									String url = "";
									Boolean isOpenInNewTab = false;
									
									if(Util.notEmpty(obj.getPlusDeDetailInterne())) {
										
										if(obj.getPlusDeDetailInterne() instanceof FileDocument) {
											
											url = ((FileDocument)obj.getPlusDeDetailInterne()).getDownloadUrl();
											isOpenInNewTab = true;
											
										} else {
											
											url = obj.getPlusDeDetailInterne().getDisplayUrl(userLocale);
										}
									} else if(Util.notEmpty(obj.getPlusDeDetailExterne())) {
										
										url = SocleUtils.parseUrl(obj.getPlusDeDetailExterne());
										isOpenInNewTab = true;
									}
									
									StringBuffer sbfTitle = new StringBuffer();
									
									if(isOpenInNewTab) {
										
										if(Util.notEmpty(obj.getTexteAlternatifLien(userLang))) {
											
											sbfTitle.append(obj.getTexteAlternatifLien(userLang));
											
										} else {
											
											sbfTitle.append(glp("jcmsplugin.socle.plusDeDetails"));
											
											if(Util.notEmpty(obj.getPlusDeDetailInterne())) {
												
												sbfTitle.append(" ")
												.append(glp("jcmsplugin.socle.sur"))
												.append(" ")
												.append(obj.getPlusDeDetailInterne().getTitle(userLang));
												
											} else {
												
												sbfTitle.append(" : ")
												.append(obj.getTitle());
											}
										}
										sbfTitle.append(" ")
										.append(glp("jcmsplugin.socle.accessibily.newTabLabel"));
									}
								%>
								<a href='<%= url %>' 
									class="ds44-btnStd ds44-btnStd--large" 
									type="button" 
									<%= isOpenInNewTab ? "title=\'"+HttpUtil.encodeForHTMLAttribute(sbfTitle.toString())+"\' target=\"_blank\"" : "" %>> 
									
									<span class="ds44-btnInnerText"><%= glp("jcmsplugin.socle.plusDeDetails") %></span> 
									<i class="icon icon-long-arrow-right" aria-hidden="true"></i>
								</a>
							</jalios:if>

						</div>
					</jalios:if>

				</div>
			</div>
		</div>
	</section>

	<jalios:if predicate='<%=Util.notEmpty(obj.getPourQui())%>'>
		<section class="ds44-contenuArticle" id="section2">
			<div class="ds44-inner-container ds44-mtb3">
				<div class="ds44-grid12-offset-2">
					<h3 id="idTitre2"><%= glp("jcmsplugin.socle.titre.pour-qui") %></h3>
					<jalios:wysiwyg><%=obj.getPourQui()%></jalios:wysiwyg>
				</div>
			</div>
		</section>
	</jalios:if>

	<jalios:if predicate='<%= Util.notEmpty(obj.getModalitesDaccueil()) %>'>
		<section class="ds44-contenuArticle" id="section3">
			<div class="ds44-inner-container ds44-mtb3">
				<div class="ds44-grid12-offset-2">
					<h3 id="idTitre3"><%= glp("jcmsplugin.socle.titre.qui-accueille") %></h3>
					<jalios:wysiwyg><%= obj.getModalitesDaccueil() %></jalios:wysiwyg>
				</div>
			</div>
		</section>
	</jalios:if>

	<jalios:if predicate='<%=Util.notEmpty(obj.getHorairesEtAcces()) || Util.notEmpty(obj.getTransportsEnCommun())
						|| Util.notEmpty(obj.getParkings())%>'>
		<section class="ds44-contenuArticle" id="section4">
			<div class="ds44-inner-container ds44-mtb3">
				<div class="ds44-grid12-offset-2">
					<div class="ds44-wsg-encadreContour">
						<p role="heading" aria-level="3" class="ds44-box-heading"><%= glp("jcmsplugin.socle.titre.horaires-acces") %></p>

						<jalios:if predicate='<%= Util.notEmpty(obj.getHorairesEtAcces()) %>'>
							<div class="ds44-docListElem mtm ds44-m-fluid-margin" role="heading" aria-level="4">
								<i class="icon icon-time ds44-docListIco" aria-hidden="true"></i>
								<jalios:wysiwyg><%= obj.getHorairesEtAcces() %></jalios:wysiwyg>
							</div>
						</jalios:if>

						<jalios:if predicate='<%= Util.notEmpty(obj.getTransportsEnCommun()) %>'>
							<div class="ds44-docListElem mtm ds44-m-fluid-margin">
								<i class="icon icon-directions ds44-docListIco" aria-hidden="true"></i>
								<jalios:wysiwyg><%= obj.getTransportsEnCommun() %></jalios:wysiwyg>
								<%-- Lien Destineo congele - manque adresse depart
								<br> 
								<a href="#" title='<%= HttpUtil.encodeForHTMLAttribute(glp("jcmsplugin.socle.ficheaide.faire-trajet-destineo") + " " + glp("jcmsplugin.socle.accessibily.newTabLabel")) %>' target="_blank"> 
									<%= glp("jcmsplugin.socle.ficheaide.faire-trajet-destineo") %> 
								</a> 
								--%>
							</div>
						</jalios:if>

						<jalios:if predicate='<%= Util.notEmpty(obj.getParkings()) %>'>
							<div class="ds44-docListElem mtm ds44-m-fluid-margin">
								<i class="icon icon-parking ds44-docListIco" aria-hidden="true"></i>
								<jalios:wysiwyg><%= obj.getParkings() %></jalios:wysiwyg>
							</div>
						</jalios:if>

						<%-- TODO accessibilite --%>
						<%-- <button class="ds44-btnStd ds44-btnStd--large mtm" type="button"
							title='<%=glp("jcmsplugin.socle.ficheaide.plus-info-accessibilite") + " : " + obj.getTitle()%>'>
							<span class="ds44-btnInnerText"><%= glp("jcmsplugin.socle.ficheaide.plus-info-accessibilite") %></span> <i class="icon icon-long-arrow-right" aria-hidden="true"></i>
						</button> --%>
					</div>
				</div>
			</div>
		</section>
	</jalios:if>

	<jalios:if predicate='<%= Util.notEmpty(obj.getDescription()) %>'>
		<section class="ds44-contenuArticle" id="section5">
			<div class="ds44-inner-container ds44-mtb3">
				<div class="ds44-grid12-offset-2">
					<jalios:wysiwyg><%= obj.getDescription() %></jalios:wysiwyg>
				</div>
			</div>
		</section>
	</jalios:if>

	<jalios:if predicate="<%= Util.notEmpty(obj.getVideo()) %>">
	    <%
	    String titleVideo = obj.getTitreVideo();
	    if (Util.isEmpty(titleVideo)) titleVideo = obj.getVideo().getTitle();
	    %>
        <ds:articleVideo video="<%= obj.getVideo() %>" title="<%= titleVideo %>" intro="<%= Util.notEmpty(obj.getIntroVideo()) ? obj.getIntroVideo() : obj.getVideo().getChapo() %>"/>
    </jalios:if>

	<jalios:if predicate='<%= Util.notEmpty(obj.getAutresLieuxAssocies()) %>'>
		<section class="ds44-contenuArticle" id="section7">
			<div class="ds44-inner-container ds44-mtb3">
				<div class="ds44-grid12-offset-2">
					<div class="ds44-wsg-encadreApplat">
						<p role="heading" aria-level="3" class="ds44-box-heading"><%= glp("jcmsplugin.socle.titre.autre-lieu-associes") %></p>
						
						<ul class="ds44-list">
							<jalios:foreach name="ficheLieu" type="FicheLieu" array='<%= obj.getAutresLieuxAssocies() %>'>
								<li class="ds44-docListElem mtm">
									<i class="icon icon-marker ds44-docListIco" aria-hidden="true"></i> 
									<a href='<%= ficheLieu.getDisplayUrl(userLocale) %>'> 
										<%= ficheLieu.getTitle() %>
									</a>
									<p>
										<%= SocleUtils.formatAdresseEcrire(ficheLieu) %>
									</p>
								</li>
							</jalios:foreach>
						</ul>
					</div>
				</div>
			</div>
		</section>
	</jalios:if>

	<jalios:if predicate='<%= Util.notEmpty(obj.getPortletBas()) %>'>
		<jalios:foreach name="portlet" type="PortalElement" array='<%= obj.getPortletBas() %>'>
			<jalios:include pub='<%= portlet %>'></jalios:include>
		</jalios:foreach>
	</jalios:if>

	<%-- TODO : bloc des réseaux sociaux --%>

</article>

<%-- TODO : bloc page a ete utile --%> 
</main>
