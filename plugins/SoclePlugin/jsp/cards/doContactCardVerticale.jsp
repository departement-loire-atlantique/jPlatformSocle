<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@ include file='/jcore/doInitPage.jspf' %>
<%@ page import="com.jalios.jcms.taglib.card.*" %>
<%@ include file='/jcore/media/mediaTemplateInit.jspf' %>
<%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%><%

  if (data == null) {
  return;
}

Publication pub = (Publication) data;

%>

<%@include file="/plugins/SoclePlugin/jsp/templates/tuileCommon.jsp" %>

<%
SimpleDateFormat sdf = new SimpleDateFormat(glp("date-format"));

try {
    subTitle = sdf.format((Date) pub.getFieldValue("dateActu"));
} catch(Exception e) {}

try {
    location = (String) pub.getFieldValue("lieu");
} catch(Exception e) {}

String imageAlt = "-1"; // dans figurePicture, si la valeur de "alt" est à -1 on force le champ alt vide sauf si Lien (autrement, il ira chercher un alt dans le contenu)

String formatTuile = isLargeTuile ? "principale" : "carrousel";

boolean isGpla = Util.notEmpty(request.getParameter("context")) && "gpla".equalsIgnoreCase(request.getParameter("context"));
Contact contact = (Contact) data;
%>

<section class='ds44-card ds44-js-card ds44-card--verticalPicture <%= isGpla ? "ds44-darkContext" : "" %> <%=styleContext%> <%= isInSixPanelsContext ? "ds44-posRel" : "" %>'>
	<ds:figurePicture pub="<%= pub %>" format="<%= formatTuile %>" image="<%= ((Contact)pub).getPhotoDidentite() %>" pictureCss='<%= isInSixPanelsContext ? "" : "ds44-container-imgRatio" %>' imgCss='<%= isInSixPanelsContext ? "" : "ds44-imgRatio" %>' alt="<%= imageAlt %>"></ds:figurePicture>
    <div class="ds44-card__section">
      <p class="ds44-cardTitle h4-like" role="heading">
          <a class="ds44-card__globalLink" href="<%= urlPub %>" <%=titleAttr%> <%=targetAttr%>>
              <%= pub.getTitle(userLang) %>
          </a>
      </p>
      <jalios:if predicate="<%= Util.notEmpty(contact.getLieuDeRattachement()) %>">
        <p class="ds44-cardLocalisation">
            <i class="icon icon-tag" aria-hidden="true"></i><span class="ds44-iconInnerText"><a title='<%= HttpUtil.encodeForHTMLAttribute(contact.getLieuDeRattachement().getTitle()) %>' href="<%= contact.getLieuDeRattachement().getDisplayUrl(userLocale) %>"><%= contact.getLieuDeRattachement().getTitle() %></a></span>
        </p>
      </jalios:if>
      <jalios:if predicate="<%= Util.notEmpty(contact.getFonction()) %>">
        <p class="ds44-cardLocalisation">
            <%= contact.getFonction() %>
        </p>
      </jalios:if>
      <jalios:if predicate="<%= Util.notEmpty(contact.getCommunes()) %>">
        <p class="ds44-cardLocalisation"><i class="icon icon-marker" aria-hidden="true"></i><span class="visually-hidden"><%= glp("jcmsplugin.socle.adresse") %> : </span><span class="ds44-iconInnerText">
            <jalios:foreach name="itCommune" type="City" array="<%= contact.getCommunes() %>">
                <%= itCommune.getTitle() %><%= itCounter < contact.getCommunes().length ? ", " : "" %>
            </jalios:foreach>
        </span></p>
      </jalios:if>
      <jalios:if predicate="<%= Util.notEmpty(contact) %>">
          <div class="ds44-cardLocalisation ds44-docListElem ds44-mt-std">
            <i class="icon icon-phone ds44-docListIco" aria-hidden="true"></i><span class="visually-hidden"><%= glp("jcmsplugin.socle.telephone") %> : </span>
            <ul class="ds44-list">
                <jalios:foreach name="itPhone" type="String" array="<%= contact.getTelephone() %>">
                    <li><ds:phone number="<%= itPhone %>" pubTitle="<%= pub.getTitle() %>"></ds:phone></li>
                </jalios:foreach>
            </ul>
          </div>
      </jalios:if>
      <jalios:if predicate="<%= Util.notEmpty(contact.getAdresseMail()) %>">
        <p class="ds44-cardLocalisation"><i class="icon icon-mail" aria-hidden="true"></i><span class="ds44-iconInnerText"><a title='<%= HttpUtil.encodeForHTMLAttribute(glp("jcmsplugin.socle.contactmail", pub.getTitle(), contact.getAdresseMail())) %>' href="mailto:<%= contact.getAdresseMail() %>" data-statistic='{"name": "declenche-evenement","category": "Contacts","action": "Mailto","label": "<%= HttpUtil.encodeForHTMLAttribute(pub.getTitle()) %>"}'><%= glp("jcmsplugin.socle.contactmail.label") %></a></span></p>
      </jalios:if>
        <i class="icon icon-arrow-right ds44-cardArrow" aria-hidden="true"></i>
    </div>
</section>