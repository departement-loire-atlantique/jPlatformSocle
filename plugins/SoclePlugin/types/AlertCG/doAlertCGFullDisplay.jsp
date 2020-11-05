<%@ page contentType="text/html; charset=UTF-8" %><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
%><% AlertCG obj = (AlertCG)request.getAttribute(PortalManager.PORTAL_PUBLICATION); %><%
%><%@ include file='/front/doFullDisplay.jspf' %>

<%
String titleLink = "";
String lblLink = glp("jcmsplugin.socle.etablissementpersonnesagees.savoirplus");
if (Util.notEmpty(obj.getTexteAlternatifLienBouton())) {
  titleLink = glp("jcmsplugin.socle.savoirplus.link", obj.getTexteAlternatifLienBouton());
} else {
  titleLink = glp("jcmsplugin.socle.savoirplus.link", obj.getTitle());
}

boolean externe = false;
String urlLink = "";
if (Util.notEmpty(obj.getLienInterne())) {
  urlLink = obj.getLienInterne().getDisplayUrl(userLocale);
} else if (Util.notEmpty(obj.getLienExterne())) {
  urlLink = obj.getLienExterne();
  externe = true;
  titleLink = glp("jcmsplugin.socle.lien.nouvelonglet", titleLink);
}
%>

<section class="ds44-alertMsg-container txtcenter">
  <ul class="ds44-collapser center">
    <li class="ds44-collapser_element">
        <button type="button" class="ds44-collapser_button show" aria-expanded="false">
          <span class="ds44-card__title"><i class="icon icon-attention" aria-hidden="true"></i><%= obj.getTitle() %></span>
          <i class="icon icon-down icon--sizeXL" aria-hidden="true"></i>
        </button>
        <div class="ds44-collapser_content">
            <div class="ds44-collapser_content--level2">
              <jalios:wysiwyg><%= obj.getSummary() %></jalios:wysiwyg>
              <jalios:if predicate="<%= Util.notEmpty(urlLink) %>">
                  <a href="<%= urlLink %>" class="ds44-btnStd mts" title="<%= titleLink %>"<%= externe ? " target=\"_blank\"" : "" %>><span class="ds44-btnInnerText"><%= lblLink %></span><i class="icon icon-long-arrow-right" aria-hidden="true"></i></a>
              </jalios:if>
            </div>
        </div>
    </li>
  </ul>
</section>