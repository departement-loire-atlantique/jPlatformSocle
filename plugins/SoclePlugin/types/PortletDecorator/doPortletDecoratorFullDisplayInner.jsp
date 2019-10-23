
<%@ include file='/jcore/doInitPage.jspf' %>
<%@ include file='/jcore/portal/doPortletParams.jspf' %>
<% 
	PortletDecorator box = (PortletDecorator) portlet;  
	ServletUtil.backupAttribute(pageContext , "ShowChildPortalElement");
	
%>

<div class="ds44-inner-container">
    <header class="txtcenter">
       <jalios:if predicate='<%= Util.notEmpty(box.getDisplayTitle(userLang)) %>'>
               <h2 class="h2-like center"><%=box.getDisplayTitle(userLang)%></h2>
           </jalios:if>
           <jalios:if predicate='<%= Util.notEmpty(box.getSkinFooter(userLang)) %>'>
               <p class="ds44-component-chapo ds44-m3c"><%=XmlUtil.extractText(box.getSkinFooter(userLang))%></p>
           </jalios:if>
    </header>
    
	<jalios:if predicate='<%= box.getChild() != null %>'>
	    <% displayPortlet = box.getChild(); request.setAttribute("ShowChildPortalElement",Boolean.TRUE); %>
	    <jalios:buffer name='collectionBuffer'><%@ include file='/jcore/portal/doIncludePortlet.jspf' %></jalios:buffer>
	    <jalios:if predicate='<%= ((Boolean)request.getAttribute("ShowChildPortalElement")).booleanValue() %>'>
	        <%= collectionBuffer %>
	    </jalios:if>
	</jalios:if>
    
</div>


<% ServletUtil.restoreAttribute(pageContext , "ShowChildPortalElement"); %>
