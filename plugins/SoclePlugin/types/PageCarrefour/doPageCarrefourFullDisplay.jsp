<%@ page contentType="text/html; charset=UTF-8" %><%
%><%@page import="fr.cg44.plugin.socle.SocleUtils"%><%
%><%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
%><%@ include file='/jcore/portal/doPortletParams.jspf' %><%
%><% 
PageCarrefour obj = (PageCarrefour)request.getAttribute(PortalManager.PORTAL_PUBLICATION);
String imageFile = obj.getImage();
String imageMobileFile = Util.notEmpty(obj.getImageMobile()) ? obj.getImageMobile() : "s.gif";
String title = obj.getTitle();
%>

<main role="main" id="content">

    <section class="ds44-container-fluid">
        
        <ds:titleBanner imagePath="<%=imageFile %>" mobileImagePath="<%=imageMobileFile %>" title="<%=title %>" breadcrumb="true"></ds:titleBanner>

        <div class="ds44-inner-container">
            <div class="grid-12-small-1">
                <div class="col-7">
                    <jalios:if predicate="<%= Util.notEmpty(obj.getDescription(userLang)) %>">
                        <p class="ds44-introduction"><%= SocleUtils.lineBreakToBr(obj.getDescription(userLang)) %></p>
                    </jalios:if>

                    <jalios:if predicate="<%= Util.notEmpty(obj.getTopportlets()) %>">
                        <jalios:foreach name="itPortlet" array="<%= obj.getTopportlets() %>" type="com.jalios.jcms.Publication">
                          <jalios:include id="<%= itPortlet.getId() %>" />
                        </jalios:foreach>
                    </jalios:if>
                    
                    <%-- Menu de nav catégories --%>
                    <jalios:if predicate='<%=Util.notEmpty(channel.getProperty("jcmsplugin.socle.pagecarrefour.portlet.nav.id")) %>'>
                        <jalios:include id='<%=channel.getProperty("jcmsplugin.socle.pagecarrefour.portlet.nav.id") %>'/>
                    </jalios:if>
                </div>
                
                <%-- Colonne de droite (affichée systématiquement même si portlets vides) --%>
                <div class="col-1 grid-offset"></div>
                <aside class="col-4">
    		        <jalios:if predicate="<%= Util.notEmpty(obj.getSideportlets()) %>">
			            <jalios:foreach name="itPortlet" array="<%= obj.getSideportlets() %>" type="com.jalios.jcms.Publication">
			                <jalios:include id="<%= itPortlet.getId() %>" />
			            </jalios:foreach>
			        </jalios:if>
                </aside>
            </div>
        </div>
    </section>

    <jalios:if predicate="<%= Util.notEmpty(obj.getBottomportlets()) %>">
        <jalios:foreach name="itPortlet" array="<%= obj.getBottomportlets() %>" type="com.jalios.jcms.Publication">
            <jalios:include id="<%= itPortlet.getId() %>" />
        </jalios:foreach>
    </jalios:if>

        
</main>


  

