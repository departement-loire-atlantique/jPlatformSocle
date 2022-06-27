<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file='/jcore/doInitPage.jspf' %>
<%@ include file='/jcore/portal/doPortletParams.jspf' %>
<%@ include file='/plugins/SoclePlugin/jsp/facettes/commonParamsFacettes.jspf' %>
<%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%>
<%
	PortletFacetteBooleen obj = (PortletFacetteBooleen) portlet;

	String rechercheId = (String) request.getAttribute("rechercheId");
  
    String idFormElement = glp("jcmsplugin.socle.facette.form-element") + "-" + rechercheId + obj.getId();
%>


<div class="ds44-form__container">

	<div id="<%= "boolean" + idFormElement %>" data-name="<%= "boolean" + idFormElement %>"  class="ds44-form__checkbox_container ds44-form__container inbl" >           
		<div class="ds44-form__container ds44-checkBox-radio_list inbl">
		    <input data-auto-submit="true" type="checkbox" id="name-check-form-element-<%= obj.getId() %>" name='<%= "boolean" + idFormElement %>' value="<%= obj.getNomTechniqueDuBooleen() %>" class="ds44-checkbox" data-technical-field /><label for="name-check-form-element-<%= obj.getId() %>" class="ds44-boxLabel" id="name-check-label-form-element-<%= obj.getId() %>"><%= obj.getLabel(userLang) %></label>	    	
		</div>    
	</div>
</div>

<input type="hidden" name='<%= "inverse_" + obj.getNomTechniqueDuBooleen() + idFormElement %>' value='<%= obj.getInverseResultat() %>' data-technical-field />