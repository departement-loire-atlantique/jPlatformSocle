<%@page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@ include file='/jcore/doInitPage.jspf' %> 
<%
Publication pub = (Publication)request.getAttribute(PortalManager.PORTAL_PUBLICATION);

if(Util.isEmpty(pub)){
    session.removeAttribute("isSearchFacetLink");
}
  
%>
