<%@ page contentType="text/html; charset=UTF-8" %>


	
		<div class="grid-12-small-1">
			<div class="col-6-small-1">
				<h3 class="h4-like"><%= Util.notEmpty(obj.getSoustitre(userLang)) ? obj.getSoustitre(userLang) : glp("jcmsplugin.socle.faq.consulter-question-frequente") %></h3>
				<ul class="ds44-collapser ds44-mb-std ">
					<jalios:foreach name="itQuestRep" type="FaqEntry" collection='<%= obj.getLinkIndexedDataSet(FaqEntry.class) %>' counter='nbrQuestRep'>
						<li class='ds44-collapser_element <%= nbrQuestRep > obj.getNombreDeQuestionsAffichees() ? "hidden" : "" %>'>
							<p role="heading" aria-level="3">
								<button type="button" class="ds44-collapser_button">
									<%= itQuestRep.getTitle(userLang) %>
									<i class="icon icon-down" aria-hidden="true"></i>
								</button>
							</p>
							<div class="ds44-collapser_content">
								<ul class="ds44-list ds44-collapser_content--level2">
									<li>
										<jalios:wysiwyg><%= itQuestRep.getAnswer(userLang) %></jalios:wysiwyg>
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
                <%-- Inclusion du formulaire --%>
                <%@ include file='doFaqForm.jspf' %>
			</div>
		</div>


