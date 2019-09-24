<%@page import="com.jalios.jcms.tools.PackerUtils"%><%
%><%@ page contentType="text/html; charset=UTF-8"%><%
%><%@ include file='/jcore/doInitPage.jsp'%>

<%-- Ajoute en front office, les CSS déclarées dans les propriétés éditables du module Charte --%>

<%
String[] cssUrlArray = channel.getStringArrayProperty("jcmsplugin.socle.css-urls", new String[] {});
List<String> cssUrlAList = Arrays.asList(cssUrlArray);

String packerVersion = Util.getString(PackerUtils.getPackVersion(), "");

if(jcmsContext.isInFrontOffice()){
    for(String itURL:cssUrlAList){%>
    	<link rel="stylesheet" href="<%=itURL%>?version=<%=packerVersion %>" media="all" />
    <%}
}
%>