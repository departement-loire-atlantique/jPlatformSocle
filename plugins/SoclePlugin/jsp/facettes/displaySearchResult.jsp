<%@page import="fr.cg44.plugin.socle.comparator.TypesComparator"%>
<%@page import="com.jalios.jcms.handler.QueryHandler"%>
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


PortletSearch portletSearch = (PortletSearch) channel.getPublication(channel.getProperty("jcmsplugin.socle.recherche.portletsearch.id"));

Integer pager = getIntParameter("page", 1);

String defaultfoQuerySort = Util.getString(channel.getProperty("query.sort.fo"), "relevance");
String foQuerySortParam = getAlphaNumParameter("sort", defaultfoQuerySort);

int maxResult = channel.getIntegerProperty("jcmsplugin.socle.recherche.max-result", 15); 

%><%

QueryHandler qh = new QueryHandler(portletSearch.getQuery());
qh.setCheckPstatus(true);
qh.setAttribute(QueryFilter.FRONTOFFICE_SEARCH, Boolean.TRUE);
qh.setText(request.getParameter("searchtext[value]"));
qh.setSort(foQuerySortParam);
qh.setSearchInFiles(Util.arrayContains(portletSearch.getSearchIn(), "searchInFiles"));
QueryResultSet collection = qh.getResultSet();


Comparator scoreTypeComparator = QueryResultSet.getScoreComparator(collection, new TypesComparator());
SortedSet<Publication> resultSet = new TreeSet<Publication>(scoreTypeComparator);
resultSet.addAll(collection);

JsonArray jsonArray = new JsonArray();
JsonObject jsonObject = new JsonObject();

jsonObject.addProperty("page-index", pager);
jsonObject.addProperty("nb-result-per-page", maxResult);
jsonObject.addProperty("nb-result", collection.getResultSize());

jsonObject.add("result", jsonArray);
%>

<jalios:foreach collection="<%= resultSet %>" name="itPub" type="Publication" max='<%= maxResult %>' skip='<%= (pager - 1) * maxResult  %>'>
    <jalios:buffer name="itPubListGabarit">
        <jalios:media data="<%= itPub %>" template="search"/>
    </jalios:buffer>
    <%     
     jsonArray.add(SocleUtils.publicationToJsonObject(itPub, itPubListGabarit, null, null));
    %><%
 %></jalios:foreach><%                                    
%><%= jsonObject %>