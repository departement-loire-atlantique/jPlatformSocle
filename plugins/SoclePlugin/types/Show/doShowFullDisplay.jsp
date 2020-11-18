<%@ page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@ page import="fr.cg44.plugin.socle.VideoUtils"%>
<%@page import="com.jalios.jcms.handler.QueryHandler"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%>
<%@ include file='/jcore/doInitPage.jspf'%>

<% Show obj = (Show)request.getAttribute(PortalManager.PORTAL_PUBLICATION); %>

<%@ include file='/front/doFullDisplay.jspf' %>

<jalios:buffer name="coloredSectionContent">
    <div class="grid-2-small-1 ds44-grid12-offset-1">

        <%-- Col gauche --%>
        <div class="col">
            <p role="heading" aria-level="3" class="ds44-box-heading"><%= glp("jcmsplugin.socle.enbref") %></p>
            
            <%-- Thématiques --%>
            <jalios:if predicate='<%= Util.notEmpty(obj.getCategorie(loggedMember)) %>'>
                <% 
                Set<Category> thematiqueCats = new TreeSet<Category>(new Category.DeepOrderComparator());
                thematiqueCats.addAll(obj.getCategorie(loggedMember));
                %>
                <p class="ds44-docListElem mts"><i class="icon icon-tag ds44-docListIco" aria-hidden="true"></i><%= Util.join(thematiqueCats, ", ") %></p>
            </jalios:if>
            
            <%-- Date de création --%>
            <jalios:if predicate='<%= Util.notEmpty(obj.getCreationDate()) %>'>
                <p class="ds44-docListElem mts"><i class="icon icon-date ds44-docListIco" aria-hidden="true"></i><strong><%= glp("jcmsplugin.socle.show.date-creation") %> : </strong><%= obj.getCreationDate() %></p>
            </jalios:if>
            
            <%-- Compagnie --%>
            <%
            List<String> listeTroupe  = new ArrayList<String>();
            
            if(Util.notEmpty(obj.getTroupe())) {
            	listeTroupe.add(obj.getTroupe().getTitle());
             }
            
            if(Util.notEmpty(obj.getOtherTroupe())) {
             listeTroupe.add(obj.getOtherTroupe());
             }
            %>
            
            <%-- Compagnie --%>
            <jalios:if predicate='<%= Util.notEmpty(obj.getTroupe()) || Util.notEmpty(obj.getOtherTroupe()) %>'>
                <p class="ds44-docListElem mts"><i class="icon icon-user-group ds44-docListIco" aria-hidden="true"></i><strong><%= glp("jcmsplugin.socle.show.compagnie") %> : </strong><%= Util.join(listeTroupe, " / ") %></p>
            </jalios:if>
            
            <%-- Auteur --%>
            <jalios:if predicate='<%= Util.notEmpty(obj.getAuthorOfTheShow())%>'>
                <p class="ds44-docListElem mts"><i class="icon icon-user ds44-docListIco" aria-hidden="true"></i><strong><%= glp("jcmsplugin.socle.show.auteur") %> : </strong><%= obj.getAuthorOfTheShow() %></p>
            </jalios:if>
            
            <%-- Mise en scène --%>
            <jalios:if predicate='<%= Util.notEmpty(obj.getDirector())%>'>
                <p class="ds44-docListElem mts"><i class="icon icon-user ds44-docListIco" aria-hidden="true"></i><strong><%= glp("jcmsplugin.socle.show.mise-en-scene") %> : </strong><%= obj.getDirector() %></p>
            </jalios:if>
            
            <%-- Public visé --%>
            <jalios:if predicate='<%= Util.notEmpty(obj.getPublicTargeted())%>'>
                <p class="ds44-docListElem mts"><i class="icon icon-user-group ds44-docListIco" aria-hidden="true"></i><strong><%= glp("jcmsplugin.socle.show.public-vise") %> : </strong><%= obj.getPublicTargeted() %></p>
            </jalios:if>
            
            <%-- Durée --%>
            <jalios:if predicate='<%= Util.notEmpty(obj.getDuration())%>'>
                <p class="ds44-docListElem mts"><i class="icon icon-time ds44-docListIco" aria-hidden="true"></i><strong><%= glp("jcmsplugin.socle.show.duree") %> : </strong><%= obj.getDuration() %></p>
            </jalios:if>

        </div>
        
        <%-- Col droite --%>
        <div class="col ds44--xl-padding-l">
            <p role="heading" aria-level="3" class="ds44-box-heading"><%= glp("jcmsplugin.socle.votrecontact") %></p>

            <%-- Contact --%>
            <jalios:if predicate='<%= Util.notEmpty(obj.getContactLabel())%>'>
                <p class="ds44-docListElem mts"><i class="icon icon-user ds44-docListIco" aria-hidden="true"></i><%= obj.getContactLabel() %></p>
            </jalios:if>
            
            <%-- Adresse --%>
            <jalios:if predicate='<%= Util.notEmpty(obj.getAddress()) || Util.notEmpty(obj.getPostalBox()) || Util.notEmpty(obj.getZipCode()) || Util.notEmpty(obj.getCommune()) %>'>
                <p class="ds44-docListElem mts"><i class="icon icon-marker ds44-docListIco" aria-hidden="true"></i>
                    <jalios:if predicate='<%= Util.notEmpty(obj.getAddress()) %>'>   
                        <%= obj.getAddress() %><br>
                    </jalios:if>
                    <jalios:if predicate='<%= Util.notEmpty(obj.getPostalBox()) %>'>
                         <%= obj.getPostalBox() %><br>
                     </jalios:if>
                     <jalios:if predicate='<%= Util.notEmpty(obj.getZipCode())  %>'> 
                         <%= obj.getZipCode() %>
                    </jalios:if>
                    <jalios:if predicate='<%= Util.notEmpty(obj.getCommune()) %>'>
                        <%= obj.getCommune().getTitle() %>
                    </jalios:if>
                </p>
            </jalios:if>

            <%-- Tel --%>
			<jalios:if predicate='<%=Util.notEmpty(obj.getPhones())%>'>
				<div class="ds44-docListElem mts">
					<i class="icon icon-phone ds44-docListIco" aria-hidden="true"></i>

					<jalios:if predicate='<%=obj.getPhones().length == 1%>'>
						<%
							String numTel = obj.getPhones()[0];
						%>
						<ds:phone number="<%=numTel%>" />
					</jalios:if>

					<jalios:if predicate='<%=obj.getPhones().length > 1%>'>
						<ul class="ds44-list">
							<jalios:foreach name="numTel" type="String"
								array="<%=obj.getPhones()%>">
								<li><ds:phone number="<%=numTel%>" /></li>
							</jalios:foreach>
						</ul>
					</jalios:if>

				</div>
			</jalios:if>

            <%-- Mails --%>
			<jalios:if predicate='<%=Util.notEmpty(obj.getMails())%>'>
				<div class="ds44-docListElem mts">
					<i class="icon icon-mail ds44-docListIco" aria-hidden="true"></i>

					<jalios:if predicate='<%=obj.getMails().length == 1%>'>
						<%
							String email = obj.getMails()[0];
						%>
						<a href='<%="mailto:" + email%>'
							title='<%=HttpUtil.encodeForHTMLAttribute(glp("jcmsplugin.socle.ficheaide.contacter-x-par-mail.label", obj.getTitle(), email))%>'
							data-statistic='{"name": "declenche-evenement","category": "BlocNousContacter","action": "Mailto","label": "<%=HttpUtil.encodeForHTMLAttribute(obj.getTitle())%>"}'>
							<%=glp("jcmsplugin.socle.ficheaide.contacter-par-mail.label")%>
						</a>
					</jalios:if>

					<jalios:if predicate='<%=obj.getMails().length > 1%>'>
						<ul class="ds44-list">
							<jalios:foreach name="email" type="String"
								array='<%=obj.getMails()%>'>
								<li><a href='<%="mailto:" + email%>'
									title='<%=HttpUtil.encodeForHTMLAttribute(glp("jcmsplugin.socle.ficheaide.contacter-x-par-mail.label", obj.getTitle(), email))%>'
									data-statistic='{"name": "declenche-evenement","category": "BlocNousContacter","action": "Mailto","label": "<%=HttpUtil.encodeForHTMLAttribute(obj.getTitle())%>"}'>
										<%=email%>
								</a></li>
							</jalios:foreach>
						</ul>
					</jalios:if>

				</div>
			</jalios:if>

            <%-- Site --%>
			<jalios:if predicate='<%=Util.notEmpty(obj.getWebsites())%>'>
                <%-- On ne prend que le 1er lien , même si plusieurs on été renseignés --%>
				<div class="ds44-docListElem mts">
					<i class="icon icon-link ds44-docListIco" aria-hidden="true"></i>

					<%
						String site = obj.getWebsites()[0];
					%>
					<a href='<%=SocleUtils.parseUrl(site)%>'
						title='<%=glp("jcmsplugin.socle.lien.site.nouvelonglet", obj.getTitle())%>'
						target="_blank"
						data-statistic='{"name": "declenche-evenement","category": "BlocNousContacter","action": "Site web","label": "<%=HttpUtil.encodeForHTMLAttribute(obj.getTitle())%>"}'>
						<%=glp("jcmsplugin.socle.ficheaide.visiter-site.label")%>
					</a>

				</div>
			</jalios:if>

		</div>
    </div>
