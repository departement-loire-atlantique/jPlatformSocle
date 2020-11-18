<%@page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@ page contentType="text/html; charset=UTF-8" %><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
%><%@ include file='/jcore/portal/doPortletParams.jspf' %><%
%><% WelcomeSection obj = (WelcomeSection)request.getAttribute(PortalManager.PORTAL_PUBLICATION); %><%
%>


<main role="main" id="content" tabindex="-1">

<jalios:include target="SOCLE_ALERTE"/>

    <section class="ds44-container-fluid">

        <div class="ds44-pageHeaderContainer">
            <jalios:if predicate="<%= Util.notEmpty(obj.getImage()) %>">
	            <picture class="ds44-pageHeaderContainer__pictureContainer">
	                <img src="<%=SocleUtils.getUrlOfFormattedImagePrincipale(obj.getImage())%>" alt="" class="ds44-headerImg" />
	            </picture>
            </jalios:if>
            <div class="ds44-titleContainer">
                <!-- Fil d'ariane (TODO : à mettre en property) -->
                <jalios:include id="c_1088465"/>
                <h1 class="h1-like ds44-text--colorInvert"><%=obj.getTitle() %></h1>
            </div>
        </div>

        <div class="ds44-inner-container">
            <div class="grid-12-small-1">
                <div class="col-7">
                    <jalios:if predicate="<%= Util.notEmpty(obj.getDescription(userLang)) %>">
                        <p class="ds44-introduction"><%= obj.getDescription(userLang) %></p>
                    </jalios:if>
                    
                    <%-- Menu de nav catégories (à mettre en prop) --%>
                    <jalios:include id="c_1088673"/>
                </div>
                
                <%-- Colonne de droite (affichée systématiquement même si portlets vides) --%>
                <div class="col-1 grid-offset"></div>
                <aside class="col-4 asideCards">                   
    		        <jalios:if predicate="<%= Util.notEmpty(obj.getTopportlets()) %>">
			            <jalios:foreach name="itPortlet" array="<%= obj.getTopportlets() %>" type="com.jalios.jcms.Publication">
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


  

