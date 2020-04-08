<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file='/jcore/doInitPage.jspf' %>
<%@ include file='/jcore/portal/doPortletParams.jspf' %>
<%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%>
<%@ page import="fr.cg44.plugin.socle.SocleUtils"%>
<% 
	PortletFacetteCategoriesLiees obj = (PortletFacetteCategoriesLiees)portlet; 

	String idFormElement = ServletUtil.generateUniqueDOMId(request, glp("jcmsplugin.socle.facette.form-element"));

	String styleChamps = Util.notEmpty(request.getAttribute("showFiltres")) && (Boolean) request.getAttribute("showFiltres") ? "Std" : "Large";
	String styleChamps2 = styleChamps.equalsIgnoreCase("large") ? "XL" : "L";
	
	String labelChamp = Util.notEmpty(obj.getLabel()) ? obj.getLabel() : obj.getCategoriePrincipales(loggedMember).first().getName();
%>
<form>
	<div class="ds44-fieldContainer ds44-champsLies">
		
		<div class="ds44-form__container">
			<div class='<%= "ds44-select__shape ds44-inp" + styleChamps %>'>
				<p class="ds44-selectLabel" aria-hidden="true">
					<%= labelChamp %>
					<%= obj.getFacetteObligatoire() ? "<sup aria-hidden=\"true\">*</sup>" : "" %>
				</p>
				<div id='<%= idFormElement %>' name='<%= idFormElement %>' class="ds44-js-select-standard ds44-selectDisplay" 
						<%= obj.getFacetteObligatoire() ? "data-required=\"true\"" : ""%>>
				</div>
				<button class="ds44-reset" type="button">
					<i class='icon icon-cross icon--size<%= styleChamps2 %>' aria-hidden="true"></i>
					<span class="visually-hidden"><%= glp("jcmsplugin.socle.facette.effacer-contenu-champ", labelChamp) %></span>
				</button>

				<button type="button" class="ds44-btnIco ds44-posAbs ds44-posRi ds44-btnOpen" 
						aria-expanded="false" 
						title='<%= labelChamp + " - " + glp("jcmsplugin.socle.obligatoire") %>'
						aria-required="true">
					<i class='icon icon-down icon--size<%= styleChamps2 %>' aria-hidden="true"></i>
					<span id='<%= "button-message-" + idFormElement %>' class="visually-hidden"><%= labelChamp %></span>
				</button>
			</div>

			<div class="ds44-select-container hidden">
				<div class="ds44-listSelect">
					<ul class="ds44-list" role="listbox" id='<%= "listbox-" + idFormElement %>' 
							aria-labelledby='<%= "button-message-" + idFormElement %>' 
							aria-required="true">
						<jalios:foreach name="itRootCat" type="Category" collection='<%= obj.getCategoriePrincipales(loggedMember) %>'>
							<jalios:foreach name="itCat" type="Category" collection='<%= SocleUtils.getOrderedAuthorizedChildrenSet(itRootCat) %>'>
								<li class="ds44-select-list_elem" role="option" data-value='<%= itCat.getId() %>' tabindex="0">
									<%= itCat.getName() %>
								</li>
							</jalios:foreach>
						</jalios:foreach>
					</ul>
				</div>
			</div>
		</div>
		<ds:facetteCategorie obj='<%= obj.getCategorieSecondaire() %>' 
				dataURL="plugins/SoclePlugin/jsp/facettes/searchCategoriesLiees.jsp" 
				idFormElement='<%= idFormElement+"-2" %>' 
				isDisabled='<%= true %>' 
				userLang='<%= userLang %>' 
				loggedMember='<%= loggedMember %>' 
				request='<%= request %>'/>
	</div>
</form>
