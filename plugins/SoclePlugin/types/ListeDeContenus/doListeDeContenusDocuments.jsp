<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file='/jcore/doInitPage.jspf' %>
<%
ListeDeContenus obj = (ListeDeContenus)request.getAttribute(PortalManager.PORTAL_PUBLICATION); 
String styleFond="";

if (Util.notEmpty(obj.getStyleDeFond()) && !obj.getStyleDeFond().equals("none")) {
	styleFond = obj.getStyleDeFond();
}
%>

<jalios:if predicate="<%=Util.notEmpty(obj.getContenus())%>">
	<section class="ds44-box mtm <%=styleFond%>">
	  <div class="ds44-innerBoxContainer">
	    <jalios:if predicate="<%=Util.notEmpty(obj.getLibelleTitre(userLang)) %>">
	        <p role="heading" aria-level="2" class="ds44-box-heading"><%=obj.getLibelleTitre(userLang) %></p>
	    </jalios:if>
		<ul class="ds44-list">
		       <jalios:foreach name="itData" type="com.jalios.jcms.Content" array="<%= obj.getContenus() %>">
		           <jalios:if predicate="<%=itData != null && itData instanceof FileDocument && itData.canBeReadBy(loggedMember)%>">
		               <% 
		               FileDocument itDoc = (FileDocument)itData;
		                String title = HttpUtil.encodeForHTMLAttribute(itDoc.getTitle());
		                String fileType = FileDocument.getExtension(itDoc.getFilename()).toUpperCase();
		                String fileSize = Util.formatFileSize(itDoc.getSize(), userLocale,false);
		              %>
		                <li class="mts">
		                    <p class="ds44-docListElem"><i class="icon icon-file ds44-docListIco" aria-hidden="true"></i>
		                        <a href="<%=itDoc.getDownloadUrl()%>" title='<%=title%> - <%=fileType%> - <%= fileSize%> <%=glp("jcmsplugin.socle.accessibily.newTabLabel")%>' target="_blank"><%=title%></a>
		                        <span class="ds44-cardFile"><%=fileType%> - <%=fileSize%></span>
		                    </p>
		                </li>
		            </jalios:if>
		       </jalios:foreach>
		    </ul>
	  </div>
	</section>
</jalios:if>