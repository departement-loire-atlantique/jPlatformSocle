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
       <img src="<%= mbr.getPhoto() %>" alt="" class="ds44-w100 ds44-imgRatio ds44-imgRatio--profil">
      </picture>
   </div>
    <div class="ds44-card__section--horizontal">
      <p role="heading" "aria-level="2" class="ds44-card__title"><%= mbr.getFullName() %></p>
      <jalios:if predicate="<%= Util.notEmpty(mbr.getLocality()) %>">
        <p class="ds44-cardLocalisation"><i class="icon icon-marker" aria-hidden="true"></i><span class="ds44-iconInnerText"><%= mbr.getLocality() %></span></p>
      </jalios:if>
      <jalios:if predicate="<%= Util.notEmpty(mbr.getPhone()) %>">
        <p class="ds44-cardLocalisation"><i class="icon icon-phone" aria-hidden="true"></i><span class="ds44-iconInnerText"><ds:phone number="<%= mbr.getPhone() %>"></ds:phone></span></p>
      </jalios:if>
      <jalios:if predicate="<%= Util.notEmpty(mbr.getEmail()) %>">
        <p class="ds44-cardLocalisation"><i class="icon icon-mail" aria-hidden="true"></i><span class="ds44-iconInnerText"><a title='<%= glp("jcmsplugin.socle.contactmail", mbr.getFullName(), mbr.getEmail()) %>' href="mailto:<%= mbr.getEmail() %>"><%= glp("jcmsplugin.socle.contactmail.label") %></a></span></p>
      </jalios:if>
    </div>
  </div>
</section>