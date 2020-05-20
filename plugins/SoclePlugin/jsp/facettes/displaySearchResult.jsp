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


PortletSearch portletSearch = (PortletSearch) channel.getPublication(channel.getProperty("jcmsplugin.socle.recherche.portletsearch.id"));

Integer pager = getIntParameter("page", 1);

String defaultfoQuerySort = Util.getString(channel.getProperty("query.sort.fo"), "relevance");
String foQuerySortParam = getAlphaNumParameter("sort", defaultfoQuerySort);

int maxResult = channel.getIntegerProperty("jcmsplugin.socle.recherche.max-result", 15); 

%><%

QueryHandler qh = new QueryHandler(portletSearch.getQuery());
qh.setCheckPstatus(true);
qh.setText(request.getParameter("searchtext[value]"));
qh.setSort(foQuerySortParam);
QueryResultSet collection = qh.getResultSet();


JsonArray jsonArray = new JsonArray();
JsonObject jsonObject = new JsonObject();

jsonObject.addProperty("page-index", pager);
jsonObject.addProperty("nb-result-per-page", maxResult);
jsonObject.addProperty("nb-result", collection.getResultSize());

jsonObject.add("result", jsonArray);


%><jalios:foreach collection="<%= collection %>" name="itPub" type="Publication" max='<%= maxResult %>' skip='<%= (pager - 1) * maxResult  %>'><%
    %><jalios:buffer name="itPubListGabarit"><%
        %>
        <section class="ds44-card ds44-js-card ds44-card--contact ds44-bgGray  ">           
            <div class="ds44-card__section">            
	            <div class="ds44-innerBoxContainer">
		            <h2 class="h4-like ds44-cardTitle" id="1"><a href="<%= itPub.getDisplayUrl(userLocale) %>" class="ds44-card__globalLink"><%= itPub.getTitle() %></a></h2>
		            <hr class="mbs" aria-hidden="true"/>
		            <p class="ds44-docListElem ds44-mt-std"><i class="icon icon-tag ds44-docListIco" aria-hidden="true"></i><%= SocleUtils.getTypeLibelle(itPub, userLang) %></p>	           
	            </div>
	            <i class="icon icon-arrow-right ds44-cardArrow" aria-hidden="true"></i>
            </div>
        </section>
        <%
    %></jalios:buffer><%
    %><%     
     jsonArray.add(SocleUtils.publicationToJsonObject(itPub, itPubListGabarit, null, null));
    %><%
 %></jalios:foreach><%                                    
%><%= jsonObject %>