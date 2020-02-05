<%@ page contentType="text/html; charset=UTF-8" %><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
%><%@ include file='/jcore/portal/doPortletParams.jspf' %><%
%><% PortletRechercheFacettes obj = (PortletRechercheFacettes)portlet; %><% 
%><div class="PortletRechercheFacettes">

    <form id="facet-search" action="<%= channel.getPublication("c_1235791").getDisplayUrl(userLocale) %>" method="get">
 
    
    
        <jalios:foreach array="<%= obj.getOrdreDesFacettes() %>" name="itOrdre" type="String">


			<jalios:if predicate='<%= "commune".equalsIgnoreCase(itOrdre) %>'>
			   <jsp:include page="doFacetteCommune.jsp" />
			</jalios:if>
			
			<jalios:if predicate='<%= "adresse".equalsIgnoreCase(itOrdre) %>'>
               <jsp:include page="doFacetteAdresse.jsp" />
            </jalios:if>
            
            <jalios:if predicate='<%= Util.notEmpty(obj.getBrancheDeRecherche(loggedMember)) && itOrdre.contains("cat|") %>'>
                <%
                String[] confCat = itOrdre.split("\\|");
                String catOrderId = confCat[1];
                Category cat = channel.getCategory(catOrderId);
                %>
                
                <jalios:select>
                
                    <jalios:if predicate='<%= "mono".equalsIgnoreCase(cat.getExtraData("extra.Category.plugin.socle.facet.apparence")) %>'>
                         <jsp:include page="doFacetteMonoCat.jsp" />
                    </jalios:if>
                    
                    <jalios:default>
                         <jsp:include page="doFacetteMultiCat.jsp" />
                    </jalios:default>
                    
                </jalios:select>
            </jalios:if>
			
		</jalios:foreach>
		
		

		
		
		
		<button type="submit" name="search" value="opSearch">Rechercher</button>
    
    </form>




</div>