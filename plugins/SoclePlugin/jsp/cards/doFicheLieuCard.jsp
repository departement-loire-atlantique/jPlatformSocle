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

FicheLieu pub = (FicheLieu) data;
String uid = ServletUtil.generateUniqueDOMId(request, "uid");
boolean isFocus = "true".equals(request.getParameter("isFocus"));
boolean noPic = "true".equals(request.getParameter("noPic"));

Category tagRootCat = channel.getCategory((String)request.getAttribute("tagRootCatId"));
%>

<section class='ds44-card ds44-js-card ds44-card--contact ds44-box ds44-bgGray<%= Util.isEmpty(pub.getServiceDuDepartement(loggedMember)) ? " ds44-cardIsPartner" : "" %><%= isFocus ? " ds44-cardIsFocus" : "" %>'>
    
    <jalios:if predicate="<%= !noPic %>">
        <%@ include file="cardPictureCommons.jspf" %>
    </jalios:if>
    
    <div class="ds44-card__section">
      
      <jalios:if predicate="<%= Util.isEmpty(pub.getServiceDuDepartement(loggedMember)) %>">
        <p class="ds44-cardPartner pal"><%= glp("jcmsplugin.socle.partenaire") %></p>
      </jalios:if>
      
      <div class="ds44-innerBoxContainer">
          <p role="heading" aria-level="2" class="h4-like ds44-cardTitle" id="titleTuileLieuCard_<%= uid %>">
            <a href="<%= pub.getDisplayUrl(userLocale) %>" class="ds44-card__globalLink"><%= pub.getTitle() %></a>
          </p>
          <hr class="mbs" aria-hidden="true">
          <jalios:if predicate='<%= pub.getCategorieDeNavigation(loggedMember).contains(channel.getCategory("$jcmsplugin.socle.fichelieu.contactPrivilegie.root")) %>'>
          <p class="ds44-mt-std"><strong><%= pub.getChapo() %></strong></p>
          <hr class="mbs" aria-hidden="true">
          </jalios:if>
          
          <jalios:if predicate="<%= Util.notEmpty(tagRootCat) %>">
            <% 
              Set<Category> allTagChildren = new TreeSet<Category>(new Category.DeepOrderComparator());                      
              for (Category itCat : pub.getCategorySet()) {
                if (itCat.hasAncestor(tagRootCat)) {
                  allTagChildren.add(itCat);
                }
              }
            %>
            <jalios:if predicate="<%= Util.notEmpty(allTagChildren) %>">
	            <p class="ds44-docListElem ds44-mt-std"><i class="icon icon-tag ds44-docListIco" aria-hidden="true"></i>
	                <%= SocleUtils.formatCategories(allTagChildren) %>
	            </p>
            </jalios:if>
          </jalios:if>
          
          <%
          String titreCommune = Util.notEmpty(pub.getCommune()) ? pub.getCommune().getTitle() : "";
          String adresse = SocleUtils.formatAddress("", pub.getEtageCouloirEscalier(),
              pub.getEntreeBatimentImmeuble(), pub.getNdeVoie(), pub.getLibelleDeVoie(), pub.getLieudit(), "",
              pub.getCodePostal(), titreCommune, "");
          %>
          <jalios:if predicate="<%= Util.notEmpty(adresse) %>">
              <p class="ds44-docListElem ds44-mt-std"><i class="icon icon-marker ds44-docListIco" aria-hidden="true"></i><%= adresse %></p>
          </jalios:if>
          <jalios:if predicate="<%= Util.notEmpty(pub.getTelephone()) %>">
	          <div class="ds44-docListElem ds44-mt-std">
			    <i class="icon icon-phone ds44-docListIco" aria-hidden="true"></i>
		        <ul class="ds44-list">
		            <jalios:foreach name="numTel" type="String" array="<%= pub.getTelephone() %>">
		                <li><ds:phone number="<%= numTel %>" /></li>
                    </jalios:foreach>
                </ul>
			  </div>
		  </jalios:if>
      </div>
      <i class="icon icon-arrow-right ds44-cardArrow" aria-hidden="true"></i>
    </div>
</section>