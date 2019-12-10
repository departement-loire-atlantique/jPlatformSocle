<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file='/jcore/doInitPage.jsp'%>
<%
String[] socialNetworksLabels = channel.getStringArrayProperty("jcmsplugin.socle.socialnetworks.labels", new String[]{});
List<String> socialNetworksLabelsList = Arrays.asList(socialNetworksLabels);

String[] socialNetworksUrls = channel.getStringArrayProperty("jcmsplugin.socle.socialnetworks.urls", new String[]{});
List<String> socialNetworksUrlsList = Arrays.asList(socialNetworksUrls);

if(socialNetworksLabelsList.size()!=socialNetworksUrlsList.size()){
	logger.warn("Erreur de configuration des réseaux sociaux. Vérifier le nombre de labels et d'URLs dans plugin.prop;");
	return;
}
%>
<h2 class="h4-like mbm"><%=glp("jcmsplugin.socle.social-networks-follow.label") %></h2>
<ul class="ds44-list ds44-flex-container ds44-flex-align-center ds44-fse">
<%
for(int i=0; i<socialNetworksLabelsList.size(); i++){%>
    <li><a href="<%=socialNetworksUrlsList.get(i)%>" target="blank" class="ds44-rsFootLink" title="<%=socialNetworksLabelsList.get(i)%>"><i class="icon icon-<%=socialNetworksLabelsList.get(i).toLowerCase().replaceAll("\\s","")%>"><span class="visually-hidden"><%= socialNetworksLabelsList.get(i)%></span></i></a></li>
<%}
%>
</ul>