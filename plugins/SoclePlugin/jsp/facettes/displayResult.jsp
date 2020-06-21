<%@page import="fr.cg44.plugin.socle.queryfilter.CategoryFacetUtil"%>
<%@page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@page import="com.jalios.io.IOUtil"%><%
%><%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%><%
%><%@page import="com.google.gson.JsonObject"%><%
%><%@page import="com.google.gson.JsonArray"%><%

request.setAttribute("inFO", Boolean.TRUE);

%><%@ include file='/jcore/doInitPage.jspf' %><%
%><%@ include file="/jcore/portal/doPortletParams.jspf" %><%


response.setContentType("application/json");

PortletRechercheFacettes  boxTmp = (PortletRechercheFacettes) (channel.getPublication(request.getParameter("boxId"))).clone();  
PortletRechercheFacettes box = new PortletRechercheFacettes(boxTmp);

if(Util.notEmpty(box.getIdDeLaCategorieTag())) {
  request.setAttribute("tagRootCatId", box.getIdDeLaCategorieTag());
}

String typeDeTuileFicheLieu = request.getParameter("typeDeTuileFicheLieu");

Category typeDelieuMisEnAvant_1 = channel.getCategory(box.getTypeDeLieu());
Category typeDelieuMisEnAvant_2 = channel.getCategory(box.getTypeDeLieu2());


%><%

%><%@ include file="/types/PortletQueryForeach/doQuery.jspf" %><%
%><%@ include file="/plugins/SoclePlugin/jsp/facettes/doQueryText.jspf" %><%
%><%@ include file="/plugins/SoclePlugin/jsp/facettes/doQueryCids.jspf" %><%
%><%@ include file="/plugins/SoclePlugin/jsp/facettes/doQueryGeoloc.jspf" %><%


%><%@ include file="/types/PortletQueryForeach/doSort.jspf" %><%

// Place les contenu mis en avant en tête de résultat
if(Util.notEmpty(typeDelieuMisEnAvant_1) || Util.notEmpty(typeDelieuMisEnAvant_2)) {
  List<Publication> misEnAvant_1_Set = new ArrayList();
  List<Publication> misEnAvant_2_Set = new ArrayList();
  
  for(Object itObj : collection) {
    if(itObj instanceof FicheLieu) {
      FicheLieu itFiche = (FicheLieu) itObj;
      Set<Category> pubCatSet = itFiche.getCategorySet();
      
      if(Util.notEmpty(typeDelieuMisEnAvant_1) && Util.notEmpty(pubCatSet)) {
        if(pubCatSet.contains(typeDelieuMisEnAvant_1) || Util.notEmpty(Util.interSet(typeDelieuMisEnAvant_1.getDescendantSet(), pubCatSet))) {
          misEnAvant_1_Set.add(itFiche);
        }
      }
      
      if(Util.notEmpty(typeDelieuMisEnAvant_2) && Util.notEmpty(pubCatSet)) {
        if(pubCatSet.contains(typeDelieuMisEnAvant_2) || Util.notEmpty(Util.interSet(typeDelieuMisEnAvant_2.getDescendantSet(), pubCatSet))) {
          misEnAvant_2_Set.add(itFiche);
        }
      }
      
    }
  }
  // Evite des doublons en priorisant les publication misEnAvant_1
  misEnAvant_2_Set.removeAll(misEnAvant_1_Set);
  // Retire les élément mis en avant des résultat pour les replacer en haut de la list
  collection.removeAll(misEnAvant_1_Set);
  collection.removeAll(misEnAvant_2_Set);  
  List<Publication> collectionBis = misEnAvant_1_Set;
  collectionBis.addAll(misEnAvant_2_Set);
  collectionBis.addAll(collection);
  collection = collectionBis;
}


JsonArray jsonArray = new JsonArray();
JsonObject jsonObject = new JsonObject();

jsonObject.addProperty("nb-result", collection.size());
jsonObject.addProperty("nb-result-per-page", box.getMaxResults());
jsonObject.addProperty("max-result", box.getMaxResults());
jsonObject.add("result", jsonArray);

%><%

%><%@ include file="/types/PortletQueryForeach/doForeachHeader.jspf" %><%

    %><jalios:buffer name="itPubListGabarit"><%       
	    %><jalios:select><%	        
	        %><jalios:if predicate="<%= itPub instanceof FicheLieu %>"><%
	           %><%
	           boolean isMiseEnAvant = false;
	           Set<Category> pubCatSet = itPub.getCategorySet();
	           
	           if(Util.notEmpty(typeDelieuMisEnAvant_1) && Util.notEmpty(pubCatSet)) {
	             if(pubCatSet.contains(typeDelieuMisEnAvant_1) || Util.notEmpty(Util.interSet(typeDelieuMisEnAvant_1.getDescendantSet(), pubCatSet))) {
	               isMiseEnAvant = true;
	             }
	           }
	           
	           if(!isMiseEnAvant && Util.notEmpty(typeDelieuMisEnAvant_2) && Util.notEmpty(pubCatSet)) {
                 if(pubCatSet.contains(typeDelieuMisEnAvant_2) || Util.notEmpty(Util.interSet(typeDelieuMisEnAvant_2.getDescendantSet(), pubCatSet))) {
                   isMiseEnAvant = true;
                 }
	           }
	           %>
	           <jalios:select>
		           <jalios:if predicate='<%= isMiseEnAvant %>'>
		              <jalios:media data="<%= itPub %>" template='cardFocusNoPic' />
		           </jalios:if>
		           <jalios:default>
		              <jalios:media data="<%= itPub %>" template='<%= Util.notEmpty(typeDeTuileFicheLieu) ? typeDeTuileFicheLieu : "cardNoPic" %>' />
		           </jalios:default>	           
	           </jalios:select>
	           <%
	        %></jalios:if><%
	        
	        %><jalios:default><%
	           %><jalios:media data="<%= itPub %>" template="card" /><%
	        %></jalios:default><%
	    %></jalios:select><%    
    %></jalios:buffer><%
    
    %><jalios:buffer name="itPubMarkerGabarit"><%
        %><jalios:include pub="<%= itPub %>" usage="marker" /><%
    %></jalios:buffer>
    <%
    %><%     
     jsonArray.add(SocleUtils.publicationToJsonObject(itPub, itPubListGabarit, itPubMarkerGabarit, null));
    %><%
                                        
%><%@ include file="/types/PortletQueryForeach/doForeachFooter.jspf" %><%
request.removeAttribute("tagRootCatId");
%><%= jsonObject %>