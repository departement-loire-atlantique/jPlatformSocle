<%@page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file='/jcore/doInitPage.jspf' %>

<%
    String communeName = request.getParameter("commune");
    if (Util.notEmpty(communeName)) {
      City selectedCommune = SocleUtils.getCommuneFromName(communeName);
      if (Util.notEmpty(selectedCommune) && Util.notEmpty(selectedCommune.getDelegation())) {
        logger.info("1");
        sendRedirect(selectedCommune.getDelegation().getDisplayUrl(userLocale));
        return;
      } else {
        logger.info("2");
        sendRedirect(channel.getData(channel.getProperty("channel.default-portal")).getDisplayUrl(userLocale));
        return;
      }
    }
%>