<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file='/jcore/doInitPage.jsp'%>
<%@ include file='/jcore/portal/doPortletParams.jsp' %>


<%
String[] headerCatListId = channel.getStringArrayProperty("jcmsplugin.socle.site.header.cat", new String[] {});
Category[] headerCatList = JcmsUtil.stringArrayToDataArray (Category.class, headerCatListId);
%>


<header role="banner" id="top" class="ds44-container-fluid">

    <ul class="ds44-list">
        <li><a href="#content" class="ds44-skiplinks--link">Aller au contenu</a></li>
        <li><a href="#menu" class="ds44-skiplinks--link">Aller au menu</a></li>
        <li><a href="#search" class="ds44-skiplinks--link">Aller à la recherche</a></li>
        <li><a href="#" class="ds44-skiplinks--link">Aller à la page d'accessibilité</a></li>
    </ul>

    <div class="ds44-flex-container ds44-flex-valign-center">
        <div class="ds44-colLeft">
            <a href="index.jsp">
                <picture class="ds44-logo">
                    <img src="<%= channel.getProperty("jcmsplugin.socle.site.src.logo") %>" alt="<%= glp("jcmsplugin.socle.site.alt.logo") %>" />
                </picture>
            </a>
        </div>
        <div class="ds44-colRight">            
            <button class="ds44-btnIcoText--maxi ds44--xl-padding" type="button" role="button"><span class="ds44-btnInnerText">Rechercher</span><i class="icon icon-magnifier icon--large"></i></button>           
            <jalios:foreach array="<%= headerCatList %>" name="itCat" type="Category">
                <a href="<%= itCat.getDisplayUrl(userLocale) %>" class="ds44-btnIcoText--maxi ds44--xl-padding" type="button" role="button"><span class="ds44-btnInnerText"><%= itCat.getName() %></span><i class="icon <%= itCat.getIcon() %> icon--large"></i></a>                          
            </jalios:foreach>
            <button class="ds44-btnIcoText--maxi ds44-btn--contextual ds44--xl-padding" type="button" role="button"><span class="ds44-btnInnerText">Menu</span><i class="icon icon-burger icon--large"></i></button>
        </div>
    </div>
    
</header>