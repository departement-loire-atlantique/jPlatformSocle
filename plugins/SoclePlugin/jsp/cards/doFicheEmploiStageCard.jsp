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
String uid = ServletUtil.generateUniqueDOMId(request, "uid");
boolean isEmploiWithSuffixe = Util.notEmpty(pub.getCategorieDemploi(loggedMember)) && pub.getCategorieDemploi(loggedMember).first().getParent().equals(channel.getCategory("$jcmsplugin.socle.emploiStage.emploi.root"));
%>

<section class="ds44-card ds44-js-card ds44-card--contact ds44-box ds44-bgGray">

    <jalios:if predicate="<%= Util.notEmpty(pub.getImage()) %>">
        <%@ include file="cardPictureCommons.jspf" %>
    </jalios:if>
    
    <div class="ds44-card__section">
		<div class="ds44-innerBoxContainer ds44-mb2">
			<h4 class="h4-like ds44-cardTitle" id="tuileEmploi_<%= pub.getId() %>"><a href="<%= pub.getDisplayUrl(userLocale) %>" class="ds44-card__globalLink"><%= pub.getTitle() %></a></h4>
			<hr class="mbs" aria-hidden="true">

			<jalios:if predicate="<%= Util.notEmpty(pub.getCategorieDemploi(loggedMember)) %>">
				<p class="ds44-docListElem ds44-mt-std">
				    <i class="icon icon-tag ds44-docListIco" aria-hidden="true"></i>
					   <jalios:select>
						   <jalios:if predicate="<%= isEmploiWithSuffixe %>">
							   <span>
							      <%= glp("jcmsplugin.socle.ficheemploi.label.emploi", glp("jcmsplugin.socle.ficheemploi.label.catemploi", pub.getCategorieDemploi(loggedMember).first())) %>
							   </span>
							   <jalios:if predicate="<%= Util.notEmpty(pub.getCategorieDemploi(loggedMember).first().getDescription()) %>">
							   <button type="button" class="js-simple-tooltip button" data-simpletooltip-content-id="tooltip-case_<%= uid %>">
		                           <i class="icon icon-help" aria-hidden="true"></i><span class="visually-hidden"><%= JcmsUtil.glp(userLang, "jcmsplugin.socle.tooltip", pub.getCategorieDemploi(loggedMember).first().getDescription()) %></span>
		                       </button>
	                           </jalios:if>
						   </jalios:if>
						   <jalios:default>
							   <span>
							      <%= glp("jcmsplugin.socle.ficheemploi.label.catemploi", pub.getCategorieDemploi(loggedMember).first()) %>
							   </span>
						   </jalios:default>
					   </jalios:select>
				</p>
				<jalios:if predicate="<%= isEmploiWithSuffixe && Util.notEmpty(pub.getCategorieDemploi(loggedMember).first().getDescription()) %>">
				  <p id="tooltip-case_<%= uid %>" class="hidden"><%= pub.getCategorieDemploi(loggedMember).first().getDescription() %></p>
				</jalios:if>
			</jalios:if>
			<jalios:if predicate="<%= Util.notEmpty(pub.getDuree()) %>">
				<p class="ds44-docListElem ds44-mt-std"><i class="icon icon-time ds44-docListIco" aria-hidden="true"></i>
				    <jalios:select>
					    <%-- Emploi --%>
					    <jalios:if predicate='<%= pub.getTypeDoffre(loggedMember).first().equals(channel.getCategory("$jcmsplugin.socle.emploiStage.typeEmploi.root"))
					       || pub.getTypeDoffre(loggedMember).first().getParent().equals(channel.getCategory("$jcmsplugin.socle.emploiStage.typeEmploi.root")) %>'>
					        <%= pub.getTypeDoffre(loggedMember).first()%><jalios:if predicate='<%= !pub.getTypeDoffre(loggedMember).equals(channel.getCategory("$jcmsplugin.socle.emploiStage.emploiPermanent")) %>'>- <%= pub.getDuree() %></jalios:if>
					    </jalios:if>
					    <%-- Autre que emploi --%>
					    <jalios:default>
					       <%= pub.getDuree() %>
					    </jalios:default>
				    </jalios:select>
				</p>
			</jalios:if>
			<p class="ds44-docListElem ds44-mt-std"><i class="icon icon-date ds44-docListIco" aria-hidden="true"></i>
			  <%= JcmsUtil.glp(userLang, "jcmsplugin.socle.ficheemploi.label.datelimite", SocleUtils.formatDate("dd/MM/yy", pub.getDateLimiteDeDepot())) %>
			</p>
			<jalios:if predicate="<%= Util.notEmpty(pub.getDirectiondelegation(loggedMember)) %>">
            <%
	        SortedSet<Category> catsWithoutServices = pub.getDirectiondelegation(loggedMember);
            if (Util.notEmpty(catsWithoutServices)) {
              catsWithoutServices.remove(channel.getCategory("$jcmsplugin.socle.emploiStage.delegationService"));
            }
	        %>
	        <p class="ds44-docListElem ds44-mt-std">
			    <i class="icon icon-marker ds44-docListIco" aria-hidden="true"></i>
			    <jalios:if predicate="<%= Util.notEmpty(catsWithoutServices) %>">
			         <%= SocleUtils.formatCategories(pub.getDirectiondelegation(loggedMember)) %> - 
			    </jalios:if>
			    <%= pub.getCommune() %>
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
