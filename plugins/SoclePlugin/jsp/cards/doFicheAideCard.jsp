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

%>

<section class="ds44-card ds44-js-card ds44-card--contact ds44-box ds44-bgGray ">
    
      <picture class="ds44-container-imgRatio">
          <img src="../../assets/images/ds44-logo--sampleImg.png" alt="" class="ds44-imgRatio">
      </picture>
    
    <div class="ds44-card__section">
        <div class="ds44-innerBoxContainer">
            <h4 class="h4-like ds44-cardTitle"><a href="#" class="ds44-card__globalLink">Accueil familial social</a></h4>
            <hr class="mbs" aria-hidden="true">
            <p class="ds44-docListElem ds44-mt-std"><i class="icon icon-tag ds44-docListIco" aria-hidden="true"></i>Autonomie</p>
            <p class="ds44-docListElem ds44-mt-std"><i class="icon icon-user ds44-docListIco" aria-hidden="true"></i>Personnes en situation de handicap, personnes âgées</p>
            <p class="ds44-mt-std"><strong>Besoin :</strong> se loger</p>
            <p class="ds44-mt-std"><strong>Type d'aide :</strong> financière, accompagnement</p>
        </div>

        <i class="icon icon-arrow-right ds44-cardArrow" aria-hidden="true"></i>

    </div>
</section>