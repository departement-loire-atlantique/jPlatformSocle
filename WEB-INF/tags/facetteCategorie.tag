<%@ taglib prefix="ds" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="jcms.tld" prefix="jalios" %>
<%@ tag 
    pageEncoding="UTF-8"
    description="Facette catégorie sans container" 
    body-content="scriptless" 
    import="com.jalios.jcms.Channel, 
            com.jalios.util.Util,
            com.jalios.jcms.JcmsUtil, 
            generated.AbstractPortletFacette, 
            javax.servlet.http.HttpServletRequest, 
            com.jalios.jcms.Member, 
            com.jalios.jcms.Category, 
            fr.cg44.plugin.socle.infolocale.entities.Genre, 
            java.util.Set, 
            java.util.TreeSet,
            java.util.Map,
            fr.cg44.plugin.socle.SocleUtils" 
%>
<%@ attribute name="obj" 
        required="true" 
        fragment="false" 
        rtexprvalue="true" 
        type="AbstractPortletFacette" 
        description="La facette categorie" 
%>
<%@ attribute name="listeCategory" 
        required="false" 
        fragment="false" 
        rtexprvalue="true" 
        type="TreeSet<Category>" 
        description="La liste des categories selectionnables" 
%>
<%@ attribute name="listeCouplesLibellesGenres" 
        required="false" 
        fragment="false" 
        rtexprvalue="true" 
        type="Map<String, Set<Genre>>" 
        description="Map de couples libellés / genres (pour l'agenda)" 
%>
<%@ attribute name="dataURL" 
        required="false" 
        fragment="false" 
        rtexprvalue="true" 
        type="String" 
        description="URL a appeler pour remplir les valeurs cochables du champ" 
%>
<%@ attribute name="idFormElement" 
        required="true" 
        fragment="false" 
        rtexprvalue="true" 
        type="String" 
        description="L'ID de l'input" 
%>
<%@ attribute name="isDisabled" 
        required="true" 
        fragment="false" 
        rtexprvalue="true" 
        type="Boolean" 
        description="Est-ce que le champ est désactivé par défaut" 
%>
<%@ attribute name="request" 
        required="true" 
        fragment="false" 
        rtexprvalue="true" 
        type="HttpServletRequest" 
        description="La requete http actuelle" 
%>
<%@ attribute name="selectionMultiple" 
        required="true" 
        fragment="false" 
        rtexprvalue="true" 
        type="Boolean" 
        description="Est ce que la facette propose une séléction multiple" 
%>
<%@ attribute name="profondeur" 
        required="true" 
        fragment="false" 
        rtexprvalue="true" 
        type="Boolean" 
        description="La profondeur est elle a 1 (sinon 2)" 
%>
<%@ attribute name="forcedLabel" 
        required="false" 
        fragment="false" 
        rtexprvalue="true" 
        type="String" 
        description="Label du champ forcé à cette valeur" 
%>
<%@ attribute name="isSizeStd" 
        required="false" 
        fragment="false" 
        rtexprvalue="true" 
        type="Boolean" 
        description="Si à 'true', force la taille du champ en Std" 
%>
<%
    Member loggedMember = Channel.getChannel().getCurrentJcmsContext().getLoggedMember();
    String userLang = Channel.getChannel().getCurrentJcmsContext().getUserLang();

    String styleChamps = (Util.notEmpty(request.getAttribute("showFiltres")) && (Boolean) request.getAttribute("showFiltres")) || (Util.notEmpty(isSizeStd) && isSizeStd) ? "Std" : "Large";
    String styleChamps2 = styleChamps.equalsIgnoreCase("large") ? "XL" : "L";
    
    String labelChamp = JcmsUtil.glp(userLang, "jcmsplugin.socle.facette.categorie.default-label");
    labelChamp = Util.notEmpty(listeCategory) ? listeCategory.first().getName() : labelChamp;
    labelChamp = Util.notEmpty(dataURL) ? JcmsUtil.glp(userLang, "jcmsplugin.socle.facette.cat-lie.sous-theme.label") : labelChamp;
    labelChamp = Util.notEmpty(obj.getLabel()) ? obj.getLabel() : labelChamp;
    labelChamp = Util.notEmpty(forcedLabel) ? forcedLabel : labelChamp;
    String classInputDisabled = isDisabled ? " ds44-inputDisabled" : "";
    
