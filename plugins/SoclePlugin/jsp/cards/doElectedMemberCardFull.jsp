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

ElectedMember pub = (ElectedMember) data;

String fullName = "";

if (Util.notEmpty(pub.getFirstName())) fullName = pub.getFirstName();
if (Util.notEmpty(pub.getNom())) {
  if (Util.notEmpty(pub.getFirstName())) fullName += " ";
  fullName += pub.getNom();
}

String position = "";
String conseillerLabel = "";
if (Util.notEmpty(pub.getFunctions(loggedMember))) {
  if (pub.getFunctions(loggedMember).contains(channel.getCategory("$jcmsplugin.socle.elu.president"))) {
    position = pub.getGender() ? glp("jcmsplugin.socle.elu.president.masculin") : glp("jcmsplugin.socle.elu.president.feminin");
  }
  if (pub.getFunctions(loggedMember).contains(channel.getCategory("$jcmsplugin.socle.elu.vicepresident"))) {
    position = pub.getGender() ? glp("jcmsplugin.socle.elu.vicepresident.masculin") : glp("jcmsplugin.socle.elu.vicepresident.feminin");
  }
  if (pub.getFunctions(loggedMember).contains(channel.getCategory("$jcmsplugin.socle.elu.conseiller"))) {
    position = pub.getGender() ? glp("jcmsplugin.socle.elu.conseiller.masculin") : glp("jcmsplugin.socle.elu.conseiller.feminin");
  }
}

%>

<section class="ds44-card ds44-box ds44-js-card ds44-card--verticalPicture ds44-card--verticalPicture--elu ds44--m-padding-b">
    <jalios:if predicate='<%= Util.notEmpty(pub.getImageMedaillon()) %>'>
    <picture class="ds44-container-imgRatio ds44-container-imgRatio--profilXL">
        <img src="<%= pub.getImageMedaillon() %>" alt="" class="ds44-w100 ds44-imgRatio ds44-imgRatio--profil">
    </picture>
    </jalios:if>
    <div class="ds44-card__section txtleft mts">
        <h4 class="h4-like ds44-cardTitle"><a href="#" class="ds44-card__globalLink" title='<%= glp("jcmsplugin.socle.elu.ficheDetaillee", fullName) %>'><%= fullName %></a></h4>
        <jalios:if predicate="<%= Util.notEmpty(position) %>">
        <p><%= position %></p>
        </jalios:if>
        <hr class="mbm mtm" aria-hidden="true">
        <jalios:if predicate="<%= Util.notEmpty(conseillerLabel) %>">
        <p class="ds44-docListElem ds44-mt-std"><i class="icon icon-tag ds44-docListIco" aria-hidden="true"></i><%= conseillerLabel %></p>
        </jalios:if>
        <p class="ds44-docListElem ds44-mt-std"><i class="icon icon-marker ds44-docListIco" aria-hidden="true"></i><%= glp("jcmsplugin.socle.facette.canton.default-label") %> : <%= pub.getCanton() %></p>
        <hr class="mbm mtm" aria-hidden="true">
        <p class="ds44-mt-std"><%= pub.getPoliticalParty(loggedMember).first() %></p>
        <jalios:if predicate="<%= Util.notEmpty(pub.getDeputy()) %>">
        <p class="ds44-mt-std"><%= glp("jcmsplugin.socle.elu.binome", pub.getDeputy()) %></p>
        </jalios:if>    
        <i class="icon icon-arrow-right ds44-cardArrow" aria-hidden="true"></i>
    </div>
</section>