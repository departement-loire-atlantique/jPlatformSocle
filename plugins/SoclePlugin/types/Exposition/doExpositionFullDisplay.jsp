<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%>
<%@ include file='/jcore/doInitPage.jspf'%>
<% Exposition obj = (Exposition)request.getAttribute(PortalManager.PORTAL_PUBLICATION); %>
<%@ include file='/front/doFullDisplay.jspf'%>
<article class="fullDisplay Exposition ds44-container-large">

	<div class="ds44-bgDark">

		<ds:titleBanner pub="<%= obj %>" imagePath="<%= obj.getImagePrincipale(userLang, true) %>" mobileImagePath="<%= obj.getImageMobile(userLang, true) %>"
			alt="<%= obj.getTexteAlternatif(userLang) %>" title="<%= obj.getTitle(userLang) %>" subtitle="<%= obj.getSoustitre(userLang) %>" breadcrumb="true"
			isCentre="true"></ds:titleBanner>

		<jalios:if predicate="<%= Util.notEmpty(obj.getChapo(userLang)) || Util.notEmpty(obj.getContenuIntro(userLang)) %>">
			<section class="ds44-contenuArticle" id="section1">
				<div class="ds44-inner-container ds44-mtb3">
					<div class="ds44-grid12-offset-2">
						<jalios:if predicate="<%= Util.notEmpty(obj.getChapo(userLang)) %>">
							<% String titreIntro = Util.notEmpty(obj.getTitreIntro(userLang)) ? obj.getTitreIntro(userLang) : glp("jcmsplugin.socle.exposition.intro.title"); %>
							<h2 class="h2-like" id="idTitrePresentation"><%= titreIntro %></h2>
							<p class="ds44-introduction"><%= obj.getChapo(userLang) %></p>
						</jalios:if>
						<%-- Boucler sur les paragraphes contenu intro --%>
						<jalios:foreach name="itParagraphe" type="String" counter="itCounter" array="<%=obj.getContenuIntro(userLang)%>">
							<% String[] arrTitresIntro = obj.getContenuIntroTitre(userLang); %>
							<jalios:if predicate="<%= Util.notEmpty(arrTitresIntro) && itCounter <= arrTitresIntro.length
														&& Util.notEmpty(arrTitresIntro[itCounter - 1]) && Util.notEmpty(itParagraphe) %>">
								<h2 class="h2-like" id="titreIntro<%= itCounter %>"><%= arrTitresIntro[itCounter - 1] %></h2>
							</jalios:if>
							<jalios:if predicate="<%= Util.notEmpty(itParagraphe) %>">
								<jalios:wysiwyg><p><%= itParagraphe %></p></jalios:wysiwyg>
							</jalios:if>
						</jalios:foreach>
					</div>
				</div>
			</section>
		</jalios:if>

		<jalios:if predicate="<%= Util.notEmpty(obj.getHoraires(userLang)) || Util.notEmpty(obj.getTarifs(userLang)) 
									|| Util.notEmpty(obj.getContactsEtReservation(userLang)) || Util.notEmpty(obj.getUrlReservation(userLang)) 
									|| Util.notEmpty(obj.getContenuInfosLibres(userLang)) %>">
			<section class="ds44-contenuArticle" id="section2">
				<div class="ds44-inner-container">
					<div class="ds44-grid12-offset-2">
						<% String titreInfosPratiques = Util.notEmpty(obj.getTitreInfosPratiques(userLang)) ? obj.getTitreInfosPratiques(userLang) : glp("jcmsplugin.socle.info-pratique.title"); %>
						<h2 class="h2-like" id="idTitreVisite"><%= titreInfosPratiques %></h2>
						<div class="grid-2-small-1">
							<jalios:if predicate="<%= Util.notEmpty(obj.getHoraires(userLang)) || Util.notEmpty(obj.getTarifs(userLang)) %>">
								<div class="col">
									<jalios:if predicate="<%= Util.notEmpty(obj.getHoraires(userLang)) %>">
										<div class="ds44-mb3">
											<% String titreHoraires = Util.notEmpty(obj.getTitreHoraires(userLang)) ? obj.getTitreHoraires(userLang) : glp("jcmsplugin.socle.horaires.title"); %>
											<h3 class="h3-like" id="idTitre-list2"><%= titreHoraires %> :</h3>
											<jalios:wysiwyg><%= obj.getHoraires(userLang) %></jalios:wysiwyg>
										</div>
									</jalios:if>
									<jalios:if predicate="<%= Util.notEmpty(obj.getTarifs(userLang)) %>">
										<div class="ds44-mb3">
											<% String titreTarifs = Util.notEmpty(obj.getTitreTarifs(userLang)) ? obj.getTitreTarifs(userLang) : glp("jcmsplugin.socle.tarifs"); %>
											<h3 class="h3-like" id="idTitre-list4"><%= titreTarifs %></h3>
											<jalios:wysiwyg><%= obj.getTarifs(userLang) %></jalios:wysiwyg>
										</div>
									</jalios:if>
								</div>
							</jalios:if>
	
							<jalios:if predicate="<%= Util.notEmpty(obj.getContactsEtReservation(userLang)) || Util.notEmpty(obj.getUrlReservation(userLang))
														|| Util.notEmpty(obj.getContenuInfosLibres(userLang)) %>">
								<div class="col ds44--xl-padding-l">
									<div class="ds44-mb3">
										<% String titreContacts = Util.notEmpty(obj.getTitreContacts(userLang)) ? obj.getTitreContacts(userLang) : glp("jcmsplugin.socle.contacts.title"); %>
										<h3 class="h3-like" id="idTitre-list3"><%= titreContacts %> :</h3>
										<div class="ds44-ml1">
											<jalios:if predicate="<%= Util.notEmpty(obj.getContactsEtReservation(userLang)) %>">
												<jalios:wysiwyg><%= obj.getContactsEtReservation(userLang) %></jalios:wysiwyg>
											</jalios:if>
	
											<jalios:if predicate="<%= Util.notEmpty(obj.getUrlReservation(userLang)) %>">
												<p>
													<%
												    String lienReserverTitle = Util.notEmpty(obj.getTexteAlternatifReservation(userLang)) ? obj.getTexteAlternatifReservation(userLang) : glp("jcmsplugin.socle.reserverlien", obj.getTitle());
												    lienReserverTitle = HttpUtil.encodeForHTMLAttribute(glp("jcmsplugin.socle.lien.nouvelonglet", lienReserverTitle));
												    %>
													<a class="ds44-btnStd ds44-btnStd--large ds44-btn--invertWhite" title="<%= lienReserverTitle %>" href="<%= obj.getUrlReservation(userLang) %>" target="_blank">
														<span class="ds44-btnInnerText"><%= glp("jcmsplugin.socle.reserver") %></span>
														<i class="icon icon-long-arrow-right" aria-hidden="true"></i>
													</a>
												</p>
											</jalios:if>
										</div>
									</div>
									<%-- Boucler sur les paragraphes contenu infos libres --%>
									<jalios:if predicate="<%= Util.notEmpty(obj.getContenuInfosLibres(userLang)) %>">
										<jalios:foreach name="itParagraphe" type="String" counter="itCounter" array="<%= obj.getContenuInfosLibres(userLang) %>">
											<div class="ds44-mb3">
												<% String[] arrTitresInfosLibres = obj.getTitreInfosLibres(userLang); %>
												<jalios:if predicate="<%= Util.notEmpty(arrTitresInfosLibres) && itCounter <= arrTitresInfosLibres.length
																			&& Util.notEmpty(arrTitresInfosLibres[itCounter - 1]) && Util.notEmpty(itParagraphe) %>">
													<h3 class="h3-like" id="titreInfosLibres<%= itCounter %>"><%= arrTitresInfosLibres[itCounter - 1] %></h3>
												</jalios:if>
												<jalios:if predicate="<%= Util.notEmpty(itParagraphe) %>">
													<div class="ds44-ml1">
														<jalios:wysiwyg><p><%= itParagraphe %></p></jalios:wysiwyg>
													</div>
												</jalios:if>
											</div>
										</jalios:foreach>
									</jalios:if>
								</div>
							</jalios:if>
	
						</div>
					</div>
				</div>
			</section>
		</jalios:if>

		<jalios:if predicate="<%= Util.notEmpty(obj.getContenuDetails(userLang)) %>">
			<section class="ds44-contenuArticle" id="section4">
				<div class="ds44-inner-container ds44-mtb3">
					<div class="ds44-grid12-offset-2">
						<%-- Boucler sur les paragraphes contenu infos libres --%>
						<jalios:foreach name="itParagraphe" type="String" counter="itCounter" array="<%=obj.getContenuDetails(userLang)%>">
							<% String[] arrTitresDetails = obj.getTitreDetails(userLang); %>
							<jalios:if predicate="<%= Util.notEmpty(arrTitresDetails) && itCounter <= arrTitresDetails.length
														&& Util.notEmpty(arrTitresDetails[itCounter - 1]) && Util.notEmpty(itParagraphe) %>">
								<h2 class="h2-like" id="titreDetails<%= itCounter %>"><%= arrTitresDetails[itCounter - 1] %></h2>
							</jalios:if>
							<jalios:if predicate="<%= Util.notEmpty(itParagraphe) %>">
								<jalios:wysiwyg><p><%= itParagraphe %></p></jalios:wysiwyg>
							</jalios:if>
						</jalios:foreach>
					</div>
				</div>
			</section>
		</jalios:if>

		<%-- Portlets bas --%>
		<jalios:if predicate="<%=Util.notEmpty(obj.getLienVersPortletsBas())%>">
			<jalios:foreach name="itPortlet" array="<%=obj.getLienVersPortletsBas()%>" type="com.jalios.jcms.portlet.PortalElement">
				<section>
					<jalios:include id="<%=itPortlet.getId()%>" />
				</section>
			</jalios:foreach>
		</jalios:if>

		<jalios:if predicate="<%=Util.notEmpty(obj.getContenuDetails2(userLang))%>">
			<section class="ds44-contenuArticle" id="section6">
				<div class="ds44-inner-container ds44-mtb3">
					<div class="ds44-grid12-offset-2">
						<%-- Boucler sur les paragraphes contenu infos libres --%>
						<jalios:foreach name="itParagraphe" type="String" counter="itCounter" array="<%=obj.getContenuDetails2(userLang)%>">
							<% String[] arrTitresDetails2 = obj.getTitreDetails2(userLang); %>
							<jalios:if predicate="<%= Util.notEmpty(arrTitresDetails2) && itCounter <= arrTitresDetails2.length
														&& Util.notEmpty(arrTitresDetails2[itCounter - 1]) && Util.notEmpty(itParagraphe) %>">
								<h2 class="h2-like" id="titreDetails2-<%= itCounter %>"><%= arrTitresDetails2[itCounter - 1] %></h2>
							</jalios:if>
							<jalios:if predicate="<%= Util.notEmpty(itParagraphe) %>">
								<jalios:wysiwyg><p><%= itParagraphe %></p></jalios:wysiwyg>
							</jalios:if>
						</jalios:foreach>
					</div>
				</div>
			</section>
		</jalios:if>

		<%@ include file="/plugins/SoclePlugin/jsp/portal/socialNetworksShare.jspf" %>

	</div>


</article>

