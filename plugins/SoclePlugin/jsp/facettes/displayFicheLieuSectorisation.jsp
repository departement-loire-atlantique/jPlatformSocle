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
qh.setCids(request.getParameter("cid"));
qh.setTypes("FicheLieu");



JsonObject jsonObject = new JsonObject();


StringBuffer contentHtml = new StringBuffer();
QueryResultSet resultSet = qh.getResultSet();

%>
<jalios:foreach collection="<%= resultSet %>" name="itPub" type="Publication"><%
    %><jalios:buffer name="fichesLieuxHTML"><%
        FicheLieu itFicheLieu = (FicheLieu) itPub;
        String adresseEcrire = SocleUtils.formatAdresseEcrire(itFicheLieu);
        %>
        
        <p class="ds44-docListElem ds44-mt-std">
            <i class="icon icon-user ds44-docListIco" aria-hidden="true"></i>
            <strong><%= itFicheLieu.getTitle() %></strong>
        </p>
        
        <jalios:if predicate='<%=Util.notEmpty(adresseEcrire)%>'>
            <p class="ds44-docListElem ds44-mt-std">
                <i class="icon icon-marker ds44-docListIco" aria-hidden="true"></i><%=adresseEcrire%>
            </p>
        </jalios:if>
        
        <jalios:if predicate='<%=Util.notEmpty(itFicheLieu.getTelephone())%>'>
	        <div class="ds44-docListElem ds44-mt-std">
	            <i class="icon icon-phone ds44-docListIco" aria-hidden="true"></i>
	            <jalios:if predicate='<%= itFicheLieu.getTelephone().length == 1 %>'>
	                <% String numTel = itFicheLieu.getTelephone()[0]; %>
	                <ds:phone number="<%= numTel %>" pubTitle="<%= HttpUtil.encodeForHTMLAttribute(itFicheLieu.getTitle()) %>"/>
	            </jalios:if>
	    
	            <jalios:if predicate='<%= itFicheLieu.getTelephone().length > 1 %>'>
	                <ul class="ds44-list">
	                    <jalios:foreach name="numTel" type="String" array="<%= itFicheLieu.getTelephone() %>">
	                        <li>
	                            <ds:phone number="<%= numTel %>" pubTitle="<%= HttpUtil.encodeForHTMLAttribute(itFicheLieu.getTitle()) %>"/>
	                        </li>
	                    </jalios:foreach>
	                </ul>
	            </jalios:if>	    
	        </div>
        </jalios:if>
        
       <jalios:if predicate='<%=Util.notEmpty(itFicheLieu.getEmail())%>'>
         <div class="ds44-docListElem ds44-mt-std"><i class="icon icon-mail ds44-docListIco" aria-hidden="true"></i>
    
             <jalios:if predicate='<%= itFicheLieu.getEmail().length == 1 %>'>
                 <% String email = itFicheLieu.getEmail()[0]; %>
                 <a href='<%= "mailto:"+email %>' title='<%= HttpUtil.encodeForHTMLAttribute(glp("jcmsplugin.socle.ficheaide.contacter-x-par-mail.label", itFicheLieu.getTitle(), email)) %>'
                       data-statistic='{"name": "declenche-evenement","category": "Contacts","action": "Mail_to","label": "<%= HttpUtil.encodeForHTMLAttribute(itFicheLieu.getTitle()) %>"}' > 
                     <%=  glp("jcmsplugin.socle.ficheaide.contacter-par-mail.label")  %>
                 </a>
             </jalios:if>
    
             <jalios:if predicate='<%= itFicheLieu.getEmail().length > 1 %>'>
                 <ul class="ds44-list">
                     <jalios:foreach name="email" type="String" array='<%= itFicheLieu.getEmail() %>'>
                         <li>
                             <a href='<%= "mailto:"+email %>' title='<%= HttpUtil.encodeForHTMLAttribute(glp("jcmsplugin.socle.ficheaide.contacter-x-par-mail.label", itFicheLieu.getTitle(), email)) %>'
                               data-statistic='{"name": "declenche-evenement","category": "Contacts","action": "Mail_to","label": "<%= HttpUtil.encodeForHTMLAttribute(itFicheLieu.getTitle()) %>"}'> 
                                 <%= email %>
                             </a>
                         </li>
                     </jalios:foreach>
                 </ul>
             </jalios:if>
    
        </div>
      </jalios:if>
      <jalios:if predicate="<%= itCounter != resultSet.size() %>">
           <hr class="mtm mbm" />
       </jalios:if><%
   %></jalios:buffer><%   
    contentHtml.append(fichesLieuxHTML);
%></jalios:foreach><%
jsonObject.addProperty("content_html", contentHtml.toString());
%><%= jsonObject %>