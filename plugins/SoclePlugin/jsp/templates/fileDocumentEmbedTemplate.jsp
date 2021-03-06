<%@ page contentType="text/html; charset=UTF-8" %><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
%><%@ include file='/jcore/media/mediaTemplateInit.jspf' %><%
%><%

if (data == null) {
  return;
}
FileDocument obj = (FileDocument) data;

String title = HttpUtil.encodeForHTMLAttribute(obj.getTitle());
String fileType = FileDocument.getExtension(obj.getFilename()).toUpperCase();
String fileSize = Util.formatFileSize(obj.getSize());
String fileUrl = ServletUtil.getBaseUrl(request) + obj.getDownloadUrl(); 
%>

	<p class="ds44-docListElem"><i class="icon icon-file ds44-docListIco" aria-hidden="true"></i>
	    <a href="<%=obj.getDownloadUrl()%>" title='<%=title%> - <%=fileType%> - <%= fileSize%> <%=glp("jcmsplugin.socle.accessibily.newTabLabel")%>' target="_blank"
	       data-statistic='{"name": "declenche-evenement","category": "Téléchargement","action": "<%= fileUrl %>"}'><%=title%></a>
	    <span class="ds44-cardFile"><%=fileType%> - <%=fileSize%></span>
	</p>
