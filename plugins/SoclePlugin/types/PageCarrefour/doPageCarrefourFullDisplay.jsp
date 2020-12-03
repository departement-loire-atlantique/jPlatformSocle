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

<main role="main" id="content">

<jalios:include target="SOCLE_ALERTE"/>

    <section class="ds44-container-large">
        
        <ds:titleBanner pub="<%= obj %>" imagePath="<%=imageFile %>" mobileImagePath="<%=imageMobileFile %>" title="<%=title %>" legend="<%=legende %>" copyright="<%=copyright%>" breadcrumb="true"></ds:titleBanner>

        <div class="ds44-inner-container ds44-xl-margin-tb">
            <div class="grid-12-small-1">
                <div class="col-7">
                    <jalios:if predicate="<%= Util.notEmpty(obj.getChapo(userLang)) %>">
                        <div class="ds44-introduction"><jalios:wysiwyg><%= obj.getChapo(userLang) %></jalios:wysiwyg></div>
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
                <aside class="col-4 asideCards">
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


  

