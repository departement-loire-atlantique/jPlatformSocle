<%@ page import="fr.cg44.plugin.socle.SocleUtils" %>
<%@ page contentType="text/html; charset=UTF-8" %>


	
		<div class="grid-12-small-1">
			<% 
				Boolean showContact = obj.getAvecFormulaireDeContact() || Util.notEmpty(obj.getTexteContact(userLang)); 
				int largeurDiv = showContact ? 6 : 12;
			%>
			<div class="col-<%= largeurDiv %>-small-1">
				<h3 class="h4-like"><%= Util.notEmpty(obj.getSoustitre(userLang)) ? obj.getSoustitre(userLang) : glp("jcmsplugin.socle.faq.consulter-question-frequente") %></h3>
				<ul class="ds44-collapser ds44-mb-std ">
				    <%-- Afficher les entrées dans l'ordre --%>
				    <%
					boolean isPreview = getBooleanParameter("preview", false);
					DataSelector authorizedSelector = new Publication.AuthorizedSelector(loggedMember);
					DataSelector selector = isPreview ? authorizedSelector : new AndDataSelector(authorizedSelector, new Publication.VisibleStateSelector());
					%>
					<jalios:query name="entrySet"
					dataset="<%= obj.getLinkIndexedDataSet(FaqEntry.class) %>"
					comparator="<%=  new custom.CustomEditFaqEntryHandler.OrderComparator() %>"
					selector="<%= selector %>"/>
					
					<jalios:foreach name="itQuestRep" type="FaqEntry" collection='<%= entrySet %>' counter='nbrQuestRep'>
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
			<jalios:if predicate='<%= showContact %>'>
				<div class="col-2-small-1 txtcenter">
					<div class="ds44-separator ds44-flex-valign-center ds44-flex-align-center ds44-flex-container">
						<p class="ds44-txtBulle ds44-theme"><%= glp("jcmsplugin.socle.ou") %></p>
					</div>
				</div>
				<div class="col-4-small-1">
					<jalios:if predicate='<%= obj.getAvecFormulaireDeContact() %>'>
						<%-- Inclusion du formulaire --%>
						<%@ include file='doFaqForm.jspf' %>
					</jalios:if>
					<jalios:if predicate='<%= ! obj.getAvecFormulaireDeContact() && Util.notEmpty(obj.getTexteContact(userLang)) %>'>
						<jalios:wysiwyg><%= obj.getTexteContact(userLang) %></jalios:wysiwyg>
					</jalios:if>
				</div>
			</jalios:if>
		</div>
		
		<%--  Ajout de données structurées json pour SEO. Elles seront affichées dans le <head>
		      via une target pointant sur addFaqStructuredData.jsp --%>
		<jalios:if predicate='<%= Util.notEmpty(entrySet) %>'>
		  <% request.setAttribute("jsonFaq", SocleUtils.faqToJson(entrySet, userLang)); %>
		</jalios:if>


