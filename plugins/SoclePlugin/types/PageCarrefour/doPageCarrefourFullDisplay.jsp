<%@ page contentType="text/html; charset=UTF-8" %><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
%><%@ include file='/jcore/portal/doPortletParams.jspf' %><%
%><% PageCarrefour obj = (PageCarrefour)request.getAttribute(PortalManager.PORTAL_PUBLICATION); %><%
%>


<main role="main" id="content">

    <section class="ds44-container-fluid">

        <div class="ds44-pageHeaderContainer">
            <jalios:if predicate="<%= Util.notEmpty(obj.getImage()) %>">
	            <picture class="ds44-pageHeaderContainer__pictureContainer">
	                <img src="<%=obj.getImage()%>" alt="" class="ds44-headerImg" />
	            </picture>
            </jalios:if>
            <div class="ds44-titleContainer">
                <!-- Fil d'ariane -->
                <jalios:if predicate='<%=Util.notEmpty(channel.getProperty("jcmsplugin.socle.portlet.filariane.id")) %>'>
                    <jalios:include id='<%=channel.getProperty("jcmsplugin.socle.portlet.filariane.id") %>'/>
                </jalios:if>
                <h1 class="h1-like ds44-text--colorInvert"><%=obj.getTitle() %></h1>
            </div>
        </div>

        <div class="ds44-inner-container">
            <div class="grid-12-small-1">
                <div class="col-7">
                    <jalios:if predicate="<%= Util.notEmpty(obj.getDescription(userLang)) %>">
                        <p class="ds44-introduction"><%= obj.getDescription(userLang) %></p>
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


  

