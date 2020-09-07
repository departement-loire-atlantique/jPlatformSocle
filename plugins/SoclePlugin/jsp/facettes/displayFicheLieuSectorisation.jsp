<%@page import="fr.cg44.plugin.socle.comparator.CategoryComparator"%>
<%@page import="com.jalios.jcms.handler.QueryHandler"%>
<%@page import="fr.cg44.plugin.socle.queryfilter.CategoryFacetUtil"%>
<%@page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@page import="com.jalios.io.IOUtil"%><%
%><%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%><%
%><%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%><%
%><%@page import="com.google.gson.JsonObject"%><%
%><%@page import="com.google.gson.JsonArray"%><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
%><%@ include file="/jcore/portal/doPortletParams.jspf" %><%

response.setContentType("application/json");


QueryHandler qh = new QueryHandler();
qh.setCids(request.getParameter("cid"), request.getParameter("cidSecondaire"));

qh.setCatMode("or");
qh.setCheckPstatus(true);
qh.setTypes("FicheLieu");



JsonObject jsonObject = new JsonObject();


StringBuffer contentHtml = new StringBuffer();
TreeSet<Publication> resultSet = new TreeSet<Publication>(new CategoryComparator(request.getParameter("cid"), request.getParameter("cidSecondaire")));
resultSet.addAll(qh.getResultSet());

//Filtre les communes non sectorisées (id ref vide) quand la sectorisation est activée
//Car en cas de recherche avec sectorisation le filtre sur les commune est désactivé (car une commune peut avoir un lieu en dehors de cette même commune)
if(Util.notEmpty(resultSet) && "true".equalsIgnoreCase(request.getParameter("sectorisation"))) {
	request.setAttribute("communeHorsSectorisation", true);
	QueryHandler qhCommune = new QueryHandler();
	qhCommune.setCids(request.getParameter("cid"), request.getParameter("cidSecondaire"));
	qhCommune.setCatMode("or");
	qhCommune.setTypes("FicheLieu");
	qhCommune.setCheckPstatus(true);
	Set resultCommuneSet = qhCommune.getResultSet();
	request.removeAttribute("communeHorsSectorisation");
	List<Publication> removeList = new ArrayList();  
	for(Object itObj : resultSet) {
	 if(itObj instanceof FicheLieu) {
	   FicheLieu itFiche = (FicheLieu) itObj;
	   if(Util.isEmpty(itFiche.getIdReferentiel()) && !resultCommuneSet.contains(itFiche)) {
	     removeList.add(itFiche);
	   }
	 }
	}
	
	if(Util.notEmpty(removeList)) {
		   resultSet.removeAll(removeList);
	}  
}



%>
<jalios:foreach collection="<%= resultSet %>" name="itPub" type="Publication"><%
    %><jalios:buffer name="fichesLieuxHTML"><%
        FicheLieu itFicheLieu = (FicheLieu) itPub;        
       %>
        
       <jalios:media data="<%= itFicheLieu %>" template="contact"/>
      
       <jalios:if predicate="<%= itCounter != resultSet.size() %>">
           <hr />
       </jalios:if><%
   %></jalios:buffer><%   
    contentHtml.append(fichesLieuxHTML);
%></jalios:foreach><%
jsonObject.addProperty("content_html", contentHtml.toString());
%><%= jsonObject %>