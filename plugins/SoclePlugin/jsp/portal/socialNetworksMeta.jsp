<%@page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@ include file='/jcore/doInitPage.jspf' %> 
<%
Publication pub = (Publication)request.getAttribute(PortalManager.PORTAL_PUBLICATION);

if(Util.notEmpty(pub) && Util.notEmpty(SocleUtils.getImageForSocialNetworks(pub))){
  request.setAttribute("metaimage", channel.getUrl() + SocleUtils.getImageForSocialNetworks(pub));
}
  
%>
