<%@ page contentType="text/html; charset=UTF-8" %><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
%><% FicheAide obj = (FicheAide)request.getAttribute(PortalManager.PORTAL_PUBLICATION); %>


<main role="main" id="content">

    <section class="ds44-container-fluid">

        <div class="ds44-pageHeaderContainer">
            <!-- TODO condition sur l'image mobile -->
            <jalios:if predicate="<%= Util.notEmpty(obj.getImagePrincipale()) %>">               
                <picture class="ds44-pageHeaderContainer__pictureContainer">
                    <img src="<%=obj.getImagePrincipale()%>" alt="" class="ds44-headerImg" />
                </picture>
            </jalios:if>
            <div class="ds44-titleContainer">
                <!-- Fil d'ariane (TODO : à mettre en property) -->
                <jalios:include id="c_1088465"/>
                <h1 class="h1-like ds44-text--colorInvert"><%=obj.getTitle() %></h1>
            </div>
        </div>
    
        <!-- TODO Liste des onglets -->
        
        
        <!-- TODO ONGLET - En résumé -->
        
        <%= obj.getChapo() %>
        
        <jalios:wysiwyg><%= obj.getPrecisionsBeneficiaires() %></jalios:wysiwyg>            
        
    
    </section>
        
</main>