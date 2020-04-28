<%@page import="com.jalios.jcms.handler.QueryHandler"%>
<%@page import="fr.cg44.plugin.socle.queryfilter.CategoryFacetUtil"%>
<%@page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@page import="com.jalios.io.IOUtil"%><%
%><%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%><%
%><%@page import="com.google.gson.JsonObject"%><%
%><%@page import="com.google.gson.JsonArray"%><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
%><%@ include file="/jcore/portal/doPortletParams.jspf" %><%

response.setContentType("application/json");

PortletQueryForeach boxTmp = (PortletQueryForeach) (channel.getPublication(request.getParameter("boxId"))).clone();  
PortletQueryForeach box = new PortletQueryForeach(boxTmp);

Integer pager = getIntParameter("page", 1);

String defaultfoQuerySort = Util.getString(channel.getProperty("query.sort.fo"), "relevance");
String foQuerySortParam = getAlphaNumParameter("sort", defaultfoQuerySort);

%><%

QueryHandler qh = new QueryHandler(box.getQueries()[0]);
qh.setCheckPstatus(true);
qh.setText(request.getParameter("text"));
qh.setSort(foQuerySortParam);
QueryResultSet collection = qh.getResultSet();


JsonArray jsonArray = new JsonArray();
JsonObject jsonObject = new JsonObject();

jsonObject.addProperty("page-index", pager);
jsonObject.addProperty("nb-result-per-page", box.getMaxResults());
jsonObject.addProperty("nb-result", collection.size());

jsonObject.add("result", jsonArray);


%><jalios:foreach collection="<%= collection %>" name="itPub" type="Publication" max='<%= box.getMaxResults() %>' skip='<%= (pager - 1) * box.getMaxResults()  %>'><%
    %><jalios:buffer name="itPubListGabarit"><%
        %><jalios:media data="<%= itPub %>" template="card" /><%
    %></jalios:buffer><%
    %><%     
     jsonArray.add(SocleUtils.publicationToJsonObject(itPub, itPubListGabarit, null, null));
    %><%
 %></jalios:foreach><%                                    
%><%= jsonObject %>