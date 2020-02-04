<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file='/jcore/doInitPage.jspf'%>
<%
	FicheLieu obj = (FicheLieu) request.getAttribute(PortalManager.PORTAL_PUBLICATION);
%>
<%@ include file='/front/doFullDisplay.jspf'%>
<%@ page import="fr.cg44.plugin.socle.SocleUtils"%>
<main role="main" id="content">

<article class="ds44-container-large">

	<div class="ds44-lightBG ds44-posRel">
		<%-- TODO bouton Retour a la liste --%>
		<%-- <a class="ds44-btnStd ds44-btnStd--retourPage" type="button" title='<%= glp("jcmsplugin.socle.retourALaListeLieux") %>'> 
			<i class="icon icon-long-arrow-left" aria-hidden="true"></i> 
			<span class="ds44-btnInnerText"><%= glp("jcmsplugin.socle.retourALaListe") %></span>
		</a> --%>
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
	<div class="ds44-img50 ds44--xl-padding-tb">
		<div class="ds44-inner-container">
			<div class="ds44-grid12-offset-1">
				<%
					StringBuffer sbfLocalisation = new StringBuffer();
					if(Util.notEmpty(obj.getExtraData("extra.Place.plugin.tools.geolocation.longitude"))
							&& Util.notEmpty(obj.getExtraData("extra.Place.plugin.tools.geolocation.latitude"))) {
						sbfLocalisation.append("https://www.openstreetmap.org/directions?route=")
								.append(obj.getExtraData("extra.FicheLieu.plugin.tools.geolocation.longitude"))
								.append("%2C")
								.append(obj.getExtraData("extra.FicheLieu.plugin.tools.geolocation.latitude"));
					}					
					String localisation = sbfLocalisation.toString();
					
					String commune = Util.notEmpty(obj.getCommune()) ? obj.getCommune().getTitle() : "";
					String adresse = SocleUtils.formatAddress("", obj.getEtageCouloirEscalier(),
							obj.getEntreeBatimentImmeuble(), obj.getNdeVoie(), obj.getLibelleDeVoie(), obj.getLieudit(), "",
							obj.getCodePostal(), commune);

					String communeEcrire = Util.notEmpty(obj.getCommune2()) ? obj.getCommune2().getTitle() : "";
					String adresseEcrire = SocleUtils.formatAddress(obj.getLibelleAutreAdresse(),
							obj.getEtageCouloirEscalier2(), obj.getEntreeBatimentImmeuble2(), obj.getNdeVoie2(),
							obj.getLibelleDeVoie2(), obj.getLieudit2(), obj.getCs2(), obj.getCodePostal2(), communeEcrire);
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
											<strong> <i class="icon icon-user ds44-docListIco" aria-hidden="true"></i> <%=obj.getComplementTypeDacces()%>
											</strong>
										</p>
									</div>
								</div>
							</jalios:if>

							<div class="grid-2-small-1 ds44-grid12-offset-1">
								<div class="col">

									<jalios:if
										predicate='<%=Util.notEmpty(adresse) || Util.notEmpty(obj.getPlanDacces())
												|| (Util.notEmpty(obj.getExtraData("extra.Place.plugin.tools.geolocation.longitude"))
														&& Util.notEmpty(obj.getExtraData("extra.Place.plugin.tools.geolocation.latitude")))%>'>
										<p role="heading" aria-level="3" class="ds44-box-heading"><%=obj.getServiceDuDepartement() ? glp("jcmsplugin.socle.ficheaide.nousRencontrer")+" :" : glp("jcmsplugin.socle.ficheaide.adresse")+" :"%></p>

										<jalios:if predicate='<%=Util.notEmpty(adresse)%>'>
											<p class="ds44-docListElem mts">
												<i class="icon icon-marker ds44-docListIco" aria-hidden="true"></i>
												<jalios:if predicate='<%=Util.notEmpty(localisation)%>'>
													<a href="<%= localisation%>" aria-label="<%= glp("jcmsplugin.socle.ficheaide.localiser-carte.label")+" : " + obj.getTitle()%>"> 
														<%=adresse%>
													</a>
												</jalios:if>
												<jalios:if predicate='<%=Util.isEmpty(localisation)%>'>
													<%=adresse%>
												</jalios:if>
											</p>
										</jalios:if>

										<%--  TODO api google adresse pour horaire ouverture/fermeture --%>
										<%--  <p class="ds44-docListElem mts">
												<i class="icon icon-time ds44-docListIco" aria-hidden="true"></i>
												Ferme bientôt : 12h15 - Ouvre à 14h
											</p> --%>

										<jalios:if predicate='<%= Util.notEmpty(obj.getPlanDacces()) %>'>
											<jalios:if predicate="<%= obj.getPlanDacces().length == 1 %>">
												<p class="ds44-docListElem mts">
													<i class="icon icon-pdf ds44-docListIco" aria-hidden="true"></i> 
													<a href="<%= obj.getPlanDacces()[0].getDisplayLink(userLocale) %>"
														aria-label="<%= glp("jcmsplugin.socle.fichelieu.telecharger-plan-acces.label")+" : " + obj.getTitle()%>"> 
														<%= glp("jcmsplugin.socle.fichelieu.telecharger-plan-acces.label") %>
													</a>
												</p>
											</jalios:if>
											<jalios:if predicate="<%= obj.getPlanDacces().length > 1 %>">
												<p class="ds44-docListElem mts">
													<i class="icon icon-pdf ds44-docListIco" aria-hidden="true"></i> 
													<jalios:foreach name="planDacces" type="Media" array="<%= obj.getPlanDacces() %>">
														<a href="<%= planDacces.getDownloadUrl() %>" 
															download="<%= encodeForHTMLAttribute(planDacces.getDownloadName(userLang)) %>" 
															aria-label="<%= glp("jcmsplugin.socle.fichelieu.telecharger-plan-acces.label")+" : " + obj.getTitle()%>"> 
															<%= planDacces.getDataName(userLang) %>
														</a>
													</jalios:foreach>
												</p>
											</jalios:if>
										</jalios:if>

										<jalios:if
											predicate='<%= Util.notEmpty(localisation) %>'>
											<p class="ds44-docListElem mts">
												<i class="icon icon-map ds44-docListIco" aria-hidden="true"></i>
												<a href="<%= localisation%>" aria-label="<%= glp("jcmsplugin.socle.ficheaide.localiser-carte.label")+" : " + obj.getTitle()%>"> 
													<%= glp("jcmsplugin.socle.ficheaide.localiser-carte.label") %> 
												</a>
											</p>
										</jalios:if>

										<%--  TODO infos accessibilite --%>
										<%-- <p role="heading" aria-level="3" class="ds44-box-heading mtl"><%= glp("jcmsplugin.socle.ficheaide.accessibilite-lieu.titre") %></p>
										<p class="ds44-docListElem mts">
											<i class="icon icon-right ds44-docListIco" aria-hidden="true"></i> 
											<a href="#" aria-label="<%= glp("jcmsplugin.socle.ficheaide.info-accessibilite.label") + " : " + obj.getTitle()%>">
												<%= glp("jcmsplugin.socle.ficheaide.info-accessibilite.label") %>
											</a>
										</p> --%>

									</jalios:if>

								</div>
								<div class="col ds44--xl-padding-l">

									<jalios:if
										predicate='<%=Util.notEmpty(obj.getTelephone()) || Util.notEmpty(obj.getEmail())
												|| Util.notEmpty(obj.getSiteInternet())%>'>
										<p role="heading" aria-level="3" class="ds44-box-heading"><%=obj.getServiceDuDepartement() ? glp("jcmsplugin.socle.ficheaide.nousContacter")+" :" : glp("jcmsplugin.socle.ficheaide.contact")+" :"%></p>

										<jalios:if predicate='<%=Util.notEmpty(obj.getTelephone())%>'>
											<p class="ds44-docListElem mts">
												<i class="icon icon-phone ds44-docListIco" aria-hidden="true"></i>
												<jalios:foreach name="numTel" type="String" array="<%= obj.getTelephone() %>">
													<jalios:phone number="<%= numTel %>"/>
												</jalios:foreach>
											</p>
										</jalios:if>

										<jalios:if predicate='<%=Util.notEmpty(obj.getEmail())%>'>
											<p class="ds44-docListElem mts">
												<i class="icon icon-mail ds44-docListIco" aria-hidden="true"></i>
												<jalios:foreach name="email" type="String" array="<%=obj.getEmail()%>">
													<a href="<%="#mailto:" + email%>" aria-label="<%=glp("jcmsplugin.socle.ficheaide.contacter.label") + " " + obj.getTitle() + " " + glp("jcmsplugin.socle.ficheaide.par-mail.label") + email%>"> 
														<%=email%>
													</a>
												</jalios:foreach>
											</p>
										</jalios:if>

										<jalios:if predicate='<%=Util.notEmpty(obj.getSiteInternet())%>'>
											<p class="ds44-docListElem mts">
												<i class="icon icon-link ds44-docListIco" aria-hidden="true"></i>
												<jalios:foreach name="site" type="String" array="<%=obj.getSiteInternet()%>">
													<a href="<%=site%>" aria-label="<%=glp("jcmsplugin.socle.ficheaide.visiter-site-web-de.label") + " " + obj.getTitle() + " " + glp("jcmsplugin.socle.accessibily.newTabLabel") %>" target="_blank"> 
														<%=obj.getSiteInternet().length > 1 ? site : glp("jcmsplugin.socle.ficheaide.visiter-site.label") %>
													</a>
												</jalios:foreach>
											</p>
										</jalios:if>

									</jalios:if>

									<jalios:if predicate='<%=Util.notEmpty(adresseEcrire)%>'>
										<p role="heading" aria-level="3" class="ds44-box-heading mtl"><%=obj.getServiceDuDepartement() ? glp("jcmsplugin.socle.ficheaide.nousEcrire") + " :" : glp("jcmsplugin.socle.ficheaide.ecrireA") + " :"%></p>
										<p class="ds44-docListElem mts">
											<i class="icon icon-marker ds44-docListIco" aria-hidden="true"></i>
											<%=adresseEcrire%>
										</p>
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
		<div class="ds44-inner-container ds44-mtb3">
			<div class="ds44-grid12-offset-1">
				<div class="grid-2-small-1">
					
					<jalios:if predicate='<%=Util.notEmpty(obj.getImagePrincipale())%>'>
						<div class="col mrl mbs">
							<%
								StringBuffer sbfLegendeCopyright = new StringBuffer();
								if(Util.notEmpty(obj.getLegende())) {
									sbfLegendeCopyright.append(obj.getLegende());
								}
								if(Util.notEmpty(obj.getCopyright())) {
									sbfLegendeCopyright.append(" © ")
										.append(obj.getCopyright());
								}
							%>
							<figure class="ds44-legendeContainer ds44-container-imgRatio" role="figure" aria-label="<%= sbfLegendeCopyright.toString() %>">
								<img src="<%= obj.getImagePrincipale() %>" alt="" class="ds44-w100 ds44-imgRatio">
								<figcaption class="ds44-imgCaption"><%= sbfLegendeCopyright.toString() %></figcaption>
							</figure>
						</div>
					</jalios:if>

					<jalios:if
						predicate='<%=Util.notEmpty(obj.getChapo()) || Util.notEmpty(obj.getPlusDeDetailInterne())
						|| Util.notEmpty(obj.getPlusDeDetailExterne())%>'>
						<div class="col mll mbs">

							<jalios:if predicate='<%=Util.notEmpty(obj.getChapo())%>'>
								<p class="ds44-introduction"><%= obj.getChapo() %></p>
							</jalios:if>

							<jalios:if predicate='<%=Util.notEmpty(obj.getPlusDeDetailInterne()) || Util.notEmpty(obj.getPlusDeDetailExterne())%>'>
								<%
									String url = "";
									String title = "";
									
									if(Util.notEmpty(obj.getPlusDeDetailInterne())) {
										
										url = obj.getPlusDeDetailInterne().getDisplayUrl(userLocale);
										title = glp("jcmsplugin.socle.plusDeDetails");
										
									} else if(Util.notEmpty(obj.getPlusDeDetailExterne())) {
										
										url = obj.getPlusDeDetailExterne();
										title = glp("jcmsplugin.socle.plusDeDetails") + " " + glp("jcmsplugin.socle.accessibily.newTabLabel");
										
									}
								%>
								<a href="<%= url %>" class="ds44-btnStd ds44-btnStd--large" type="button" title="<%= title %>"> 
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

	<jalios:if
		predicate='<%=Util.notEmpty(obj.getPourQui()) || (!obj.getToutesLesCommunesDuDepartement()
						&& (Util.notEmpty(obj.getCommune()) || Util.notEmpty(obj.getEpci(loggedMember))))%>'>
		<section class="ds44-contenuArticle" id="section2">
			<div class="ds44-inner-container ds44-mtb3">
				<div class="ds44-grid12-offset-2">
					<h3 id="idTitre2"><%= glp("jcmsplugin.socle.titre.pour-qui") %></h3>

					<jalios:if predicate='<%=Util.notEmpty(obj.getPourQui())%>'>
						<%=obj.getPourQui()%>
					</jalios:if>

					<jalios:if
						predicate='<%=!obj.getToutesLesCommunesDuDepartement()
								&& (Util.notEmpty(obj.getCommunes()) || Util.notEmpty(obj.getEpci(loggedMember)))%>'>
						<%
							String separatorCommune = ", ";

							StringBuffer sbfCommunesLiees = new StringBuffer();
							sbfCommunesLiees.append(glp("jcmsplugin.socle.ficheaide.accueilUniquementHabitantsDe"))
								.append(" ");

							if (Util.notEmpty(obj.getCommune())) {

								for (City catCommune : obj.getCommunes()) {
									sbfCommunesLiees.append(catCommune.getTitle()).append(separatorCommune);
								}

							} else if (Util.notEmpty(obj.getEpci(loggedMember))) {

								for (Category catCommune : obj.getEpci(loggedMember)) {
									sbfCommunesLiees.append(catCommune.getName()).append(separatorCommune);
								}

							}
							sbfCommunesLiees.delete(sbfCommunesLiees.length() - 2, sbfCommunesLiees.length() - 1);
						%>
						<p>
							<strong class="ds44-wsg-exergue"><%= glp("jcmsplugin.socle.ficheaide.important") %></strong>
						</p>
						<p>
							<strong><%= sbfCommunesLiees.toString() %></strong>
						</p>
					</jalios:if>
				</div>
			</div>
		</section>
	</jalios:if>

	<jalios:if predicate='<%= Util.notEmpty(obj.getModalitesDaccueil()) %>'>
		<section class="ds44-contenuArticle" id="section3">
			<div class="ds44-inner-container ds44-mtb3">
				<div class="ds44-grid12-offset-2">
					<h3 id="idTitre3"><%= glp("jcmsplugin.socle.titre.qui-accueille") %></h3>
					<%= obj.getModalitesDaccueil() %>
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
						<p role="heading" aria-level="2" class="ds44-box-heading"><%= glp("jcmsplugin.socle.titre.horaires-acces") %></p>

						<jalios:if predicate='<%= Util.notEmpty(obj.getHorairesEtAcces()) %>'>
							<p class="ds44-docListElem mtm ds44-m-fluid-margin" role="heading" aria-level="3">
								<i class="icon icon-time ds44-docListIco" aria-hidden="true"></i>
								<%-- vire les balises <div class="wyziwyg"> et <p> qui englobent le texte pour que le style fonctionne --%>
								<%= obj.getHorairesEtAcces().substring(24, obj.getHorairesEtAcces().length()-10) %>
							</p>
						</jalios:if>

						<jalios:if predicate='<%= Util.notEmpty(obj.getTransportsEnCommun()) %>'>
							<p class="ds44-docListElem mtm ds44-m-fluid-margin">
								<i class="icon icon-directions ds44-docListIco" aria-hidden="true"></i>
								<%-- vire les balises <div class="wyziwyg"> et <p> qui englobent le texte pour que le style fonctionne --%>
								<%= obj.getTransportsEnCommun().substring(24, obj.getTransportsEnCommun().length()-10) %>
								<br> 
								<a href="#" aria-label="<%= glp("jcmsplugin.socle.ficheaide.faire-trajet-destineo") + " " + glp("jcmsplugin.socle.accessibily.newTabLabel") %>" target="_blank"> 
									<%= glp("jcmsplugin.socle.ficheaide.faire-trajet-destineo") %> 
								</a>
							</p>
						</jalios:if>

						<jalios:if predicate='<%= Util.notEmpty(obj.getParkings()) %>'>
							<p class="ds44-docListElem mtm ds44-m-fluid-margin">
								<i class="icon icon-parking ds44-docListIco" aria-hidden="true"></i>
								<%-- vire les balises <div class="wyziwyg"> et <p> qui englobent le texte pour que le style fonctionne --%>
								<%= obj.getParkings().substring(24, obj.getParkings().length()-10) %>
							</p>
						</jalios:if>

						<%-- TODO accessibilite --%>
						<%-- <button class="ds44-btnStd ds44-btnStd--large mtm" type="button"
							aria-label="<%=glp("jcmsplugin.socle.ficheaide.plus-info-accessibilite") + " : " + obj.getTitle()%>">
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
					<%-- vire la balise <div class="wyziwyg"> qui englobe le texte pour que le style fonctionne --%>
					<%= obj.getDescription().substring(21, obj.getDescription().length()-6) %>
				</div>
			</div>
		</section>
	</jalios:if>

	<%-- TODO : bloc video avec doc retranscription textuelle --%>
	<%-- 
	<section class="ds44-contenuArticle" id="section6">
		<div class="ds44-inner-container ds44-mtb3">
			<div class="ds44-grid12-offset-2">
				<h3 id="idTitre6">Les consultations de la Protection maternelle et infantile</h3>
				<a href="#"> 
					<img src="../../assets/images/img_video_bigger-2.jpg" alt="Vidéo : Les consultations de la Protection maternelle et infantile" class="ds44-w100">
				</a> 
				<a href="#" aria-label="Télécharger le fichier de restranscription de la vidéo : [Les consultations de la Protection maternelle et infantile]">
					Télécharger le fichier de restranscription de la vidéo 
				</a>
			</div>
		</div>
	</section>
	 --%>

	<jalios:if predicate='<%= Util.notEmpty(obj.getAutresLieuxAssocies()) %>'>
		<section class="ds44-contenuArticle" id="section7">
			<div class="ds44-inner-container ds44-mtb3">
				<div class="ds44-grid12-offset-2">
					<div class="ds44-wsg-encadreApplat">
						<p role="heading" aria-level="2" class="ds44-box-heading"><%= glp("jcmsplugin.socle.titre.autre-lieu-associes") %></p>

						<jalios:foreach name="ficheLieu" type="FicheLieu" array="<%= obj.getAutresLieuxAssocies() %>">
							<p class="ds44-docListElem mtm">
								<i class="icon icon-marker ds44-docListIco" aria-hidden="true"></i> 
								<a href="<%= "#mailto:"+ficheLieu.getEmailMLE() %>"
									aria-label="<%= glp("jcmsplugin.socle.ficheaide.contacter.label") + " "+ficheLieu.getTitle()+" : "+ficheLieu.getEmailMLE() %>"> 
									<%= ficheLieu.getTitle() %>
								</a>
							</p>
							<%
								String communeFiche = Util.notEmpty(ficheLieu.getCommune()) ? ficheLieu.getCommune().getTitle() : "";
								String addresseFiche = SocleUtils.formatAddress("", ficheLieu.getEtageCouloirEscalier(), 
										ficheLieu.getEntreeBatimentImmeuble(), ficheLieu.getNdeVoie(), ficheLieu.getLibelleDeVoie(), 
										ficheLieu.getLieudit(), "", ficheLieu.getCodePostal(), communeFiche);
							%>
							<p>
								<%= addresseFiche %>
							</p>
						</jalios:foreach>

					</div>
				</div>
			</div>
		</section>
	</jalios:if>

	<jalios:if predicate='<%= Util.notEmpty(obj.getPortletBas()) %>'>
		<jalios:foreach name="portlet" type="PortalElement" array="<%= obj.getPortletBas() %>">
			<jalios:include pub="<%= portlet %>"></jalios:include>
		</jalios:foreach>
	</jalios:if>

	<%-- TODO : bloc des réseaux sociaux --%>

</article>

<%-- TODO : bloc page a ete utile --%> 
</main>