<%@ page contentType="text/html; charset=UTF-8" %><%
%><%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
%><%@ include file='/jcore/portal/doPortletParams.jspf' %><%
%><% 
PageCarrefour obj = (PageCarrefour)request.getAttribute(PortalManager.PORTAL_PUBLICATION);
String imageFile = obj.getImageBandeau();
String imageMobileFile = Util.notEmpty(obj.getImageMobile()) ? obj.getImageMobile() : "s.gif";
String title = obj.getTitle(userLang);
String legende = obj.getLegende(userLang);
String copyright = obj.getCopyright(userLang);
%>

<jalios:buffer name="mainColumn">

    <jalios:if predicate="<%= Util.notEmpty(obj.getChapo(userLang)) %>">
        <div class="ds44-introduction"><jalios:wysiwyg><%= obj.getChapo(userLang) %></jalios:wysiwyg></div>
    </jalios:if>

    <jalios:if predicate="<%= Util.notEmpty(obj.getTopportlets()) %>">
        <jalios:foreach name="itPortlet" array="<%= obj.getTopportlets() %>" type="com.jalios.jcms.Publication">
          <jalios:include id="<%= itPortlet.getId() %>" />
        </jalios:foreach>
    </jalios:if>
    
    <%-- Menu de nav catégories --%>
    <jalios:if predicate='<%=Util.notEmpty(channel.getProperty("jcmsplugin.socle.pagecarrefour.portlet.nav.visuel.id")) %>'>
        <jalios:include id='<%=channel.getProperty("jcmsplugin.socle.pagecarrefour.portlet.nav.visuel.id") %>' />
    </jalios:if>

</jalios:buffer>

<jalios:buffer name="asideColumn">

    <jalios:if predicate="<%= Util.notEmpty(obj.getSideportlets()) %>">
         <jalios:foreach name="itPub" array="<%= obj.getSideportlets() %>" type="com.jalios.jcms.Publication">
         
             <jalios:select>
                  <jalios:if predicate='<%= itPub instanceof PortalElement %>'>
                      <jalios:include id="<%= itPub.getId() %>"/>
                  </jalios:if>
                  
                  <jalios:if predicate='<%= itPub instanceof Publication %>'>
                      <jalios:media data="<%= itPub %>"/>
                  </jalios:if>
             </jalios:select>
              
             <jalios:if predicate="<%= itCounter < obj.getSideportlets().length %>">
                 <div class="ds44-mb3"></div>
             </jalios:if>
             
         </jalios:foreach>
     </jalios:if>

</jalios:buffer>

<main role="main" id="content">

<jalios:include target="SOCLE_ALERTE"/>

    <section class="ds44-container-large">
        
        <ds:titleBanner pub="<%= obj %>" imagePath="<%=imageFile %>" mobileImagePath="<%=imageMobileFile %>" title="<%=title %>" legend="<%=legende %>" copyright="<%=copyright%>" breadcrumb="true"></ds:titleBanner>

        <div class="ds44-inner-container <%= Util.notEmpty(obj.getChapo(userLang)) || Util.notEmpty(obj.getTopportlets()) ? "ds44-xl-margin-tb" : "" %>">
            
            <jalios:select>
                 <jalios:if predicate='<%= Util.notEmpty(obj.getSideportlets()) %>'>
                     <div class="grid-12-small-1">
		                <%-- Colonne centrale --%>
		                <div class="col-7"><%= mainColumn %></div>
		                <div class="col-1 grid-offset"></div>
		                <%-- Colonne de droite --%>
		                <aside class="col-4 asideCards"><%= asideColumn %></aside>
		             </div>
                 </jalios:if>
                 
                 <jalios:default>
                    <%-- Colonne unique --%>
                    <%= mainColumn %><%= asideColumn %>
                 </jalios:default>
            </jalios:select>
            
        </div>
    </section>

    <jalios:if predicate="<%= Util.notEmpty(obj.getBottomportlets()) %>">
        <% request.setAttribute("currentCatSearch", currentCategory.getId());%>
        <% request.setAttribute("parentCatSearch", currentCategory.getParent().getId());%>
        <jalios:foreach name="itPortlet" array="<%= obj.getBottomportlets() %>" type="com.jalios.jcms.Publication">
           <jalios:if predicate="<%= itPortlet instanceof FaqAccueil %>">
           <div class="ds44--xxl-padding-t">
           </jalios:if>
            <jalios:include id="<%= itPortlet.getId() %>" />
           <jalios:if predicate="<%= itPortlet instanceof FaqAccueil %>">
           </div>
           </jalios:if>
        </jalios:foreach>
        <% request.removeAttribute("currentCatSearch"); %>
        <% request.removeAttribute("parentCatSearch"); %>
    </jalios:if>

        
</main>


  

