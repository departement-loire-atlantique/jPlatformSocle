<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%>
<%@ include file='/jcore/doInitPage.jspf'%>
<%
    FicheLieu obj = (FicheLieu) request.getAttribute(PortalManager.PORTAL_PUBLICATION);

%>
<%@ include file='/front/doFullDisplay.jspf'%>
<%@ page import="fr.cg44.plugin.socle.SocleUtils"%>
<main role="main" id="content">

<jalios:include target="SOCLE_ALERTE"/>

<article class="ds44-container-large">

    <div class='<%= Util.notEmpty(request.getAttribute("isSearchFacetPanel")) ? "ds44-js-results-card" : "ds44-lightBG ds44-posRel"%>'>
        <%-- bouton Retour a la liste --%>
        <p class="ds44-noMrg">
            <%@ include file="/plugins/SoclePlugin/jsp/facettes/doRetourListe.jspf" %>
        </p>
        
        <div class="ds44-inner-container ds44--xl-padding-t ds44--m-padding-b ds44-tablet-augment-pt">
            <div class="ds44-grid12-offset-2">
                <jalios:if predicate='<%=Util.notEmpty(Channel.getChannel().getProperty("jcmsplugin.socle.portlet.filariane.id"))%>'>
                    <jalios:include id='<%=Channel.getChannel().getProperty("jcmsplugin.socle.portlet.filariane.id")%>' />
                </jalios:if>
                <h1 class="h1-like mbs mts " id="idTitre1"><%=obj.getTitle(userLang)%></h1>
                <% String ariaLevelPHeading = "2"; %>
                <jalios:if predicate='<%=Util.notEmpty(obj.getSoustitre())%>'>
                    <% ariaLevelPHeading = "3"; %>
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
                    
                    if (Util.notEmpty(adresseEcrire) || adresse.equals(adresseEcrire)) adresse = SocleUtils.formatAdressePhysique(obj, true);
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
                                        <p role="heading" aria-level="<%= ariaLevelPHeading %>" class="ds44-box-heading"><%=Util.notEmpty(obj.getServiceDuDepartement(loggedMember)) ? glp("jcmsplugin.socle.ficheaide.nousRencontrer")+" :" : glp("jcmsplugin.socle.ficheaide.adresse")+" :"%></p>

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
                                        <%-- <p role="heading" aria-level="<%= ariaLevelPHeading %>" class="ds44-box-heading mtl"><%= glp("jcmsplugin.socle.ficheaide.accessibilite-lieu.titre") %></p>
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
                                        <p role="heading" aria-level="<%= ariaLevelPHeading %>" class="ds44-box-heading">
                                            <%=Util.notEmpty(obj.getServiceDuDepartement(loggedMember)) ? glp("jcmsplugin.socle.ficheaide.nousContacter")+" :" : glp("jcmsplugin.socle.ficheaide.contact")+" :"%>
                                        </p>

                                        <jalios:if predicate='<%=Util.notEmpty(obj.getTelephone())%>'>
											<jalios:select>
												<jalios:if predicate='<%=obj.getTelephone().length > 1%>'>
													<div class="ds44-docListElem mts">
												</jalios:if>
												<jalios:default>
													<p class="ds44-docListElem mts">
												</jalios:default>
											</jalios:select>

                                            <i class="icon icon-phone ds44-docListIco" aria-hidden="true"></i>

                                            <jalios:if predicate='<%= obj.getTelephone().length == 1 %>'>
                                                <% String numTel = obj.getTelephone()[0]; %>
                                                <ds:phone number="<%= numTel %>" pubTitle="<%= obj.getTitle() %>"/>
                                            </jalios:if>

                                            <jalios:if predicate='<%= obj.getTelephone().length > 1 %>'>
                                                <ul class="ds44-list">
                                                    <jalios:foreach name="numTel" type="String" array="<%= obj.getTelephone() %>">
                                                        <li>
                                                            <ds:phone number="<%= numTel %>" pubTitle="<%= obj.getTitle() %>"/>
                                                        </li>
                                                    </jalios:foreach>
                                                </ul>
                                            </jalios:if>

											<jalios:select>
												<jalios:if predicate='<%=obj.getTelephone().length > 1%>'>
													</div>
												</jalios:if>
												<jalios:default>
													</p>
												</jalios:default>
											</jalios:select>
										</jalios:if>

                                        <jalios:if predicate='<%=Util.notEmpty(obj.getEmail())%>'>
                                            <jalios:select>
                                                <jalios:if predicate='<%=obj.getEmail().length > 1%>'>
                                                    <div class="ds44-docListElem mts">
                                                </jalios:if>
                                                <jalios:default>
                                                    <p class="ds44-docListElem mts">
                                                </jalios:default>
                                            </jalios:select>

											<i class="icon icon-mail ds44-docListIco" aria-hidden="true"></i>
					
											<jalios:if predicate='<%=obj.getEmail().length == 1%>'>
												<%
												  String email = obj.getEmail()[0];
												%>
												
												
												<jalios:select>
													<jalios:if predicate='<%= obj.containsCategory(channel.getCategory("$jcmsplugin.socle.fichelieu.contact-form.cat")) %>'>                        
									                   <%
									                   Data contactData = channel.getData(channel.getProperty("jcmsplugin.assmatplugin.formulaire.contact.ram"));
									                   if(Util.notEmpty(contactData)){
									                       String contactLien = contactData.getDisplayUrl(userLocale) + "?idRAM=" + encodeForHTML(obj.getId());
									                       %><a href='<%= contactLien %>'><%=glp("jcmsplugin.socle.ficheaide.contacter-par-mail.label")%></a><%
									                   }
									                   %>                  
									                </jalios:if>
													
													<jalios:default>												
														<a href='<%="mailto:" + email%>'
															title='<%=HttpUtil.encodeForHTMLAttribute(glp("jcmsplugin.socle.ficheaide.contacter-x-par-mail.label", obj.getTitle(), email))%>'
															data-statistic='{"name": "declenche-evenement","category": "BlocNousContacter","action": "Mailto","label": "<%=HttpUtil.encodeForHTMLAttribute(obj.getTitle())%>"}'>
															<%=glp("jcmsplugin.socle.ficheaide.contacter-par-mail.label")%>
														</a>
													</jalios:default>
												</jalios:select>											
												
											</jalios:if>
					
											<jalios:if predicate='<%=obj.getEmail().length > 1%>'>
												<ul class="ds44-list">
													<jalios:foreach name="email" type="String"
														array='<%=obj.getEmail()%>'>
														<li><a href='<%="mailto:" + email%>'
															title='<%=HttpUtil.encodeForHTMLAttribute(glp("jcmsplugin.socle.ficheaide.contacter-x-par-mail.label", obj.getTitle(), email))%>'
															data-statistic='{"name": "declenche-evenement","category": "BlocNousContacter","action": "Mailto","label": "<%=HttpUtil.encodeForHTMLAttribute(obj.getTitle())%>"}'>
																<%=email%>
														</a></li>
													</jalios:foreach>
												</ul>
											</jalios:if>
					
											<jalios:select>
                                                <jalios:if predicate='<%=obj.getEmail().length > 1%>'>
                                                    </div>
                                                </jalios:if>
                                                <jalios:default>
                                                    </p>
                                                </jalios:default>
                                            </jalios:select>
                                             
                                        </jalios:if>

                                        <jalios:if predicate='<%=Util.notEmpty(obj.getSiteInternet())%>'>
                                            <jalios:select>
                                                <jalios:if predicate='<%=obj.getSiteInternet().length > 1%>'>
                                                    <div class="ds44-docListElem mts">
                                                </jalios:if>
                                                <jalios:default>
                                                    <p class="ds44-docListElem mts">
                                                </jalios:default>
                                            </jalios:select>

											<i class="icon icon-link ds44-docListIco" aria-hidden="true"></i>
						
											<jalios:if predicate='<%=obj.getSiteInternet().length == 1%>'>
												<%
												  String site = obj.getSiteInternet()[0];
												%>
												<a href='<%=SocleUtils.parseUrl(site)%>'
													title='<%=glp("jcmsplugin.socle.lien.site.nouvelonglet", obj.getTitle())%>'
													target="_blank"
													data-statistic='{"name": "declenche-evenement","category": "BlocNousContacter","action": "Site web","label": "<%=HttpUtil.encodeForHTMLAttribute(obj.getTitle())%>"}'>
													<%=glp("jcmsplugin.socle.ficheaide.visiter-site.label")%>
												</a>
											</jalios:if>
						
											<jalios:if predicate='<%=obj.getSiteInternet().length > 1%>'>
												<ul class="ds44-list">
													<jalios:foreach name="site" type="String"
														array='<%=obj.getSiteInternet()%>'>
														<li><a href='<%=SocleUtils.parseUrl(site)%>'
															title='<%=glp("jcmsplugin.socle.lien.site.nouvelonglet", site)%>'
															target="_blank"
															data-statistic='{"name": "declenche-evenement","category": "BlocNousContacter","action": "Site web","label": "<%=HttpUtil.encodeForHTMLAttribute(obj.getTitle())%>"}'>
																<%=SocleUtils.parseUrl(site)%>
														</a></li>
													</jalios:foreach>
												</ul>
											</jalios:if>
						
											<jalios:select>
                                                <jalios:if predicate='<%=obj.getSiteInternet().length > 1%>'>
                                                    </div>
                                                </jalios:if>
                                                <jalios:default>
                                                    </p>
                                                </jalios:default>
                                            </jalios:select>
                                            
                                        </jalios:if>

                                    </jalios:if>

									<jalios:if predicate='<%=Util.notEmpty(adresseEcrire)%>'>
										<p role="heading" aria-level="<%=ariaLevelPHeading%>" class="ds44-box-heading mtl">
											<%=Util.notEmpty(obj.getServiceDuDepartement(loggedMember)) ? glp("jcmsplugin.socle.ficheaide.nousEcrire") + " :"
              : glp("jcmsplugin.socle.ficheaide.ecrireA") + " :"%>
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
                                String altTxt = SocleUtils.getAltTextFromPub(obj);
                            %>
                            <jalios:select>
                                <jalios:if predicate='<%= Util.notEmpty(sbfLegendeCopyright.toString()) %>'>
                            <figure class="ds44-legendeContainer ds44-container-imgRatio" role="figure" 
                                    <%= Util.notEmpty(sbfLegendeCopyright.toString()) ? "aria-label='"+ HttpUtil.encodeForHTMLAttribute(sbfLegendeCopyright.toString())+"'" : "" %>>
                                </jalios:if>
                                <jalios:default>
                            <picture class="ds44-legendeContainer ds44-container-imgRatio" 
                                    <%= Util.notEmpty(sbfLegendeCopyright.toString()) ? "aria-label='"+ HttpUtil.encodeForHTMLAttribute(sbfLegendeCopyright.toString())+"'" : "" %>>
                                </jalios:default>
                            </jalios:select>
                                <img src='<%= SocleUtils.getUrlOfFormattedImagePrincipale(obj.getImagePrincipale()) %>' class="ds44-w100 ds44-imgRatio" alt="<%= HttpUtil.encodeForHTMLAttribute(altTxt) %>">
                                <jalios:select>
                                    <jalios:if predicate='<%= Util.notEmpty(sbfLegendeCopyright.toString()) %>'>
                                    <figcaption class="ds44-imgCaption"><%= sbfLegendeCopyright.toString() %></figcaption>
                            </figure>
                                    </jalios:if>
                                    <jalios:default>
                            </picture>
                                    </jalios:default>
                                </jalios:select>
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
                                    if(isOpenInNewTab) {
                                        sbfTitle.append(" ")
                                            .append(glp("jcmsplugin.socle.accessibily.newTabLabel"));
                                    }
                                %>
                                <a href='<%= url %>' 
                                    class="ds44-btnStd ds44-btnStd--large" 
                                    type="button" 
                                    title='<%= HttpUtil.encodeForHTMLAttribute(sbfTitle.toString())%>'
                                    <%= isOpenInNewTab ? "target=\"_blank\"" : "" %> > 
                                    
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
                    <% String titrePourQui = Util.notEmpty(obj.getTitreSeoPourQui())? 
                        obj.getTitreSeoPourQui() : glp("jcmsplugin.socle.titre.pour-qui"); %>
                    <jalios:if predicate='<%= ariaLevelPHeading.equalsIgnoreCase("2") %>'>
                        <h2><%= titrePourQui %></h2>
                    </jalios:if>
                    <jalios:if predicate='<%= ariaLevelPHeading.equalsIgnoreCase("3") %>'>
                        <h3><%= titrePourQui %></h3>
                    </jalios:if>
                    <jalios:wysiwyg><%=obj.getPourQui()%></jalios:wysiwyg>
                </div>
            </div>
        </section>
    </jalios:if>
    
    <jalios:if predicate='<%= Util.notEmpty(obj.getDescription()) %>'>
        <section class="ds44-contenuArticle" id="section5">
            <div class="ds44-inner-container ds44-mtb3">
                <div class="ds44-grid12-offset-2">
                    <jalios:foreach name="it" type="String" array="<%= obj.getDescription() %>">
	                    <% 
	                    int itCount = itCounter-1;
	                    String itTitre = obj.getTitreSeoDescription().length>itCount? 
	                        obj.getTitreSeoDescription()[itCount] : null;
	                    %>
	                    <jalios:if predicate='<%= Util.notEmpty(itTitre) %>'>
		                    <jalios:if predicate='<%= ariaLevelPHeading.equalsIgnoreCase("2") %>'>
		                        <h2><%= itTitre %></h2>
		                    </jalios:if>
		                    <jalios:if predicate='<%= ariaLevelPHeading.equalsIgnoreCase("3") %>'>
		                        <h3><%= itTitre %></h3>
		                    </jalios:if>
	                    </jalios:if>
	                    <jalios:wysiwyg><%= obj.getDescription()[itCount] %></jalios:wysiwyg>
                    </jalios:foreach>
                </div>
            </div>
        </section>
    </jalios:if>

    <jalios:if predicate='<%= Util.notEmpty(obj.getModalitesDaccueil()) %>'>
        <section class="ds44-contenuArticle" id="section3">
            <div class="ds44-inner-container ds44-mtb3">
                <div class="ds44-grid12-offset-2">
                    <% String titreModalAccueil = Util.notEmpty(obj.getTitreSeoModaliteAccueil())? 
                        obj.getTitreSeoModaliteAccueil() : glp("jcmsplugin.socle.titre.qui-accueille"); %>
                    <jalios:if predicate='<%= ariaLevelPHeading.equalsIgnoreCase("2") %>'>
                        <h2><%= titreModalAccueil %></h2>
                    </jalios:if>
                    <jalios:if predicate='<%= ariaLevelPHeading.equalsIgnoreCase("3") %>'>
                        <h3><%= titreModalAccueil %></h3>
                    </jalios:if>
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
                        <p role="heading" aria-level="<%= ariaLevelPHeading %>" class="ds44-box-heading">
                            <%= Util.notEmpty(obj.getTitreSeoHorairesAcces())? obj.getTitreSeoHorairesAcces() : glp("jcmsplugin.socle.titre.horaires-acces") %>
                        </p>

                        <jalios:if predicate='<%= Util.notEmpty(obj.getHorairesEtAcces()) %>'>
                            <div class="ds44-docListElem mtm ds44-m-fluid-margin" role="heading" aria-level="4">
                                <i class="icon icon-time ds44-docListIco" aria-hidden="true"></i>
                                <jalios:wysiwyg><%= obj.getHorairesEtAcces() %></jalios:wysiwyg>
                            </div>
                        </jalios:if>
                        

                        <jalios:if predicate='<%= Util.notEmpty(obj.getTransportsEnCommun()) %>'>
                            <jalios:if predicate="<%= Util.notEmpty(obj.getTitreSeoTransportEnCommun()) %>">
	                            <p role="heading" aria-level="<%= ariaLevelPHeading %>" class="ds44-box-heading">
	                                <%= obj.getTitreSeoTransportEnCommun() %>     
	                            </p>
	                        </jalios:if>
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
                            <jalios:if predicate="<%= Util.notEmpty(obj.getTitreSeoParkings()) %>">
	                            <p role="heading" aria-level="<%= ariaLevelPHeading %>" class="ds44-box-heading">
	                                <%= obj.getTitreSeoParkings() %>     
	                            </p>
	                        </jalios:if>
                        
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
    <% Group groupeAsu = channel.getGroup("$jcmsplugin.socle.fichelieu.groupe.asu"); %>
    <jalios:if predicate='<%= (Util.notEmpty(obj.getReserveASU(userLang)) || Util.notEmpty(obj.getDocumentsASU())) && Util.notEmpty(groupeAsu) && (Util.notEmpty(loggedMember) ? loggedMember.isAccount() && loggedMember.belongsToGroup(groupeAsu) : false)  %>'>
        <%-- Bloc spécifique ASU --%>
        <div class="ds44-inner-container">
            <div class="ds44-grid12-offset-1">
		        <section class="ds44-box ds44-theme" id="sectionASU">
				  <div class="ds44-innerBoxContainer">
				      <p role="heading" aria-level="2" class="ds44-box-heading"><%= glp("jcmsplugin.socle.fichelieu.asu") %></p>
				      <jalios:if predicate="<%= Util.notEmpty(obj.getReserveASU(userLang)) %>">
				        <jalios:wysiwyg><%= obj.getReserveASU(userLang) %></jalios:wysiwyg>
				      </jalios:if>
				      
				      <jalios:if predicate="<%= Util.notEmpty(obj.getDocumentsASU()) %>">
					      <h2 class="h4-like ds44-mt3" id="titre_documents_asu"><%= glp("jcmsplugin.socle.fichelieu.dl.docs") %></h2>
	                      <ul class="ds44-list">
		                      <jalios:foreach name="itDoc" type="FileDocument" collection="<%= Arrays.asList(obj.getDocumentsASU()) %>">
			                      <li class="mts ds44-docListElem">
				                      <% 
					                      // Récupérer l'extension du fichier
					                      String fileType = FileDocument.getExtension(itDoc.getFilename()).toUpperCase();
					                      // Récupérer la taille du fichier
					                      String fileSize = Util.formatFileSize(itDoc.getSize());
					                                                    
					                      String fileUrl = ServletUtil.getBaseUrl(request) + itDoc.getDownloadUrl(); 
				                      %>
				                      <i class="icon icon-file ds44-docListIco" aria-hidden="true"></i>
				                      <% String titleModalFaireDemande = itDoc.getTitle() + " - " + fileType + " - " + fileSize + " " + glp("jcmsplugin.socle.accessibily.newTabLabel"); %>
				                      <a href="<%= itDoc.getDownloadUrl() %>" target="_blank" title='<%= HttpUtil.encodeForHTMLAttribute(titleModalFaireDemande) %>'
				                        data-statistic='{"name": "declenche-evenement","category": "Faire une demande","action": "Téléchargement","label": "<%= HttpUtil.encodeForHTMLAttribute(obj.getTitle()) %>"}'>
				                         <%= itDoc.getTitle() %>
				                      </a> 
				                      <span class="ds44-cardFile"><%= fileType %> - <%= fileSize %></span>
			                      </li>
		                      </jalios:foreach>
	                      </ul>
                      </jalios:if>
				  </div>
				</section>
			</div>
		</div>
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
                        <p role="heading" aria-level="<%= ariaLevelPHeading %>" class="ds44-box-heading"><%= glp("jcmsplugin.socle.titre.autre-lieu-associes") %></p>
                        
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
                            <jalios:foreach name="itAccueilAnnuaireAgenda" type="AccueilAnnuaireAgenda" array='<%= obj.getAutresLieuxAssociesAccueilAnnuai() %>'>
                                <li class="ds44-docListElem mtm">
                                    <i class="icon icon-marker ds44-docListIco" aria-hidden="true"></i> 
                                    <a href='<%= itAccueilAnnuaireAgenda.getDisplayUrl(userLocale) %>'> 
                                        <%= itAccueilAnnuaireAgenda.getTitle() %>
                                    </a>
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

    <%-- Partagez cette page --%>
    <%@ include file="/plugins/SoclePlugin/jsp/portal/socialNetworksShare.jspf" %>

</article>

<%-- Page utile --%>
<jsp:include page="/plugins/SoclePlugin/types/PageUtileForm/editFormPageUtileForm.jsp"/>
     
</main>
