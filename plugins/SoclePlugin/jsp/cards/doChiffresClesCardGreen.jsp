<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%>
<%@ include file='/jcore/doInitPage.jspf' %><%
%><%@ page import="com.jalios.jcms.taglib.card.*" %><%
%><%@ include file='/jcore/media/mediaTemplateInit.jspf' %><%
%><%

if (data == null) {
  return;
}

ChiffresCles pub = (ChiffresCles) data;

// recuperation de l'url de l'icone pour le chiffre principal
String urlImage = SocleUtils.getDescriptionChampCategorie(pub.getIconePrincipale(loggedMember), userLang, channel.getCategory("$jcmsplugin.socle.chiffres-cles.icone-principale.cat"));

%>

<section class="ds44-box ds44-theme">
   <div class="ds44-innerBoxContainer ds44-flex-container ds44-flex-valign-center">
      <picture class="ds44-boxPic ds44-boxPic--light">
         <img src="<%= urlImage %>" alt="">
      </picture>
      <p><strong><span class="ds44-txtExergue"><%= pub.getChiffrePrincipal() %></span></strong><%= HtmlUtil.html2text(pub.getLibelleChiffrePrincipal()) %></p>
   </div>
</section>