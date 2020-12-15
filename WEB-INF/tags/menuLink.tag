<%@ taglib prefix="ds" tagdir="/WEB-INF/tags" %><%
%><%@ taglib uri="jcms.tld" prefix="jalios" %><%
%><%@ tag 
    pageEncoding="UTF-8"
    description="Lien d'un sous-menu dans le menu de navigation" 
    body-content="scriptless" 
    import="com.jalios.jcms.Category,
            java.util.Locale,
            com.jalios.jcms.JcmsUtil,
            com.jalios.util.Util,
            com.jalios.jcms.HttpUtil"
%><%
%><%@ attribute name="itCategory"
    required="true"
    fragment="false"
    rtexprvalue="true"
    type="com.jalios.jcms.Category"
    description="Catégorie qui sera utilisée pour générer le lien"
%><%@ attribute name="userLocale"
    required="true"
    fragment="false"
    rtexprvalue="true"
    type="Locale"
    description="La valeur de userLocale pour la bonne traduction du label"
%><%@ attribute name="userLang"
    required="true"
    fragment="false"
    rtexprvalue="true"
    type="String"
    description="La valeur de userLang pour la bonne traduction du label"
%>

<%
String cible= "";
String title = "";
String libelleCat = Util.notEmpty(itCategory.getExtraData("extra.Category.plugin.tools.synonyme.facet.title")) ? itCategory.getExtraData("extra.Category.plugin.tools.synonyme.facet.title") : itCategory.getName(userLang);
boolean targetBlank = "true".equals(itCategory.getExtraData("extra.Category.plugin.tools.blank")) ? true : false;
if(targetBlank){
    cible="target=\"_blank\" ";
    title = "title=\"" + HttpUtil.encodeForHTMLAttribute(libelleCat + " " + JcmsUtil.glp(userLang, "jcmsplugin.socle.accessibily.newTabLabel"))+"\"";
}
%>

<li><a href="<%= itCategory.getDisplayUrl(userLocale) %>" class="ds44-menuLink ds44-menuLink--subLvl" <%=title%> <%=cible%>><%=libelleCat%><i class="icon icon-arrow-right" aria-hidden="true"></i></a></li>