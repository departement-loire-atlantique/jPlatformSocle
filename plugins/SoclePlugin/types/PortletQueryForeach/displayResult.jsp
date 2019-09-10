<%@page import="org.apache.lucene.index.DirectoryReader"%>
<%@page import="org.apache.lucene.search.IndexSearcher"%>
<%
  // For Improvement JCMS-3078, set FrontOffice status to true
  request.setAttribute("inFO", Boolean.TRUE);

%><%@ include file='/jcore/doInitPage.jspf' %>



<%
//jcmsContext.addJavaScript("https://api.tiles.mapbox.com/mapbox-gl-js/v0.49.0/mapbox-gl.js");


 String hautGaucheLat = request.getParameter("northWestLat");
 String hautGaucheLng = request.getParameter("northWestLng");
 
 String basDroiteLat = request.getParameter("southEastLat");
 String basDroiteLng = request.getParameter("southEastLng");

 
 String query = request.getParameter("query");
 String textSeach = "localisation:1,hautGaucheLat:"+ hautGaucheLat +",hautGaucheLng:"+ hautGaucheLng + ",basDroiteLat:"+ basDroiteLat + ",basDroiteLng:"+ basDroiteLng;
 query += "&text=" + textSeach;
 
 
 String panierId =  request.getParameter("cartId");
 Set<String> panier = Util.notEmpty(session.getAttribute(panierId)) ? (Set<String>) session.getAttribute(panierId) : new HashSet<String>();
 
%>



<jalios:query  name="collection" queryString="<%= query %>" />




<div>


	<ul id="result-list">
<%--         <jalios:if predicate="<%= collection.size() > 20 %>"> --%>
<!--             Seuls les 20 premiers résultats sont affichés -->
<%--         </jalios:if> --%>
        	
		<jalios:foreach collection="<%= collection %>" name="itPub" type="Publication">
		      <% 
		      String itClassName = itPub.getClass().getSimpleName(); 
		      String itLat = itPub.getExtraData("extra."+ itClassName +".plugin.tools.geolocation.latitude");
		      String itLng = itPub.getExtraData("extra."+ itClassName +".plugin.tools.geolocation.longitude");
		      boolean inCart = panier.contains(itPub.getId());
		      %>
			
			  
			  
		      <li data-id="<%= itPub.getId()%>" data-lat="<%= itLat %>" data-lng="<%= itLng %>" >
                   <%= itPub.getTitle() %> 
                   <a href="#" class="panier" data-id="<%= itPub.getId() %>"><%= inCart ? "Retirer du panier" : "Ajouter au panier" %></a> 
                   <jalios:include pub="<%= itPub %>" usage="liste" />
              </li>			
					      
		</jalios:foreach>
		
	</ul>

</div>
