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

%>

<section class="ds44-card ds44-box ds44-js-card ds44-card--verticalPicture ds44-card--verticalPicture--elu ds44--m-padding-b">
    <picture class="ds44-container-imgRatio ds44-container-imgRatio--profilXL">
        <img src="../../assets/images/medaillon-president.jpg" alt="" class="ds44-w100 ds44-imgRatio ds44-imgRatio--profil">
    </picture>
    <div class="ds44-card__section txtleft mts">
        <h4 class="h4-like ds44-cardTitle"><a href="#" class="ds44-card__globalLink" title="Fiche détaillée de Philippe Grosvalet">Philippe Grosvalet</a></h4>
        <p>président du Département</p>
        <hr class="mbm mtm" aria-hidden="true">
        <p class="ds44-docListElem ds44-mt-std"><i class="icon icon-tag ds44-docListIco" aria-hidden="true"></i>Conseiller départemental</p>
        <p class="ds44-docListElem ds44-mt-std"><i class="icon icon-marker ds44-docListIco" aria-hidden="true"></i>Canton : Saint-Nazaire 2</p>
        <hr class="mbm mtm" aria-hidden="true">
        <p class="ds44-mt-std">Parti Socialiste (PS)</p>
        <p class="ds44-mt-std">En binôme avec : Lydia Meignen</p>
        <i class="icon icon-arrow-right ds44-cardArrow" aria-hidden="true"></i>
    </div>
</section>