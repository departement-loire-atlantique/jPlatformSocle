<%@page import="org.apache.commons.lang.StringUtils"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@ include file='/jcore/doInitPage.jspf' %>
<%@ page import="com.jalios.jcms.taglib.card.*" %>
<%@ include file='/jcore/media/mediaTemplateInit.jspf' %>
<%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%><%

if (data == null) { return; }
Publication pub = (Publication) data;

%><%@include file="/plugins/SoclePlugin/jsp/templates/tuileCommon.jsp" %><%

SimpleDateFormat sdf = new SimpleDateFormat(glp("date-format"));
String tags = "";
if(pub instanceof FicheActu) {
  FicheActu ficheActu = (FicheActu) pub;
  if(Util.notEmpty(ficheActu.getDateActu())) {    
    if(Util.notEmpty(ficheActu.getDateFinActu())) {
      subTitle = glp("jcmsplugin.socle.infolocale.label.carrousel.periode",
          sdf.format(ficheActu.getDateActu()),sdf.format(ficheActu.getDateFinActu()));
    } else {
      subTitle = sdf.format(ficheActu.getDateActu());
    }
    subTitle += "<br>";
  }
  if (Util.notEmpty(ficheActu.getDateLibre())) {
    subTitle += ficheActu.getDateLibre(userLang);
  }
  if(Util.notEmpty(ficheActu.getLieu())) {
    location = ficheActu.getLieu();
  }
  if(Util.notEmpty(ficheActu.getTypes(loggedMember))){
    Category tagRootCat = channel.getCategory((String)request.getAttribute("tagRootCatId"));
    if(Util.notEmpty(tagRootCat)) {
      Set<Category> allTagChildren = new TreeSet<Category>(new Category.DeepOrderComparator());
      for (Category itCat : ficheActu.getTypes(loggedMember)) {
        if (itCat.hasAncestor(tagRootCat)) {
          allTagChildren.add(itCat);
        }
      }
      tags = SocleUtils.formatCategories(allTagChildren);
    } else {
      tags = SocleUtils.formatCategories(ficheActu.getTypes(loggedMember));
    }
  } 
}

String imageAlt = "-1"; // dans figurePicture, si la valeur de "alt" est à -1 on force le champ alt vide sauf si Lien (autrement, il ira chercher un alt dans le contenu)
String formatTuile = isLargeTuile ? "principale" : "carrousel";
boolean isGpla = Util.notEmpty(request.getParameter("context")) && "gpla".equalsIgnoreCase(request.getParameter("context"));
%>

<section class='ds44-card ds44-cardIsPartner ds44-card--contact ds44-js-card ds44-card--verticalPicture <%= isGpla ? "ds44-darkContext" : "" %> <%=styleContext%> <%= isInSixPanelsContext ? "ds44-posRel" : "" %>'>
	<ds:figurePicture pub="<%= pub %>" format="<%= formatTuile %>" pictureCss='<%= isInSixPanelsContext ? "" : "ds44-container-imgRatio" %>' imgCss='<%= isInSixPanelsContext ? "" : "ds44-imgRatio" %>' alt="<%= imageAlt %>"></ds:figurePicture>
    <div class="ds44-card__section">
        <div class="ds44-innerBoxContainer">
	        <p class="ds44-cardTitle h4-like" role="heading">
	            <a class="ds44-card__globalLink" href="<%= urlPub %>" <%=titleAttr%> <%=targetAttr%>>
	                <%= pub.getTitle(userLang) %>
	            </a>
	        </p>
	        <jalios:if predicate="<%= Util.notEmpty(subTitle) %>">
	            <p class='ds44-docListElem ds44-mt-std'>
		            <i class="icon icon-date ds44-docListIco" aria-hidden="true"></i>
		            <%= subTitle %>
	            </p>
	        </jalios:if>
	        <jalios:if predicate="<%= Util.notEmpty(location) %>">
	            <p class="ds44-docListElem ds44-mt-std">
	                <i class="icon icon-marker ds44-docListIco" aria-hidden="true"></i>
	                <span class="ds44-iconInnerText"><%= location %></span>
	            </p>
	        </jalios:if>
	        <jalios:if predicate="<%= Util.notEmpty(tags) %>">
	           <p class="ds44-docListElem ds44-mt-std ">
                   <i class="icon icon-tag ds44-docListIco" aria-hidden="true"></i>
                   <%= tags %>
               </p>
            </jalios:if>
	        <i class="icon icon-arrow-right ds44-cardArrow" aria-hidden="true"></i>
        </div>
    </div>
</section>