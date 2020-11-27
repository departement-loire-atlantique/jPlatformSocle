<%@page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@ include file='/jcore/doInitPage.jspf' %>
<%@ include file='/jcore/portal/doPortletParams.jspf' %>
<%@ include file='/types/PortletNavigate/doInitPortletNavigate.jspf' %>

<%-- SGU : inspiré de doPortletNavigateLocation.jsp
    On adapte la liste au design system et on gère les extradatas de catégories (libellé, target)
    Les liens pointent vers les catégories. Un portalPolicyFilter s'occupe de rediriger vers le
    bon contenu.
    On n'affiche pas dans le fil d'Ariane les catégories qui ne contiennt pas de contenu principal.
    Les arborescences peuvent être différentes selon les sites mais on aura en commun les niveaux suivants : 
    "Navigation" > "Navigation des espaces"
    On récupère les ancetres de la catégorie courante et on supprime les 2 premiers niveaux ci-dessus.
    
    MAJ 20/10/2020 : on n'affiche pas le fil d'ariane si on est en mode "résultat de recherche à facette" car
    le calcul de la catégorie courante est faussé.
--%>

<%

if(Util.notEmpty(request.getAttribute("isSearchFacetPanel"))){
  return;
}
        
List<Category> ancestors  = currentCategory.getAncestorList();
    
for (Iterator<Category> it = rootCategory.getAncestorList().iterator() ; it.hasNext() ;) {
  ancestors.remove(it.next());
}

if (Util.isEmpty(ancestors) && box.getHideWhenNoResults()) {
  request.setAttribute("ShowPortalElement",Boolean.FALSE);
  return;
}

// On supprime les 2 premiers niveaux : "Navigation" > "Navigation des espaces"
Collections.reverse(ancestors);
if(Util.notEmpty(ancestors)) {
	ancestors.remove(0);
	if(Util.notEmpty(ancestors)) {
		ancestors.remove(0);
	}
}

String nofollow = box.getNavigatePortlet() ? "" : "rel='nofollow'";
int counter = 0;
String libelleCat = "";
String cible="";
String title = "";
String textColorStyle = "";

String lblAltTitle = glp("jcmsplugin.socle.retour.accueil");

// texte du breadcrumb clair/sombre
if(Util.notEmpty(request.getAttribute("textColor"))){
    textColorStyle = "ds44-text--colorInvert";
}
%>

<nav role="navigation" aria-label='<%=glp("jcmsplugin.socle.breadcrumb.position")%>' class="ds44-hide-mobile">
    <ul class="ds44-list ds44-breadcrumb <%=textColorStyle%>">
        <li class="ds44-breadcrumb_item">
            <a href="index.jsp" title="<%= lblAltTitle %> <%=channel.getName()%>"><i class="icon icon-home icon--medium"></i><span class="visually-hidden">Accueil</span></a>
        </li>
        
        <jalios:foreach collection="<%= ancestors %>" type="Category" name="itCategory" counter="itCounter">
           <jalios:select>
             <jalios:if predicate='<%= itCounter == 1 && Util.isEmpty(SocleUtils.getContenuPrincipal(itCategory)) %>'>
                <%-- On affiche le 1er ancêtre s'il existe --%>
                <%
                libelleCat = Util.notEmpty(itCategory.getExtraData("extra.Category.plugin.tools.synonyme.facet.title")) ? itCategory.getExtraData("extra.Category.plugin.tools.synonyme.facet.title") : itCategory.getName(userLang);
                counter++;
                %>
                <li class="ds44-breadcrumb_item"><span><%= libelleCat %></span></li>
             </jalios:if>
             <jalios:if predicate='<%= (itCounter == 1 && Util.notEmpty(SocleUtils.getContenuPrincipal(itCategory))) || (itCategory.canBeReadBy(loggedMember , true, true) && Util.notEmpty(SocleUtils.getContenuPrincipal(itCategory)) && counter < box.getLevels()-1) %>'>
                <%-- On boucle sur les autres ancêtres et on vérifie la présence d'un contenu principal --%>
                <%
                libelleCat = Util.notEmpty(itCategory.getExtraData("extra.Category.plugin.tools.synonyme.facet.title")) ? itCategory.getExtraData("extra.Category.plugin.tools.synonyme.facet.title") : itCategory.getName(userLang);
                boolean targetBlank = "true".equals(itCategory.getExtraData("extra.Category.plugin.tools.blank")) ? true : false;
                if(targetBlank){
                    cible="target=\"_blank\"";
                    title = "title=\"" + libelleCat + " " + glp("jcmsplugin.socle.accessibily.newTabLabel") + "\"";
                }
                %>
        
                <li class="ds44-breadcrumb_item">
                    <a <%= nofollow %> href='<%= SocleUtils.getContenuPrincipal(itCategory).getDisplayUrl(userLocale) %>' <%=cible%> <%=title%>><%= libelleCat %></a>
                </li>
                <% counter++; %>
            </jalios:if>
           </jalios:select>
        </jalios:foreach>
        
        <%-- On affiche la catégorie courante --%>
        <li class="ds44-breadcrumb_item" aria-current="location">
            <%= Util.notEmpty(currentCategory.getExtraData("extra.Category.plugin.tools.synonyme.facet.title")) ? currentCategory.getExtraData("extra.Category.plugin.tools.synonyme.facet.title") : currentCategory.getName(userLang) %>
            <% counter++; %>
        </li>
    </ul>
</nav>