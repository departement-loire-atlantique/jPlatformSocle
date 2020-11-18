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

<main role="main" id="content" class="ds44-mainResults" tabindex="-1">

<jalios:include target="SOCLE_ALERTE"/>

<section class="ds44-container-large">
    <jalios:include id='<%= request.getParameter("boxId" + glp("jcmsplugin.socle.facette.form-element") + "[value]") %>' />
 </section>      
</main>


  

