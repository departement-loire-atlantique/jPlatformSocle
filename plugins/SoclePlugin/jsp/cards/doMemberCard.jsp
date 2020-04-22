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

Member mbr = (Member) data;

%>

<section class="ds44-box ds44-bgGray">
  <div class="ds44-flex-container ds44-flex-valign-center">
    <div class="ds44-card__section--horizontal--img">
      <picture class="ds44-container-imgRatio ds44-container-imgRatio--profil ds44-m-std ">
       <img src="../../assets/images/sample-img-profil.jpg" alt="" class="ds44-w100 ds44-imgRatio ds44-imgRatio--profil">
      </picture>
   </div>
    <div class="ds44-card__section--horizontal">
      <p role="heading" "aria-level="2" class="ds44-card__title">Carine TROTTIER</p>
      <p class="ds44-cardFile"></p>
      <p class="ds44-cardLocalisation"><i class="icon icon-marker" aria-hidden="true"></i><span class="ds44-iconInnerText">Batz-sur-Mer</span></p>
      <p class="ds44-cardLocalisation"><i class="icon icon-phone" aria-hidden="true"></i><span class="ds44-iconInnerText">06 86 45 82 41</span></p>
      <p class="ds44-cardLocalisation"><i class="icon icon-mail" aria-hidden="true"></i><span class="ds44-iconInnerText"><a href="mailto:contact@loire-atlantique.fr">Contacter par mail</a></span></p>
    </div>
  </div>
</section>