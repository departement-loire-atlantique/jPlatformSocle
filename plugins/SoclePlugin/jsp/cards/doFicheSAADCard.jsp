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

FicheSAAD pub = (FicheSAAD) data;

String uid = ServletUtil.generateUniqueDOMId(request, "uid");
boolean isFocus = "true".equals(request.getParameter("isFocus"));

%>

<section class='ds44-card ds44-js-card ds44-card--contact ds44-box ds44-bgGray<%= isFocus ? " ds44-cardIsFocus" : "" %>'>
    
    <div class="ds44-card__section">
      
      <div class="ds44-innerBoxContainer">
          <p role="heading" aria-level="2" class="h4-like ds44-cardTitle" id="tuileSaad_<%= uid %>">
            <a href="<%= pub.getDisplayUrl(userLocale) %>" class="ds44-card__globalLink"><%= pub.getTitle() %></a>
          </p>
          <hr class="mbs" aria-hidden="true">
          <p class="ds44-docListElem ds44-mt-std">
            <i class="icon icon-tag ds44-docListIco" aria-hidden="true"></i>
            <%= SocleUtils.formatCategories(pub.getModesDintervention(loggedMember)) %>
          </p>
		  <div class="ds44-docListElem ds44-mt-std">
			<i class="icon icon-marker ds44-docListIco" aria-hidden="true"></i><span class="visually-hidden"><%= glp("jcmsplugin.socle.adresse") %></span>
			<jalios:wysiwyg><%= pub.getAdresse() %></jalios:wysiwyg>
		  </div>
		  <p class="ds44-docListElem ds44-mt-std">
			<i class="icon icon-phone ds44-docListIco" aria-hidden="true"></i><span class="visually-hidden"><%= glp("jcmsplugin.socle.telephone") %></span>
			<%= pub.getTelephone() %>
		  </p>
      </div>
      <i class="icon icon-arrow-right ds44-cardArrow" aria-hidden="true"></i>
    </div>
</section>