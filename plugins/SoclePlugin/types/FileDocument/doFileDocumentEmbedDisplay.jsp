<%@ page contentType="text/html; charset=UTF-8" %><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
%><% 
FileDocument obj = (FileDocument)request.getAttribute(PortalManager.PORTAL_PUBLICATION);
String title = HttpUtil.encodeForHTMLAttribute(obj.getTitle());
String fileType = FileDocument.getExtension(obj.getFilename()).toUpperCase();
String fileSize = Util.formatFileSize(obj.getSize());
%>

	<div class="ds44-docListElem"><i class="icon icon-file ds44-docListIco" aria-hidden="true"></i>
	    <a href="<%=obj.getDownloadUrl()%>" title='<%=title%> - <%=fileType%> - <%= fileSize%> <%=glp("jcmsplugin.socle.accessibily.newTabLabel")%>' target="_blank"><%=title%></a>
	    <span class="ds44-cardFile"><%=fileType%> - <%=fileSize%></span>
	</div>
