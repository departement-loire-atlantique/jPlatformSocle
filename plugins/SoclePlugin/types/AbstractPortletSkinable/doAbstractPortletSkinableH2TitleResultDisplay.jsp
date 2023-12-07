<%@ include file='/jcore/doInitPage.jspf' %><%@ include file='/jcore/portal/doPortletParams.jspf' %>

<%-- SGU : inspiré de doDefaultSkin.jsp 
    Dérive de "AbstractportletSkinable" pour pouvoir utiliser le nouveau champ "footer" si besoin.
    TODO : voir si on maintient la possibilité de customiser la portlet via ses propriétés de styles.
--%>

<%
String id              = portletDomId;
String styleOutter     = PortalManager.getOutterStyles(portlet).trim();
String styleInner      = PortalManager.getInnerStyles(portlet).trim();
String classOutter     = PortalManager.getOutterClasses(portlet).trim();
String classInner      = PortalManager.getInnerClasses(portlet).trim();

AbstractPortletSkinable portletSkinable  = (AbstractPortletSkinable) portlet;
%><jalios:buffer name="buffer"><%@ include file='/jcore/portal/doIncludePortletTemplate.jspf' %></jalios:buffer><%

String styleOutterCustom = Util.getString(request.getAttribute("styleOutterCustom"), ""); 
String styleInnerCustom  = Util.getString(request.getAttribute("styleInnerCustom"), "");
String classOutterCustom = Util.getString(request.getAttribute("classOutterCustom"), "");
String classInnerCustom  = Util.getString(request.getAttribute("classInnerCustom"), "");

styleOutter = (styleOutter + " " + styleOutterCustom).trim();
styleInner = (styleInner + " " + styleInnerCustom).trim();

classOutter = (classOutter + " " + classOutterCustom).trim();
classInner = (classInner + " " + classInnerCustom).trim();

boolean showHeader = Util.notEmpty(portletSkinable.getDisplayTitle(userLang).trim());
boolean showFooter = Util.notEmpty(portletSkinable.getSkinFooter(userLang));
%>
<section id="<%= id %>" css='<%= "panel-default " + classOutter %>' style="<%= styleOutter %>">
  <% if (showHeader) { %>
    <header class="txtcenter">
        <h2 class="h2-like center"><%@ include file="../../../../types/AbstractPortletSkinable/doSkinTitle.jspf" %></h2>
        <jalios:if predicate="<%= Util.notEmpty(portlet.getAbstract(userLang)) %>">
            <p class="ds44-component-chapo ds44-centeredBlock">
                <%= HtmlUtil.html2text(portlet.getAbstract(userLang)) %>
            </p>
        </jalios:if>
    </header>
  <% } %>

  <div class="<%= classInner %>" style="<%= styleInner %>">
    <%= buffer %>
  </div>
  <% if (showFooter) { %>
     <%=portletSkinable.getSkinFooter(userLang)%>
  <% } %>  
</section>
<%
request.removeAttribute("styleOutterCustom");
request.removeAttribute("styleInnerCustom");
request.removeAttribute("classOutterCustom");
request.removeAttribute("classInnerCustom");
request.removeAttribute("defaultSkin.show-header"); 
request.removeAttribute("defaultSkin.info"); 
request.removeAttribute("defaultSkin.footer");   
%>