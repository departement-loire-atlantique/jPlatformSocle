<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file='/jcore/doInitPage.jspf' %>
<%@ include file='/jcore/portal/doPortletParams.jspf' %>
<% 
	FaqAccueil obj = (FaqAccueil) request.getAttribute(PortalManager.PORTAL_PUBLICATION); 
%>

<section class="ds44--xxl-padding-b">
	<header class="txtcenter ds44--xxl-padding-b">
		<h2 class="h2-like center"><%= glp("jcmsplugin.socle.faq.vous-avez-question") %></h2>
	</header>
	<div class="ds44-inner-container ds44-flex-container ds44-flex-valign-center ds44-flex-align-center ds44--xl-padding-lr">
		<div class="grid-12-small-1">
			<div class="col-6-small-1">
				<h3 class="h4-like" aria-level="2" role="heading"><%= Util.notEmpty(obj.getSoustitre(userLang)) ? obj.getSoustitre(userLang) : glp("jcmsplugin.socle.faq.consulter-question-frequente") %></h3>
				<ul class="ds44-collapser ds44-mb-std ">
					<jalios:foreach name="itQuestRep" type="FaqEntry" collection='<%= obj.getLinkIndexedDataSet(FaqEntry.class) %>' counter='nbrQuestRep'>
						<li class='ds44-collapser_element <%= nbrQuestRep > obj.getNombreDeQuestionsAffichees() ? "hidden" : "" %>'>
							<button type="button" class="ds44-collapser_button">
								<%= itQuestRep.getTitle(userLang) %>
								<i class="icon icon-down" aria-hidden="true"></i>
							</button>
							<div class="ds44-collapser_content">
								<ul class="ds44-list ds44-collapser_content--level2">
									<li>
										<%= itQuestRep.getAnswer(userLang) %>
									</li>
								</ul>
							</div>
						</li>
					</jalios:foreach>
				</ul>
				<jalios:if predicate='<%= obj.getLinkIndexedDataSet(FaqEntry.class).size() > obj.getNombreDeQuestionsAffichees() %>'>
					<button class="ds44-btnStd ds44-btnStd--large ds44-js-more-button" type="button" title='<%= glp("jcmsplugin.socle.faq.afficher-plus-questions") %>'>
						<span class="ds44-btnInnerText"><%= glp("jcmsplugin.socle.faq.plus-questions") %></span>
						<i class="icon icon-long-arrow-right" aria-hidden="true"></i>
					</button>
				</jalios:if>
			</div>
			<div class="col-2-small-1 txtcenter">
				<div class="ds44-separator ds44-flex-valign-center ds44-flex-align-center ds44-flex-container">
					<p class="ds44-txtBulle ds44-theme"><%= glp("jcmsplugin.socle.ou") %></p>
				</div>
			</div>
			<div class="col-4-small-1">
				<p class="h4-like" aria-level="2" role="heading"><%= glp("jcmsplugin.socle.faq.poser-question") %></p>
				<p class="ds44-textLegend ds44-textLegend--mentions"><%= glp("jcmsplugin.socle.facette.champs-obligatoires") %></p>
				<%
					String mail = channel.getProperty("jcmsplugin.socle.contact-faq.default-mail");
					
					//TODO ecraser mail s'il y a un mail de contact par defaut pour le service
					
					if(Util.notEmpty(obj.getEmailSpecifique())) {
						mail = obj.getEmailSpecifique();
					}
					
					if(Util.notEmpty(request.getAttribute("contactfaq"))) {
						mail = request.getAttribute("contactfaq").toString();
					}
				%>
				<form data-statistic='{"name": "declenche-evenement","category": "Formulaire","action": "Poser une question","label": "$commune|text"}'>
					<div class="ds44-form__container">
						<div class="ds44-posRel">
							<label for="form-element-10988" class="ds44-formLabel">
                                <span class="ds44-labelTypePlaceholder">
									<span class="ds44-labelTypePlaceholder">
										<%= glp("jcmsplugin.socle.faq.votre-question") %><sup aria-hidden="true">*</sup>
									</span>
								</span>
							</label>
							<textarea name="question" rows="5" cols="1" id="form-element-10988" class="ds44-inpStd" 
									title='<%= glp("jcmsplugin.socle.faq.votre-question") %> - <%= glp("jcmsplugin.socle.obligatoire") %>'
									required aria-required="true"></textarea>
						</div>
						<div class="ds44-errorMsg-container hidden" aria-live="polite"></div>
					</div>
					<div class="ds44-form__container">
						<div class="ds44-posRel">
							<label for="form-element-26867" class="ds44-formLabel">
                                <span class="ds44-labelTypePlaceholder">
								    <span class="ds44-labelTypePlaceholder"><%= glp("jcmsplugin.socle.pdcv.votrecommune") %></span>
                                </span>
							</label>
							<input type="text" id="form-element-77221" name="commune" class="ds44-inpStd" 
									role="combobox" 
									aria-autocomplete="list" 
									autocomplete="address-level2"
									aria-expanded="false" 
									title='<%= glp("jcmsplugin.socle.faq.selectionner-commune") %>' 
									data-url="/json/autocomplete-city.json" 
									data-mode="select-only" />
							<button class="ds44-reset" type="button">
								<i class="icon icon-cross icon--sizeL" aria-hidden="true"></i>
								<span class="visually-hidden">
									<%= glp("jcmsplugin.socle.facette.effacer-contenu-champ", glp("jcmsplugin.socle.pdcv.votrecommune")) %>
								</span>
							</button> 
							
							<div class="ds44-autocomp-container hidden">
								<div class="ds44-autocomp-list">
									<ul class="ds44-list" role="listbox"></ul>
								</div>
							</div>
						</div>
						<div class="ds44-errorMsg-container hidden" aria-live="polite"></div>
					</div>
					<div class="ds44-form__container">
						<div class="ds44-posRel">
							<label for="form-element-99423" class="ds44-formLabel">
                                <span class="ds44-labelTypePlaceholder">
									<span class="ds44-labelTypePlaceholder">
										<%= glp("jcmsplugin.socle.faq.votre-email") %><sup aria-hidden="true">*</sup>
									</span>
                                </span>
							</label>
							<input type="text" id="form-element-42259" name="form-element-42259" class="ds44-inpStd" 
									title='<%= glp("jcmsplugin.socle.faq.votre-email") %> - <%= glp("jcmsplugin.socle.obligatoire") %>' 
									required autocomplete="email"
									aria-describedby="explanation-form-element-42259" />
							<span class="ds44-labelTypeInfoComp" id="explanation-form-element-42259"><%= glp("jcmsplugin.socle.faq.ex-email") %></span>
							<button class="ds44-reset" type="button">
								<i class="icon icon-cross icon--sizeL" aria-hidden="true"></i>
								<span class="visually-hidden">
									<%= glp("jcmsplugin.socle.facette.effacer-contenu-champ", glp("jcmsplugin.socle.faq.votre-email")) %>
								</span>
							</button> 
						</div>
						<div class="ds44-errorMsg-container hidden" aria-live="polite"></div>
					</div>
					<button class="ds44-btnStd ds44-btn--invert" title='<%= HttpUtil.encodeForHTMLAttribute(glp("jcmsplugin.socle.faq.valider-envoie-question")) %>'>
						<span class="ds44-btnInnerText"><%= glp("jcmsplugin.socle.valider") %></span>
						<i class="icon icon-long-arrow-right" aria-hidden="true"></i>
					</button>
				</form>
			</div>
		</div>
	</div>
</section>
