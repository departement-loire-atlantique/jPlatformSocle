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

<section class="ds44-card ds44-js-card ds44-card--verticalPicture ds44-card--verticalPicture--elu">
    <picture class="ds44-container-imgRatio ds44-container-imgRatio--profil">
      <img src="../../assets/images/medaillon-touchefeu.jpg" alt="" class="ds44-w100 ds44-imgRatio ds44-imgRatio--profil">
    </picture>
    <div class="ds44-card__section">
      <p role="heading" aria-level="2" class="ds44-card__title">
        <a href="#" class="ds44-card__globalLink" title="Fiche détaillée de Catherine Touchefeu">Catherine Touchefeu</a>
      </p>
      <p>Parti Socialiste (PS)</p>
      <i class="icon icon-arrow-right ds44-cardArrow" aria-hidden="true"></i>
    </div>
</section>