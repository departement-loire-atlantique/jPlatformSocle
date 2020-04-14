<%@page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file='/jcore/doInitPage.jspf' %>

<%
    String communeCode = request.getParameter("commune[value]");
    if (Util.notEmpty(communeCode)) {
      City selectedCommune = SocleUtils.getCommuneFromCode(communeCode);
      if (Util.notEmpty(selectedCommune) && Util.notEmpty(selectedCommune.getDelegation())) {
        sendRedirect(selectedCommune.getDelegation().getDisplayUrl(userLocale));
        return;
      } else {
        sendRedirect(channel.getData(channel.getProperty("channel.default-portal")).getDisplayUrl(userLocale));
        return;
      }
    } else {
      sendRedirect(channel.getData(channel.getProperty("channel.default-portal")).getDisplayUrl(userLocale));
      return;
    }
%>