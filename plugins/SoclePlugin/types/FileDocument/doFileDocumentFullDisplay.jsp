<%@page import="com.jalios.io.IOUtil"%><%
%><%@ page import="com.jalios.jcms.webdav.cat.CatWebdavUtil" %><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
  FileDocument doc = (FileDocument)request.getAttribute(PortalManager.PORTAL_PUBLICATION);
  String jsp = ServletUtil.getJsp(request);
  if (jcmsContext.isInFrontOffice()) {
    sendRedirect(doc.getFilename(), request, response);
    return;
  }
  boolean printView = (request.getAttribute("printView") != null) || (hasParameter("printView"));
  
  boolean opengraphEnabled = channel.getBooleanProperty(PortalManager.SEO_OPENGRAPH_ENABLED_PROP, true);
  if (opengraphEnabled) {
    if (doc.isVideo()) {
      jcmsContext.addCustomHeader("<meta property=\"og:video\" content=\""+ channel.getUrl() + doc.getFilename() + "\" />");
      jcmsContext.addCustomHeader("<meta property=\"og:video:type\" content=\""+ doc.getContentType() + "\" />");
    }
    if (doc.isAudio()) {
      jcmsContext.addCustomHeader("<meta property=\"og:audio\" content=\""+ channel.getUrl() + doc.getFilename() + "\" />");
      jcmsContext.addCustomHeader("<meta property=\"og:audio:type\" content=\""+ doc.getContentType() + "\" />");
    }
    if (doc.isImage()) {
      jcmsContext.addCustomHeader("<meta property=\"og:image\" content=\""+ channel.getUrl() + doc.getFilename() + "\" />");
      jcmsContext.addCustomHeader("<meta property=\"og:image:type\" content=\""+ doc.getContentType() + "\" />");
      jcmsContext.addCustomHeader("<meta property=\"og:image:width\" content=\""+ doc.getWidth() + "\" />");
      jcmsContext.addCustomHeader("<meta property=\"og:image:height\" content=\""+ doc.getHeight() + "\" />");
    }  
  }
%>
<%@ include file='/jcore/doMessageBox.jspf' %>
<%@ include file='/front/doFullDisplay.jspf' %>
<div class="fullDisplay FileDocument" itemscope="itemscope">
  <%@ include file='/front/publication/doPublicationHeader.jspf' %>  
  <%-- TARGET --%>
  <jalios:include target="FILEDOCUMENT_FULLDISPLAY_HEADER" />
  
  <div class="publication-body">
    <%-- DESCRIPTION --%>
    <% if (Util.notEmpty(doc.getDescription(userLang))) { %>
    <div class="description">
      <jalios:wiki data="<%= doc %>" field="description"><%= doc.getDescription(userLang) %></jalios:wiki>
    </div>
    <% } %>
    
    <%-- MAIN ACTIONS --%>
    <div class="main-actions br hidden-print">
    
      <%-- Download --%>
      <% 
      String ariaLabel = encodeForHTMLAttribute(doc.getTitle(userLang)) + " - " + encodeForHTMLAttribute(doc.getTypeInfo(userLang));
      if (!doc.isRemote()) {
        ariaLabel += " - " + encodeForHTMLAttribute(Util.formatFileSize(doc.getSize()));
      }
      %>
      <a class="btn btn-success" href="<%= doc.getDownloadUrl() %>" download="<%= encodeForHTMLAttribute(doc.getDownloadName(userLang)) %>" aria-label='<%= ariaLabel %>'><jalios:icon src="download-btn" /> <%= glp("ui.com.btn.download") %></a>
    
      <%-- Reupload --%>
      <% if (isLogged && doc.canBeUploadedBy(loggedMember)) { %>
        <% String docChooserRedirect = ServletUtil.encodeURL(ServletUtil.getBaseUrl(request) + doc.getDisplayUrl(userLocale) + "?details=true"); %>
        <a class="btn btn-default" href="work/docChooser.jsp?id=<%= doc.getId() %>&amp;nbElt=1&amp;redirect=<%= docChooserRedirect %>" onclick="popupWindow(this.href, 'DocChooser_<%= doc.getId() %>', <%= JcmsConstants.DOCCHOOSER_WIDTH %>, <%= JcmsConstants.DOCCHOOSER_HEIGHT %>); return false;"><%= glp("ui.filedocument.lbl.update") %></a>
      <% } %>

      <%-- Edit With... --%>
      <%@ include file="/jcore/document/editDocumentWith.jspf" %>

      <jalios:include target="FILEDOCUMENT_MAIN_ACTIONS" targetContext="" />
    </div>
    
    <%-- TARGET --%>
    <jalios:include target="FILEDOCUMENT_FULLDISPLAY" targetContext="div" />
    
    <%-- PREVIEW --%> 
    <% if (Util.toBoolean(request.getAttribute("fileDocumentPreview"),true)){ %>
    <div class="preview">
     <% if (doc.isRemote() && doc.previewRemoteWithIFrame()) { %>
     <iframe src="<%= doc.getRemotePreviewUrl() %>" class="remote-document-preview"/>
     <% } else { %>
     <jalios:media fileDoc="<%= doc %>"/>
     <% } %>
    </div>
    <% } %>      
  </div>  
</div>