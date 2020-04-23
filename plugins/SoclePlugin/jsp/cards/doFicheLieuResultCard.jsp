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

FicheLieu pub = (FicheLieu) data;
String uid = ServletUtil.generateUniqueDOMId(request, "uid");
boolean isFocus = "true".equals(request.getParameter("isFocus"));
%>

<section class='ds44-card ds44-js-card ds44-card--contact ds44-bgGray<%= !pub.getServiceDuDepartement() ? " ds44-cardIsPartner" : "" %><%= isFocus ? " ds44-cardIsFocus" : "" %>'>
    <div class="ds44-card__section">
        
        <jalios:if predicate="<%= !pub.getServiceDuDepartement() %>">
            <p class="ds44-cardPartner pal"><%= glp("jcmsplugin.socle.partenaire") %></p>
        </jalios:if>
        
        <div class="ds44-innerBoxContainer">
            <h4 class="h4-like ds44-cardTitle" id="titleTuileLieuCard_<%= uid %>"><a href="<%= pub.getDisplayUrl(userLocale) %>" class="ds44-card__globalLink"><%= pub.getTitle() %></a></h4>
            <hr class="mbs" aria-hidden="true">
            <jalios:if predicate="<%= pub.getComplementTypeDacces() %>">
                <p class="ds44-docListElem ds44-mt-std"><i class="icon icon-attention ds44-docListIco" aria-hidden="true"></i><%= pub.getComplementTypeDacces() %></p>
            </jalios:if>
            <jalios:if predicate="<%= Util.notEmpty(pub.getBesoins(loggedMember)) %>">
                <p class="ds44-docListElem ds44-mt-std"><i class="icon icon-tag ds44-docListIco" aria-hidden="true"></i><%= SocleUtils.formatCategories(pub.getBesoins(loggedMember)) %></p>
            </jalios:if>
            <jalios:if predicate="<%= Util.notEmpty(pub.getPublics(loggedMember)) %>">
                <p class="ds44-docListElem ds44-mt-std"><i class="icon icon-user ds44-docListIco" aria-hidden="true"></i><%= SocleUtils.formatCategories(pub.getPublics(loggedMember)) %></p>
            </jalios:if>
        </div>
        <i class="icon icon-arrow-right ds44-cardArrow" aria-hidden="true"></i>
    </div>
</section>