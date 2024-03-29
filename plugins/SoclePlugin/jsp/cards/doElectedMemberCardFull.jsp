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

ElectedMember pub = (ElectedMember) data;

String uid = ServletUtil.generateUniqueDOMId(request, "uid");
String fullName = SocleUtils.getElectedMemberFullName(pub);

String position = "";
String conseillerLabel = "";
if (Util.notEmpty(pub.getFunctions(loggedMember))) {
  position = SocleUtils.getElectedMemberFunction(pub);
  if (pub.getFunctions(loggedMember).contains(channel.getCategory("$jcmsplugin.socle.elu.conseiller"))) {
    conseillerLabel = pub.getGender() ? glp("jcmsplugin.socle.elu.conseiller.masculin") : glp("jcmsplugin.socle.elu.conseiller.feminin");
  }
}

String urlImage = pub.getImageMedaillon();
if (Util.isEmpty(urlImage)) urlImage = pub.getPicture();

%>

<section class='ds44-card ds44-box ds44-js-card ds44-card--verticalPicture ds44-card--verticalPicture--elu ds44--m-padding-b <%= Util.notEmpty(request.getParameter("wysiwygEmbed")) ? "large-w50" : ""%>'>
    <ds:figurePicture format="custom" image="<%= pub.getPicture() %>" pictureCss="ds44-container-imgRatio ds44-container-imgRatio--profilXL" imgCss="ds44-imgRatio--profil" width="160" height="160"/>
    <div class="ds44-card__section txtleft mts">
        <p class="h4-like ds44-cardTitle" id="tuileElu_<%= uid %>">
            <a href="<%= pub.getDisplayUrl(userLocale) %>" class="ds44-card__globalLink" title='<%= glp("jcmsplugin.socle.elu.ficheDetaillee", fullName) %>'><%= fullName %></a>
        </p>
        <jalios:if predicate="<%= Util.notEmpty(position) %>">
        <p><%= position %></p>
        </jalios:if>
        <hr class="mbm mtm" aria-hidden="true">
        <jalios:if predicate="<%= Util.notEmpty(conseillerLabel) %>">
        <p class="ds44-docListElem ds44-mt-std"><i class="icon icon-tag ds44-docListIco" aria-hidden="true"></i><%= conseillerLabel %></p>
        </jalios:if>
        <p class="ds44-docListElem ds44-mt-std"><i class="icon icon-marker ds44-docListIco" aria-hidden="true"></i><span class="visually-hidden"><%= glp("jcmsplugin.socle.adresse") %> : </span><%= glp("jcmsplugin.socle.facette.canton.default-label") %> : <%= pub.getCanton() %></p>
        
        <%-- On masque certaines infos si la tuile est insérée dans un bloc wysiwyg (insertion unifiée) --%>
        <jalios:if predicate='<%=Util.isEmpty(request.getParameter("wysiwygEmbed"))%>'>
	        <hr class="mbm mtm" aria-hidden="true">
	        <p class="ds44-mt-std"><%= pub.getPoliticalParty(loggedMember).first() %></p>
	        <% ElectedMember binome = SocleUtils.getElectedMemberBinome(pub); %>
	        <jalios:if predicate="<%= Util.notEmpty(binome) %>">
	        <p class="ds44-mt-std"><%= glp("jcmsplugin.socle.elu.binome", SocleUtils.getElectedMemberFullName(binome)) %></p>
	        </jalios:if>  
        </jalios:if>  
        <i class="icon icon-arrow-right ds44-cardArrow" aria-hidden="true"></i>
    </div>
</section>