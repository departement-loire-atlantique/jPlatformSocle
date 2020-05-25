<%@ taglib prefix="ds" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="jcms.tld" prefix="jalios" %>
<%@ tag 
	pageEncoding="UTF-8"
	description="Facette catégorie sans container" 
	body-content="scriptless" 
	import="com.jalios.jcms.Channel, 
			com.jalios.util.Util,
			com.jalios.jcms.JcmsUtil, 
			com.jalios.jcms.Category" 
%>
<%@ attribute name="cat" 
		required="true" 
		fragment="false" 
		rtexprvalue="true" 
		type="Category" 
		description="Categorie de la liste à afficher" 
%>
<%@ attribute name="typeDeSelection" 
		required="true" 
		fragment="false" 
		rtexprvalue="true" 
		type="Boolean" 
		description="true = C'est une checkbox ; false = C'est un bouton radio" 
%>
<%@ attribute name="numCat" 
		required="true" 
		fragment="false" 
		rtexprvalue="true" 
		type="Integer" 
		description="Numéro de position de la catégorie dans la liste" 
%>
<%@ attribute name="idFormElement" 
		required="true" 
		fragment="false" 
		rtexprvalue="true" 
		type="String" 
		description="id de l'input" 
%>
<%
	String userLang = Channel.getChannel().getCurrentJcmsContext().getUserLang();

	String nameType = typeDeSelection ? "name-check-" : "name-radio-";
	String typeInput = typeDeSelection ? "checkbox" : "radio";
	String labelInput = typeDeSelection ? "box" : "radio";
	
	String nameInput = idFormElement + "-" + numCat;
	String idInput = nameType + nameInput;
%>

<div class="ds44-form__container ds44-checkBox-radio_list ">
	<input type='<%= typeInput %>' 
			id='<%= idInput %>' 
			name="<%= nameInput %>" 
			value='<%= cat.getId() %>' 
			class='<%= "ds44-"+typeInput %>' 
			aria-disabled="true"/>

	<label for='<%= idInput %>' 
			class='<%= "ds44-" + labelInput + "Label" %>'
			id="<%= nameType + "-label-" + nameInput %>">

		<%= cat.getName() %>

		<jalios:if predicate='<%= Boolean.parseBoolean(cat.getExtraData("extra.Category.plugin.tools.tooltip")) %>'>
			<button type="button" class="js-simple-tooltip button" data-simpletooltip-content-id='<%= "tooltip-"+cat.getId() %>'>
				<i class="icon icon-help" aria-hidden="true"></i>
				<span class="visually-hidden"><%= JcmsUtil.glp(userLang, "jcmsplugin.socle.tooltip", cat.getName()) %></span>
			</button>
			<p id='<%= "tooltip-"+cat.getId() %>' class="hidden">
				<%= cat.getDescription(userLang) %>
			</p>
		</jalios:if>
	</label>
</div>
