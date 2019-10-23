<%@ include file='/jcore/doInitPage.jspf' %>
<%@ include file='/jcore/portal/doPortletParams.jspf' %>
<%@ include file='/types/PortletNavigate/doInitPortletNavigate.jspf' %>

<%-- SGU : inspiré de "doPortletNavigateFullDisplay.jsp"
    On adapte la liste au design system et on gère les extradatas de catégories (libellé, target)
    TODO : voir si on calcule l'URL du lien en amont ou si on laisse JCMS gérer.
--%>

<%
Set navigateSet = new TreeSet(Category.getOrderComparator(userLang));
navigateSet.addAll(rootCategory.getChildrenSet());

if (Util.isEmpty(navigateSet) && box.getHideWhenNoResults()){
    request.setAttribute("ShowPortalElement",Boolean.FALSE);
  return;
}

String nofollow = box.getNavigatePortlet() ? "" : "rel='nofollow'";
%>

<jalios:if predicate='<%= Util.notEmpty(navigateSet) %>'>
    <div class="ds44-bgGray">
        <div class="ds44-inner-container">
            <ul class="ds44-list ds44-flex-container ds44-footerList">
                <jalios:foreach collection='<%= navigateSet %>' type="Category" name="itCategory">
                    <jalios:if predicate='<%= itCategory.canBeReadBy(loggedMember , true, true) %>'><%
                        String libelleCat = Util.notEmpty(itCategory.getExtraData("extra.Category.plugin.tools.synonyme.facet.title")) ? itCategory.getExtraData("extra.Category.plugin.tools.synonyme.facet.title") : itCategory.getName(userLang);
                        boolean targetBlank = "true".equals(itCategory.getExtraData("extra.Category.plugin.tools.blank")) ? true : false;%>
                        <li>
                            <a <%= nofollow %> href='<%= PortalManager.getUrlWithUpdateCtxCategories(itCategory , ctxCategories, request , !box.getNavigatePortlet()) %>' <%=targetBlank ? "target=\"blank\"" :"" %> class="footerLink"><%= libelleCat %></a>
                        </li>
                    </jalios:if>
                </jalios:foreach>
            </ul>
        </div>
    </div>
</jalios:if>