</jalios:buffer>

<main id="content" role="main" tabindex="-1">

<jalios:include target="SOCLE_ALERTE"/>

    <article class="ds44-container-large">
    
        <ds:titleNoImage title="<%=obj.getTitle(userLang)%>" breadcrumb="true" coloredSection="<%=coloredSectionContent%>"></ds:titleNoImage>

        <section class="ds44-contenuArticle" id="section2">
            <div class="ds44-inner-container ds44-mtb3">
                <div class="ds44-grid12-offset-2">
                
                    <%-- Synopsys --%>
                    <jalios:if predicate='<%=Util.notEmpty(obj.getDescription())%>'>
                        <h2><%=glp("jcmsplugin.socle.show.synopsys")%></h2>
                        <jalios:wysiwyg css="mbm"><%=obj.getDescription()%></jalios:wysiwyg>
                    </jalios:if>
                    
                    <%-- Interprètes --%>
                    <jalios:if predicate='<%=Util.notEmpty(obj.getActors())%>'>
                        <h3><%=glp("jcmsplugin.socle.show.interpretes")%></h3>
                        <jalios:wysiwyg><%=obj.getActors()%></jalios:wysiwyg>
                    </jalios:if>
                    
                    <%-- Infos pratiques --%>
                    <jalios:if predicate='<%=Util.notEmpty(obj.getShowCost()) || Util.notEmpty(obj.getParticularConditions())%>'>
                        <div class="ds44-wsg-encadreContour">
                            <p role="heading" aria-level="2" class="ds44-box-heading"><%= glp("jcmsplugin.socle.show.infos") %></p>
                            
                            <jalios:if predicate='<%= Util.notEmpty(obj.getShowCost()) %>'>
                                <div class="ds44-docListElem mts"><i class="icon icon-cost ds44-docListIco" aria-hidden="true"></i><strong><%= glp("jcmsplugin.socle.show.cout") %> : </strong><jalios:wysiwyg><%= obj.getShowCost() %></jalios:wysiwyg></div>
                            </jalios:if>
                            
                            <jalios:if predicate='<%= Util.notEmpty(obj.getParticularConditions()) %>'>
                                <div class="ds44-docListElem mts"><i class="icon icon-tag ds44-docListIco" aria-hidden="true"></i><strong><%= glp("jcmsplugin.socle.show.conditions") %> : </strong><jalios:wysiwyg><%= obj.getParticularConditions() %></jalios:wysiwyg></div>
                            </jalios:if>
                            
                        </div>
                    </jalios:if>

					<%-- Liens utiles --%>
					<jalios:if predicate='<%= (Util.notEmpty(obj.getWebsites()) && obj.getWebsites().length > 1) || Util.notEmpty(obj.getDailymotionUrls()) || Util.notEmpty(obj.getVimeoUrls()) %>'>
						<div class="ds44-box ds44-bgGray">
							<div class="ds44-innerBoxContainer">
								<p role="heading" aria-level="2" class="ds44-box-heading"><%=glp("jcmsplugin.socle.show.liens")%></p>
                                    <ul class="ds44-list">
                                    
                                        <%-- Site web --%>
                                        <jalios:if predicate='<%= Util.notEmpty(obj.getWebsites()) %>'>
											<jalios:foreach name="site" type="String" array='<%=obj.getWebsites()%>'>
												<li>
		                                            <div class="ds44-docListElem mts">
		                                                <i class="icon icon-link ds44-docListIco" aria-hidden="true"></i>
		                                                <a href='<%=SocleUtils.parseUrl(site)%>'
														    title='<%=glp("jcmsplugin.socle.lien.site.nouvelonglet", HttpUtil.encodeForHTMLAttribute(site))%>'
														    target="_blank"
														    data-statistic='{"name": "declenche-evenement","category": "BlocLiensUtiles","action": "Site web","label": "<%=HttpUtil.encodeForHTMLAttribute(site)%>"}'>
														    <%=SocleUtils.parseUrl(site)%>
		                                                </a>
		                                            </div>
												 </li>
											</jalios:foreach>
                                        </jalios:if>
                                        
                                        <%-- URLs Vimeo --%>
                                        <jalios:if predicate='<%= Util.notEmpty(obj.getVimeoUrls()) %>'>
                                            <jalios:foreach name="site" type="String" array='<%=obj.getVimeoUrls()%>'>
                                                <li>
                                                    <div class="ds44-docListElem mts">
                                                        <i class="icon icon-link ds44-docListIco" aria-hidden="true"></i>
                                                        <a href='<%=SocleUtils.parseUrl(site)%>'
                                                            title='<%=glp("jcmsplugin.socle.lien.site.nouvelonglet", HttpUtil.encodeForHTMLAttribute(site))%>'
                                                            target="_blank"
                                                            data-statistic='{"name": "declenche-evenement","category": "BlocLiensUtiles","action": "Site web","label": "<%=HttpUtil.encodeForHTMLAttribute(site)%>"}'>
                                                            <%=SocleUtils.parseUrl(site)%>
                                                        </a>
                                                    </div>
                                                 </li>
                                            </jalios:foreach>
                                        </jalios:if>
                                        
                                        <%-- URLs Dailymotion --%>
                                        <jalios:if predicate='<%= Util.notEmpty(obj.getDailymotionUrls()) %>'>
                                            <jalios:foreach name="site" type="String" array='<%=obj.getDailymotionUrls()%>'>
                                                <li>
                                                    <div class="ds44-docListElem mts">
                                                        <i class="icon icon-link ds44-docListIco" aria-hidden="true"></i>
                                                        <a href='<%=SocleUtils.parseUrl(site)%>'
                                                            title='<%=glp("jcmsplugin.socle.lien.site.nouvelonglet", HttpUtil.encodeForHTMLAttribute(site))%>'
                                                            target="_blank"
                                                            data-statistic='{"name": "declenche-evenement","category": "BlocLiensUtiles","action": "Site web","label": "<%=HttpUtil.encodeForHTMLAttribute(site)%>"}'>
                                                            <%=SocleUtils.parseUrl(site)%>
                                                        </a>
                                                    </div>
                                                 </li>
                                            </jalios:foreach>
                                        </jalios:if>                                        
									</ul>

							</div>
						</div>
					</jalios:if>
					
					<%-- Diaporama --%>
                    <jalios:if predicate='<%= Util.notEmpty(obj.getSlideShow())  %>'>
                        <div class="mtm">
                            <jalios:include pub="<%= obj.getSlideShow() %>"/>
                        </div>
                    </jalios:if>  
                    
                    <%-- Vidéo Youtube --%>
                    <jalios:if predicate='<%=Util.notEmpty(obj.getYoutubeUrls())%>'>
						<jalios:foreach name="itUrlVideo" type="String" array='<%=obj.getYoutubeUrls()%>'>
                            <% 
                            String urlVideo = Util.decodeUrl(VideoUtils.buildYoutubeUrl(itUrlVideo));
                            %>
                            <iframe title='<%=JcmsUtil.glp(userLang, "jcmsplugin.socle.video.acceder", urlVideo)%>' style="width: 100%; height: 480px; border: none;" class="mtm" src="<%=urlVideo%>" allowfullscreen></iframe>
						</jalios:foreach>
                    </jalios:if>

				</div>
            </div>
        </section>

		<%-- Partagez cette page --%>
		<%@ include	file="/plugins/SoclePlugin/jsp/portal/socialNetworksShare.jspf"%>

	</article>
    
	<%-- Page utile --%>
	<jsp:include page="/plugins/SoclePlugin/types/PageUtileForm/editFormPageUtileForm.jsp"/>


</main>