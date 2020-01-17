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
description="Niveau courant de l'arbre"%><%

Member loggedMember = Channel.getChannel().getCurrentJcmsContext().getLoggedMember();
String userLang = Channel.getChannel().getCurrentJcmsContext().getUserLang();

// Tri des catégories filles + filtre sur catégories autorisées
TreeSet<Category> childrenCatSet = SocleUtils.getOrderedAuthorizedChildrenSet(rootCat);

// Calcul du niveau d'itération courant
int itLevel = currentLevel!=null ? currentLevel : 0;
itLevel++;

// Style pour le padding des listes imbriquées (padding doublé au-delà du niveau 1)
String paddingClass = "ds44-list ds44-collapser_content--level2";
%>
<jalios:if predicate="<%= !childrenCatSet.isEmpty() && itLevel <= maxLevels  %>">
    <% if(itLevel>1) paddingClass = "ds44-list ds44-collapser_content--level3"; %>
    <ul class="<%=paddingClass%>">
    <%-- Si présence de page carrefour comme contenu principal de la catégorie, alors lien vers cette page carrefour, sinon génération des enfants. --%>
    <%
	for(Category itCategory : childrenCatSet){
		Publication itContenuPrincipal = SocleUtils.getContenuPrincipal(itCategory);
	    boolean linkToPub = Util.notEmpty(itContenuPrincipal) ? itContenuPrincipal instanceof PageCarrefour : false;
	    if(linkToPub) {%>
	    	<li><jalios:link data="<%=itContenuPrincipal%>" css="ds44-collapser_content--buttonLike"><%=itCategory.getName()%></jalios:link></li>
	    	
	    <%}
	    else{%>
	       <li>
	           <jalios:link data="<%=itCategory%>" css="ds44-collapser_content--link"><%=itCategory.getName()%></jalios:link>
	           <ds:categoryList rootCat='<%=itCategory %>' maxLevels="<%=maxLevels%>" currentLevel="<%=itLevel%>"/>
           </li><%
	    }
	}%>
    </ul>
</jalios:if>
