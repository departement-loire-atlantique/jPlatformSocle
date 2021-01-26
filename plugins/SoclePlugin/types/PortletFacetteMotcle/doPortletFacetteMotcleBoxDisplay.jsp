<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file='/jcore/doInitPage.jspf' %>
<%@ include file='/jcore/portal/doPortletParams.jspf' %>
<%@ include file='/plugins/SoclePlugin/jsp/facettes/commonParamsFacettes.jspf' %>
<% 
	PortletFacetteMotcle obj = (PortletFacetteMotcle)portlet; 

    String rechercheId = (String) request.getAttribute("rechercheId");
    String idFormElement = ServletUtil.generateUniqueDOMId(request, glp("jcmsplugin.socle.facette.form-element"));

	String styleChamps = isInRechercheFacette || (Util.notEmpty(request.getAttribute("showFiltres")) && (Boolean)request.getAttribute("showFiltres")) ? "Std" : "Large"; 
	String styleChamps2 = styleChamps.equalsIgnoreCase("large") ? "Large" : "";
	String styleChamps3 = styleChamps.equalsIgnoreCase("large") ? "large" : "sizeL";
	
	String labelChamp = Util.notEmpty(obj.getLabel(userLang, false)) ? obj.getLabel(userLang, false) : glp("jcmsplugin.socle.facette.mot-cle.default-label");
	String name = "text" + glp("jcmsplugin.socle.facette.form-element") + "-" + rechercheId + obj.getId();
%>

<div class="ds44-form__container">
	<div class="ds44-posRel">
		<label id="label-<%= idFormElement %>" for='<%= idFormElement %>' class="ds44-formLabel">
			<span class='<%= "ds44-labelTypePlaceholder ds44-labelTypePlaceholder" + styleChamps2 %>'>
				<span>
					<%= labelChamp %><%= obj.getFacetteObligatoire() ? "<sup aria-hidden=\"true\">*</sup>" : "" %>
				</span>
			</span>
		</label>
		<input name='<%= name %>' type="text" id='<%= idFormElement %>' class='<%= "ds44-inp" + styleChamps %>' 
				title='<%= obj.getFacetteObligatoire() ? glp("jcmsplugin.socle.facette.champ-obligatoire.title", labelChamp) : labelChamp %>'
				<%= obj.getFacetteObligatoire() ? "required aria-required=\"true\"" : ""%> 
				<%= (Boolean)(request.getAttribute("isFilter")) ? "data-auto-submit=\"true\"" : "" %>/>
		
		<button class="ds44-reset" type="button" aria-describedby="label-<%= idFormElement %>">
			<i class="icon icon-cross icon--<%= styleChamps3 %>" aria-hidden="true"></i>
			<span class="visually-hidden"><%= glp("jcmsplugin.socle.facette.effacer-contenu-champ", labelChamp) %></span>
		</button> 
	</div>
</div>