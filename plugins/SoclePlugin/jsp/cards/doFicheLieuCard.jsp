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
boolean isPartenaire = "true".equals(request.getParameter("isPartenaire")) && Util.isEmpty(pub.getServiceDuDepartement(loggedMember));
Boolean displayCommunesConcernees = "true".equals(request.getParameter("afficheCommunes"));
Boolean displayEPCIConcernees = "true".equals(request.getParameter("afficheEpci"));

Category tagRootCat = channel.getCategory((String)request.getAttribute("tagRootCatId"));
%>

<section class='ds44-card ds44-js-card ds44-card--contact ds44-box ds44-bgGray<%= isPartenaire ? " ds44-cardIsPartner" : "" %><%= isFocus ? " ds44-cardIsFocus" : "" %>'>
    
    <jalios:if predicate="<%= !noPic %>">
        <%@ include file="cardPictureCommons.jspf" %>
    </jalios:if>
    
    <div class="ds44-card__section">
      
      <jalios:if predicate="<%= isPartenaire %>">
        <p class="ds44-cardPartner pal"><%= glp("jcmsplugin.socle.partenaire") %></p>
      </jalios:if>
      
      <div class="ds44-innerBoxContainer">
          <p class="h4-like ds44-cardTitle" id="titleTuileLieuCard_<%= uid %>">
            <a href="<%= pub.getDisplayUrl(userLocale) %>" class="ds44-card__globalLink"><%= pub.getTitle() %></a>
          </p>
          <hr class="mbs" aria-hidden="true">
          <jalios:if predicate='<%= pub.getCategorieDeNavigation(loggedMember).contains(channel.getCategory("$jcmsplugin.socle.fichelieu.contactPrivilegie.root")) %>'>
          <p class="ds44-mt-std"><strong><%= pub.getChapo() %></strong></p>
          <hr class="mbs" aria-hidden="true">
          </jalios:if>
          
          <%
          // RS-1334 Affiche en tag seulement la catégorie recherchée
          Set<Category> allTagChildren = new TreeSet<Category>(new Category.DeepOrderComparator());           
          boolean isNodeTag = false;
                    
          if(Util.notEmpty(request.getParameterValues("cids"))) {
        	  tagRootCat = getCategoryParameter("cids");
        	  for(String itCatId : request.getParameterValues("cids")) {
        		  Category itCat = channel.getCategory(itCatId);
        		  if(itCat != null && itCat.hasAncestor(tagRootCat) && Util.notEmpty(pub.getDescendantCategorySet(itCat, true))) {
        			   allTagChildren.add(itCat);
        			   isNodeTag = true;
        		  }
        	  }       	         	  
          }
          %>
          
          <jalios:if predicate="<%= Util.notEmpty(tagRootCat) %>">
            <%
              if(!isNodeTag) {
	              for (Category itCat : pub.getCategorySet()) {
	                if (itCat.hasAncestor(tagRootCat)) {
	                  allTagChildren.add(itCat);
	                }
	              }
              }
              if(Util.isEmpty(allTagChildren) && Util.notEmpty(pub.getCategorySet())) {
            	  for(String itCatId : request.getParameterValues("cids")) {
            		  Category itCat = channel.getCategory(itCatId);
            		  if(pub.getCategorySet().contains(itCat)){
            			  allTagChildren.add(itCat);
            		  }
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
              pub.getEntreeBatimentImmeuble(), pub.getNdeVoie(), pub.getLibelleDeVoie(), pub.getLieudit(), pub.getCs2(),
              pub.getCodePostal(), titreCommune, pub.getCedex2());
          %>
          <jalios:if predicate="<%= Util.notEmpty(adresse) %>">
              <p class="ds44-docListElem ds44-mt-std"><i class="icon icon-marker ds44-docListIco" aria-hidden="true"></i><span class="visually-hidden"><%= glp("jcmsplugin.socle.adresse") %> : </span><%= adresse %></p>
          </jalios:if>
          <jalios:if predicate="<%= Util.notEmpty(pub.getTelephone()) %>">
	          <div class="ds44-docListElem ds44-mt-std">
			    <i class="icon icon-phone ds44-docListIco" aria-hidden="true"></i><span class="visually-hidden"><%= glp("jcmsplugin.socle.telephone") %> : </span>
		        <ul class="ds44-list">
		            <jalios:foreach name="numTel" type="String" array="<%= pub.getTelephone() %>">
		                <li><ds:phone number="<%= numTel %>" /></li>
                    </jalios:foreach>
                </ul>
			  </div>
		  </jalios:if>
		  
		  <jalios:if predicate="<%= displayCommunesConcernees && Util.notEmpty(pub.getCommunes()) %>">
              <p class="ds44-docListElem ds44-mt-std"><i class="icon icon-marker ds44-docListIco" aria-hidden="true"></i><span class="visually-hidden"><%= glp("jcmsplugin.socle.fichearticle.tuile.communes.label") %> : </span><%= JcmsUtil.join(Arrays.asList(pub.getCommunes()), ", ", userLang) %></p>
          </jalios:if>
          
          <jalios:if predicate="<%= displayEPCIConcernees && Util.notEmpty(pub.getEpci(loggedMember)) %>">
              <p class="ds44-docListElem ds44-mt-std"><i class="icon icon-marker ds44-docListIco" aria-hidden="true"></i><span class="visually-hidden"><%= glp("jcmsplugin.socle.fichearticle.tuile.epci.label") %> : </span><%= JcmsUtil.join(pub.getEpci(loggedMember), ", ", userLang) %></p>
          </jalios:if>
		  
      </div>
      <i class="icon icon-arrow-right ds44-cardArrow" aria-hidden="true"></i>
    </div>
</section>