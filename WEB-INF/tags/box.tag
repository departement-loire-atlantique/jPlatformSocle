<%@ taglib uri="jcms.tld" prefix="jalios" %>
<%@ tag 
    pageEncoding="UTF-8"
    description="Encadré" 
    body-content="scriptless" 
    import="com.jalios.util.Util, com.jalios.util.ServletUtil"
%>
<%@ attribute name="title"
    required="false"
    fragment="false"
    rtexprvalue="true"
    type="String"
    description="Le titre de l'encadré"
%>
<%@ attribute name="legend"
    required="false"
    fragment="false"
    rtexprvalue="true"
    type="String"
    description="Le texte de légende de l'encadré"
%>
<%@ attribute name="type"
    required="false"
    fragment="false"
    rtexprvalue="true"
    type="String"
    description="Le type d'encadré : gris / theme / bordure / alerte ('theme' si vide)"
%>
<%@ attribute name="boxClasses"
    required="false"
    fragment="false"
    rtexprvalue="true"
    type="String"
    description="Les classes css à rajouter au niveau de la section"
%>
<%@ attribute name="titleClasses"
    required="false"
    fragment="false"
    rtexprvalue="true"
    type="String"
    description="Les classes css à rajouter au niveau du titre"
%>
<%@ attribute name="ariaLevel"
    required="false"
    fragment="false"
    rtexprvalue="true"
    type="String"
    description="Le niveau de aria-level pour le titre. 2 par défaut"
%>

<%-- Si le titre est renseigné on le gère en tant que <p role="heading"> uniquement.
     On peut préciser le niveau du aria-level. Si null alors on met "2" par défaut.
     On ne gère pas les <h>.
     On peux préciser une classe css de titre. Ce sera utile pour forcer un "h3-like" par ex.
     Sinon par défaut la classe "ds44-box-heading" sera appliquée.   
--%>
<%
String styleEncadre = "";
String niveauTitre = Util.notEmpty(ariaLevel) ? ariaLevel : "2";
String styleTitre = Util.notEmpty(titleClasses) ? titleClasses : "ds44-box-heading"; 
  
switch(type) {

	case "gris" :
	  styleEncadre = "ds44-bgGray";
	  break;
	  
	case "bordure" :
	  styleEncadre = "ds44-borderContainer";
	  break;
	  
	case "alerte" :
	  styleEncadre = "ds44-alertMsg-container";
	  break;  
	
	default :
	  styleEncadre = "ds44-theme";
}
%>

<section class="ds44-box <%= styleEncadre %> <%= boxClasses %>">
    <div class="ds44-innerBoxContainer">
    
        <jalios:if predicate="<%= Util.notEmpty(title) %>">
            <p role="heading" aria-level="<%= niveauTitre %>" class="<%= styleTitre %>"><%= title %></p>
        </jalios:if>
        
	    <jalios:if predicate="<%= Util.notEmpty(legend) %>">    
	        <p class="ds44-textLegend ds44-textLegend--mentions"><%= legend %></p>
	    </jalios:if>
	    
	    <jsp:doBody/>
	    
    </div>
</section>