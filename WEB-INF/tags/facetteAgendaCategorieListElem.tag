<%@ taglib prefix="ds" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="jcms.tld" prefix="jalios" %>
<%@ tag 
	pageEncoding="UTF-8"
	description="Facette catégorie sans container" 
	body-content="scriptless" 
	import="com.jalios.jcms.Channel, 
			com.jalios.util.Util,
			com.jalios.jcms.JcmsUtil, 
			fr.cg44.plugin.socle.infolocale.entities.Genre" 
%>
<%@ attribute name="genre" 
		required="true" 
		fragment="false" 
		rtexprvalue="true" 
		type="Genre" 
		description="Genre de la liste à afficher" 
%>
<%@ attribute name="typeDeSelection" 
		required="true" 
		fragment="false" 
		rtexprvalue="true" 
		type="Boolean" 
		description="true = C'est une checkbox ; false = C'est un bouton radio" 
%>
<%@ attribute name="numGenre" 
		required="true" 
		fragment="false" 
		rtexprvalue="true" 
		type="Integer" 
		description="Numéro de position du genre dans la liste" 
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
	
	String sbfNameCheck = nameType + idFormElement + "-" + numGenre;
%>

<div class="ds44-form__container ds44-checkBox-radio_list ">
	<input value='<%= genre.getGenreId() %>' 
			id='<%= sbfNameCheck %>' 
			class='<%= "ds44-"+typeInput %>' 
			type='<%= typeInput %>' />

	<label for='<%= sbfNameCheck %>' class='<%= "ds44-" + labelInput + "Label" %>'>
		<%= genre.getLibelle() %>
	</label>
</div>
