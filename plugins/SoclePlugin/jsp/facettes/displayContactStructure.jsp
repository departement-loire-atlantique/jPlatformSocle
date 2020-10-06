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

FicheLieu ficheLieu = (FicheLieu) getPublicationParameter("structure");


Set<Contact> resultSet = ficheLieu.getLinkIndexedDataSet(Contact.class, "contactPourLesFichesLieux");


JsonObject jsonObject = new JsonObject();


StringBuffer contentHtml = new StringBuffer();



%>
<jalios:foreach collection="<%= resultSet %>" name="itContact" type="Contact"><%
    %><jalios:buffer name="contactHTML"><%       
       %><jalios:media data="<%= itContact %>" template="card"/><%
   %></jalios:buffer><%   
    contentHtml.append(contactHTML);
%></jalios:foreach>

<jalios:if predicate="<%= Util.isEmpty(resultSet) %>"><%
    %><jalios:buffer name="contactHTML">
     <section class="class='ds44-card ds44-box ds44-bgGray">
         <div class="ds44-flex-container ds44-flex-valign-center">
            <div class="ds44-card__section--horizontal">
			     <p><%= glp("jcmsplugin.socle.structure.contact.no-result.title", ficheLieu.getTitle()) %></p>
			     <p><%= glp("jcmsplugin.socle.structure.contact.no-result.description") %></p>
		     </div>
		 </div>
     </section>
     </jalios:buffer><%
     contentHtml.append(contactHTML);
%></jalios:if>

<%
jsonObject.addProperty("content_html", contentHtml.toString());
%><%= jsonObject %>