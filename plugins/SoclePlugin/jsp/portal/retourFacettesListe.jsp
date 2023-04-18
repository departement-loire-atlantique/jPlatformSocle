<%@page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@ include file='/jcore/doInitPage.jspf' %> 
<%@ include file='/jcore/portal/doPortletParams.jspf'%>
<%
Publication pub = (Publication)request.getAttribute(PortalManager.PORTAL_PUBLICATION);




if(Util.isEmpty(pub) && !JcmsUtil.isSameId(currentCategory, channel.getCategory("$id.jcmsplugin.socle.selection.page.cat"))){
    session.removeAttribute("isSearchFacetLink");
}
  
%>
