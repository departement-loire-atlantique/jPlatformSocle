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

FicheEquipement pub = (FicheEquipement) data;

boolean hasBottomInfos = Util.notEmpty(pub.getThematique(loggedMember)) || (Util.notEmpty(pub.getMontantDeLaSubvention()) && pub.getMontantDeLaSubvention() > 0);
%>

<section class="ds44-card ds44-js-card ds44-card--contact ds44-bgGray">
    <div class="ds44-card__section">
        <div class="ds44-innerBoxContainer">
            <p class="h4-like ds44-cardTitle" id="tuileEquipement_<%= pub.getId() %>">
                <a href="<%= pub.getDisplayUrl(userLocale) %>" class="ds44-card__globalLink"><%= pub.getTitle() %></a>
            </p>
            <jalios:if predicate="<%= hasBottomInfos %>">
	            <hr class="mbs" aria-hidden="true">
	            <jalios:if predicate="<%= Util.notEmpty(pub.getThematique(loggedMember)) %>">
	            <p class="ds44-docListElem ds44-mt-std"><i class="icon icon-tag ds44-docListIco" aria-hidden="true"></i>
                    <%= SocleUtils.formatCategories(pub.getThematique(loggedMember)) %>
                </p>
	            </jalios:if>
	            <jalios:if predicate="<%= Util.notEmpty(pub.getMontantDeLaSubvention()) && pub.getMontantDeLaSubvention() > 0 %>">
	            <p class="ds44-mt1"><strong><%= glp("jcmsplugin.socle.financementDep") %> :</strong><br/><%= SocleUtils.formatPrice(pub.getMontantDeLaSubvention()) %> <%= glp("jcmsplugin.socle.symbol.euro") %></p>
	            </jalios:if>
            </jalios:if>
        </div>
        <i class="icon icon-arrow-right ds44-cardArrow" aria-hidden="true"></i>
    </div>
</section>