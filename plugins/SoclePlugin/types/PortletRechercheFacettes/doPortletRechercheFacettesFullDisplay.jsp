<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file='/jcore/doInitPage.jspf'%>
<%@ include file='/jcore/portal/doPortletParams.jspf'%>
<% 
	PortletRechercheFacettes obj = (PortletRechercheFacettes)portlet;
%>

<div class="PortletRechercheFacettes">

	<%
		request.setAttribute("Queries", new ArrayList<String>());
	%>

	<form id="facet-search" action="<%= true %>" method="get">

		<%
			int weight = 0;
			
			for(AbstractPortletFacette itFacette : obj.getFacettesPrincipales()) {
				
				if(itFacette instanceof PortletFacetteCategoriesLiees 
						|| itFacette instanceof PortletFacetteCommuneAdresseLiee
						|| (itFacette instanceof PortletFacetteAdresse
								&& Util.notEmpty(itFacette.getRayon(loggedMember)))
						|| (itFacette instanceof PortletFacetteCommune
								&& Util.notEmpty(itFacette.getRayon(loggedMember))) {
					
					weight += 2;
					
				} else {
					
					weight ++;
				}
				
				if(weight > 4) break;
				
				%>
				<jalios:include pub="<%= itFacette %>" usage="facette"/>
				<%
				
			}
			
		%>

		<button type="submit" name="search" value="opSearch">Rechercher</button>

		<jalios:if predicate="<%= Util.notEmpty(obj.getFacettesSecondaires()) %>">
			<jalios:foreach array="<%= obj.getFacettesSecondaires() %>" name="itFacette" type="AbstractPortletFacette">

				<jalios:include pub="<%= itFacette %>" usage="facette"/>

			</jalios:foreach>
		</jalios:if>

	</form>

</div>