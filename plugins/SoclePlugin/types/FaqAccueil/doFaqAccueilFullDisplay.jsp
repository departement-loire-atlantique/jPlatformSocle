<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file='/jcore/doInitPage.jspf' %>
<%@ include file='/jcore/portal/doPortletParams.jspf' %>
<% 
	FaqAccueil obj = (FaqAccueil) request.getAttribute(PortalManager.PORTAL_PUBLICATION); 
%>

<section class="ds44-container-fluid ds44--xxl-padding-tb">
	<header class="txtcenter ds44--xxl-padding-b">
		<h2 class="h2-like"><%= glp("jcmsplugin.socle.faq.vous-avez-question") %></h2>
	</header>
	<div class="ds44-inner-container ds44-flex-container ds44-flex-valign-center ds44-flex-align-center ds44--xl-padding-lr">
		<div class="grid-12-small-1">
			<div class="col-6-small-1">
				<p class="h4-like" aria-level="3" role="heading"><%= glp("jcmsplugin.socle.faq.consulter-question-frequente") %></p>
				<ul class="ds44-collapser ds44-mb-std ">
					<jalios:foreach name="itQuestRep" type="FaqEntry" collection="<%= obj.getLinkIndexedDataSet(FaqEntry.class) %>">
						<li class="ds44-collapser_element">
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
				<button class="ds44-btnStd ds44-btnStd--large" type="button" title="Afficher plus de questions">
					<span class="ds44-btnInnerText"><%= glp("jcmsplugin.socle.faq.plus-questions") %></span>
					<i class="icon icon-long-arrow-right" aria-hidden="true"></i>
				</button>
			</div>
			<div class="col-2-small-1 txtcenter ds44-h100">
				<div class="ds44-separator ds44-flex-valign-center ds44-flex-align-center ds44-flex-container">
					<p class="ds44-txtBulle ds44-theme"><%= glp("jcmsplugin.socle.ou") %></p>
				</div>
			</div>
			<div class="col-4-small-1">
				<p class="h4-like" aria-level="3" role="heading"><%= glp("jcmsplugin.socle.faq.poser-question") %></p>
				<p class="ds44-textLegend ds44-textLegend--mentions"><%= glp("jcmsplugin.socle.facette.champs-obligatoires") %></p>
				<%
					String mail = channel.getProperty("jcmsplugin.socle.contact-faq.default-mail");
					
					//TODO ecraser mail s'il y a un mail de contact par defaut pour le service
					
					if(Util.notEmpty(request.getParameter("contactfaq"))) {
						mail = request.getParameter("contactfaq");
					}
				%>
				<form>
					<div class="ds44-form__container">
						<label for="form-element-10988" class="ds44-formLabel">
							<span class="ds44-labelTypePlaceholder">
								<%= glp("jcmsplugin.socle.faq.votre-question") %><sup aria-hidden="true">*</sup>
							</span> 
							<textarea rows="5" cols="1" id="form-element-10988" class="ds44-inpStd" 
									title="Votre question - obligatoire"
									required aria-required="true"></textarea>
						</label>
					</div>
					<div class="ds44-form__container">
						<label for="form-element-26867" class="ds44-formLabel">
							<span class="ds44-labelTypePlaceholder"><%= glp("jcmsplugin.socle.pdcv.votrecommune") %></span> 
							<input type="text" id="form-element-26867" class="ds44-inpStd" title="Votre commune" />
							<button class="ds44-reset" type="button">
								<i class="icon icon-cross icon--large" aria-hidden="true"></i>
								<span class="visually-hidden">
									<%= glp("jcmsplugin.socle.facette.effacer-contenu-champ", glp("jcmsplugin.socle.pdcv.votrecommune")) %>
								</span>
							</button> 
						</label>
					</div>
					<div class="ds44-form__container">
						<label for="form-element-99423" class="ds44-formLabel">
							<span class="ds44-labelTypePlaceholder">
								<%= glp("jcmsplugin.socle.faq.votre-email") %><sup aria-hidden="true">*</sup>
							</span>
							<input type="text" id="form-element-99423" class="ds44-inpStd" title="Votre email - obligatoire" required aria-required="true" /> 
							<span class="ds44-labelTypeInfoComp"><%= glp("jcmsplugin.socle.faq.ex-email") %></span>
							<button class="ds44-reset" type="button">
								<i class="icon icon-cross icon--large" aria-hidden="true"></i>
								<span class="visually-hidden">
									<%= glp("jcmsplugin.socle.facette.effacer-contenu-champ", glp("jcmsplugin.socle.faq.votre-email")) %>
								</span>
							</button> 
						</label>
					</div>
					<button class="ds44-btnStd ds44-btn--invert" title="Valider l'envoi de votre question">
						<span class="ds44-btnInnerText"><%= glp("jcmsplugin.socle.valider") %></span>
						<i class="icon icon-long-arrow-right" aria-hidden="true"></i>
					</button>
				</form>
			</div>
		</div>
	</div>
</section>
