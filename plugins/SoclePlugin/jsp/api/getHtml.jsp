<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="com.jalios.jcms.wysiwyg.WysiwygRenderer"%>
<%@include file='/jcore/doInitPage.jsp'%>

<%-- Récupération du contenu HTML d'une portlet Wysiwyg.
     Utilisé sur le site ASD pour mettre à jour la page d'accueil avec du contenu jPlatform
     Fonctionne uniquement avec droits d'admin (via authKey)
--%>

<%
if(null == loggedMember){
  response.setStatus(HttpServletResponse.SC_FORBIDDEN);
  return;
}
if(!loggedMember.isAdmin()){
  response.setStatus(HttpServletResponse.SC_FORBIDDEN);
  return;
}

if(Util.isEmpty(request.getParameter("id"))){
  response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
}

PortletWYSIWYG portlet = (PortletWYSIWYG)channel.getPublication(request.getParameter("id"));
	
if(Util.notEmpty(portlet)){
  String htmlContent = portlet.getWysiwyg();
  String wysiwyg = WysiwygRenderer.processWysiwyg(htmlContent, userLocale);
  wysiwyg = WysiwygRenderer.processWysiwygBaseUrl(wysiwyg, userLocale);
    
  response.setContentType("text/html");
  out.print(JcmsUtil.convertUri2Url(wysiwyg, channel.getUrl()));
}
else {
  response.setStatus(HttpServletResponse.SC_NOT_FOUND);
}
%>