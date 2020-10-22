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

String styleChampsReset = (Util.notEmpty(request.getAttribute("showFiltres")) && (Boolean) request.getAttribute("showFiltres")) || isInRechercheFacette ? "L" : "XL";

%>

 

<div class="ds44-form__container">
   <div class='ds44-select__shape <%= isInRechercheFacette ? "ds44-inpStd" : "ds44-inpLarge" %>'>
      <p class="ds44-selectLabel ds44-moveSelectLabel" aria-hidden="true"><%= title %><sup aria-hidden="true"><%= isRequired ? glp("jcmsplugin.socle.facette.asterisque") : "" %></sup></p>
      <div id="<%= uid %>" data-name="<%= uid %>" class="ds44-js-select-radio ds44-selectDisplay"  data-required="<%= isRequired %>"></div>
      <button type="button" id="button-<%= uid %>" class="ds44-btnIco ds44-posAbs ds44-posRi ds44-btnOpen" aria-expanded="false" title='<%= isRequired ? glp("jcmsplugin.socle.facette.champ-obligatoire.title", title) : title %>'><i class="icon icon-down icon--sizeL" aria-hidden="true"></i><span id="button-message-<%= uid %>" class="visually-hidden"><%= title %></span></button>
      <button class="ds44-reset" type="button"><i class="icon icon-cross icon--size<%= styleChampsReset %>" aria-hidden="true"></i><span class="visually-hidden"><%= glp("jcmsplugin.socle.facette.effacer-contenu-champ", title) %></span></button>
   </div>
   <div class="ds44-select-container hidden">
      <div class="ds44-listSelect">
         <ul class="ds44-list" id="listbox-<%= uid %>">
            <jalios:foreach name="itDateLabel" type="String" collection="<%= datesLabelValues.keySet() %>">
            <li class="ds44-select-list_elem">
               <div class="ds44-form__container ds44-checkBox-radio_list ">
                  <% 
                  String uidFormElem = ServletUtil.generateUniqueDOMId(request, glp("jcmsplugin.socle.facette.form-element"));
                  %>
                  <input type="radio" name="<%= uid %>" value="<%= datesLabelValues.get(itDateLabel) %>" id="name-radio-<%= uidFormElem %>-<%= itCounter %>" class="ds44-radio" /><label id="label-radio-<%= uidFormElem %>-<%= itCounter %>" for="name-radio-<%= uidFormElem %>-<%= itCounter %>" class="ds44-radioLabel"><%= itDateLabel %></label>
               </div>
            </li>
            </jalios:foreach>
            <li class="ds44-select-list_elem">
               <% 
                  String uidFormElem = ServletUtil.generateUniqueDOMId(request, glp("jcmsplugin.socle.facette.form-element"));
                      
                  String uidFormElemList;
               %>
               <div class="ds44-form__container ds44-checkBox-radio_list ">
                  <input type="radio" name="<%= uid %>" value="1" id="name-radio-<%= uidFormElem %>-<%= datesLabelValues.size() + 1 %>" class="ds44-radio" /><label id="label-radio-<%= uidFormElem %>-<%= datesLabelValues.size() + 1 %>" for="name-radio-<%= uidFormElem %>-<%= datesLabelValues.size() + 1 %>" class="ds44-radioLabel"><%= glp("jcmsplugin.socle.facette.date.select.example.custom") %></label>
               </div>
               <div class="ds44-select-list_elem_child hidden">
                  <%
                  uidFormElemList = ServletUtil.generateUniqueDOMId(request, glp("jcmsplugin.socle.facette.form-element"));
                  %>
                  <div class="ds44-form__container">
                     <div class="ds44-posRel">
                        <label for="<%= uidFormElemList %>" class="ds44-formLabel ds44-datepicker ds44-moveLabel"><span class="ds44-labelTypePlaceholder"><span><%= glp("jcmsplugin.socle.facette.date.select.du.label") %><sup aria-hidden="true"><%= isRequired ? glp("jcmsplugin.socle.facette.asterisque") : "" %></sup></span></span></label>
                        <div data-name="<%= uidFormElemList %>" class="ds44-datepicker__shape ds44-inpStd" data-next-year-dates="false" data-past-dates="false" data-required="<%= isRequired %>">
                            <input id="<%= uidFormElemList %>" type="text" inputmode="numeric" pattern="[0-9]*" maxlength="2" title='<%= isRequired ? glp("jcmsplugin.socle.facette.champ-obligatoire.title", glp("jcmsplugin.socle.facette.date.exemple.jour", glp("jcmsplugin.socle.facette.date.select.du.label"))) : glp("jcmsplugin.socle.facette.date.exemple.jour", glp("jcmsplugin.socle.facette.date.select.du.label")) %>' data-is-date="true"  <%= isRequired ? "required" : "" %>  aria-describedby="explanation-<%= uidFormElemList %> label-radio-<%= uidFormElem %>-<%= datesLabelValues.size() + 1 %> button-message-<%= uid %>">
                            <span>/</span>
                            <input type="text" inputmode="numeric" pattern="[0-9]*" maxlength="2" title='<%= isRequired ? glp("jcmsplugin.socle.facette.champ-obligatoire.title", glp("jcmsplugin.socle.facette.date.exemple.mois", glp("jcmsplugin.socle.facette.date.select.du.label"))) : glp("jcmsplugin.socle.facette.date.exemple.mois", glp("jcmsplugin.socle.facette.date.select.du.label")) %>' data-is-date="true"  <%= isRequired ? "required" : "" %>  aria-describedby="explanation-<%= uidFormElemList %> label-radio-<%= uidFormElem %>-<%= datesLabelValues.size() + 1 %> button-message-<%= uid %>">
                            <span>/</span>
                            <input type="text" inputmode="numeric" pattern="[0-9]*" maxlength="4" title='<%= isRequired ? glp("jcmsplugin.socle.facette.champ-obligatoire.title", glp("jcmsplugin.socle.facette.date.exemple.annee", glp("jcmsplugin.socle.facette.date.select.du.label"))) : glp("jcmsplugin.socle.facette.date.exemple.annee", glp("jcmsplugin.socle.facette.date.select.du.label")) %>' data-is-date="true"  <%= isRequired ? "required" : "" %>  aria-describedby="explanation-<%= uidFormElemList %> label-radio-<%= uidFormElem %>-<%= datesLabelValues.size() + 1 %> button-message-<%= uid %>">
                        </div>
                        <button class="ds44-reset" type="button" aria-describedby="label-<%= uidFormElemList %> label-radio-<%= uidFormElem %>-<%= datesLabelValues.size() + 1 %>"><i class="icon icon-cross icon--sizeL" aria-hidden="true"></i><span class="visually-hidden"><%= glp("jcmsplugin.socle.facette.effacer-contenu-champ", glp("jcmsplugin.socle.facette.date.select.du.label")) %></span></button>
                        <span class="ds44-calendar" aria-hidden="true" aria-describedby="label-<%= uidFormElemList %> label-radio-<%= uidFormElem %>-<%= datesLabelValues.size() + 1 %>"><i class="icon icon-date icon--large" aria-hidden="true"></i><span class="visually-hidden"><%= glp("jcmsplugin.socle.facette.date.calendrier.afficher", glp("jcmsplugin.socle.facette.date.select.du.label")) %></span></span>
                        <div class="vanilla-calendar hidden" data-calendar-next-year-dates="false" data-calendar-past-dates="false"></div>
                     </div>
                     <div class="ds44-field-information" aria-live="polite">
                        <ul class="ds44-field-information-list ds44-list">
                           <li id="explanation-<%= uidFormElemList %>" class="ds44-field-information-explanation"><%= glp("jcmsplugin.socle.facette.date.select.example.label") %></li>
                        </ul>
                     </div>
                  </div>
                  <%
                  String previousUid = uidFormElemList;
                  uidFormElemList = ServletUtil.generateUniqueDOMId(request, glp("jcmsplugin.socle.facette.form-element"));
                  %>
                  <div class="ds44-form__container ds44-mt2">
                     <div class="ds44-posRel">
                        <label for="<%= uidFormElemList %>" class="ds44-formLabel ds44-datepicker"><span class="ds44-labelTypePlaceholder"><span><%= glp("jcmsplugin.socle.facette.date.select.jusquau.label") %></span></span></label>
                        <div data-name="<%= uidFormElemList %>" class="ds44-datepicker__shape ds44-inpStd" data-previous-date-id="<%= previousUid %>">
	                        <input id="<%= uidFormElemList %>" type="text" inputmode="numeric" pattern="[0-9]*" maxlength="2" title='<%= isRequired ? glp("jcmsplugin.socle.facette.champ-obligatoire.title", glp("jcmsplugin.socle.facette.date.exemple.jour", glp("jcmsplugin.socle.facette.date.select.jusquau.label"))) : glp("jcmsplugin.socle.facette.date.exemple.jour", glp("jcmsplugin.socle.facette.date.select.jusquau.label")) %>' data-is-date="true"   aria-describedby="explanation-<%= uidFormElemList %> label-radio-<%= uidFormElem %>-<%= datesLabelValues.size() + 1 %> button-message-<%= uid %>">
	                        <span>/</span>
	                        <input type="text" inputmode="numeric" pattern="[0-9]*" maxlength="2" title='<%= isRequired ? glp("jcmsplugin.socle.facette.champ-obligatoire.title", glp("jcmsplugin.socle.facette.date.exemple.mois", glp("jcmsplugin.socle.facette.date.select.jusquau.label"))) : glp("jcmsplugin.socle.facette.date.exemple.mois", glp("jcmsplugin.socle.facette.date.select.jusquau.label")) %>' data-is-date="true"   aria-describedby="explanation-<%= uidFormElemList %> label-radio-<%= uidFormElem %>-<%= datesLabelValues.size() + 1 %> button-message-<%= uid %>">
	                        <span>/</span>
	                        <input type="text" inputmode="numeric" pattern="[0-9]*" maxlength="4" title='<%= isRequired ? glp("jcmsplugin.socle.facette.champ-obligatoire.title", glp("jcmsplugin.socle.facette.date.exemple.annee", glp("jcmsplugin.socle.facette.date.select.jusquau.label"))) : glp("jcmsplugin.socle.facette.date.exemple.annee", glp("jcmsplugin.socle.facette.date.select.jusquau.label")) %>' data-is-date="true"   aria-describedby="explanation-<%= uidFormElemList %> label-radio-<%= uidFormElem %>-<%= datesLabelValues.size() + 1 %> button-message-<%= uid %>">
                        </div>
                        <button class="ds44-reset" type="button" aria-describedby="label-<%= uidFormElemList %> label-<%= uidFormElemList %> label-radio-<%= uidFormElem %>-<%= datesLabelValues.size() + 1 %>"><i class="icon icon-cross icon--sizeL" aria-hidden="true"></i><span class="visually-hidden"><%= glp("jcmsplugin.socle.facette.effacer-contenu-champ", glp("jcmsplugin.socle.facette.date.select.jusquau.label")) %> </span></button>
                        <span class="ds44-calendar" aria-hidden="true" aria-describedby="label-<%= uidFormElemList %> label-<%= uidFormElemList %> label-radio-<%= uidFormElem %>-<%= datesLabelValues.size() + 1 %>"><i class="icon icon-date icon--large" aria-hidden="true"></i><span class="visually-hidden"><%= glp("jcmsplugin.socle.facette.date.calendrier.afficher", glp("jcmsplugin.socle.facette.date.select.jusquau.label")) %></span></span>
                        <div class="vanilla-calendar hidden"></div>
                     </div>
                     <div class="ds44-field-information" aria-live="polite">
                        <ul class="ds44-field-information-list ds44-list">
                           <li id="explanation-<%= uidFormElemList %>" class="ds44-field-information-explanation"><%= glp("jcmsplugin.socle.facette.date.select.example.label") %></li>
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