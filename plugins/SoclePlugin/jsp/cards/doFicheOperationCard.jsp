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

FicheOperation pub = (FicheOperation) data;
String uid = ServletUtil.generateUniqueDOMId(request, "uid");
boolean isWysiwygEmbed = Util.notEmpty(request.getParameter("wysiwygEmbed"));
%>

<section class='ds44-card ds44-box ds44-bgGray <%= isWysiwygEmbed ? " ds44-wsg-transparent" : ""%>'>
  <div class="ds44-flex-container ds44-flex-valign-center">
   <jalios:if predicate='<%= Util.notEmpty(pub.getImagePrincipale()) %>'>
	    <div class="ds44-card__section--horizontal--img">
	      <picture class="ds44-container-imgRatio ds44-container-imgRatio--profil ds44-m-std ">
	       <img src="<%= pub.getImagePrincipale() %>" alt="" class="ds44-w100 ds44-imgRatio ds44-imgRatio--profil">
	      </picture>
	   </div>
   </jalios:if>
   <div class='ds44-card__section--horizontal <%= isWysiwygEmbed ? "ds44-wsg-noPadding" : "" %>'>
     <p role="heading" aria-level="2" class="ds44-card__title" id="tuileFicheOperation_<%= uid %>"><%= pub.getTitle() %></p>
     <jalios:if predicate="<%= Util.notEmpty(pub.getTypeDeChantier(loggedMember)) %>">
        <p class="ds44-docListElem ds44-mt-std ">
            <i class="icon icon-tag ds44-docListIco" aria-hidden="true"></i>
            <%= SocleUtils.formatCategories(pub.getTypeDeChantier(loggedMember)) %>
        </p>
     </jalios:if>
     <jalios:if predicate="<%= Util.notEmpty(pub.getAmenageur()) %>">
        <p class="ds44-docListElem ds44-mt-std ">
            <i class="icon icon-user ds44-docListIco" aria-hidden="true"></i>
            <%= pub.getAmenageur() %>
        </p>
     </jalios:if>     
   </div>
  </div>
</section>