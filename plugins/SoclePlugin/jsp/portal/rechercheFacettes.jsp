<%@ include file='/jcore/doInitPage.jspf' %><%
%><%@ include file='/jcore/portal/doPortletParams.jspf'  %><% 
  PortalJspCollection box = (PortalJspCollection) portlet;
  ServletUtil.backupAttribute(pageContext , "ShowChildPortalElement");
  
%>
<%@ include file='/types/AbstractCollection/doIncludePortletCollection.jspf'%>

<%
  ServletUtil.restoreAttribute(pageContext , "ShowChildPortalElement");
%>

<%= getPortlet(bufferMap,"header") %>

<main role="main" id="content" class="ds44-mainResults">

<section class="ds44-container-large">
    <jalios:include id='<%= request.getParameter("boxId[value]") %>' />
 </section>      
</main>


  