%>
<div class="ds44-form__container">
    <div class='<%= "ds44-select__shape ds44-inp" + styleChamps + classInputDisabled %>'>
        <p id="label-<%= idFormElement %>" class="ds44-selectLabel" aria-hidden="true">
            <%= labelChamp %>
            <%= obj.getFacetteObligatoire() ? "<sup aria-hidden=\"true\">*</sup>" : "" %>
        </p>
        
        <% 
            String classTypeInput = selectionMultiple ? "ds44-js-select-checkbox" : "ds44-js-select-radio"; 
            classTypeInput = Util.isEmpty(dataURL) && !profondeur ? "ds44-js-select-multilevel" : classTypeInput; 
        %>
        <div id='<%= idFormElement %>' data-name='<%= "cids" + idFormElement %>' class='<%= classTypeInput + " ds44-selectDisplay" %>' 
                <%= Util.notEmpty(dataURL) ? "data-url=\"" + dataURL + "\"" : "" %> 
                <%= obj.getFacetteObligatoire() ? "data-required=\"true\"" : ""%>
                <%= isDisabled ? "data-disabled=\"true\"" : "" %>
                <%= Util.notEmpty(request.getAttribute("isFilter")) && (Boolean)(request.getAttribute("isFilter")) ? "data-auto-submit=\"true\"" : "" %>></div>

        <button class="ds44-reset" type="button" aria-describedby="label-<%= idFormElement %>">
            <i class='icon icon-cross icon--size<%= styleChamps2 %>' aria-hidden="true"></i>
            <span class="visually-hidden"><%= JcmsUtil.glp(userLang, "jcmsplugin.socle.facette.effacer-contenu-champ", labelChamp) %></span>
        </button>
        <button type="button" id="button-<%= idFormElement %>" class="ds44-btnIco ds44-posAbs ds44-posRi ds44-btnOpen" 
                title='<%= JcmsUtil.glp(userLang, "jcmsplugin.socle.facette.champ-obligatoire.title", labelChamp) %>' 
                aria-expanded="false" 
                <%= isDisabled ? "data-disabled=\"true\"" : "" %>>
            <i class='<%= "icon icon-down icon--size" + styleChamps2 %>' aria-hidden="true"></i>
            <span id='<%= "button-message-" + idFormElement %>' class="visually-hidden"><%= labelChamp %></span>
        </button>
    </div>

    <div class="ds44-select-container hidden">
        <jalios:if predicate='<%= selectionMultiple %>'>
            <div class="ds44-flex-container ds44--m-padding">
                <button class="ds44-btnStd ds44-bgGray ds44-btnStd--plat ds44-fg1" type="button" 
                        aria-describedby='<%= "button-message-" + idFormElement %>'>
                    <span class="ds44-btnInnerText"><%= JcmsUtil.glp(userLang, "jcmsplugin.socle.tout-cocher") %></span>
                    <i class="icon icon-check icon--medium" aria-hidden="true"></i>
                </button>
                <button class="ds44-btnStd ds44-bgGray ds44-btnStd--plat ds44-fg1 ds44-border-left--light" type="button"
                    aria-describedby="button-message-<%= idFormElement %>">
                    <span class="ds44-btnInnerText"><%= JcmsUtil.glp(userLang, "jcmsplugin.socle.tout-decocher") %></span>
                    <i class="icon icon-cross icon--medium" aria-hidden="true"></i>
                </button>
            </div>
        </jalios:if>
        <% int nbrTotalCat = 0; %>
        <jalios:if predicate='<%= Util.notEmpty(dataURL) || profondeur %>'>
            
            <div class="ds44-listSelect">
                <ul class="ds44-list" id='<%= "listbox-" + idFormElement %>'>
                    <%-- Catégories classiques --%>
                    <jalios:if predicate="<%= Util.notEmpty(listeCategory) %>">
                        <jalios:foreach name="itRootCat" type="Category" collection='<%= listeCategory %>'>
                            <jalios:foreach name="itCat" type="Category" collection='<%= SocleUtils.getOrderedAuthorizedChildrenSet(itRootCat) %>'>
                                <% nbrTotalCat++; %>
                                <li class="ds44-select-list_elem">
                                    
                                    <ds:facetteCategorieListElem cat='<%= itCat %>' 
                                        idFormElement='<%= idFormElement %>' 
                                        typeDeSelection='<%= selectionMultiple %>' 
                                        numCat='<%= nbrTotalCat %>'/>
                                </li>
                            </jalios:foreach>
                        </jalios:foreach>
                    </jalios:if>
                    <%-- Thématiques, genres et catégories Infolocale - niveau 1 uniquement --%>
                    <jalios:if predicate="<%= Util.notEmpty(listeCouplesLibellesGenres) %>">
                        <jalios:select>
                            <jalios:if predicate="<%= listeCouplesLibellesGenres.keySet().size() > 1 %>">
                                <%-- Cas 1 : plusieurs libellés, un libellé = plusieurs genres concaténés --%>
                                <jalios:foreach name="itLibelle" type="String" collection='<%= listeCouplesLibellesGenres.keySet() %>' counter="itCatCounter">
                                    <li class="ds44-select-list_elem">
                                        <ds:facetteAgendaCategorieListElem setGenre='<%=listeCouplesLibellesGenres.get(itLibelle)%>' 
                                           idFormElement='<%=idFormElement + "-" + nbrTotalCat%>' 
                                           typeDeSelection='<%=selectionMultiple%>' 
                                           numGenre='<%=itCatCounter%>'
                                           customLabel='<%= itLibelle %>'/>
                                    </li>
                                </jalios:foreach>
                            </jalios:if>
                            <jalios:default>
                                <%-- Cas 2 : un seul libellé = afficher tous les éléments --%>
                                <jalios:foreach name="itGenre" type="Genre" collection='<%= listeCouplesLibellesGenres.get(listeCouplesLibellesGenres.keySet().iterator().next()) %>' counter="itCatCounter">
                                    <li class="ds44-select-list_elem">
                                        <ds:facetteAgendaCategorieListElem genre='<%= itGenre %>' 
                                           idFormElement='<%=idFormElement + "-" + nbrTotalCat%>' 
                                           typeDeSelection='<%=selectionMultiple%>' 
                                           numGenre='<%=itCatCounter%>'/>
                                    </li>
                                </jalios:foreach>
                            </jalios:default>
                        </jalios:select>
                        
                    </jalios:if>
                </ul>
            </div>
            
        </jalios:if>
        <jalios:if predicate='<%= Util.isEmpty(dataURL) && !profondeur %>'>
            <ul class="ds44-collapser ds44-listSelect">
                <jalios:select>
                     <jalios:if predicate="<%= Util.notEmpty(listeCouplesLibellesGenres) %>">
                     <%-- Thématiques, catégories et genres infolocale --%>
                         <jalios:foreach name="itLibelle" type="String" collection='<%= listeCouplesLibellesGenres.keySet() %>'>
                            <% 
                            nbrTotalCat++; 
                            Category tmpCat = new Category();
                            tmpCat.setName(itLibelle);
                            %>
                            <li class="ds44-collapser_element ds44-collapser--select">                          
                                <div class="ds44-select__categ">
                                   <ds:facetteCategorieListElem cat='<%= tmpCat %>' 
                                           idFormElement='<%= idFormElement %>' 
                                           typeDeSelection='<%= selectionMultiple %>' 
                                           numCat='<%= nbrTotalCat %>'/>
    
                                </div>                      
                                <button type="button" class="ds44-collapser_button ds44-collapser_button--select" 
                                        aria-describedby='<%= "name-check-label-" + idFormElement + "-" + nbrTotalCat %>'>
                                    <span class="visually-hidden"><%= JcmsUtil.glp(userLang, "jcmsplugin.socle.deplier") %></span>
                                    <i class="icon icon-down ds44-noLineH" aria-hidden="true"></i>
                                </button>
                                <div class="ds44-collapser_content">
                                    <ul class="ds44-list ds44-collapser_content--level2">
                                        <jalios:foreach name="itSubGenre" type="Genre" collection='<%= listeCouplesLibellesGenres.get(itLibelle) %>' counter="itSubCatCounter">
                                            <li class="ds44-select-list_elem">
                                                <ds:facetteAgendaCategorieListElem genre='<%= itSubGenre %>' 
                                                        idFormElement='<%= idFormElement + "-" + nbrTotalCat %>' 
                                                        typeDeSelection='<%= selectionMultiple %>' 
                                                        numGenre='<%= itSubCatCounter %>'/>
                                            </li>
                                        </jalios:foreach>
                                    </ul>
                                </div>
                            </li>
                        </jalios:foreach>
                     </jalios:if>
                     <jalios:default>
                     <%-- Catégories classiques --%>
                         <jalios:foreach name="itRootCat" type="Category" collection='<%= listeCategory %>'>
                            <jalios:foreach name="itCat" type="Category" collection='<%= SocleUtils.getOrderedAuthorizedChildrenSet(itRootCat) %>'>
                                <% nbrTotalCat++; 
                                Set childrenSet = SocleUtils.getOrderedAuthorizedChildrenSet(itCat);
                                %>
                                <%-- Sans enfant --%>                   
                                <jalios:if predicate='<%= Util.isEmpty(childrenSet) %>'>
                                     <li class="ds44-collapser_element ds44-collapser--select ds44-select__categ ds44-select-list_elem">
                                          <ds:facetteCategorieListElem cat='<%= itCat %>' 
                                                idFormElement='<%= idFormElement %>' 
                                                typeDeSelection='<%= selectionMultiple %>' 
                                                numCat='<%= nbrTotalCat %>'/>
                                     </li>
                                </jalios:if>
                                <%-- avec enfants --%>  
                                <jalios:if predicate='<%= Util.notEmpty(childrenSet) %>'>                       
                                    <li class="ds44-collapser_element ds44-collapser--select">                          
                                        <div class="ds44-select__categ">
                                           <ds:facetteCategorieListElem cat='<%= itCat %>' 
                                                   idFormElement='<%= idFormElement %>' 
                                                   typeDeSelection='<%= selectionMultiple %>' 
                                                   numCat='<%= nbrTotalCat %>'/>
            
                                        </div>                      
                                        <button type="button" class="ds44-collapser_button ds44-collapser_button--select" 
                                                aria-describedby='<%= "name-check-label-" + idFormElement + "-" + nbrTotalCat %>'>
                                            <span class="visually-hidden"><%= JcmsUtil.glp(userLang, "jcmsplugin.socle.deplier") %></span>
                                            <i class="icon icon-down ds44-noLineH" aria-hidden="true"></i>
                                        </button>
                                        <div class="ds44-collapser_content">
                                            <ul class="ds44-list ds44-collapser_content--level2">
                                                <jalios:foreach name="itSubCat" type="Category" collection='<%= SocleUtils.getOrderedAuthorizedChildrenSet(itCat) %>' counter="itSubCatCounter">
                                                    <li class="ds44-select-list_elem">
                                                        <ds:facetteCategorieListElem cat='<%= itSubCat %>' 
                                                                idFormElement='<%= idFormElement + "-" + nbrTotalCat %>' 
                                                                typeDeSelection='<%= selectionMultiple %>' 
                                                                numCat='<%= itSubCatCounter %>'/>
                                                    </li>
                                                </jalios:foreach>
                                            </ul>
                                        </div>
                                    </li>
                                </jalios:if>
                                
                            </jalios:foreach>
                        </jalios:foreach>
                     </jalios:default>
                </jalios:select>
            </ul>
        </jalios:if>
        <button type="button" class="ds44-fullWBtn ds44-btnSelect ds44-theme" aria-describedby='<%= "button-message-" + idFormElement %>'
                title='<%= JcmsUtil.glp(userLang, "jcmsplugin.socle.facette.cat-lie.valider-selection.label", labelChamp) %>'>
            <span class="ds44-btnInnerText" aria-hidden="true"><%= JcmsUtil.glp(userLang, "jcmsplugin.socle.valider") %></span>
            <i class="icon icon-long-arrow-right ds44-noLineH" aria-hidden="true"></i>
        </button>
    </div>
</div>