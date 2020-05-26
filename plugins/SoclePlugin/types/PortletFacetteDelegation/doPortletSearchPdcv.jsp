<%@ include file='/jcore/doInitPage.jspf' %>
<%@ include file='/jcore/portal/doPortletParams.jspf' %>
<%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%>

<% PortletFacetteDelegation obj = (PortletFacetteDelegation)portlet; %>

<section class="ds44-box ds44-theme ds44-mb3">
    <div class="ds44-innerBoxContainer">
        <p role="heading" aria-level="2" class="ds44-box-heading"><%= glp("jcmsplugin.socle.menu.pdcv") %></p>
        <form data-statistic='{"name": "declenche-evenement","category": "Formulaire","action": "Recherchez un contact","label": "$commune|text"}'>
            <div class="ds44-js-linked-fields ds44-js-masked-fields">
                <%
                String idFormElement= ServletUtil.generateUniqueDOMId(request, glp("jcmsplugin.socle.facette.form-element"));
                String titleAttr = glp("jcmsplugin.socle.recherche.facettes.commune.autocomplete.title");
                %>
                <ds:facetteAutoCompletion idFormElement="<%= idFormElement %>"
                        name="commune" 
                        request="<%= request %>" 
                        isFacetteObligatoire="<%= obj.getFacetteObligatoire() %>" 
                        dataMode="select-only" 
                        dataUrl="plugins/SoclePlugin/jsp/facettes/acSearchCommune.jsp" 
                        label='<%= Util.notEmpty(obj.getLabel()) ? obj.getLabel() : glp("jcmsplugin.socle.facette.commune.default-label") %>'
                        title='<%= glp("jcmsplugin.socle.facette.champ-obligatoire.title",titleAttr) %>'
                        isLarge="false"/>
                <ds:pdcvSearchFields idFormElement='<%= ServletUtil.generateUniqueDOMId(request, glp("jcmsplugin.socle.facette.form-element")) %>'/>
                
                <input type="hidden" name="redirectToDelegation" value="true"/>
                <button class="ds44-btnStd ds44-btn--invert" type="submit" title='<%= JcmsUtil.glp(userLang,"jcmsplugin.socle.menu.pdcv.valider") %>'>
                    <span class="ds44-btnInnerText"><%= JcmsUtil.glp(userLang,"jcmsplugin.socle.valider") %></span><i class="icon icon-long-arrow-right" aria-hidden="true"></i>
                </button>
            </div>
        </form>
    </div>
</section>
