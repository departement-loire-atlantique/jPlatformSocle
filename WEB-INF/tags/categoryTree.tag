<%@tag import="generated.PortletPortalRedirect"%>
<%@ taglib prefix="ds" tagdir="/WEB-INF/tags" %><%
%><%@ taglib uri="jcms.tld" prefix="jalios" %><%
%><%@ tag 
    pageEncoding="UTF-8"
    description="Liste des catégories et leurs enfants sur un nobre de niveau donné" 
    body-content="scriptless" 
    import="com.jalios.jcms.Channel,
            com.jalios.jcms.Category,
            com.jalios.jcms.Member,
            com.jalios.jcms.Publication,
            com.jalios.jcms.DataSelector,
            com.jalios.jcms.JcmsUtil,
            com.jalios.util.ServletUtil,
            com.jalios.util.Util,
            java.util.TreeSet,
            java.util.Set,
            java.util.Locale,
            fr.cg44.plugin.socle.SocleUtils,
            generated.PageCarrefour"
%><%
%><%@ attribute name="rootCat"
    required="true"
    fragment="false"
    rtexprvalue="true"
    type="com.jalios.jcms.Category"
    description="Catégorie racine sur laquelle itérer pour générer la liste"
%><%
%><%@ attribute name="maxLevels"
    required="true"
    fragment="false"
    rtexprvalue="true"
    type="Integer"
    description="Niveau max de profondeur de l'arbre"
%><%
%><%@ attribute name="currentLevel"
required="false"
fragment="false"
rtexprvalue="true"
type="Integer"
description="Niveau courant de l'arbre"%>

<%
Member loggedMember = Channel.getChannel().getCurrentJcmsContext().getLoggedMember();
String userLang = Channel.getChannel().getCurrentJcmsContext().getUserLang();
Locale userLocale = Channel.getChannel().getCurrentJcmsContext().getUserLocale();

// Tri des catégories filles + filtre sur catégories autorisées
Set<Category> childrenCatSet = SocleUtils.getOrderedAuthorizedChildrenSet(rootCat);

// Calcul du niveau d'itération courant
int itLevel = currentLevel!=null ? currentLevel : 0;
itLevel++;

// Style pour le padding des listes imbriquées (padding doublé au-delà du niveau 1)
String paddingClass = "ds44-list ds44-collapser_content--level2";
%>
<jalios:if predicate="<%= !childrenCatSet.isEmpty() && itLevel <= maxLevels  %>">
    <% if(itLevel>1) paddingClass = "ds44-list ds44-collapser_content--level3"; %>
    <ul class="<%=paddingClass%>">
    <%-- Si présence d'un contenu principal dans la catégorie, alors lien vers ce contenu, sinon génération des enfants. --%>
    <%
	for(Category itCategory : childrenCatSet){
		String cible= "";
		String title = "";
		String libelleCat = Util.notEmpty(itCategory.getExtraData("extra.Category.plugin.tools.synonyme.facet.title")) ? itCategory.getExtraData("extra.Category.plugin.tools.synonyme.facet.title") : itCategory.getName(userLang);
		boolean targetBlank = "true".equals(itCategory.getExtraData("extra.Category.plugin.tools.blank")) ? true : false;
		if(targetBlank){
		    cible="target=\"_blank\" ";
		    title = "title=\"" + libelleCat + " " + JcmsUtil.glp(userLang, "jcmsplugin.socle.accessibily.newTabLabel")+"\"";
		}
		
		Publication itContenuPrincipal = SocleUtils.getContenuPrincipal(itCategory);
		PortletPortalRedirect itRedirect = SocleUtils.getPortalRedirect(itCategory);
	    if(Util.notEmpty(itContenuPrincipal)) {%>
	    	<li><a href="<%= itContenuPrincipal.getDisplayUrl(userLocale) %>" class="ds44-collapser_content--link" <%=title%> <%=cible%>><%=libelleCat%></a></li>
	    <%}
	    else if (Util.notEmpty(itRedirect)) {%>
	       <jalios:select>
               <jalios:if predicate='<%= itRedirect.getStatus().equals("url") && Util.notEmpty(itRedirect.getUrl()) %>'>
	           <li><a target="_blank" href="<%= itCategory.getDisplayUrl(userLocale) %>" class="ds44-collapser_content--link" <%=title%> <%=cible%>><%=libelleCat%></a></li>
	           </jalios:if>
	           <jalios:default>
	           <li><a href="<%= itCategory.getDisplayUrl(userLocale) %>" class="ds44-collapser_content--link" <%=title%> <%=cible%>><%=libelleCat%></a></li>
	           </jalios:default>
	       </jalios:select>
	    <%}
        else {%>
	       <li>
	           <jalios:select>
		           <jalios:if predicate="<%= Util.notEmpty(itCategory.getChildrenSet()) %>">
			           <span class="ds44-collapser_content--txt"><%=libelleCat%></span>
		               <ds:categoryTree rootCat='<%=itCategory %>' maxLevels="<%=maxLevels%>" currentLevel="<%=itLevel%>"/>
		           </jalios:if>
		           <jalios:default>
		               <a href="<%= itCategory.getDisplayUrl(userLocale) %>" class="ds44-collapser_content--link" <%=title%> <%=cible%>><%=libelleCat%></a>
		           </jalios:default>
	           </jalios:select>
           </li><%
	    }
	}%>
    </ul>
</jalios:if>
