<%@page import="fr.cg44.plugin.socle.infolocale.util.InfolocaleUtil"%>
<%@page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file='/jcore/doInitPage.jspf' %>
<%@ include file='/jcore/portal/doPortletParams.jspf' %>
<%@ include file='/plugins/SoclePlugin/jsp/facettes/commonParamsFacettes.jspf' %>
<%@ taglib prefix="ds" tagdir="/WEB-INF/tags" %>
<% PortletFacetteAgendaAccessibilit obj = (PortletFacetteAgendaAccessibilit)portlet; %>

<% 
String uid = ServletUtil.generateUniqueDOMId(request, glp("jcmsplugin.socle.facette.form-element")); 
LinkedHashMap<String, String> accessibiliteValues = new LinkedHashMap<>();
accessibiliteValues.put(channel.getProperty("jcmsplugin.socle.infolocale.metadata.accessibilite.auditif"), glp("jcmsplugin.socle.infolocale.label.accessibilite.handicapauditif"));
accessibiliteValues.put(channel.getProperty("jcmsplugin.socle.infolocale.metadata.accessibilite.mental"), glp("jcmsplugin.socle.infolocale.label.accessibilite.handicapmental"));
accessibiliteValues.put(channel.getProperty("jcmsplugin.socle.infolocale.metadata.accessibilite.visuel"), glp("jcmsplugin.socle.infolocale.label.accessibilite.handicapvisuel"));
accessibiliteValues.put(channel.getProperty("jcmsplugin.socle.infolocale.metadata.accessibilite.moteur"), glp("jcmsplugin.socle.infolocale.label.accessibilite.handicapmoteur"));
String title = Util.getString(obj.getLabel(userLang, false), glp("jcmsplugin.socle.facette.accessibilite.title"));
boolean isRequired = obj.getFacetteObligatoire();   
%>

<div class="ds44-form__container">
   <div class='ds44-select__shape <%= isInRechercheFacette ? "ds44-inpStd" : "ds44-inpLarge" %>'>
      <p id="label-<%= uid %>" class="ds44-selectLabel" aria-hidden="true"><%= glp("jcmsplugin.socle.infolocale.label.accessibilite") %>
        <jalios:if predicate="<%= isRequired %>"><sup aria-hidden="true"><%= glp("jcmsplugin.socle.facette.asterisque") %></sup></jalios:if>
      </p>
      <div id="<%= uid %>" data-name="accessibilite" class="ds44-js-select-checkbox ds44-selectDisplay" data-required="<%= isRequired %>"></div>
      <button class="ds44-reset" type="button" aria-describedby="label-<%= uid %>"><i class="icon icon-cross icon--sizeL" aria-hidden="true"></i><span class="visually-hidden"><%= glp("jcmsplugin.socle.facette.effacer-contenu-champ", title) %></span></button>
      <button type="button" id="button-<%= uid %>" class="ds44-btnIco ds44-posAbs ds44-posRi ds44-btnOpen" aria-expanded="false" title='<%= isRequired ? glp("jcmsplugin.socle.facette.champ-obligatoire.title", title) : title %>'  ><i class="icon icon-down icon--sizeL" aria-hidden="true"></i><span id="button-message-<%= uid %>" class="visually-hidden"><%= title %></span></button>
   </div>
   <div class="ds44-select-container hidden">
      <div class="ds44-flex-container ds44--m-padding">
         <button class="ds44-btnStd ds44-bgGray ds44-btnStd--plat ds44-fg1" type="button" aria-describedby="button-message-<%= uid %>"><span class="ds44-btnInnerText"><%= glp("jcmsplugin.socle.tout-cocher") %></span><i class="icon icon-check icon--medium" aria-hidden="true"></i></button>
         <button class="ds44-btnStd ds44-bgGray ds44-btnStd--plat ds44-fg1 ds44-border-left--light" type="button" aria-describedby="button-message-<%= uid %>"><span class="ds44-btnInnerText"><%= glp("jcmsplugin.socle.tout-decocher") %></span><i class="icon icon-cross icon--medium" aria-hidden="true"></i></button>
      </div>
      <div class="ds44-listSelect">
         <ul class="ds44-list" id="listbox-<%= uid %>">
            <jalios:foreach name="itAccessibiliteValue" type="String" collection="<%= accessibiliteValues.keySet() %>">
                <% String uidFormElem = ServletUtil.generateUniqueDOMId(request, glp("jcmsplugin.socle.facette.form-element"));  %>
	            <li class="ds44-select-list_elem">
	               <div class="ds44-form__container ds44-checkBox-radio_list ">
	                  <input type="checkbox" id="name-check-<%= uidFormElem %>-<%= itCounter %>" name="accessibilite-<%= itCounter %>" value="<%= itAccessibiliteValue %>" class="ds44-checkbox" />
	                  <label for="name-check-<%= uidFormElem %>-<%= itCounter %>" class="ds44-boxLabel" id="name-check-label-<%= uidFormElem %>-<%= itCounter %>"><%= accessibiliteValues.get(itAccessibiliteValue) %></label>
	               </div>
	            </li>
            </jalios:foreach>
         </ul>
      </div>
      <button type="button" class="ds44-fullWBtn ds44-btnSelect ds44-theme" title='<%= glp("jcmsplugin.socle.facette.cat-lie.valider-selection.label", title) %>'><span class="ds44-btnInnerText"><%= glp("jcmsplugin.socle.valider") %></span><i class="icon icon-long-arrow-right ds44-noLineH" aria-hidden="true"></i></button>
   </div>
</div>