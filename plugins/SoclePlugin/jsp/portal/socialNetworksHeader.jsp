<%@ include file="socialNetworksCommon.jspf" %> 

<p class="h4-like mbm ds44-hide-mobile"><%=glp("jcmsplugin.socle.social-networks-follow.label") %></p>
<ul class="ds44-list ds44-flex-container ds44-fse">
<%for(int i=0; i<socialNetworksLabelsList.size(); i++){%>
    <li><a href="<%=socialNetworksUrlsList.get(i)%>" target="_blank" class="ds44-rsHeadLink" title='<%=socialNetworksLabelsList.get(i)%> <%=glp("jcmsplugin.socle.accessibily.newTabLabel")%>'><i class="icon icon-<%=socialNetworksLabelsList.get(i).toLowerCase().replaceAll("\\s","")%>"><span class="visually-hidden"><%= socialNetworksLabelsList.get(i)%></span></i></a></li>
<%}%>    
</ul>
