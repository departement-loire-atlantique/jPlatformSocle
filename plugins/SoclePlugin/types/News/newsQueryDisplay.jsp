<%@page import="fr.cg44.plugin.corporateidentity.exception.UnknowCurrentSpaceException" %><%
%><%@page import="fr.cg44.plugin.corporateidentity.tools.Navigation"%><%
%><%@page import="fr.cg44.plugin.corporateidentity.news.NewsDirectoryLinkGenerator"%><%
%><%@ include file='/jcore/doInitPage.jsp'%><%
  // CSS et Javascript
  jcmsContext.addCSSHeader("plugins/CorporateIdentityPlugin/css/types/News/newsQueryDisplay.css");
  News obj = (News)request.getAttribute(PortalManager.PORTAL_PUBLICATION);
 
  //Paramètres pour le portail et la catégorie
  String params = NewsDirectoryLinkGenerator.getLinkParams(obj, true, true);
  
  Category newsType = (Category) obj.getNewsType(loggedMember).first();
 
  String url = obj.getUrlExterne();
  String target = obj.getOuvrirDansUnNouvelOnglet()?"target='_blank'":"";
  String title = obj.getOuvrirDansUnNouvelOnglet()?obj.getTitle(userLang)+" (nouvelle fenêtre)":obj.getTitle(userLang);
  
 %><div class="news-box-display-container row-fluid"><%
	// Partie consacrée à l'image - Avant la partie contenu pour l'affichage sur tablette
	%><div class="span6 illustration hidden-phone">
		<div class="image-and-news-type">
		  <div class="image">
		  
		  	<jalios:select>
		  		<%-- Si Url externe renseignée --%>
   	  			<jalios:if predicate='<%= Util.notEmpty(url) %>'>
			        <a class="noTooltipCard" <%= target %> title="<%= title %>" href="<%= url %>">
			          <img src="<%=Util.encodeUrl(obj.getMainIllustration())%>" alt="<%= Util.escapeHtmlQuote(glp("plugin.corporateidentity.news.alt", obj.getTitle())) %>" />
			          <jalios:edit pub='<%=obj%>' fields='mainIllustration' />
			        </a>
			    </jalios:if>
			    
			    <%-- Si lien vers publication renseigné (pas de type actualité) --%>
			    <jalios:if predicate='<%= Util.notEmpty(obj.getLienInternePublication()) && !(obj.getLienInternePublication() instanceof News) %>'>
			    	<jalios:link css="noTooltipCard" title="<%= obj.getTitle(userLang) %>" data="<%= NewsDirectoryLinkGenerator.getNewsInternLink(obj) %>">
			          <img src="<%=Util.encodeUrl(obj.getMainIllustration())%>" alt="<%= Util.escapeHtmlQuote(glp("plugin.corporateidentity.news.alt", obj.getTitle())) %>" />
			          <jalios:edit pub='<%=obj%>' fields='mainIllustration' />
			        </jalios:link>
			    </jalios:if>
			    
			    <%-- Si lien vers publication renseigné (type actualité) ou redirection --%>
			    <jalios:default>
			    	<jalios:link css="noTooltipCard" title="<%= obj.getTitle(userLang) %>" data="<%= NewsDirectoryLinkGenerator.getNewsInternLink(obj) %>" params="<%= params %>">
			          <img src="<%=Util.encodeUrl(obj.getMainIllustration())%>" alt="<%= Util.escapeHtmlQuote(glp("plugin.corporateidentity.news.alt", obj.getTitle())) %>" />
			          <jalios:edit pub='<%=obj%>' fields='mainIllustration' />
			        </jalios:link>
			    </jalios:default>
			</jalios:select>
				
				<%// Type d'actualité
				%><div class="news-type"><img src="<%= newsType.getIcon()%>" alt="<%= newsType.getName() %>" /></div>
      </div>
		</div>
	</div><%
	
	// Partie consacrée au contenu
	%><div class="span6 content"><%
	 // Type d'actualité sur mobile
	 %><div class="news-type hidden-tablet hidden-desktop"><img src="<%= newsType.getIcon()%>" alt="<%= newsType.getName() %>" /></div><%
	    		
	 // Titre de l'actualité
   %><div class="title">
   	  <jalios:select>
   	  	<%-- Si Url externe renseignée --%>
   	  	<jalios:if predicate='<%= Util.notEmpty(url) %>'>
      		<h3><a class="noTooltipCard" <%= target %> title="<%= title %>" href="<%= url %>"><%= obj.getTitle(userLang) %></a><jalios:edit pub='<%= obj %>' /></h3>
    	</jalios:if>
    	
    	<%-- Si lien vers publication renseigné (pas de type actualité) --%>
    	<jalios:if predicate='<%= Util.notEmpty(obj.getLienInternePublication()) && !(obj.getLienInternePublication() instanceof News) %>'>
    		<h3><jalios:link css="noTooltipCard" title="<%= obj.getTitle(userLang) %>" data="<%= NewsDirectoryLinkGenerator.getNewsInternLink(obj) %>"><%= obj.getTitle(userLang) %></jalios:link><jalios:edit pub='<%= obj %>' /></h3>    		
    	</jalios:if>
    	
    	<%-- Si lien vers publication renseigné (type actualité) ou redirection --%>
    	<jalios:default>
    		<h3><jalios:link css="noTooltipCard" title="<%= obj.getTitle(userLang) %>" data="<%= NewsDirectoryLinkGenerator.getNewsInternLink(obj) %>" params="<%= params %>"><%= obj.getTitle(userLang) %></jalios:link><jalios:edit pub='<%= obj %>' /></h3>    		
    	</jalios:default>
      </jalios:select>
    </div><%
    
    // Date
    %><div class="date"><p><jalios:date locale="<%= userLocale %>" date="<%= obj.getPdate() %>" format="dd/MM/yyyy"/></p></div><%
    
    // Chapo
    %><div class="abstract"><jalios:wiki><%= obj.getDescription(userLang) %></jalios:wiki><jalios:edit pub='<%= obj %>' fields='description'/></div>
	</div>
</div>