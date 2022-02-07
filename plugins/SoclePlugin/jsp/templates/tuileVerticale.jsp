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

<%@include file="tuileCommon.jsp" %>

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

%>

<section class='ds44-card ds44-js-card ds44-card--verticalPicture <%= isGpla ? "ds44-darkContext" : "" %> <%=styleContext%> <%= isInSixPanelsContext ? "ds44-posRel" : "" %>'>
	<ds:figurePicture pub="<%= pub %>" format="<%= formatTuile %>" pictureCss='<%= isInSixPanelsContext ? "" : "ds44-container-imgRatio" %>' imgCss='<%= isInSixPanelsContext ? "" : "ds44-imgRatio" %>' alt="<%= imageAlt %>"></ds:figurePicture>
    <div class="ds44-card__section">
        <p class="ds44-card__title">
            <a class="ds44-card__globalLink" href="<%= urlPub %>" <%=titleAttr%> <%=targetAttr%>>
                <jalios:select>
                    <jalios:if predicate="<%= isGpla && data instanceof Lien && Util.notEmpty(((Lien)data).getPicto()) %>">
                        <% Lien lien = (Lien) data; %>
                        <span class="visually-hidden"><%= pub.getTitle(userLang) %></span>
                        <img src="<%= lien.getPicto() %>" alt="<%= HttpUtil.encodeForHTMLAttribute(lien.getTexteAlternatif(userLang)) %>" class="ds44-logoCard"/>
                    </jalios:if>
                    <jalios:default>
                        <%= pub.getTitle(userLang) %>
                    </jalios:default>
                </jalios:select>
            </a>
        </p>
        <jalios:if predicate="<%= isDoc %>">
            <p class="ds44-cardFile"><%= fileType %> - <%= fileSize %></p>
        </jalios:if>
        <jalios:if predicate="<%= isDossier %>">
            <%
            Dossier tmpDossier = (Dossier) pub;
            %>
            <jalios:if predicate="<%= Util.notEmpty(tmpDossier.getDate()) %>">
                <p class='ds44-cardDate'>
                     <%= SocleUtils.formatDate("dd/MM/yy", tmpDossier.getDate()) %>
                </p>
            </jalios:if>
        </jalios:if>
        <jalios:if predicate="<%= Util.notEmpty(subTitle) %>">
            <p class='ds44-cardDate'>
                <%= subTitle %>
            </p>
        </jalios:if>
        <jalios:if predicate="<%= Util.notEmpty(location) %>">
            <p class="ds44-cardLocalisation">
                <i class="icon icon-marker" aria-hidden="true"></i><span class="ds44-iconInnerText"><%= location %></span>
            </p>
        </jalios:if>        
        <i class="icon icon-arrow-right ds44-cardArrow" aria-hidden="true"></i>
    </div>
</section>