<%@page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file='/jcore/doInitPage.jspf' %>

<%
    String communeCode = request.getParameter("commune[value]");
    if (Util.notEmpty(communeCode)) {
      City selectedCommune = SocleUtils.getCommuneFromCode(communeCode);
      if (Util.notEmpty(selectedCommune) && Util.notEmpty(selectedCommune.getDelegation()) && Util.notEmpty(selectedCommune.getDelegation().getLinkIndexedDataSet(AccueilDelegation.class))) {
        AccueilDelegation pageDeleg = selectedCommune.getDelegation().getLinkIndexedDataSet(AccueilDelegation.class).first();
        sendRedirect(pageDeleg.getDisplayUrl(userLocale));
        return;
    }

	sendRedirect(channel.getData(channel.getProperty("channel.default-index")).getDisplayUrl(userLocale));
	return;
%>