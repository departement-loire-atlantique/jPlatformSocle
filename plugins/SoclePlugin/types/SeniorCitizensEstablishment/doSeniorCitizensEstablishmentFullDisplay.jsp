<%@ page import="fr.cg44.plugin.socle.SocleUtils" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="ds" tagdir="/WEB-INF/tags" %>
<%@ include file='/jcore/doInitPage.jspf' %>
<%@ page import="fr.cg44.plugin.socle.SocleUtils" %>
<% SeniorCitizensEstablishment obj = (SeniorCitizensEstablishment)request.getAttribute(PortalManager.PORTAL_PUBLICATION); %>

<main id="content" role="main">
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
					<h1 class="h1-like mbs mts" id="idTitre1"><%=obj.getTitle()%></h1>
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
										String longitude = obj.getExtraData("extra.FicheLieu.plugin.tools.geolocation.longitude");
										String latitude = obj.getExtraData("extra.FicheLieu.plugin.tools.geolocation.latitude");
										String localisation = SocleUtils.formatOpenStreetMapLink(latitude, longitude);
									%>
									<jalios:if predicate='<%= Util.notEmpty(localisation) %>'>
										<p class="ds44-docListElem mts">
											<i class="icon icon-map ds44-docListIco" aria-hidden="true"></i>
											<a href='<%= localisation%>' 
												title='<%= HttpUtil.encodeForHTMLAttribute(glp("jcmsplugin.socle.ficheaide.localiser-carte.label")+" : " + obj.getTitle() + " " + glp("jcmsplugin.socle.accessibily.newTabLabel"))%>' 
												target="_blank"> 
												
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
													<ds:phone number="<%= numTel %>"/>
												</jalios:if>

												<jalios:if predicate='<%= obj.getPhones().length > 1 %>'>
													<ul class="ds44-list">
														<jalios:foreach name="numTel" type="String" array="<%= obj.getPhones() %>">
															<li>
																<ds:phone number="<%= numTel %>"/>
															</li>
														</jalios:foreach>
													</ul>
												</jalios:if>

											</div>
										</jalios:if>

										<jalios:if predicate='<%=Util.notEmpty(obj.getMails())%>'>
											<div class="ds44-docListElem mts">
												<i class="icon icon-mail ds44-docListIco" aria-hidden="true"></i>
												<% 
													StringBuffer sbfAriaLabelMail = new StringBuffer();
													sbfAriaLabelMail.append(glp("jcmsplugin.socle.ficheaide.contacter.label"))
														.append(" ")
														.append(obj.getTitle())
														.append(" ")
														.append(glp("jcmsplugin.socle.ficheaide.par-mail.label"))
														.append(" : ");
													String strAriaLabelMail = HttpUtil.encodeForHTMLAttribute(sbfAriaLabelMail.toString());
												%>

												<jalios:if predicate='<%= obj.getMails().length == 1 %>'>
													<% String email = obj.getMails()[0]; %>
													<a href='<%= "mailto:"+email %>' title='<%= strAriaLabelMail + email %>'> 
														<%
															StringBuffer sbfLabelMail = new StringBuffer();
															sbfLabelMail.append(glp("jcmsplugin.socle.ficheaide.contacter.label"))
																.append(" ")
																.append(glp("jcmsplugin.socle.ficheaide.par-mail.label"));
														%>
														<%=  sbfLabelMail.toString()  %>
													</a>
												</jalios:if>

												<jalios:if predicate='<%= obj.getMails().length > 1 %>'>
													<ul class="ds44-list">
														<jalios:foreach name="email" type="String" array='<%= obj.getMails() %>'>
															<li>
																<a href='<%= "mailto:"+email %>' title='<%= strAriaLabelMail + email %>'> 
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
												<% 
													StringBuffer sbfAriaLabelSite = new StringBuffer();
													sbfAriaLabelSite.append(glp("jcmsplugin.socle.ficheaide.visiter-site-web-de.label"))
														.append(" ")
														.append(obj.getTitle())
														.append(" ")
														.append(glp("jcmsplugin.socle.accessibily.newTabLabel"));
													String strAriaLabelSite = HttpUtil.encodeForHTMLAttribute(sbfAriaLabelSite.toString());
												%>

												<jalios:if predicate='<%= obj.getWebsites().length == 1 %>'>
													<% String site = obj.getWebsites()[0]; %>
													<a href='<%= SocleUtils.parseUrl(site) %>' title='<%= strAriaLabelSite %>' target="_blank">
														<%= glp("jcmsplugin.socle.ficheaide.visiter-site.label") %>
													</a>
												</jalios:if>

												<jalios:if predicate='<%= obj.getWebsites().length > 1 %>'>
													<ul class="ds44-list">
														<jalios:foreach name="site" type="String" array='<%= obj.getWebsites() %>'>
															<li>
																<a href='<%= SocleUtils.parseUrl(site) %>' title='<%= strAriaLabelSite %>' target="_blank"> 
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
						</div>
					</section>
				</div>
			</div>
		</div>
	
		<jalios:if predicate="<%= Util.notEmpty(obj.getDescription()) || Util.notEmpty(obj.getLifeEnvironmentText()) 
				|| Util.notEmpty(obj.getSafeServiceText()) || Util.notEmpty(obj.getSocialLifeText()) || Util.notEmpty(obj.getAnimationsText()) ||  %>">
			<section class="ds44-contenuArticle" id="section1">
				<div class="ds44-inner-container">
					<div class="ds44-grid12-offset-2">
						<div class="grid-2-small-1">
							<jalios:if predicate="<%= Util.notEmpty(obj.getDescription()) %>">
								<div class="col mrs ds44-mtb2">
									<h2 class="h3-like" id="idTitre-list1"><%= glp("jcmsplugin.socle.fichepublication.enresume") %></h2>
									<jalios:wysiwyg><%= obj.getDescription() %></jalios:wysiwyg>
								</div>
							</jalios:if>
							<jalios:if predicate="<%= Util.notEmpty(obj.getLifeEnvironmentText()) %>">
								<div class="col mls ds44-mtb2">
									<h2 class="h3-like" id="idTitre-list2"><%= glp("jcmsplugin.socle.fichepublication.cadredevie") %></h2>
									<jalios:wysiwyg><%= obj.getLifeEnvironmentText() %></jalios:wysiwyg>
								</div>
							</jalios:if>
							<jalios:if predicate="<%= Util.notEmpty(obj.getSafeServiceText()) %>">
								<div class="col mrs ds44-mtb2">
									<h2 class="h3-like" id="idTitre-list3"><%= glp("jcmsplugin.socle.fichepublication.services") %></h2>
									<jalios:wysiwyg><%= obj.getSafeServiceText() %></jalios:wysiwyg>
								</div>
							</jalios:if>
							<jalios:if predicate="<%= Util.notEmpty(obj.getSocialLifeText()) %>">
								<div class="col mrs ds44-mtb2">
									<h2 class="h3-like" id="idTitre-list4"><%= glp("jcmsplugin.socle.fichepublication.viesociale") %></h2>
									<jalios:wysiwyg><%= obj.getSocialLifeText() %></jalios:wysiwyg>
								</div>
							</jalios:if>
							<jalios:if predicate="<%= Util.notEmpty(obj.getAnimationsText()) %>">
								<div class="col mrs ds44-mtb2">
									<h2 class="h3-like" id="idTitre-list5"><%= glp("jcmsplugin.socle.fichepublication.animations") %></h2>
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
								<p role="heading" aria-level="2" class="ds44-box-heading"><%= glp("jcmsplugin.socle.fichepublication.tarifsconventions") %></p>
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
						<h2 class="h3-like ds44-mt3 ds44-mb2" id="idTitre2"><%= glp("jcmsplugin.socle.fichepublication.remarquessupplementaires") %></h2>
						<jalios:wysiwyg><%= obj.getRemarkText() %></jalios:wysiwyg>
					</jalios:if>
	
					<div class="ds44-mtb3">
						<section class="ds44-innerBoxContainer ds44-borderContainer">
							<h2 id="idTitreBox2col-1" class="h2-like"><%= glp("jcmsplugin.socle.fichepublication.questionconseil") %></h2>
	
							<div class="grid-12-small-1">
								<jalios:if predicate="<%= Util.notEmpty(obj.getClics()) %>">
									<jalios:foreach name="itFicheLieu" type="FicheLieu" array="<%= obj.getClics() %>">
										<% 
											String style = itCounter == 0 ? "ds44-mb3" : "ds44-medToXlarge-pl3";
										%>
										<div class="col col-6 <%= style %>">
											<p role="heading" aria-level="3" class="h3-like"><%= itFicheLieu.getTitle() %></p>
											<p class="ds44-docListElem mts">
												<i class="icon icon-marker ds44-docListIco" aria-hidden="true"></i>
												<%= SocleUtils.formatAdresseEcrire(itFicheLieu) %>
											</p>
											
											<jalios:if predicate='<%=Util.notEmpty(itFicheLieu.getPhones())%>'>
												<div class="ds44-docListElem mts">
													<i class="icon icon-phone ds44-docListIco" aria-hidden="true"></i>
	
													<jalios:if predicate='<%= itFicheLieu.getPhones().length == 1 %>'>
														<% String numTel = itFicheLieu.getPhones()[0]; %>
														<ds:phone number="<%= numTel %>"/>
													</jalios:if>
	
													<jalios:if predicate='<%= itFicheLieu.getPhones().length > 1 %>'>
														<ul class="ds44-list">
															<jalios:foreach name="numTel" type="String" array="<%= itFicheLieu.getPhones() %>">
																<li>
																	<ds:phone number="<%= numTel %>"/>
																</li>
															</jalios:foreach>
														</ul>
													</jalios:if>
	
												</div>
											</jalios:if>
	
											<jalios:if predicate='<%=Util.notEmpty(itFicheLieu.getMails())%>'>
												<div class="ds44-docListElem mts">
													<i class="icon icon-mail ds44-docListIco" aria-hidden="true"></i>
													<% 
														StringBuffer sbfAriaLabelMail = new StringBuffer();
														sbfAriaLabelMail.append(glp("jcmsplugin.socle.ficheaide.contacter.label"))
															.append(" ")
															.append(itFicheLieu.getTitle())
															.append(" ")
															.append(glp("jcmsplugin.socle.ficheaide.par-mail.label"))
															.append(" : ");
														String strAriaLabelMail = HttpUtil.encodeForHTMLAttribute(sbfAriaLabelMail.toString());
													%>
	
													<jalios:if predicate='<%= itFicheLieu.getMails().length == 1 %>'>
														<% String email = itFicheLieu.getMails()[0]; %>
														<a href='<%= "mailto:"+email %>' title='<%= strAriaLabelMail + email %>'> 
															<%
																StringBuffer sbfLabelMail = new StringBuffer();
																sbfLabelMail.append(glp("jcmsplugin.socle.ficheaide.contacter.label"))
																	.append(" ")
																	.append(glp("jcmsplugin.socle.ficheaide.par-mail.label"));
															%>
															<%=  sbfLabelMail.toString()  %>
														</a>
													</jalios:if>
	
													<jalios:if predicate='<%= itFicheLieu.getMails().length > 1 %>'>
														<ul class="ds44-list">
															<jalios:foreach name="email" type="String" array='<%= itFicheLieu.getMails() %>'>
																<li>
																	<a href='<%= "mailto:"+email %>' title='<%= strAriaLabelMail + email %>'> 
																		<%= email %>
																	</a>
																</li>
															</jalios:foreach>
														</ul>
													</jalios:if>
	
												</div>
											</jalios:if>
											<p>
												<a class="ds44-btnStd ds44-mt3" href='<%= ficheLieu.getDisplayUrl(userLocale) %>' 
														title="<%= glp("jcmsplugin.socle.fichepublication.savoirplussur", itFicheLieu.getTitle()) %>">
													<span class="ds44-btnInnerText"><%= glp("jcmsplugin.socle.fichepublication.savoirplus") %></span>
													<i class="icon icon-long-arrow-right" aria-hidden="true"></i>
												</a>
											</p>
										</div>
									</jalios:foreach>
								</jalios:if>
								<jalios:if predicate="<%= Util.isEmpty(obj.getClics()) %>">
									<%-- TODO : get fiche lieu le plus proche --%>
									<% FicheLieu itFicheLieu = null; %>
									<div class="col col-6 ds44-mb3">
										<p role="heading" aria-level="3" class="h3-like"><%= itFicheLieu.getTitle() %></p>
										<p class="ds44-docListElem mts">
											<i class="icon icon-marker ds44-docListIco" aria-hidden="true"></i>
											<%= SocleUtils.formatAdresseEcrire(itFicheLieu) %>
										</p>
										
										<jalios:if predicate='<%=Util.notEmpty(itFicheLieu.getPhones())%>'>
											<div class="ds44-docListElem mts">
												<i class="icon icon-phone ds44-docListIco" aria-hidden="true"></i>

												<jalios:if predicate='<%= itFicheLieu.getPhones().length == 1 %>'>
													<% String numTel = itFicheLieu.getPhones()[0]; %>
													<ds:phone number="<%= numTel %>"/>
												</jalios:if>

												<jalios:if predicate='<%= itFicheLieu.getPhones().length > 1 %>'>
													<ul class="ds44-list">
														<jalios:foreach name="numTel" type="String" array="<%= itFicheLieu.getPhones() %>">
															<li>
																<ds:phone number="<%= numTel %>"/>
															</li>
														</jalios:foreach>
													</ul>
												</jalios:if>

											</div>
										</jalios:if>

										<jalios:if predicate='<%=Util.notEmpty(itFicheLieu.getMails())%>'>
											<div class="ds44-docListElem mts">
												<i class="icon icon-mail ds44-docListIco" aria-hidden="true"></i>
												<% 
													StringBuffer sbfAriaLabelMail = new StringBuffer();
													sbfAriaLabelMail.append(glp("jcmsplugin.socle.ficheaide.contacter.label"))
														.append(" ")
														.append(itFicheLieu.getTitle())
														.append(" ")
														.append(glp("jcmsplugin.socle.ficheaide.par-mail.label"))
														.append(" : ");
													String strAriaLabelMail = HttpUtil.encodeForHTMLAttribute(sbfAriaLabelMail.toString());
												%>

												<jalios:if predicate='<%= itFicheLieu.getMails().length == 1 %>'>
													<% String email = itFicheLieu.getMails()[0]; %>
													<a href='<%= "mailto:"+email %>' title='<%= strAriaLabelMail + email %>'> 
														<%
															StringBuffer sbfLabelMail = new StringBuffer();
															sbfLabelMail.append(glp("jcmsplugin.socle.ficheaide.contacter.label"))
																.append(" ")
																.append(glp("jcmsplugin.socle.ficheaide.par-mail.label"));
														%>
														<%=  sbfLabelMail.toString()  %>
													</a>
												</jalios:if>

												<jalios:if predicate='<%= itFicheLieu.getMails().length > 1 %>'>
													<ul class="ds44-list">
														<jalios:foreach name="email" type="String" array='<%= itFicheLieu.getMails() %>'>
															<li>
																<a href='<%= "mailto:"+email %>' title='<%= strAriaLabelMail + email %>'> 
																	<%= email %>
																</a>
															</li>
														</jalios:foreach>
													</ul>
												</jalios:if>

											</div>
										</jalios:if>
										<p>
											<a class="ds44-btnStd ds44-mt3" href='<%= ficheLieu.getDisplayUrl(userLocale) %>' 
													title="<%= glp("jcmsplugin.socle.fichepublication.savoirplussur", itFicheLieu.getTitle()) %>">
												<span class="ds44-btnInnerText"><%= glp("jcmsplugin.socle.fichepublication.savoirplus") %></span>
												<i class="icon icon-long-arrow-right" aria-hidden="true"></i>
											</a>
										</p>
									</div>
								</jalios:if>
							</div>
	
						</section>
					</div>
	
				</div>
			</div>
		</section>

		<%-- TODO : bloc partager la page --%> 
		
		<%-- TODO : bloc page a ete utile --%> 
	
	</article>
</main>