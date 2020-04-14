<%@page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file='/jcore/doInitPage.jspf' %>
<%@ include file='/jcore/portal/doPortletParams.jspf' %>
<% 
    PortletFacetteDelegation obj = (PortletFacetteDelegation)portlet;
    
    String idFormElement = ServletUtil.generateUniqueDOMId(request, glp("jcmsplugin.socle.facette.form-element"));
    String dataMode = "select-only";
    String dataUrl = "plugins/SoclePlugin/jsp/facettes/acSearchCommune.jsp";
    String name = "commune";
    String label = Util.notEmpty(obj.getLabel()) ? obj.getLabel() : glp("jcmsplugin.socle.facette.commune.default-label");
    String option = "";
    TreeSet<Category> setRayons = new TreeSet<Category>();
%>

<form data-statistic='{"name": "declenche-evenement","category": "Formulaire","action": "Recherchez un contact","label": "$commune|text"}' action="plugins/SoclePlugin/types/PortletFacetteDelegation/doDelegationPdcvRedirection.jsp" method="GET">
    <div class="ds44-js-linked-fields ds44-js-masked-fields">
        <%@ include file='/plugins/SoclePlugin/jsp/portlet/portletFacetteAutoCompletion.jspf' %>
        
        <div class="ds44-form__container hidden">
            <div class="ds44-posRel">
                <label for="adresse-<%= idFormElement %>" class="ds44-formLabel--external"><span class="ds44-labelTypePlaceholder"><%= glp("jcmsplugin.socle.menu.pdcv.ajouterAdresse") %><sup aria-hidden="true"><%= glp("jcmsplugin.socle.facette.asterisque") %></sup></span></label>
                
                <input class="ds44-input-value" type="hidden" value=""><input class="ds44-input-metadata" type="hidden" value=""><input type="text" id="adresse-<%= idFormElement %>" name="adresse" class="ds44-inpStd" role="combobox" aria-autocomplete="list" autocomplete="off" aria-expanded="false" title='<%= glp("jcmsplugin.socle.menu.pdcv.ajouterAdresse") %> - <%= gkp("jcmsplugin.socle.obligatoire") %>' data-url="/json/autocomplete-address.json" data-mode="select-only" required="" placeholder='<%= glp("jcmsplugin.socle.menu.pdcv.votreAdresse") %>' aria-owns="owned_listbox_idpuhzgtecd3n"><button class="ds44-reset" type="button" style="display: none;"><i class="icon icon-cross icon--sizeL" aria-hidden="true"></i><span class="visually-hidden"><%= glp("jcmsplugin.socle.facette.effacer-contenu-champ", glp("jcmsplugin.socle.menu.pdcv.ajouterAdresse")) %></span></button>
                
                <div class="ds44-autocomp-container hidden" aria-hidden="true">
                    <div class="ds44-autocomp-list">
                        <ul class="ds44-list" role="listbox" id="owned_listbox_idpuhzgtecd3n"></ul>
                    </div>
                </div>
            </div>
            
            <div class="ds44-errorMsg-container hidden" aria-live="polite"></div>
        </div>
        
        <input type="hidden" name="redirectToDelegation" value="true"/>
        <button class="ds44-btnStd ds44-btn--invert" type="submit" aria-label='<%= glp("jcmsplugin.socle.menu.pdcv.valider") %>'>
        <span class="ds44-btnInnerText"><%= glp("jcmsplugin.socle.valider") %></span><i class="icon icon-long-arrow-right" aria-hidden="true"></i>
        </button>
    </div>
</form>