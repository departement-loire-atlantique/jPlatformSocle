<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%>
<%@ include file='/jcore/doInitPage.jspf'%>
<%
	ElectedMember obj = (ElectedMember) request.getAttribute(PortalManager.PORTAL_PUBLICATION);
%>
<%@ include file='/front/doFullDisplay.jspf'%>
<%@ page import="fr.cg44.plugin.socle.SocleUtils"%>

<main role="main" id="content">

<article class="ds44-container-large">

	<% String fullName = SocleUtils.getElectedMemberFullName(obj); %>
	<jalios:if predicate='<%= Util.notEmpty(Channel.getChannel().getProperty("jcmsplugin.socle.portlet.filariane.id")) || Util.notEmpty(fullName) 
			|| (Util.notEmpty(obj.getFunctions(loggedMember)) && obj.getFunctions(loggedMember).contains(channel.getCategory("$jcmsplugin.socle.elu.president"))) %>'>
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
					<jalios:if predicate="<%= Util.notEmpty(fullName) %>">
						<h1 class="h1-like mbs mts " id="idTitre1"><%= fullName %></h1>
					</jalios:if>
					<jalios:if predicate='<%= Util.notEmpty(obj.getFunctions(loggedMember)) && obj.getFunctions(loggedMember).contains(channel.getCategory("$jcmsplugin.socle.elu.president")) %>'>
						<h2 class="h2-like" id="idTitre0">
							<%= obj.getGender() ? glp("jcmsplugin.socle.elu.president.masculin") : glp("jcmsplugin.socle.elu.president.feminin") %>
						</h2>
					</jalios:if>
				</div>
			</div>
		</div>
	</jalios:if>
	<div class="ds44-img50 ds44--l-padding-tb">
		<div class="ds44-inner-container">
			<div class="ds44-grid12-offset-1">
				<section class="ds44-box ds44-theme">
					<div class="ds44-innerBoxContainer">

						<div class="grid-2-small-1 ds44-grid12-offset-1">

							<div class="col ds44--xl-padding-l">
								<p role="heading" aria-level="3" class="ds44-box-heading">
									<%= obj.getGender() ? glp("jcmsplugin.socle.elu.conseiller.masculin") : glp("jcmsplugin.socle.elu.conseiller.feminin") %> <%= glp("jcmsplugin.socle.elu.canton") %> <%= obj.getCanton().getTitle() %>
								</p>
								<% String strVicePresident = SocleUtils.getElectedMemberFullFunctionVicePresident(obj); %>
								<jalios:if predicate="<%= Util.notEmpty(strVicePresident) || Util.notEmpty(obj.getCommittees(loggedMember))%>">
									<p class="mts">
										<jalios:if predicate="<%= Util.notEmpty(strVicePresident) %>">
											<%= strVicePresident %>
											</br>
										</jalios:if>
										<jalios:if predicate='<%= Util.notEmpty(obj.getCommittees(loggedMember))%>'>
											<% ArrayList<Category> arrCommissionPresident = new ArrayList<Category>(); %>
											<jalios:foreach name="itCat" type="Category" collection="<%= obj.getCommittees(loggedMember) %>">
												<jalios:if predicate='<%= itCat.getId().equalsIgnoreCase(channel.getProperty("$jcmsplugin.socle.electedMember.commission-permanente.root")) %>'>
													<%= glp("jcmsplugin.socle.elu.membre-commission", glp("jcmsplugin.socle.elu.permanente")) %>
													</br>
												</jalios:if>
												<jalios:if predicate='<%= itCat.getName(userLang).equalsIgnoreCase(glp("jcmsplugin.socle.elu.president")) %>'>
													<% arrCommissionPresident.add(itCat.getParent()); %>
													<%= obj.getGender() ? glp("jcmsplugin.socle.elu.president-commission.masculin", itCat.getParent().getName(userLang)) : glp("jcmsplugin.socle.elu.president-commission.feminin", itCat.getParent().getName(userLang)) %>
													</br>
												</jalios:if>
												<jalios:if predicate='<%= itCat.getName(userLang).equalsIgnoreCase(glp("jcmsplugin.socle.elu.membre")) 
														&& ! arrCommissionPresident.contains(itCat.getParent()) %>'>
													<%= glp("jcmsplugin.socle.elu.membre-commission", itCat.getParent().getName(userLang)) %>
													</br>
												</jalios:if>
											</jalios:foreach>
										</jalios:if>
										
									</p>
								</jalios:if>
								<% String strMission = SocleUtils.getElectedMemberMissionString(obj); %>
								<jalios:if predicate="<%= Util.notEmpty(strMission) %>">
									<p class="mts">
										<%= strMission %>
									</p>
								</jalios:if>
								<% ElectedMember eluBinome = SocleUtils.getElectedMemberBinome(obj); %>
								<jalios:if predicate="<%= Util.notEmpty(eluBinome) || Util.notEmpty(obj.getDeputy()) %>">
									<p class="mts">
										<%
											String fullNameBinome = SocleUtils.getElectedMemberFullName(eluBinome);
										%>
										<jalios:if predicate="<%= Util.notEmpty(eluBinome) %>">
											<strong><%= glp("jcmsplugin.socle.elu.en-binome-avec") %></strong> <a href="<%= eluBinome.getDisplayUrl(userLocale) %>"><%= Util.notEmpty(fullNameBinome) ? fullNameBinome : glp("jcmsplugin.socle.elu.nom-binome.default") %></a>
											<br>
										</jalios:if>
										<jalios:if predicate="<%= Util.notEmpty(obj.getDeputy()) %>">
											<strong><%= glp("jcmsplugin.socle.elu.remplacant") %></strong> <%= obj.getDeputy() %>
										</jalios:if>
									</p>
								</jalios:if>
								<p class="mts">
									<%= obj.getPoliticalParty(loggedMember).first().getName() %>
									<% String labelAnneeElection = SocleUtils.getElectedMemberElectionYear(obj); %>
									<jalios:if predicate="<%= Util.notEmpty(labelAnneeElection) %>">
										</br>
										<%= labelAnneeElection %>
									</jalios:if>
								</p>
							</div>

							<jalios:if predicate='<%= Util.notEmpty(obj.getMails()) || Util.notEmpty(obj.getWebSites())
									|| Util.notEmpty(obj.getFacebook()) || Util.notEmpty(obj.getTwitter())
									|| Util.notEmpty(obj.getPicture()) %>'>

								<div class="col ds44--xl-padding-l">

									<jalios:if predicate="<%= Util.notEmpty(obj.getPicture()) %>">
										<picture class="ds44-container-imgRatio ds44-container-imgRatio--profilXL">
											<img src="<%= obj.getPicture() %>" alt="" class="ds44-w100 ds44-imgRatio ds44-imgRatio--profil">
										</picture>
									</jalios:if>

									<jalios:if predicate='<%=Util.notEmpty(obj.getMails())%>'>
										<div class="ds44-docListElem mts">
											<i class="icon icon-mail ds44-docListIco" aria-hidden="true"></i>

											<jalios:if predicate='<%= obj.getMails().length == 1 %>'>
												<% String email = obj.getMails()[0]; %>
												<a href='<%= "mailto:"+email %>' title='<%= HttpUtil.encodeForHTMLAttribute(glp("jcmsplugin.socle.ficheaide.contacter-x-par-mail.label", obj.getTitle(), email)) %>'> 
													<%=  glp("jcmsplugin.socle.ficheaide.contacter-par-mail.label")  %>
												</a>
											</jalios:if>

											<jalios:if predicate='<%= obj.getMails().length > 1 %>'>
												<ul class="ds44-list">
													<jalios:foreach name="email" type="String" array='<%= obj.getMails() %>'>
														<li>
															<a href='<%= "mailto:"+email %>' title='<%= HttpUtil.encodeForHTMLAttribute(glp("jcmsplugin.socle.ficheaide.contacter-x-par-mail.label", obj.getTitle(), email)) %>'> 
																<%= email %>
															</a>
														</li>
													</jalios:foreach>
												</ul>
											</jalios:if>

										</div>
									</jalios:if>

									<jalios:if predicate='<%=Util.notEmpty(obj.getWebSites())%>'>
										<div class="ds44-docListElem mts">
											<i class="icon icon-link ds44-docListIco" aria-hidden="true"></i>

											<jalios:if predicate='<%= obj.getWebSites().length == 1 %>'>
												<% String site = obj.getWebSites()[0]; %>
												<a href='<%= SocleUtils.parseUrl(site) %>' title='<%= glp("jcmsplugin.socle.ficheaide.visiter-site-web-de.label", obj.getTitle(), glp("jcmsplugin.socle.accessibily.newTabLabel")) %>' target="_blank">
													<%= glp("jcmsplugin.socle.ficheaide.visiter-site.label") %>
												</a>
											</jalios:if>

											<jalios:if predicate='<%= obj.getWebSites().length > 1 %>'>
												<ul class="ds44-list">
													<jalios:foreach name="site" type="String" array='<%= obj.getWebSites() %>'>
														<li>
															<a href='<%= SocleUtils.parseUrl(site) %>' title='<%= glp("jcmsplugin.socle.ficheaide.visiter-site-web-de.label", obj.getTitle(), glp("jcmsplugin.socle.accessibily.newTabLabel")) %>' target="_blank"> 
																<%= SocleUtils.parseUrl(site) %>
															</a>
														</li>
													</jalios:foreach>
												</ul>
											</jalios:if>

										</div>
									</jalios:if>

									<jalios:if predicate="<%= Util.notEmpty(obj.getFacebook()) || Util.notEmpty(obj.getTwitter()) %>">
										<div class="ds44-docListElem mts">
											<ul class="ds44-list ds44-flex-container ds44-flex-align-left">
												<jalios:if predicate="<%= Util.notEmpty(obj.getFacebook()) %>">
													<li>
														<a href="<%= obj.getFacebook() %>" target="_blank" class="ds44-rsLink" 
																title='<%= glp("jcmsplugin.socle.lien.nouvelonglet", glp("jcmsplugin.socle.elu.page-facebook", SocleUtils.getElectedMemberFullName(obj))) %>' 
																data-statistic="{&quot;name&quot;: &quot;declenche-evenement&quot;,&quot;category&quot;: &quot;Partage page&quot;,&quot;action&quot;: &quot;Facebook&quot;}">
															<i class="icon icon-facebook icon--sizeL" aria-hidden="true"></i>
															<span class="visually-hidden"><%= glp("jcmsplugin.socle.elu.page-facebook", SocleUtils.getElectedMemberFullName(obj)) %></span>
														</a>
													</li>
												</jalios:if>
												<jalios:if predicate="<%= Util.notEmpty(obj.getTwitter()) %>">
													<li>
														<a href="<%= obj.getTwitter() %>" target="_blank" class="ds44-rsLink" 
																title='<%= glp("jcmsplugin.socle.lien.nouvelonglet", glp("jcmsplugin.socle.elu.page-twitter", SocleUtils.getElectedMemberFullName(obj))) %>' 
																data-statistic="{&quot;name&quot;: &quot;declenche-evenement&quot;,&quot;category&quot;: &quot;Partage page&quot;,&quot;action&quot;: &quot;Twitter&quot;}">
															<i class="icon icon-twitter icon--sizeL" aria-hidden="true"></i>
															<span class="visually-hidden"><%= glp("jcmsplugin.socle.elu.page-twitter", SocleUtils.getElectedMemberFullName(obj)) %></span>
														</a>
													</li>
												</jalios:if>
											</ul>
										</div>
									</jalios:if>

								</div>
							</jalios:if>
						</div>
					</div>
				</section>
			</div>
		</div>
	</div>

	<jalios:if predicate='<%= Util.notEmpty(obj.getCurrentMandate(userLang)) %>'>
		<section class="ds44-contenuArticle" id="section3">
			<div class="ds44-inner-container ds44-mtb3">
				<div class="ds44-grid12-offset-2">
					<h3 id="idTitre3"><%= glp("jcmsplugin.socle.elu.fonctions-actuelles.titre") %></h3>
					<jalios:wysiwyg><%= obj.getCurrentMandate(userLang) %></jalios:wysiwyg>
				</div>
			</div>
		</section>
	</jalios:if>

	<jalios:if predicate='<%= Util.notEmpty(obj.getHistoricalCGMandates(userLang)) %>'>
		<section class="ds44-contenuArticle" id="section4">
			<div class="ds44-inner-container ds44-mtb3">
				<div class="ds44-grid12-offset-2">
					<h3 id="idTitre4"><%= glp("jcmsplugin.socle.elu.historique-fonctions.titre") %></h3>
					<jalios:wysiwyg><%= obj.getHistoricalCGMandates(userLang) %></jalios:wysiwyg>
				</div>
			</div>
		</section>
	</jalios:if>

	<jalios:if predicate='<%= Util.notEmpty(obj.getOtherLocalNationalMandates(userLang)) %>'>
		<section class="ds44-contenuArticle" id="section5">
			<div class="ds44-inner-container ds44-mtb3">
				<div class="ds44-grid12-offset-2">
					<div class="ds44-wsg-encadreContour">
						<h3 id="idTitre5"><%= glp("jcmsplugin.socle.elu.autres-fonctions.titre") %></h3>
						<jalios:wysiwyg><%= obj.getOtherLocalNationalMandates(userLang) %></jalios:wysiwyg>
					</div>
				</div>
			</div>
		</section>
	</jalios:if>

	<%-- TODO : bloc des réseaux sociaux --%>

</article>

<%-- TODO : bloc page a ete utile --%> 
</main>
	