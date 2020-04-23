<%@page import="com.jalios.jcms.tools.PackerUtils"%><%
%><%@ page contentType="text/html; charset=UTF-8"%><%
%><%@ include file='/jcore/doInitPage.jsp'%>

<%-- Ajoute en front office, les JS déclarés dans les propriétés éditables du module Charte --%>

<%
String[] jsUrlArray = channel.getStringArrayProperty("jcmsplugin.socle.js-urls", new String[] {});
List<String> jsUrlAList = Arrays.asList(jsUrlArray);

String packerVersion = Util.getString(PackerUtils.getPackVersion(), "");

if(jcmsContext.isInFrontOffice() || "true".equals(request.getAttribute("pageErreur"))){

    for(String itURL:jsUrlAList){%>
        <script src="<%=itURL%>?version=<%=packerVersion %>"></script>
    <%}
}
%>