<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@ include file='/jcore/doInitPage.jspf' %><%
%><%@ page import="com.jalios.jcms.taglib.card.*" %><%
%><%@ include file='/jcore/media/mediaTemplateInit.jspf' %><%
%><%

if (data == null) {
  return;
}

FicheActionEducative pub = (FicheActionEducative) data;

String uid = ServletUtil.generateUniqueDOMId(request, "uid");
%>


<section class="ds44-card ds44-js-card ds44-card--contact ds44-box ds44-bgGray  ">
    <jalios:if predicate="<%= Util.notEmpty(pub.getImageMobile()) %>">
        <% request.setAttribute("forcedImgUrl", pub.getImageMobile()); %>
        <%@ include file="cardPictureCommons.jspf" %>
        <% request.removeAttribute("forcedImgUrl"); %>
    </jalios:if>
    
    <div class="ds44-card__section">
        <div class="ds44-innerBoxContainer">
            <p role="heading" aria-level="2" class="h4-like ds44-cardTitle" id="tuileActionEdu_<%= uid %>">
                <a href="<%= pub.getDisplayUrl(userLocale) %>" class="ds44-card__globalLink"><%= pub.getTitle() %></a>
            </p>
            <hr class="mbs"aria-hidden="true" />
            <p class="ds44-docListElem ds44-mt-std"><i class="icon icon-tag ds44-docListIco" aria-hidden="true"></i><%= SocleUtils.formatCategories(pub.getFormat(loggedMember)) %></p>
            <p class="ds44-docListElem ds44-mt-std"><i class="icon icon-user-group ds44-docListIco" aria-hidden="true"></i><%= SocleUtils.formatCategories(pub.getNiveau(loggedMember)) %></p>
            <div class="ds44-docListElem ds44-mt-std"><i class="icon icon-date ds44-docListIco" aria-hidden="true"></i><jalios:wysiwyg><%= pub.getDepotDuDossier().replaceFirst("<p>", "<p>" + glp("jcmsplugin.socle.actuedu.depotdossier.label") + " ") %></jalios:wysiwyg></div>
        </div>
        <i class="icon icon-arrow-right ds44-cardArrow" aria-hidden="true"></i>
    </div>
</section>