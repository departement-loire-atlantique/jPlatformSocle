<%@page import="fr.cg44.plugin.socle.infolocale.util.InfolocaleUtil"%>
<%@page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file='/jcore/doInitPage.jspf' %>
<%@ include file='/jcore/portal/doPortletParams.jspf' %>
<%@ include file='/plugins/SoclePlugin/jsp/facettes/commonParamsFacettes.jspf' %>
<%@ taglib prefix="ds" tagdir="/WEB-INF/tags" %>
<% PortletFacetteAgendaDate obj = (PortletFacetteAgendaDate)portlet; %>

<% 
String uid = ServletUtil.generateUniqueDOMId(request, glp("jcmsplugin.socle.facette.form-element")); 
LinkedHashMap<String, String> datesLabelValues = new LinkedHashMap<>();
datesLabelValues.put(glp("jcmsplugin.socle.facette.date.select.today.label"), InfolocaleUtil.getDateTodayInfolocale());
datesLabelValues.put(glp("jcmsplugin.socle.facette.date.select.tomorrow.label"), InfolocaleUtil.getDateTomorrowInfolocale());
datesLabelValues.put(glp("jcmsplugin.socle.facette.date.select.weekend.label"), String.join(",", InfolocaleUtil.getDateWeekendInfolocale()));
datesLabelValues.put(glp("jcmsplugin.socle.facette.date.select.nextseven.label"), String.join(",", InfolocaleUtil.getDateNextSevenDaysInfolocale()));
String title = Util.getString(obj.getLabel(), glp("jcmsplugin.socle.facette.date.select.title"));
boolean isRequired = obj.getFacetteObligatoire();
%>

