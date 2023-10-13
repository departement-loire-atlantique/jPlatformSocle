<%@page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@ page contentType="text/html; charset=UTF-8" %><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
%><%@ include file='/jcore/portal/doPortletParams.jspf' %>
<%@ include file='/types/PortletNavigate/doInitPortletNavigate.jspf'%>
<% 
PortletNavigate obj = (PortletNavigate)portlet; 

if (((rootCategory == null) || (rootCategory.isLeaf())) && box.getHideWhenNoResults()){
    request.setAttribute("ShowPortalElement",Boolean.FALSE);
    return;
}

// Tri et filtre sur les catégories autorisées
Set<Category> rootSet = SocleUtils.getOrderedAuthorizedChildrenSet(rootCategory);
int maxLevels = box.getLevels();
%>

<div class="grid-12-small-1">
  <jalios:foreach name="itCat" type="Category" collection="<%= rootSet %>">
   <div class="col col-6">
     <a href="<%= itCat.getDisplayUrl(userLocale) %>">
     <div class="ds44-card ds44-js-card ds44-legendeContainer ds44-container-imgRatio ds44-container-imgRatio--tuileMiseEnAvant">
       <img src="<%= itCat.getImage() %>" alt="" class="ds44-w100 ds44-imgRatio">
         <div class="ds44-theme ds44-innerBoxContainer ds44-blockAbsolute ds44-blockAbsolute--bl">
            <p><%= itCat.getName() %></p>
         </div>
     </div>
     </a>
   </div>
  </jalios:foreach>
</div>