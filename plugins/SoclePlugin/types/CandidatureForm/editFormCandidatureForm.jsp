<%@ page contentType="text/html; charset=UTF-8" %><%
%><%@ include file='/jcore/doInitPage.jspf' %>
<% String[] formTitles = JcmsUtil.getLanguageArray(channel.getTypeEntry(CandidatureForm.class).getLabelMap()); %>
<jsp:useBean id='formHandler' scope='page' class='generated.EditCandidatureFormHandler'>
  <jsp:setProperty name='formHandler' property='request' value='<%= request %>'/>
  <jsp:setProperty name='formHandler' property='response' value='<%= response %>'/>
  <jsp:setProperty name='formHandler' property='*' />
  <jsp:setProperty name='formHandler' property='author' value='j_2'/>
  <jsp:setProperty name='formHandler' property='title' value='<%= formTitles %>'/>
</jsp:useBean>
<%
  if (formHandler.validate()) {
    return;
  }
%>

<jalios:if predicate='<%= formHandler.isOneSubmit() && formHandler.isSubmitted() %>'>
  <% setWarningMsg(glp("msg.edit.already-one-submit"), request); %>
</jalios:if>

<%@ include file='/plugins/SoclePlugin/jsp/doMessageBoxCustom.jspf' %>

<% request.setAttribute("titreFormulaire", glp("jcmsplugin.socle.form.candidature.titre")); %>
<%@ include file='/plugins/SoclePlugin/jsp/forms/doFormHeader.jspf' %>


<%-- -- FORM -------------------------------------------- --%>
<jalios:query name='__memberSet' dataset='<%= channel.getDataSet(Member.class) %>' comparator='<%= Member.getNameComparator() %>'/>
<% request.setAttribute("formMemberSet", __memberSet); %>
<jalios:query name='__groupSet' dataset='<%= channel.getDataSet(Group.class) %>' comparator='<%= Group.getNameComparator() %>'/>
<% request.setAttribute("formGroupSet", __groupSet); %>

<%
Publication currentPub = (Publication) request.getAttribute(PortalManager.PORTAL_PUBLICATION);
String formAction = "plugins/SoclePlugin/jsp/forms/doFormDecodeParams.jsp";
%>
<form action='<%= formAction %>' method='post' name='editForm' accept-charset="UTF-8"  enctype="multipart/form-data">
    
    <%
    request.setAttribute("formHandler", formHandler);
    %>

    <jsp:include page="doEditCandidatureForm.jsp" />
    
    <input type='hidden' name='redirect' value='<%= currentPub.getDisplayUrl(userLocale) %>' data-technical-field />
    <input type='hidden' name='ws' value='<%= formHandler.getWorkspace().getId() %>' data-technical-field />
    <input type='hidden' name='opCreate' value='<%= glp("ui.com.btn.submit") %>' data-technical-field />
    <input type="hidden" name="csrftoken" value="<%= HttpUtil.getCSRFToken(request) %>" data-technical-field>
    <input type="hidden" name="noSendRedirect" value='true' data-technical-field />
    <input type="hidden" name="id" value='<%= request.getParameter("id") %>' data-technical-field />

</form>

<% request.setAttribute("idPortletBas", channel.getProperty("jcmsplugin.socle.form.candidature.portlet-rgpd.id")); %>

<%@ include file='/plugins/SoclePlugin/jsp/forms/doFormFooter.jspf' %>

