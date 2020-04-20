<%@ taglib uri="jcms.tld" prefix="jalios" %>
<%@ tag 
    pageEncoding="UTF-8"
    description="Affiche une infobulle avec, soit le texte passé en paramètre, soit la description de la catégorie passée en paramètre" 
    body-content="scriptless" 
    import="com.jalios.jcms.Channel, com.jalios.util.ServletUtil, com.jalios.util.Util"
%>
<%@ attribute name="cat"
    required="false"
    fragment="false"
    rtexprvalue="true"
    type="com.jalios.jcms.Category"
    description="La catégorie dont on souhaite afficher la description dans l'infobulle"
%>
<%@ attribute name="help"
    required="false"
    fragment="false"
    rtexprvalue="true"
    type="String"
    description="Le texte d'aide pour le bouton d'infobulle"
%>
<%@ attribute name="text"
    required="false"
    fragment="false"
    rtexprvalue="true"
    type="String"
    description="Le contenu de l'infobulle (si catégorie absente)"
%>

<% 
String uid = ServletUtil.generateUniqueDOMId(request, "uid");
String userLang = Channel.getChannel().getCurrentJcmsContext().getUserLang();

/* Si le texte est vide on regarde si la catégorie possède une description et une autorisation d'affichage de tooltip.
 * Si on ne trouve rien, on n'affiche rien.
*/
System.out.println(cat.getName());
System.out.println(help);
String tooltipContent = text;
if(Util.isEmpty(tooltipContent)){
	if(Util.notEmpty(cat) && Boolean.parseBoolean(cat.getExtraData("extra.Category.plugin.tools.tooltip")) && Util.notEmpty(cat.getDescription(userLang))){
		tooltipContent = cat.getDescription(userLang);
  	}
	if(Util.isEmpty(tooltipContent)){
		return;
	}
}
%>

<button type="button" class="js-simple-tooltip button" data-simpletooltip-content-id="tooltip_<%= uid %>">
    <i class="icon icon-help" aria-hidden="true"></i>
    <jalios:if predicate='<%= Util.notEmpty(help) %>'>
        <span class="visually-hidden"><%= help %></span>
    </jalios:if>
</button>
<span id="tooltip_<%= uid %>" class="simpletooltip js-simple-tooltip" role="tooltip" aria-hidden="true"><%= tooltipContent %></span>

