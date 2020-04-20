<%@ taglib prefix="ds" tagdir="/WEB-INF/tags" %><%
%><%@ taglib uri="jcms.tld" prefix="jalios" %><%
%><%@ tag 
    pageEncoding="UTF-8"
    description="Affiche une liste de noms de catégories séparées par un séparateur. Possibilité d'affiher une infobulle.
    Les catégories affichées sont passées en paramètres ou bien sont calculées à partir d'une catégorie racine." 
    body-content="scriptless" 
    import="com.jalios.jcms.Channel,
            com.jalios.jcms.Category,
            com.jalios.jcms.Member,
            com.jalios.jcms.Publication,
            com.jalios.jcms.JcmsUtil,
            com.jalios.util.ServletUtil,
            com.jalios.util.Util,
            java.util.TreeSet,
            java.util.Set,
            fr.cg44.plugin.socle.SocleUtils"
%><%
%><%@ attribute name="rootCat"
    required="false"
    fragment="false"
    rtexprvalue="true"
    type="com.jalios.jcms.Category"
    description="Catégorie racine sur laquelle itérer pour générer la liste"
%><%
%><%@ attribute name="categories"
	required="false"
	fragment="false"
	rtexprvalue="true"
	type="Set<Category>"
	description="Catégorie racine sur laquelle itérer pour générer la liste"
%><%
%><%@ attribute name="separator"
	required="false"
	fragment="false"
	rtexprvalue="true"
	type="String"
	description="Le caractère de séparation entre les catégories"
%><%
%><%@ attribute name="tooltip"
	required="false"
	fragment="false"
	rtexprvalue="true"
	type="Boolean"
	description="Affiche un tooltip à côté du nom de la catégorie ou pas."
%><%

String separateur = Util.notEmpty(separator) ? separator : ", ";
String userLang = Channel.getChannel().getCurrentJcmsContext().getUserLang();


// Tri des catégories filles + filtre sur catégories autorisées
if(Util.notEmpty(rootCat)){
	categories = SocleUtils.getOrderedAuthorizedChildrenSet(rootCat);
}

%>

<jalios:foreach name="itCat" type="Category" collection="<%= categories %>">
    <%= itCat.getName() %>
    <ds:tooltip cat='<%= itCat %>' help='<%= JcmsUtil.glp(userLang,"jcmsplugin.socle.tooltip", itCat.getName()) %>' />
    <%= itCounter < categories.size() ? separateur : "" %>
</jalios:foreach>
        
