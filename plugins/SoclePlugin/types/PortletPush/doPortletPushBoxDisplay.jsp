<%@ include file="/jcore/doInitPage.jspf" %>
<%@ include file="/jcore/portal/doPortletParams.jspf" %>
<% PortletPush box = (PortletPush) portlet; %>
<%
if (Util.isEmpty(box.getListeDeContenusPush())) return; // pas de contenu push à afficher

boolean doNotAddContainer = false;
Publication obj = (Publication)request.getAttribute(PortalManager.PORTAL_PUBLICATION);
if (Util.notEmpty(obj)) {
  doNotAddContainer = obj instanceof FicheActu;
}
%>
<jalios:if predicate="<%= !doNotAddContainer %>">
<div class="ds44-container-large">
</jalios:if>
    <jalios:select>
        <jalios:if predicate='<%= channel.getProperty("jcmsplugin.socle.horizontal.value").equals(box.getAffichage()) || box.getListeDeContenusPush().length == 1 %>'>
            <%-- Affichage horizontal sur toutes les tuiles --%>
            <jalios:foreach name="itPush" type="ContenuPush" array="<%= box.getListeDeContenusPush() %>">
                <%@ include file="/plugins/SoclePlugin/types/ContenuPush/doContenuPushHorizontalCard.jspf" %>
                <br/>
            </jalios:foreach>
        </jalios:if>
        <jalios:default>
            <%-- Affichage vertical --%>
            <%
            boolean lastLine = false;
            int finalColSize = (box.getListeDeContenusPush().length % 3 == 0) ? 4 : (12 / (box.getListeDeContenusPush().length % 3));
            
            // Trois éléments ou moins : on indique qu'on atteint la dernière ligne
            if (box.getListeDeContenusPush().length <= 3) {
                lastLine = true;
            }
            %>
            <div class="grid-12-small-1">
            <jalios:foreach name="itPush" type="ContenuPush" array="<%= box.getListeDeContenusPush() %>" counter="itCounter">
                <jalios:select>
                    <%-- Si c'est la ligne finale, on affiche les blocs selon une taille pré-définie --%>
                    <jalios:if predicate="<%= lastLine %>">
                        <% int colSize = finalColSize; %>
                        <%@ include file="/plugins/SoclePlugin/types/ContenuPush/doContenuPushVerticalCard.jspf" %>
                    </jalios:if>
                    <jalios:default>
                        <jalios:select>
                            <%-- Trois éléments ont été affichés, on détermine si on arrive à la dernière ligne (3 éléments restants ou moins) --%>
                            <jalios:if predicate="<%= itCounter > 3 && (box.getListeDeContenusPush().length - itCounter) <= 3 %>">
                                <%-- On arrive à la dernière ligne. On détermine si on affiche un élément horizontal (1 restant) ou des éléments verticaux (2/3 restants) --%>
                                <jalios:select>
	                                <jalios:if predicate="<%= box.getListeDeContenusPush().length == itCounter %>">
	                                    </div>
	                                    <%@ include file="/plugins/SoclePlugin/types/ContenuPush/doContenuPushHorizontalCard.jspf" %>
	                                </jalios:if>
	                                <jalios:default>
		                                <%
		                                lastLine = true;
		                                int colSize = finalColSize;
		                                %>
		                                <%@ include file="/plugins/SoclePlugin/types/ContenuPush/doContenuPushVerticalCard.jspf" %>
	                                </jalios:default>
                                </jalios:select>
                            </jalios:if>
                            <jalios:default>
                                <%-- Rien de particulier. On affiche normalement --%>
                                <% int colSize = 4; %>
                                <%@ include file="/plugins/SoclePlugin/types/ContenuPush/doContenuPushVerticalCard.jspf" %>
                            </jalios:default>
                        </jalios:select>
                    </jalios:default>
                </jalios:select>
                
                <jalios:if predicate="<%= itCounter % 3 == 0 %>">
                    <%-- Saut de ligne pour éviter les blocs collés --%>
                    </div>
                    <br/>
                    <div class="grid-12-small-1">
                </jalios:if>
            </jalios:foreach>
            </div>
        </jalios:default>
    </jalios:select>
<jalios:if predicate="<%= !doNotAddContainer %>">
</div>
</jalios:if>