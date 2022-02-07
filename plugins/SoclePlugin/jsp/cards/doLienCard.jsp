<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%>
<%@ include file='/jcore/doInitPage.jspf' %><%
%><%@ page import="com.jalios.jcms.taglib.card.*" %><%
%><%@ include file='/jcore/media/mediaTemplateInit.jspf' %><%
%><%

if (data == null) {
  return;
}

Lien pub = (Lien) data;

String uid = ServletUtil.generateUniqueDOMId(request, "uid");

Category tagRootCat = channel.getCategory((String)request.getAttribute("tagRootCatId"));

Boolean displayCommunesConcernees = "true".equals(request.getParameter("afficheCommunes"));
Boolean displayEPCIConcernees = "true".equals(request.getParameter("afficheEpci"));

%>

<section class="ds44-card ds44-js-card ds44-card--contact ds44-box ds44-bgGray  ">
    
    <%@ include file="cardPictureCommons.jspf" %>
    
    <div class="ds44-card__section">
        <div class="ds44-innerBoxContainer">
            <p class="h4-like ds44-cardTitle" id="titleFicheArticle_<%= uid %>">
                <jalios:select>
                    <jalios:if predicate="<%= Util.notEmpty(pub.getLienInterne()) %>">
                        <a href="<%= pub.getLienInterne().getDisplayUrl(userLocale) %>" class="ds44-card__globalLink"><%= pub.getTitle() %></a>
                    </jalios:if>
                    <jalios:default>
                         <a href="<%= pub.getLienExterne() %>" target="_blank" class="ds44-card__globalLink"><%= pub.getTitle() %></a>
                    </jalios:default>
                </jalios:select>
            </p>
          <jalios:if predicate="<%= Util.notEmpty(tagRootCat) %>">
            <% 
              Set<Category> allTagChildren = new TreeSet<Category>(new Category.DeepOrderComparator());
              for (Category itCat : pub.getCategorySet()) {
                if (itCat.hasAncestor(tagRootCat)) {
                  allTagChildren.add(itCat);
                }
              }
            %>
            <jalios:if predicate="<%= Util.notEmpty(allTagChildren) %>">
                <hr class="mbs" aria-hidden="true">
                <p class="ds44-docListElem ds44-mt-std"><i class="icon icon-tag ds44-docListIco" aria-hidden="true"></i>
                    <%= SocleUtils.formatCategories(allTagChildren) %>
                </p>
            </jalios:if>
          </jalios:if>
          
          <jalios:if predicate="<%= displayCommunesConcernees && Util.notEmpty(pub.getCommunes()) %>">
              <p class="ds44-docListElem ds44-mt-std"><i class="icon icon-marker ds44-docListIco" aria-hidden="true"></i><span class="visually-hidden"><%= glp("jcmsplugin.socle.fichearticle.tuile.communes.label") %> : </span><%= JcmsUtil.join(Arrays.asList(pub.getCommunes()), ", ", userLang) %></p>
          </jalios:if>
          
          <jalios:if predicate="<%= displayEPCIConcernees && Util.notEmpty(pub.getEpci(loggedMember)) %>">
              <p class="ds44-docListElem ds44-mt-std"><i class="icon icon-marker ds44-docListIco" aria-hidden="true"></i><span class="visually-hidden"><%= glp("jcmsplugin.socle.fichearticle.tuile.epci.label") %> : </span><%= JcmsUtil.join(pub.getEpci(loggedMember), ", ", userLang) %></p>
          </jalios:if>
          
          
      </div>
      <i class="icon icon-arrow-right ds44-cardArrow" aria-hidden="true"></i>
    </div>
</section>