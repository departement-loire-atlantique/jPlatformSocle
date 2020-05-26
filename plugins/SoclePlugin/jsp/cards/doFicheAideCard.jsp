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

FicheAide pub = (FicheAide) data;

String uid = ServletUtil.generateUniqueDOMId(request, "uid");

Category tagRootCat = channel.getCategory((String)request.getAttribute("tagRootCatId"));

%>

<section class="ds44-card ds44-js-card ds44-card--contact ds44-box ds44-bgGray ">
     
    <%@ include file="cardPictureCommons.jspf" %>
   
    <div class="ds44-card__section">
        <div class="ds44-innerBoxContainer">
            <p role="heading" aria-level="2" class="h4-like ds44-cardTitle" id="titreTuileFicheAide_<%= uid %>">
                <a href="<%= pub.getDisplayUrl(userLocale) %>" class="ds44-card__globalLink"><%= pub.getTitle() %></a>
            </p>
            <hr class="mbs" aria-hidden="true">
            
            <jalios:if predicate="<%= Util.notEmpty(tagRootCat) %>">
	            <% 
	              List<Category> allTagChildren = new ArrayList<>();
	              for (Category itCat : pub.getCategorySet()) {
	                if (!itCat.isRoot() && itCat.getParent().equals(tagRootCat)) {
	                  allTagChildren.add(itCat);
	                }
	              }
	            %>
	            <jalios:if predicate="<%= Util.notEmpty(allTagChildren) %>">
	                <p class="ds44-docListElem ds44-mt-std"><i class="icon icon-tag ds44-docListIco" aria-hidden="true"></i>
	                    <%= SocleUtils.formatCategories(allTagChildren) %>
	                </p>
	            </jalios:if>
            </jalios:if>

            <jalios:if predicate="<%= Util.notEmpty(pub.getPublics(loggedMember)) %>">
                <p class="ds44-docListElem ds44-mt-std"><i class="icon icon-user ds44-docListIco" aria-hidden="true"></i><%= SocleUtils.formatCategories(pub.getPublics(loggedMember)) %></p>
            </jalios:if>
            <jalios:if predicate="<%= Util.notEmpty(pub.getBesoins(loggedMember)) %>">
                <p class="ds44-mt-std"><strong><%= glp("jcmsplugin.socle.ficheaide.tuile.besoin.label") %></strong> <%= SocleUtils.formatCategories(pub.getBesoins(loggedMember)) %></p>
            </jalios:if>
            <%
            Category typeAideCat = channel.getCategory("$jcmsplugin.socle.ficheaide.typeaide.root");
            List<Category> pubTypeAideCats = new ArrayList<>();
            for (Category itCat : pub.getAnnuaires(loggedMember)) {
              if (itCat.getParent().equals(typeAideCat)) {
                pubTypeAideCats.add(itCat);
              }
            }
            %>
            <jalios:if predicate="<%= Util.notEmpty(pubTypeAideCats) %>">
                <p class="ds44-mt-std"><strong><%= glp("jcmsplugin.socle.ficheaide.tuile.typeAide.label") %></strong> <%= SocleUtils.formatCategories(pubTypeAideCats) %></p>
            </jalios:if>
        </div>

        <i class="icon icon-arrow-right ds44-cardArrow" aria-hidden="true"></i>

    </div>
</section>