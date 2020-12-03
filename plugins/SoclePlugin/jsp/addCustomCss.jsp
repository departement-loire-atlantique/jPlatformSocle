<%@page import="com.jalios.jcms.tools.PackerUtils"%>
<%@page import="fr.cg44.plugin.socle.SocleConstants"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file='/jcore/doInitPage.jsp'%>

<%--    Ajoute en front office, les CSS déclarées dans les propriétés éditables du module Charte
        Ajoute également un style pour les contributeurs pour visualiser le bandeau malgré la Topbar
--%>

<%
String[] cssUrlArray = channel.getStringArrayProperty("jcmsplugin.socle.css-urls", new String[] {});
List<String> cssUrlAList = Arrays.asList(cssUrlArray);

String packerVersion = Util.getString(PackerUtils.getPackVersion(), "");

if(jcmsContext.isInFrontOffice() ){
    for(String itURL:cssUrlAList){%>
    	<link rel="stylesheet" href="<%=itURL%>?version=<%=packerVersion %>" media="all" />
    <%}
    if(isLogged && loggedMember.belongsToGroup(channel.getGroup(SocleConstants.VISIBLE_TOPBAR_GROUP_PROP))){%>
    <style>
       .ds44-header{top:64px!important;}
       .PortalMode .ds44-header{top:113px!important;}
       .member-profile{margin-top:100px!important;}
    </style>
    <%}
}
%>