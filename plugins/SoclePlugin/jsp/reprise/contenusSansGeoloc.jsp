<%@page import="java.util.regex.Matcher"%>
<%@page import="java.util.regex.Pattern"%>
<%@page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@page import="com.jalios.jcms.handler.QueryHandler"%>
<%@page import="java.io.IOException"%>
<%
  
%><%@ include file="/jcore/doInitPage.jsp"%>
<%
  if (!isAdmin) {
    sendForbidden(request, response);
    return;
  }

String defaultTypes = "FicheSAAD FicheLieu SeniorCitizensEstablishment";
%>
<%@ include file='/admin/doAdminHeader.jspf'%>

<div class="page-header">
	<h1>Liste des contenus sans géoloc renseignée</h1>
</div>

<p>Saisir les noms techniques des types de contenus à vérifier, séparés par un espace.</p>

<form>
    <input type="text" name="dataType" value="<%= Util.notEmpty(request.getParameter("dataType")) ? request.getParameter("dataType") : defaultTypes %>" size="100">
    <input type="hidden" name="executeReprise" value="true">
    <input class="btn btn-danger modal confirm" type="submit" value="Vérifier géoloc"/>
</form>

<% 
String[] dataTypes = getUntrustedStringParameter("dataType", "").split(" "); 
%>

<jalios:if predicate='<%= getBooleanParameter("executeReprise", false) && Util.notEmpty(dataTypes) %>'>

	<jalios:foreach name='dataType' array='<%=dataTypes %>' type='String'>
	    <h2><%= dataType %></h2>
	    <%
	    // Teste si le nom de classe saisi existe
	    try{
		    // Pas de QueryHandler car il ne remonte pas toutes les pubs à cause du "IgnoreQueryFilter"
		    TreeSet<Publication> itPubSet = channel.getAllPublicationSet(channel.getClass(dataType),loggedMember,false);
		    int cpt=0;
		    %>
		    
	        <jalios:buffer name='buffer'>
	            <ul>
			        <jalios:foreach name='itPub' collection='<%= itPubSet %>' type='Publication'>
                        <jalios:if predicate='<%=
                        	    Util.isEmpty(itPub.getExtraData("extra."+ dataType +".plugin.tools.geolocation.longitude")) || 
                        	    Util.isEmpty(itPub.getExtraData("extra."+ dataType +".plugin.tools.geolocation.latitude"))
		                   %>'>
                            <% cpt++; %>
                            <li><%= itPub %><jalios:edit pub="<%= itPub %>" /></li>
                        </jalios:if>
			        </jalios:foreach>
	            </ul>
	        </jalios:buffer>
	        
	        <p><%= cpt %> contenus trouvés sur un total de <%= itPubSet.size() %></p>
	        
	        <%= buffer %>
        
	    <%}catch(ClassNotFoundException e) { %>
	        <p>Le type "<%= dataType %>" n'a pas été trouvé. Merci de vérifier la syntaxe.</p>
	    <%} %> 
	      
	</jalios:foreach>
	
</jalios:if>



<%@ include file='/admin/doAdminFooter.jspf'%>
