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

%>

<section class="ds44-box ds44-bgGray">
  <div class="ds44-flex-container ds44-flex-valign-center">
    <div class="ds44-card__section--horizontal--img">
      <picture class="ds44-container-imgRatio ds44-container-imgRatio--profil ds44-m-std ">
       <img src="<%= pub.getPhotoDidentite() %>" alt="" class="ds44-w100 ds44-imgRatio ds44-imgRatio--profil">
      </picture>
   </div>
    <div class="ds44-card__section--horizontal">
      <p role="heading" "aria-level="2" class="ds44-card__title"><%= pub.getTitle() %></p>
      <jalios:if predicate="<%= Util.notEmpty(pub.getCommunes()) %>">
        <p class="ds44-cardLocalisation"><i class="icon icon-marker" aria-hidden="true"></i><span class="ds44-iconInnerText">
	        <jalios:foreach name="itCommune" type="City" array="<%= pub.getCommunes() %>">
	            <%= itCommune.getTitle() %><%= itCounter < pub.getCommunes().length ? ", " : "" %>
	        </jalios:foreach>
        </span></p>
      </jalios:if>
      <jalios:if predicate="<%= Util.notEmpty(pub.getTelephone()) %>">
        <div class="ds44-cardLocalisation"><i class="icon icon-phone" aria-hidden="true"></i><span class="ds44-iconInnerText">
	        <jalios:if predicate='<%= pub.getTelephone().length == 1 %>'>
	           <% String numTel = pub.getTelephone()[0]; %>
	           <ds:phone number="<%= numTel %>"/>
	        </jalios:if>
	
	        <jalios:if predicate='<%= pub.getTelephone().length > 1 %>'>
			        <jalios:foreach name="numTel" type="String" array="<%= pub.getTelephone() %>">
				            <%= numTel.replaceAll("[^0-9-]","").replaceAll("..", "$0 ") %><%= itCounter < pub.getTelephone().length ? " - " : "" %>
			        </jalios:foreach>
		        </ul>
	        </jalios:if>
	    </span></div>
      </jalios:if>
      <jalios:if predicate="<%= Util.notEmpty(pub.getAdresseMail()) %>">
        <p class="ds44-cardLocalisation"><i class="icon icon-mail" aria-hidden="true"></i><span class="ds44-iconInnerText"><a title='<%= glp("jcmsplugin.socle.contactmail", pub.getTitle(), pub.getAdresseMail()) %>' href="mailto:<%= pub.getAdresseMail() %>"><%= glp("jcmsplugin.socle.contactmail.label") %></a></span></p>
      </jalios:if>
    </div>
  </div>
</section>