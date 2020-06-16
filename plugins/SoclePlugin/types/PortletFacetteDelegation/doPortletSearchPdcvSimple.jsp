<%@ include file='/jcore/doInitPage.jspf' %>
<%@ include file='/jcore/portal/doPortletParams.jspf' %>
<%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%>

<% 
request.setAttribute("isSimpleGabarit", true);
%>

<jalios:include jsp="plugins/SoclePlugin/types/PortletFacetteDelegation/doPortletSearchPdcv.jsp" />