<%@ include file="/jcore/doInitPage.jspf" %>
<%@ include file="/jcore/portal/doPortletParams.jspf" %>
<% PortletMiseEnAvantDeContenus box = (PortletMiseEnAvantDeContenus) portlet;  %>
<%@ include file="/types/PortletQueryForeach/doQuery.jspf" %>
<%@ include file="/types/PortletQueryForeach/doSort.jspf" %>

<%
//Gestion du bouton
boolean isLienExterne = Util.isEmpty(box.getLienInterne());
String labelBouton = box.getLabelDuLien();
String urlBouton = "";
String targetAttr = "";
String titleValue = Util.notEmpty(box.getTitreCompletDeLien()) ? box.getTitreCompletDeLien() : labelBouton;

if(isLienExterne){
  urlBouton = box.getLienExterne();
  targetAttr = glp("jcmsplugin.socle.targetblank");
  titleValue = glp("jcmsplugin.socle.lien.site.nouvelonglet", titleValue);
}
else{
  urlBouton = box.getLienInterne().getDisplayUrl(userLocale);  
}
%>

<header class="txtcenter">
	<jalios:if predicate='<%=Util.notEmpty(box.getTitreVisuel(userLang)) %>'>
	    <h2 class="h2-like" id="idTitre2"><%= box.getTitreVisuel(userLang) %></h2>
	</jalios:if>
	<jalios:if predicate='<%=Util.notEmpty(box.getSoustitre()) %>'>
	    <div class="ds44-introduction ds44-hide-tiny-to-medium"><%= box.getSoustitre(userLang) %></div>
	</jalios:if>
</header>

<div class="ds44-results ds44-inner-container">
    <div class="ds44-listResults">
		<ul class="ds44-list ds44-list--results ds44-flex-container">
		  <%@ include file="/types/PortletQueryForeach/doForeachHeader.jspf" %>
		    <li class="ds44-fg1"><jalios:media data="<%= itPub %>" template="tuileVerticale"/></li>
		  <%@ include file="/types/PortletQueryForeach/doForeachFooter.jspf" %>
		</ul>
	</div>
</div>
<%@ include file="/types/PortletQueryForeach/doPager.jspf" %>

<%-- Bouton desktop --%>
<jalios:if predicate='<%=Util.notEmpty(box.getLabelDuLien(userLang)) %>'>
    <p class="txtcenter">
        <a href="<%= urlBouton %>" title='<%= HttpUtil.encodeForHTMLAttribute(titleValue) %>' <%= targetAttr %> 
                class="ds44-btnStd ds44-btnStd--large ds44-hide-tiny-to-medium ds44-btnFullMobile">
            <span class="ds44-btnInnerText"><%= box.getLabelDuLien(userLang) %></span>
            <i class="icon icon-long-arrow-right" aria-hidden="true"></i>
        </a>
    </p>
</jalios:if>