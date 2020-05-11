<%@ taglib prefix="ds" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="jcms.tld" prefix="jalios" %>
<%@ tag 
	pageEncoding="UTF-8"
	description="Facette catégorie sans container" 
	body-content="scriptless" 
	import="com.jalios.jcms.Channel, 
			com.jalios.util.Util,
			com.jalios.jcms.JcmsUtil, 
			generated.PortletFacetteCategorie, 
			javax.servlet.http.HttpServletRequest, 
			com.jalios.jcms.Member, 
			com.jalios.jcms.Category, 
			java.util.Set, 
			fr.cg44.plugin.socle.SocleUtils" 
%>
<%@ attribute name="obj" 
		required="true" 
		fragment="false" 
		rtexprvalue="true" 
		type="PortletFacetteCategorie" 
		description="La facette categorie" 
%>
<%@ attribute name="listeCategory" 
		required="false" 
		fragment="false" 
		rtexprvalue="true" 
		type="Set<Category>" 
		description="La liste des categories selectionnables" 
%>
<%@ attribute name="dataURL" 
		required="false" 
		fragment="false" 
		rtexprvalue="true" 
		type="String" 
		description="URL a appeler pour remplir les valeurs cochables du champ" 
%>
<%@ attribute name="idFormElement" 
		required="true" 
		fragment="false" 
		rtexprvalue="true" 
		type="String" 
		description="L'ID de l'input" 
%>
<%@ attribute name="isDisabled" 
		required="true" 
		fragment="false" 
		rtexprvalue="true" 
		type="Boolean" 
		description="Est-ce que le champ est désactivé par défaut" 
%>
<%@ attribute name="request" 
		required="true" 
		fragment="false" 
		rtexprvalue="true" 
		type="HttpServletRequest" 
		description="La requete http actuelle" 
%>
<%
	Member loggedMember = Channel.getChannel().getCurrentJcmsContext().getLoggedMember();
	String userLang = Channel.getChannel().getCurrentJcmsContext().getUserLang();

	String styleChamps = Util.notEmpty(request.getAttribute("showFiltres")) && (Boolean) request.getAttribute("showFiltres") ? "Std" : "Large";
	String styleChamps2 = styleChamps.equalsIgnoreCase("large") ? "XL" : "L";
	
	String labelChamp = obj.getCategoriesRacines(loggedMember).first().getName();
	labelChamp = Util.notEmpty(dataURL) ? JcmsUtil.glp(userLang, "jcmsplugin.socle.facette.cat-lie.sous-theme.label") : labelChamp;
	labelChamp = Util.notEmpty(obj.getLabel()) ? obj.getLabel() : labelChamp;
	String classInputDisabled = isDisabled ? " ds44-inputDisabled" : "";
