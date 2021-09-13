<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file='/jcore/doInitPage.jspf' %>
<%@ include file='/jcore/portal/doPortletParams.jspf' %>
<%@ include file='/types/PortletNavigate/doInitPortletNavigate.jspf' %>

<%-- SGU : inspiré de "doPortletNavigateFullDisplay.jsp"
    On adapte la liste au design system et on gère les extradatas de catégories (libellé, target)
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
    <section class="ds44-container-fluid ds44-bgGray ds44--l-padding-tb">
        <ul class="ds44-list ds44-flex-container ds44-footerList">
            <jalios:foreach collection='<%= navigateSet %>' type="Category" name="itCategory">
                <jalios:if predicate='<%= itCategory.canBeReadBy(loggedMember , true, true) %>'>
                    <%
                    String cible= "";
                    String title = "";
                    String lien = itCategory.getDisplayUrl(userLocale);
                    String libelleCat = Util.notEmpty(itCategory.getExtraData("extra.Category.plugin.tools.synonyme.facet.title")) ? itCategory.getExtraData("extra.Category.plugin.tools.synonyme.facet.title") : itCategory.getName(userLang);
                    boolean targetBlank = "true".equals(itCategory.getExtraData("extra.Category.plugin.tools.blank")) ? true : false;
                    if(targetBlank){
                        cible="target=\"_blank\" ";
                        title = "title=\"" + libelleCat + " " + JcmsUtil.glp(userLang, "jcmsplugin.socle.accessibily.newTabLabel")+"\"";
                    }
                    %>
                    
                    <jalios:select>
                        <jalios:if predicate='<%= itCategory.equals(currentCategory) %>'>
                            <li class="ds44-footerLink" aria-current="location">
                                <%= libelleCat %>
                            </li>        
                        </jalios:if>
                        <jalios:default>
                            <li class="ds44-footerLink">
                                <a href="<%= lien %>" <%=title%> <%=cible%>><%= libelleCat %></a>
                            </li>
                        </jalios:default>
                    </jalios:select>
                </jalios:if>
            </jalios:foreach>
            
            <!-- Lien "cookies présent systématiquement pour ouvrir la modale Orejime -->
            <li class="ds44-footerLink">
                <a href="javascript:;" class="ds44-js-orejime-show" role="button" tabindex="0" lang="en"><%= glp("jcmsplugin.socle.cookies") %></a>
            </li>
        </ul>
    </section>
</jalios:if>
