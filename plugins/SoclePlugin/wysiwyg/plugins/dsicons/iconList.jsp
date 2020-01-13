<%@page import="com.jalios.jcms.tools.PackerUtils"%>
<%@ include file='/jcore/doInitPage.jspf' %><% 

jcmsContext.addCSSHeader("plugins/SoclePlugin/wysiwyg/plugins/dsicons/icon-picker.css");
jcmsContext.addJavaScript("plugins/SoclePlugin/wysiwyg/plugins/dsicons/icon-picker.js");

// On charge les CSS du DS pour pouvoir afficher les icônes
String[] cssUrlArray = channel.getStringArrayProperty("jcmsplugin.socle.css-urls", new String[] {});
List<String> cssUrlAList = Arrays.asList(cssUrlArray);
String packerVersion = Util.getString(PackerUtils.getPackVersion(), "");
for(String itURL:cssUrlAList){%>
    <link rel="stylesheet" href="<%=itURL%>?version=<%=packerVersion %>" media="all" />
<%}
%>

<%@ include file='/jcore/doEmptyHeader.jspf' %><%
String[] iconsArray = channel.getStringArrayProperty("jcmsplugin.socle.wysiwyg.icons", new String[]{});

%>
<div class="listeIcones">
<%
for(int i = 0; i < iconsArray.length; i++) {
        String codeIcone = "<i class='icon "+ iconsArray[i] + "' aria-hidden='true'>&nbsp;</i>";%>
        <a href="#" data-icon="<%=codeIcone%>"><%= codeIcone%></a>
<%}%> 	   
</div>

<%@ include file='/jcore/doEmptyFooter.jspf' %>