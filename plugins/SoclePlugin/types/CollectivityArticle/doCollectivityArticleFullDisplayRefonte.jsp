<%@ page contentType="text/html; charset=UTF-8" %><%
%><%@ page import="fr.cg44.plugin.seo.SEOUtils" %><%
%><%-- This file has been automatically generated. --%><%
%><%--
  @Summary: CollectivityArticle display page
  @Category: Generated
  @Author: JCMS Type Processor
  @Customizable: True
  @Requestable: True
--%><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
%><%
CollectivityArticle obj = (CollectivityArticle)request.getAttribute(PortalManager.PORTAL_PUBLICATION);
boolean notEmptyFreePart = Util.notEmpty(obj.getFreePartContents());


%><%
%><%@ include file='/front/doFullDisplay.jspf' %>
<div class="fullDisplay CollectivityArticle container <%= obj.canBeEditedFieldByField(loggedMember) ? "unitFieldEdition" : "" %>" itemscope="itemscope">
<div class="row">
    <!-- Colonne principale -->
    <div class="col-md-7">
        <h1 class="publication-title" <%= gfla(obj, "title") %> itemprop="name"><%= obj.getTitle(userLang) %></h1>
        
        <% if (Util.notEmpty(obj.getSummary(userLang))) { %>
            <jalios:wiki><%= obj.getSummary(userLang) %></jalios:wiki>
        <% } %>
        
        <div>
            <% if (Util.notEmpty(obj.getDescription(userLang))) { %>
                <jalios:wysiwyg data='<%= obj %>' field='description'><%= obj.getDescription(userLang) %></jalios:wysiwyg>            
            <% } %>
        </div>
    </div>
    
    <!-- Colonne de droite -->        
    <div class="col-md-4 col-md-offset-1">
		<% if (Util.notEmpty(obj.getMainIllustration())) { %>
		  <div><img src='<%= Util.encodeUrl(obj.getMainIllustration()) %>' alt='' /></div>
		<% } %>   
		
		<% if (Util.notEmpty(obj.getMainIllustrationLegend(userLang))) { %>
            <div><%= obj.getMainIllustrationLegend(userLang) %></div>
        <% } %> 
            
        <% if (Util.notEmpty(obj.getMainIllustrationCopyright(userLang))) { %>
            <div><%= obj.getMainIllustrationCopyright(userLang) %></div>
        <% } %>
        
        
        <%// Partie Libre
          %><jalios:if predicate="<%= notEmptyFreePart %>"><%
              
              String[] freePartTitles = obj.getFreePartTitles();
              String[] freePartContents = obj.getFreePartContents();
          
            %><jalios:foreach array="<%= freePartContents %>" name="itContent" type="String" counter="itCounter"><%
             
              // Récupération du titre
              String title = "";
              if(Util.notEmpty(freePartTitles)) {
                try {
                  title = freePartTitles[itCounter - 1]; // Changement de titre si la case existe                         
                } catch(IndexOutOfBoundsException e) {
                  //Pas de traitement => Cela vient du fait que les groupes de listes ont des longueurs différentes
                }
              }             
             %>
             <div>
               <jalios:if predicate="<%= Util.notEmpty(title) %>"><h2><%= title %> <jalios:edit pub="<%= obj %>" fields="freePartTitles, freePartContents"/></h2></jalios:if>
               <jalios:if predicate="<%= Util.notEmpty(itContent) %>"><jalios:wysiwyg><%= itContent %></jalios:wysiwyg></jalios:if>
             </div>
           </jalios:foreach>
         </jalios:if>
        
    </div>
</div>


</div>