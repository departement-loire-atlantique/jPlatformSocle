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

PressCommunique pub = (PressCommunique) data;

%>

<section class="ds44-card ds44-js-card ds44-card--contact ds44-bgGray">
    <div class="ds44-card__section">
        <div class="ds44-innerBoxContainer">
            <h3 class="h4-like ds44-cardTitle" id="tuilePressCommunique_<%= pub.getId() %>"><a href="<%= pub.getDisplayUrl(userLocale) %>" class="ds44-card__globalLink"><%= pub.getTitle() %></a></h3>
            <hr class="mbs" aria-hidden="true">
            <p class="ds44-docListElem ds44-mt-std"><i class="icon icon-date ds44-docListIco" aria-hidden="true"></i><jalios:date format="dd/MM/yyyy" date="<%= pub.getPdate() %>"/></p>
            
        </div>
        <i class="icon icon-arrow-right ds44-cardArrow" aria-hidden="true"></i>
    </div>
</section>