%>
<div class="ds44-form__container">
	<div class='<%= "ds44-select__shape ds44-inp" + styleChamps + classInputDisabled %>'>
		<p class="ds44-selectLabel" aria-hidden="true">
			<%= labelChamp %>
			<%= obj.getFacetteObligatoire() ? "<sup aria-hidden=\"true\">*</sup>" : "" %>
		</p>
		
		<% 
			String classTypeInput = obj.getTypeDeSelection() ? "ds44-js-select-checkbox" : "ds44-js-select-radio"; 
			classTypeInput = Util.isEmpty(dataURL) && !obj.getProfondeur() ? "ds44-js-select-multilevel" : classTypeInput; 
		%>
		<div id='<%= idFormElement %>' data-name='<%= "cids" + idFormElement %>' class='<%= classTypeInput + " ds44-selectDisplay" %>' 
				<%= Util.notEmpty(dataURL) ? "data-url=\"" + dataURL + "\"" : "" %> 
				<%= obj.getFacetteObligatoire() ? "data-required=\"true\"" : ""%>
				<%= isDisabled ? "data-disabled=\"true\"" : "" %>
				<%= (Boolean)(request.getAttribute("isFilter")) ? "data-auto-submit=\"true\"" : "" %>></div>

		<button class="ds44-reset" type="button">
			<i class='icon icon-cross icon--size<%= styleChamps2 %>' aria-hidden="true"></i>
			<span class="visually-hidden"><%= JcmsUtil.glp(userLang, "jcmsplugin.socle.facette.effacer-contenu-champ", labelChamp) %></span>
		</button>
		<button type="button" class="ds44-btnIco ds44-posAbs ds44-posRi ds44-btnOpen" 
				title='<%= labelChamp + " - " + JcmsUtil.glp(userLang, "jcmsplugin.socle.obligatoire") %>' 
				aria-expanded="false" 
				<%= isDisabled ? "data-disabled=\"true\"" : "" %>>
			<i class='<%= "icon icon-down icon--size" + styleChamps2 %>' aria-hidden="true"></i>
			<span id='<%= "button-message-" + idFormElement %>' class="visually-hidden"><%= labelChamp %></span>
		</button>
	</div>

	<div class="ds44-select-container hidden">
		<jalios:if predicate='<%= obj.getTypeDeSelection() %>'>
			<div class="ds44-flex-container ds44--m-padding">
				<button class="ds44-btnStd ds44-bgGray ds44-btnStd--plat ds44-fg1" type="button" 
						aria-describedby='<%= "button-message-" + idFormElement %>'>
					<span class="ds44-btnInnerText"><%= JcmsUtil.glp(userLang, "jcmsplugin.socle.tout-cocher") %></span>
					<i class="icon icon-check icon--medium" aria-hidden="true"></i>
				</button>
				<button class="ds44-btnStd ds44-bgGray ds44-btnStd--plat ds44-fg1 ds44-border-left--light" type="button"
					aria-describedby="button-message-form-element-47425">
					<span class="ds44-btnInnerText"><%= JcmsUtil.glp(userLang, "jcmsplugin.socle.tout-decocher") %></span>
					<i class="icon icon-cross icon--medium" aria-hidden="true"></i>
				</button>
			</div>
		</jalios:if>
		<% int nbrTotalCat = 0; %>
		<jalios:if predicate='<%= Util.notEmpty(dataURL) || obj.getProfondeur() %>'>
			<div class="ds44-listSelect">
				<ul class="ds44-list" id='<%= "listbox-" + idFormElement %>'>
					<jalios:foreach name="itRootCat" type="Category" collection='<%= listeCategory %>'>
						<jalios:foreach name="itCat" type="Category" collection='<%= SocleUtils.getOrderedAuthorizedChildrenSet(itRootCat) %>'>
							<% nbrTotalCat++; %>
							<li class="ds44-select-list_elem">
								
								<ds:facetteCategorieListElem cat='<%= itCat %>' 
									idFormElement='<%= idFormElement %>' 
									typeDeSelection='<%= obj.getTypeDeSelection() %>' 
									numCat='<%= nbrTotalCat %>'/>
							</li>
						</jalios:foreach>
					</jalios:foreach>
				</ul>
			</div>
		</jalios:if>
		<jalios:if predicate='<%= Util.isEmpty(dataURL) && !obj.getProfondeur() %>'>
			<ul class="ds44-collapser ds44-listSelect">
				<jalios:foreach name="itRootCat" type="Category" collection='<%= listeCategory %>'>
					<jalios:foreach name="itCat" type="Category" collection='<%= SocleUtils.getOrderedAuthorizedChildrenSet(itRootCat) %>'>
						<% nbrTotalCat++; %>
						<li class="ds44-collapser_element ds44-collapser--select">
							<div class="ds44-select__categ">
								<ds:facetteCategorieListElem cat='<%= itCat %>' 
										idFormElement='<%= idFormElement %>' 
										typeDeSelection='<%= obj.getTypeDeSelection() %>' 
										numCat='<%= nbrTotalCat %>'/>

							</div>
							<jalios:if predicate='<%= Util.notEmpty(itCat.getChildrenSet()) %>'>
								<button type="button" class="ds44-collapser_button ds44-collapser_button--select" 
										aria-describedby='<%= "name-check-label-" + idFormElement + "-" + nbrTotalCat %>'>
									<span class="visually-hidden"><%= JcmsUtil.glp(userLang, "jcmsplugin.socle.deplier") %></span>
									<i class="icon icon-down ds44-noLineH" aria-hidden="true"></i>
								</button>
								<div class="ds44-collapser_content">
									<ul class="ds44-list ds44-collapser_content--level2">
										<jalios:foreach name="itSubCat" type="Category" collection='<%= SocleUtils.getOrderedAuthorizedChildrenSet(itCat) %>' counter="itSubCatCounter">
											<li class="ds44-select-list_elem">
												<ds:facetteCategorieListElem cat='<%= itSubCat %>' 
														idFormElement='<%= idFormElement + "-" + nbrTotalCat %>' 
														typeDeSelection='<%= obj.getTypeDeSelection() %>' 
														numCat='<%= itSubCatCounter %>'/>
											</li>
										</jalios:foreach>
									</ul>
								</div>
							</jalios:if>
						</li>
					</jalios:foreach>
				</jalios:foreach>
			</ul>
		</jalios:if>
		<button type="button" class="ds44-fullWBtn ds44-btnSelect ds44-theme" aria-describedby='<%= "button-message-" + idFormElement %>'
				title='<%= JcmsUtil.glp(userLang, "jcmsplugin.socle.facette.cat-lie.valider-selection.label", labelChamp) %>'>
			<span class="ds44-btnInnerText" aria-hidden="true"><%= JcmsUtil.glp(userLang, "jcmsplugin.socle.valider") %></span>
			<i class="icon icon-long-arrow-right ds44-noLineH" aria-hidden="true"></i>
		</button>
	</div>
	<div class="ds44-errorMsg-container hidden" aria-live="polite"></div>
</div>