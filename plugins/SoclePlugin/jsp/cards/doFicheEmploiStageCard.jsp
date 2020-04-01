<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@ include file='/jcore/doInitPage.jspf' %><%
%><%@ page import="com.jalios.jcms.taglib.card.*" %><%
%><%@ include file='/jcore/media/mediaTemplateInit.jspf' %><%
%><%

if (data == null) {
  return;
}

FicheEmploiStage pub = (FicheEmploiStage) data;

%>

<section class="ds44-card ds44-js-card ds44-card--contact ds44-box ds44-bgGray">

    <%@ include file="cardPictureCommons.jspf" %>
       
    <div class="ds44-card__section">
		<div class="ds44-innerBoxContainer ds44-mb2">
			<h4 class="h4-like ds44-cardTitle"><a href="<%= pub.getDisplayUrl(userLocale) %>" class="ds44-card__globalLink"><%= pub.getTitle() %></a></h4>
			<hr class="mbs" aria-hidden="true">
			<jalios:if predicate="<%= Util.notEmpty(pub.getCategorieDemploi(loggedMember)) %>">
				<p class="ds44-docListElem ds44-mt-std">
				    <i class="icon icon-tag ds44-docListIco" aria-hidden="true"></i>
					<span><%= JcmsUtil.glp(userLang, "jcmsplugin.socle.ficheemploi.label.catemploi", pub.getCategorieDemploi(loggedMember).first()) %></span>
					<jalios:if predicate="<%= Util.notEmpty(pub.getCategorieDemploi(loggedMember).first().getDescription()) %>">
						<button type="button" class="js-simple-tooltip button" data-simpletooltip-content-id="tooltip-case_1">
						    <i class="icon icon-help" aria-hidden="true"></i><span class="visually-hidden"><%= JcmsUtil.glp(userLang, "jcmsplugin.socle.tooltip", pub.getCategorieDemploi(loggedMember).first()) %></span>
						</button>
					</jalios:if>
				</p>
				<jalios:if predicate="<%= Util.notEmpty(pub.getCategorieDemploi(loggedMember).first().getDescription()) %>">
	              <p id="tooltip-case_<%= pub.getId() %>" class="hidden"><%= pub.getCategorieDemploi(loggedMember).first().getDescription() %></p>
	            </jalios:if>
			</jalios:if>
			<jalios:if predicate="<%= Util.notEmpty(pub.getDuree()) %>">
				<p class="ds44-docListElem ds44-mt-std"><i class="icon icon-time ds44-docListIco" aria-hidden="true"></i>
				    <%= pub.getTypeDoffre(loggedMember).first()%> - <%= pub.getDuree() %>
				</p>
			</jalios:if>
			<p class="ds44-docListElem ds44-mt-std"><i class="icon icon-date ds44-docListIco" aria-hidden="true"></i>
			  <%= JcmsUtil.glp(userLang, "jcmsplugin.socle.ficheemploi.label.datelimite", SocleUtils.formatDate("dd/MM/yy", pub.getDateLimiteDeDepot())) %>
			</p>
			<jalios:if predicate="<%= Util.notEmpty(pub.getDirectiondelegation(loggedMember)) %>">
			<p class="ds44-docListElem ds44-mt-std">
			  <i class="icon icon-marker ds44-docListIco" aria-hidden="true"></i>
			  <%= SocleUtils.formatCategories(pub.getDirectiondelegation(loggedMember)) %>
			</p>
			</jalios:if>
			<hr class="mbs" aria-hidden="true">
			<jalios:if predicate="<%= Util.notEmpty(pub.getTexteentete()) %>">
			  <jalios:wysiwyg><%= pub.getTexteentete() %></jalios:wysiwyg>
			</jalios:if>
		</div>
		<i class="icon icon-arrow-right ds44-cardArrow" aria-hidden="true"></i>
    </div>
</section>
