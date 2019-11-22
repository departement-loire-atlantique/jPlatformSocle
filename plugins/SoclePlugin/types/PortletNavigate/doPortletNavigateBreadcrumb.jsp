<%@ include file='/jcore/doInitPage.jspf' %>
<%@ include file='/jcore/portal/doPortletParams.jspf' %>
<%@ include file='/types/PortletNavigate/doInitPortletNavigate.jspf' %>

<%-- SGU : inspiré de doPortletNavigateLocation.jsp
    On adapte la liste au design system et on gère les extradatas de catégories (libellé, target)
    Les liens pointent vers les catégories. Un portalPolicyFilter s'occupe de rediriger vers le
    bon contenu.
--%>
        
<%
List<Category> ancestors  = currentCategory.getAncestorList();
	
for (Iterator<Category> it = rootCategory.getAncestorList().iterator() ; it.hasNext() ;) {
  ancestors.remove(it.next());
}

if (Util.isEmpty(ancestors) && box.getHideWhenNoResults()) {
  request.setAttribute("ShowPortalElement",Boolean.FALSE);
  return;
}

Collections.reverse(ancestors);

//ancestors.add(currentCategory);
	
String nofollow = box.getNavigatePortlet() ? "" : "rel='nofollow'";
int counter = 0;
String libelleCat = "";
%>

<nav role="navigation" aria-label='<%=glp("jcmsplugin.socle.breadcrumb.position")%>'>
	<ul class="ds44-list ds44-text--colorInvert">
	    <li class="ds44-breadcrumb"><a href="index.jsp"><i class="icon icon-home icon--medium"></i><span class="visually-hidden">Accueil</span></a></li>
	    <jalios:foreach collection="<%= ancestors %>" type="Category" name="itCategory">
	            <jalios:if predicate='<%= itCategory.canBeReadBy(loggedMember , true, true) %>'>
	                <%
	            	if((itCategory.hasAncestor(rootCategory) || itCategory.equals(rootCategory)) && (counter < box.getLevels()-1)) {
	            		libelleCat = Util.notEmpty(itCategory.getExtraData("extra.Category.plugin.tools.synonyme.facet.title")) ? itCategory.getExtraData("extra.Category.plugin.tools.synonyme.facet.title") : itCategory.getName(userLang);
	            		boolean targetBlank = "true".equals(itCategory.getExtraData("extra.Category.plugin.tools.blank")) ? true : false;
		           %>
	    
				    <li class="ds44-breadcrumb">
				        <a <%= nofollow %> href='<%= PortalManager.getUrlWithUpdateCtxCategories(itCategory , ctxCategories, request , !box.getNavigatePortlet()) %>' <%=targetBlank ? "target=\"blank\"" :"" %>><%= libelleCat %></a>
				    </li>
				    <% counter++; %>
				  <% } %>
	        </jalios:if>
	    </jalios:foreach>
	    <li class="ds44-breadcrumb" aria-current="location">
            <%= Util.notEmpty(currentCategory.getExtraData("extra.Category.plugin.tools.synonyme.facet.title")) ? currentCategory.getExtraData("extra.Category.plugin.tools.synonyme.facet.title") : currentCategory.getName(userLang) %>
        </li>
	</ul>
</nav>

<% 
if (counter == 0) {
  request.setAttribute("ShowPortalElement",Boolean.FALSE);
}
%>