<div class="ds44-form__container">
   <div class='ds44-select__shape <%= isInRechercheFacette ? "ds44-inpStd" : "ds44-inpLarge" %>'>
      <p id="label-<%= uid %>" class="ds44-selectLabel" aria-hidden="true"><%= title %><sup aria-hidden="true"><%= isRequired ? glp("jcmsplugin.socle.facette.asterisque") : "" %></sup></p>
      <div id="<%= uid %>" data-name="agenda-date" class="ds44-js-select-radio ds44-selectDisplay"  data-required="<%= isRequired %>"></div>
      <button class="ds44-reset" type="button" aria-describedby="label-<%= uid %>"><i class="icon icon-cross icon--sizeL" aria-hidden="true"></i><span class="visually-hidden"><%= glp("jcmsplugin.socle.facette.effacer-contenu-champ", title) %></span></button>
      <button type="button" id="button-<%= uid %>" class="ds44-btnIco ds44-posAbs ds44-posRi ds44-btnOpen" aria-expanded="false" title='<%= isRequired ? glp("jcmsplugin.socle.facette.champ-obligatoire.title", title) : title %>'><i class="icon icon-down icon--sizeL" aria-hidden="true"></i><span id="button-message-<%= uid %>" class="visually-hidden"><%= title %></span></button>
   </div>
   
   <div class="ds44-select-container hidden">
        <div class="ds44-listSelect">
            <ul class="ds44-list" id="listbox-<%= uid %>">
                <jalios:foreach name="itDateLabel" type="String" collection="<%= datesLabelValues.keySet() %>">
	                <li class="ds44-select-list_elem">
		               <div class="ds44-form__container ds44-checkBox-radio_list">
		                  <% 
		                  String uidFormElem = ServletUtil.generateUniqueDOMId(request, glp("jcmsplugin.socle.facette.form-element"));
		                  %>
		                  <input type="radio" name="form-element-<%= uid %>" value="<%= datesLabelValues.get(itDateLabel) %>" id="name-radio-<%= uidFormElem %>-<%= itCounter %>" class="ds44-radio" /><label id="label-radio-<%= uidFormElem %>-<%= itCounter %>" for="name-radio-<%= uidFormElem %>-<%= itCounter %>" class="ds44-radioLabel"><%= itDateLabel %></label>
		               </div>
		            </li>
	            </jalios:foreach>
	            <li class="ds44-select-list_elem">
	               <%-- Sélecteur de plage de dates --%>
	               <% 
	                  String uidFormElem = ServletUtil.generateUniqueDOMId(request, glp("jcmsplugin.socle.facette.form-element"));
	                      
	                  String uidFormElemDateDebut = ServletUtil.generateUniqueDOMId(request, glp("jcmsplugin.socle.facette.form-element"));
	                  
	                  String uidFormElemDateFin = ServletUtil.generateUniqueDOMId(request, glp("jcmsplugin.socle.facette.form-element"));
	                  
	                  int indexCheckbox = datesLabelValues.size() + 1;
	               %>
	               <div class="ds44-form__container ds44-checkBox-radio_list ">
	                   <input type="radio" name="form-element-<%= uid %>" value="<%= indexCheckbox %>" id="name-radio-form-element-<%= uidFormElem %>-<%= indexCheckbox %>" class="ds44-radio"><label id="label-radio-form-element-<%= uidFormElem %>-<%= indexCheckbox %>" for="name-radio-form-element-<%= uidFormElem %>-<%= indexCheckbox %>" class="ds44-radioLabel"><%= glp("jcmsplugin.socle.facette.date.select.example.custom") %></label>
	               </div>
	               <div class="ds44-select-list_elem_child hidden">
			         <div class="ds44-form__container">
			            <div class="ds44-posRel">
			               <label for="form-element-<%= uidFormElemDateDebut %>" class="ds44-formLabel ds44-datepicker"><span class="ds44-labelTypePlaceholder"><span><%= glp("jcmsplugin.socle.facette.date.select.du.label") %><sup aria-hidden="true"><%= isRequired ? glp("jcmsplugin.socle.facette.asterisque") : "" %></sup></span></span></label>
			               <input class="ds44-input-value" type="hidden">
			               <div data-name="form-element-<%= uidFormElemDateDebut %>" class="ds44-datepicker__shape ds44-inpStd" data-past-dates="false" data-required="<%= isRequired %>">
			                 <input id="form-element-<%= uidFormElemDateDebut %>" type="text" inputmode="numeric" pattern="[0-9]*" maxlength="2" title='<%= isRequired ? glp("jcmsplugin.socle.facette.champ-obligatoire.title", glp("jcmsplugin.socle.facette.date.exemple.jour", glp("jcmsplugin.socle.facette.date.select.du.label"))) : glp("jcmsplugin.socle.facette.date.exemple.jour", glp("jcmsplugin.socle.facette.date.select.du.label")) %>' data-is-date="true" required="" aria-describedby="explanation-form-element-<%= uidFormElemDateDebut %> label-radio-form-element-<%= uidFormElem %>-<%= indexCheckbox %> button-message-form-element-<%= uid %>" data-bkp-aria-describedby="explanation-form-element-<%= uidFormElemDateDebut %> label-radio-form-element-<%= uidFormElem %>-<%= indexCheckbox %> button-message-form-element-<%= uid %>"><span>/</span><input type="text" inputmode="numeric" pattern="[0-9]*" maxlength="2" title='<%= isRequired ? glp("jcmsplugin.socle.facette.champ-obligatoire.title", glp("jcmsplugin.socle.facette.date.exemple.mois", glp("jcmsplugin.socle.facette.date.select.du.label"))) : glp("jcmsplugin.socle.facette.date.exemple.mois", glp("jcmsplugin.socle.facette.date.select.du.label")) %>' data-is-date="true" required="" aria-describedby="explanation-form-element-<%= uidFormElemDateDebut %> label-radio-form-element-<%= uidFormElem %>-<%= indexCheckbox %> button-message-form-element-<%= uid %>" data-bkp-aria-describedby="explanation-form-element-<%= uidFormElemDateDebut %> label-radio-form-element-<%= uidFormElem %>-<%= indexCheckbox %> button-message-form-element-<%= uid %>"><span>/</span><input type="text" inputmode="numeric" pattern="[0-9]*" maxlength="4" title='<%= isRequired ? glp("jcmsplugin.socle.facette.champ-obligatoire.title", glp("jcmsplugin.socle.facette.date.exemple.annee", glp("jcmsplugin.socle.facette.date.select.du.label"))) : glp("jcmsplugin.socle.facette.date.exemple.annee", glp("jcmsplugin.socle.facette.date.select.du.label")) %>' data-is-date="true" required="" aria-describedby="explanation-form-element-<%= uidFormElemDateDebut %> label-radio-form-element-<%= uidFormElem %>-<%= indexCheckbox %> button-message-form-element-<%= uid %>" data-bkp-aria-describedby="explanation-form-element-<%= uidFormElemDateDebut %> label-radio-form-element-<%= uidFormElem %>-<%= indexCheckbox %> button-message-form-element-<%= uid %>">
			               </div>
			               <button class="ds44-reset" type="button"><i class="icon icon-cross icon--sizeL" aria-hidden="true"></i><span class="visually-hidden"><%= glp("jcmsplugin.socle.facette.effacer-contenu-champ", glp("jcmsplugin.socle.facette.date.select.du.label")) %></span></button>
			               <span class="ds44-calendar" aria-hidden="true" aria-describedby="label-radio-form-element-<%= uidFormElem %>-<%= indexCheckbox %>"><i class="icon icon-date icon--large" aria-hidden="true"></i><span class="visually-hidden"><%= glp("jcmsplugin.socle.facette.date.calendrier.afficher", glp("jcmsplugin.socle.facette.date.select.du.label")) %></span></span>
			               <div class="vanilla-calendar hidden" data-calendar-past-dates="false"></div>
			            </div>
			            <div class="ds44-field-information" aria-live="polite">
			               <ul class="ds44-field-information-list ds44-list">
			                  <li id="explanation-form-element-<%= uidFormElemDateDebut %>" class="ds44-field-information-explanation"><%= glp("jcmsplugin.socle.facette.date.select.example.label") %></li>
			               </ul>
			            </div>
			         </div>
			         <div class="ds44-form__container ds44-mt2">
			            <div class="ds44-posRel">
			               <label for="form-element-<%= uidFormElemDateFin %>" class="ds44-formLabel ds44-datepicker"><span class="ds44-labelTypePlaceholder"><span>Jusqu'au</span></span></label>
			               <input class="ds44-input-value" type="hidden">
			               <div data-name="form-element-<%= uidFormElemDateFin %>" class="ds44-datepicker__shape ds44-inpStd" data-next-year-dates="false" data-previous-date-id="form-element-<%= uidFormElemDateDebut %>">
			                 <input id="form-element-<%= uidFormElemDateFin %>" type="text" inputmode="numeric" pattern="[0-9]*" maxlength="2" title='<%= isRequired ? glp("jcmsplugin.socle.facette.champ-obligatoire.title", glp("jcmsplugin.socle.facette.date.exemple.jour", glp("jcmsplugin.socle.facette.date.select.jusquau.label"))) : glp("jcmsplugin.socle.facette.date.exemple.jour", glp("jcmsplugin.socle.facette.date.select.jusquau.label")) %>' data-is-date="true" required="" aria-describedby="explanation-form-element-<%= uidFormElemDateFin %> label-radio-form-element-<%= uidFormElem %>-<%= indexCheckbox %> button-message-form-element-<%= uid %>" data-bkp-aria-describedby="explanation-form-element-<%= uidFormElemDateFin %> label-radio-form-element-<%= uidFormElem %>-<%= indexCheckbox %> button-message-form-element-<%= uid %>"><span>/</span><input type="text" inputmode="numeric" pattern="[0-9]*" maxlength="2" title='<%= isRequired ? glp("jcmsplugin.socle.facette.champ-obligatoire.title", glp("jcmsplugin.socle.facette.date.exemple.mois", glp("jcmsplugin.socle.facette.date.select.jusquau.label"))) : glp("jcmsplugin.socle.facette.date.exemple.mois", glp("jcmsplugin.socle.facette.date.select.jusquau.label")) %>' data-is-date="true" required="" aria-describedby="explanation-form-element-<%= uidFormElemDateFin %> label-radio-form-element-<%= uidFormElem %>-<%= indexCheckbox %> button-message-form-element-<%= uid %>" data-bkp-aria-describedby="explanation-form-element-<%= uidFormElemDateFin %> label-radio-form-element-<%= uidFormElem %>-<%= indexCheckbox %> button-message-form-element-<%= uid %>"><span>/</span><input type="text" inputmode="numeric" pattern="[0-9]*" maxlength="4" title='<%= isRequired ? glp("jcmsplugin.socle.facette.champ-obligatoire.title", glp("jcmsplugin.socle.facette.date.exemple.annee", glp("jcmsplugin.socle.facette.date.select.jusquau.label"))) : glp("jcmsplugin.socle.facette.date.exemple.annee", glp("jcmsplugin.socle.facette.date.select.jusquau.label")) %>' data-is-date="true" required="" aria-describedby="explanation-form-element-<%= uidFormElemDateFin %> label-radio-form-element-<%= uidFormElem %>-<%= indexCheckbox %> button-message-form-element-<%= uid %>" data-bkp-aria-describedby="explanation-form-element-<%= uidFormElemDateFin %> label-radio-form-element-<%= uidFormElem %>-<%= indexCheckbox %> button-message-form-element-<%= uid %>">
			               </div>
			               <button class="ds44-reset" type="button"><i class="icon icon-cross icon--sizeL" aria-hidden="true"></i><span class="visually-hidden">Effacer le contenu saisi dans le champ : Jusqu'au</span></button>
			               <span class="ds44-calendar" aria-hidden="true" aria-describedby="label-radio-form-element-<%= uidFormElem %>-<%= indexCheckbox %>"><i class="icon icon-date icon--large" aria-hidden="true"></i><span class="visually-hidden">Afficher le calendrier pour le champ : Jusqu'au</span></span>
			               <div class="vanilla-calendar hidden" data-calendar-next-year-dates="false"></div>
			            </div>
			            <div class="ds44-field-information" aria-live="polite">
			               <ul class="ds44-field-information-list ds44-list">
			                  <li id="explanation-form-element-<%= uidFormElemDateFin %>" class="ds44-field-information-explanation"><%= glp("jcmsplugin.socle.facette.date.select.example.label") %></li>
			               </ul>
			            </div>
			         </div>
			      </div>
	            </li>
            </ul>
        </div>
        <button type="button" class="ds44-fullWBtn ds44-btnSelect ds44-theme" title='<%= glp("jcmsplugin.socle.facette.cat-lie.valider-selection.label", title) %>'><span class="ds44-btnInnerText"><%= glp("jcmsplugin.socle.valider") %></span><i class="icon icon-long-arrow-right ds44-noLineH" aria-hidden="true"></i></button>
   </div>
   
</div>