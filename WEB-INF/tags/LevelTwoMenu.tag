<%@ taglib prefix="ds" tagdir="/WEB-INF/tags" %><%
%><%@ taglib uri="jcms.tld" prefix="jalios" %><%
%><%@ tag 
    pageEncoding="UTF-8"
    description="Deuxieme niveau du menu de navigation principal" 
    body-content="scriptless" 
    import="com.jalios.jcms.Category"
%><%
%><%@ attribute name="rootCat"
    required="true"
    fragment="false"
    rtexprvalue="true"
    type="com.jalios.jcms.Category"
    description="Catégorie racine sur laquelle itérer pour générer la liste"
%><%@ attribute name="id"
    required="true"
    fragment="false"
    rtexprvalue="true"
    type="String"
    description="Id du second niveau du menu"
%>

<section id="<%= id %>" class="ds44-overlay ds44-theme ds44-bgCircle ds44-bg-br ds44-overlay--navNiv2" role="dialog" aria-label="Menu principal niveau 2">

    <button class="ds44-btnOverlay ds44-btnOverlay--closeOverlay" type="button" aria-label="fermer le menu de navigation"><i class="icon icon-cross icon--xlarge" aria-hidden="true"></i><span class="ds44-btnInnerText--bottom">Fermer</span></button>

    <nav role="navigation">
        <div class="ds44-inner-container">

            <div class="ds44-posAbs ds44-posTopCont">
                <button type="button" title="Retour menu principal" class="ds44-btn-backOverlay"><i class="icon icon-arrow-left icon--xlarge" aria-hidden="true"></i><span class="ds44-btnInnerText--bottom">Retour</span></button>
                <p role="heading" aria-level="1" class="ds44-menuBackLink"><%= rootCat.getName() %></p>
            </div>

            <ul class="ds44-navListN2 ds44-multiCol ds44-xl-gap ds44-xl-fluid-margin ds44-list">
            <jalios:foreach collection="<%= rootCat.getChildrenSet() %>" name="itCat" type="Category">
                <li><a href="<%= itCat.getDisplayUrl(userLocale) %>" class="ds44-menuLink ds44-menuLink--subLvl"><%= itCat.getName() %><i class="icon icon-arrow-right" aria-hidden="true"></i></a></li>
            </jalios:foreach>
            </ul>
        </div>
    </nav>

</section>