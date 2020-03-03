<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file='/jcore/doInitPage.jspf' %>
<%@ include file='/jcore/portal/doPortletParams.jspf' %>
<% 
	PortletFacetteMotcle obj = (PortletFacetteMotcle)portlet; 

	String idFormElement = ServletUtil.generateUniqueDOMId(request, glp("jcmsplugin.socle.facette.form-element"));

	String styleChamps = Util.notEmpty(request.getAttribute("showFiltres")) && (Boolean)request.getAttribute("showFiltres") ? "Std" : "Large"; 
	String styleChamps2 = styleChamps.equalsIgnoreCase("large") ? "Large" : "";
%>

<div class="ds44-form__container">
	<label for='<%= idFormElement %>' class="ds44-formLabel">
		<span class='<%= "ds44-labelTypePlaceholder" + styleChamps2 %>'>
			<%= Util.notEmpty(obj.getLabel()) ? obj.getLabel() : "Mot clé"%><%= obj.getFacetteObligatoire() ? "<sup aria-hidden=\"true\">*</sup>" : "" %>
		</span>
		<input type="text" id='<%= idFormElement %>' class='<%= "ds44-inp" + styleChamps %>' 
				<%= obj.getFacetteObligatoire() ? "required aria-required=\"true\"" : ""%> />
		
		<button class="ds44-reset" type="button">
			<i class="icon icon-cross icon--large" aria-hidden="true"></i>
			<span class="visually-hidden"><%= glp("jcmsplugin.socle.facette.effacer-contenu") %></span>
		</button> 
	</label>
</div>