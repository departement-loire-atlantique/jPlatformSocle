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

Contact pub = (Contact) data;
String uid = ServletUtil.generateUniqueDOMId(request, "uid");

%>

<section class='ds44-card ds44-box ds44-bgGray <%= Util.notEmpty(request.getParameter("wysiwygEmbed")) ? "large-w50" : ""%>'>
  <div class="ds44-flex-container ds44-flex-valign-center">
    <jalios:if predicate='<%= Util.notEmpty(pub.getPhotoDidentite()) %>'>
	    <div class="ds44-card__section--horizontal--img">
	      <picture class="ds44-container-imgRatio ds44-container-imgRatio--profil ds44-m-std ">
	       <img src="<%= pub.getPhotoDidentite() %>" alt="" class="ds44-w100 ds44-imgRatio ds44-imgRatio--profil">
	      </picture>
	   </div>
   </jalios:if>
    <div class="ds44-card__section--horizontal">
      <p role="heading" aria-level="2" class="ds44-card__title" id="tuileContact_<%= uid %>"><%= pub.getTitle() %></p>
      <jalios:if predicate="<%= Util.notEmpty(pub.getLieuDeRattachement()) %>">
        <p class="ds44-cardLocalisation">
            <i class="icon icon-marker" aria-hidden="true"></i><span class="ds44-iconInnerText"><a title='<%= HttpUtil.encodeForHTMLAttribute(pub.getLieuDeRattachement()) %>' href="<%= pub.getLieuDeRattachement().getDisplayUrl(userLocale) %>"><%= pub.getLieuDeRattachement().getTitle() %></a></span>
        </p>
      </jalios:if>
      <jalios:if predicate="<%= Util.notEmpty(pub.getFonction()) %>">
        <p class="ds44-cardLocalisation">
            <%= pub.getFonction() %>
        </p>
      </jalios:if>
      <jalios:if predicate="<%= Util.notEmpty(pub.getCommunes()) %>">
        <p class="ds44-cardLocalisation"><i class="icon icon-marker" aria-hidden="true"></i><span class="visually-hidden"><%= glp("jcmsplugin.socle.adresse") %></span><span class="ds44-iconInnerText">
	        <jalios:foreach name="itCommune" type="City" array="<%= pub.getCommunes() %>">
	            <%= itCommune.getTitle() %><%= itCounter < pub.getCommunes().length ? ", " : "" %>
	        </jalios:foreach>
        </span></p>
      </jalios:if>
      <jalios:if predicate="<%= Util.notEmpty(pub.getTelephone()) %>">
          <div class="ds44-cardLocalisation ds44-docListElem ds44-mt-std">
            <i class="icon icon-phone ds44-docListIco" aria-hidden="true"></i><span class="visually-hidden"><%= glp("jcmsplugin.socle.telephone") %></span>
            <ul class="ds44-list">
	            <jalios:foreach name="itPhone" type="String" array="<%= pub.getTelephone() %>">
	                <li><ds:phone number="<%= itPhone %>"></ds:phone></li>
	            </jalios:foreach>
            </ul>
          </div>
      </jalios:if>
      <jalios:if predicate="<%= Util.notEmpty(pub.getAdresseMail()) %>">
        <p class="ds44-cardLocalisation"><i class="icon icon-mail" aria-hidden="true"></i><span class="ds44-iconInnerText"><a title='<%= glp("jcmsplugin.socle.contactmail", pub.getTitle(), pub.getAdresseMail()) %>' href="mailto:<%= pub.getAdresseMail() %>" data-statistic='{"name": "declenche-evenement","category": "Contacts","action": "Mailto","label": "<%= HttpUtil.encodeForHTMLAttribute(pub.getTitle()) %>"}'><%= glp("jcmsplugin.socle.contactmail.label") %></a></span></p>
      </jalios:if>
    </div>
  </div>
</section>