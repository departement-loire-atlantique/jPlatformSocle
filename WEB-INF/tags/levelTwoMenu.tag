<%@ taglib prefix="ds" tagdir="/WEB-INF/tags" %><%
%><%@ taglib uri="jcms.tld" prefix="jalios" %><%
%><%@ tag 
    pageEncoding="UTF-8"
    description="Deuxieme niveau du menu de navigation principal" 
    body-content="scriptless" 
    import="com.jalios.jcms.Channel,
            com.jalios.jcms.Category,
            java.util.Locale,
            fr.cg44.plugin.socle.SocleUtils,
            com.jalios.jcms.JcmsUtil,
            com.jalios.util.Util,
            java.util.SortedSet,
            com.jalios.jcms.HttpUtil"
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
<%
String userLang = Channel.getChannel().getCurrentUserLang();
Locale userLocale = Channel.getChannel().getCurrentJcmsContext().getUserLocale();
%>
<section id="<%= id %>" class="ds44-overlay ds44-theme ds44-bgCircle ds44-bg-br ds44-overlay--navNiv2" role="dialog" aria-label='<%= HttpUtil.encodeForHTMLAttribute(JcmsUtil.glp(userLang, "jcmsplugin.socle.menu.principal2", rootCat.getName(userLang))) %>' aria-hidden="true">
    <div class="ds44-container-menuBackLink">
        <button type="button" title='<%= JcmsUtil.glp(userLang, "jcmsplugin.socle.menu.retour") %>' class="ds44-btn-backOverlay"><i class="icon icon-arrow-left icon--xlarge" aria-hidden="true"></i><span class="ds44-btnInnerText--bottom"><%= JcmsUtil.glp(userLang, "jcmsplugin.socle.retour") %></span></button>
        <p role="heading" aria-level="1" class="ds44-menuBackLink"><%=rootCat.getName()%></p>
    </div>
    <button class="ds44-btnOverlay ds44-btnOverlay--closeOverlay" type="button" aria-label='<%= JcmsUtil.glp(userLang, "jcmsplugin.socle.menu.fermer") %>'><i class="icon icon-cross icon--xlarge" aria-hidden="true"></i><span class="ds44-btnInnerText--bottom"><%= JcmsUtil.glp(userLang, "jcmsplugin.socle.fermer") %></span></button>
    
    <nav role="navigation" aria-label='<%= JcmsUtil.glp(userLang, "jcmsplugin.socle.menu.navigation") %>' class="ds44-navContainer ds44-flex-container--column ds44-fse ds44-tiny-to-med-ftop">
        <div class="ds44-navList">
            <ul class="ds44-navListN2 ds44-multiCol ds44-xl-gap ds44-xl-fluid-margin ds44-list">
            <% SortedSet<Category> orderedAuthorizedChildrenSet = SocleUtils.getOrderedAuthorizedChildrenSet(rootCat); %>
            <jalios:foreach collection="<%= orderedAuthorizedChildrenSet %>" name="itCat" type="Category">
                <ds:menuLink itCategory="<%= itCat %>" userLang="<%= userLang %>" userLocale="<%= userLocale %>"/>
            </jalios:foreach>
            </ul>
        </div>
    </nav>

</section>