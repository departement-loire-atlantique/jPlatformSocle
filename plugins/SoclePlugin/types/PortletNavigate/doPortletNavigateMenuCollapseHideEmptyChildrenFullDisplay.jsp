<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file='/jcore/doInitPage.jspf'%>
<%@ include file='/jcore/portal/doPortletParams.jspf'%>
<%@ include file='/types/PortletNavigate/doInitPortletNavigate.jspf'%>
<%-- SGU
    Menu de navigation déroulant (collapse)
    Affiche systématiquement 2 niveaux (le 1er niveau sous forme de titre, et le 2è sous forme de "collapser"),
    puis boucle récursivement jusqu'à afficher le nombre max de niveaux paramétré dans la portlet.
 --%>
<%
	if (((rootCategory == null) || (rootCategory.isLeaf())) && box.getHideWhenNoResults()){
		request.setAttribute("ShowPortalElement",Boolean.FALSE);
		return;
	}
	
	// Tri et filtre sur les catégories autorisées
	Set<Category> rootSet = SocleUtils.getOrderedAuthorizedChildrenSet(rootCategory);
	
	int maxLevels = box.getLevels();
%>
<jalios:foreach collection="<%= rootSet %>" type="Category" name="itCatLevel1">
	<h2 class="h3-like"><%=itCatLevel1.getName(userLang)%></h2>
	<% Set<Category> level1CatSet = SocleUtils.getOrderedAuthorizedChildrenSet(itCatLevel1); %>
	<ul class="ds44-collapser">
	   <%-- Si pas de publications on n'affiche pas l'item --%>
        <jalios:foreach collection="<%= level1CatSet %>" type="Category" name="itCatLevel2">
            <jalios:if predicate="<%= Util.notEmpty(itCatLevel2.getAllPublicationSet()) %>" breakselect="true">
                <li class="ds44-collapser_element">
					<%-- Si présence d'un contenu principal sur la catégorie, alors lien vers ce contenu,
					      sinon génération des enfants ou lien direct vers la catégorie si pas d'enfants. --%> 
					<%
						Set<Category> level3CatSet = SocleUtils.getOrderedAuthorizedChildrenSet(itCatLevel2);
						Publication itContenuPrincipal = SocleUtils.getContenuPrincipal(itCatLevel2);
						PortletPortalRedirect itRedirect = SocleUtils.getPortalRedirect(itCatLevel2);
					%> 
					<jalios:select>
						<jalios:if predicate="<%= Util.notEmpty(itContenuPrincipal) %>" breakselect="true">
							<jalios:if predicate="<%= itContenuPrincipal instanceof FileDocument %>"> 
								<% 
									String fileType = " - " + FileDocument.getExtension(((FileDocument)itContenuPrincipal).getFilename()).toUpperCase();
									String fileSize = " - " + Util.formatFileSize(((FileDocument)itContenuPrincipal).getSize());
									String linkTitle = glp("jcmsplugin.socle.fichepublication.telecharger") + " " + itCatLevel2.getName(userLang) + fileType + fileSize + " " + glp("jcmsplugin.socle.accessibily.newTabLabel");
								%>
								<jalios:link data="<%=itContenuPrincipal%>" css="ds44-collapser_content--buttonLike" title="<%= linkTitle %>" htmlAttributes="target='_blank'"><%=itCatLevel2.getName(userLang)%></jalios:link>
							</jalios:if>
							<jalios:if predicate="<%= ! (itContenuPrincipal instanceof FileDocument) %>"> 
								<jalios:link data="<%=itContenuPrincipal%>" css="ds44-collapser_content--buttonLike"><%=itCatLevel2.getName(userLang)%></jalios:link>
							</jalios:if>
						</jalios:if>
						<jalios:if predicate="<%= Util.notEmpty(itRedirect) %>" breakselect="true">
							<jalios:select>
								<jalios:if predicate='<%= itRedirect.getStatus().equals("url") && Util.notEmpty(itRedirect.getUrl()) %>'>
									<jalios:link data="<%=itCatLevel2%>" css="ds44-collapser_content--buttonLike" htmlAttributes="target='_blank'"><%=itCatLevel2.getName(userLang)%></jalios:link>
								</jalios:if>
								<jalios:default>
									<jalios:link data="<%=itCatLevel2%>" css="ds44-collapser_content--buttonLike"><%=itCatLevel2.getName(userLang)%></jalios:link>
								</jalios:default>
							</jalios:select> 
						</jalios:if>
						<jalios:if predicate="<%= Util.notEmpty(level3CatSet) %>" breakselect="true">
							<c:set var="itCategory" value="<%=itCatLevel2%>" scope="request" /> 
							<c:set var="maxLevels" value="<%=maxLevels%>" scope="request" /> 
							<ds:toggle title="<%=itCatLevel2.getName(userLang) %>">
								<ds:categoryTree rootCat="${itCategory}" maxLevels="${maxLevels}" currentLevel="0" />
							</ds:toggle>
						</jalios:if>
						<jalios:default>
							<jalios:link data="<%=itCatLevel2%>" css="ds44-collapser_content--buttonLike"><%=itCatLevel2.getName(userLang)%></jalios:link> 
						</jalios:default>
					</jalios:select>
                </li>
            </jalios:if>
		</jalios:foreach>
	</ul>
</jalios:foreach>
