<%@ page contentType="text/html; charset=UTF-8" %><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
%><%@ include file='/jcore/portal/doPortletParams.jspf' %><%
%><% PortletConteneurAgenda box = (PortletConteneurAgenda)portlet; %><%
%>

<%
String themeClair = "tuileVerticaleLight";
String titreBloc = box.getTitreDuBloc();
String sousTitreBloc = box.getSoustitreBloc();
%>

<section class='ds44-container-fluid <%= box.getSelectionDuTheme().equals(themeClair) ? " ds44-lightBG ds44-wave-white" : "" %> ds44--xxl-padding-tb'>
    <jalios:if predicate="<%= Util.notEmpty(titreBloc) || Util.notEmpty(sousTitreBloc) %>">
	    <div class="ds44-inner-container ds44--mobile--m-padding-b">
	        <header class="txtcenter <%=Util.isEmpty(sousTitreBloc) ? "ds44-mb2" : ""%>">
	            <h2 class="h2-like center"><%= titreBloc %></h2>
	            
	            <jalios:if predicate="<%= Util.notEmpty(sousTitreBloc) %>">
	                <div class="ds44-component-chapo ds44-centeredBlock" role="heading" aria-level="3">
	                    <jalios:wysiwyg><%= sousTitreBloc %></jalios:wysiwyg>
	                </div>
	            </jalios:if>
	        </header>
	    </div>
    </jalios:if>

    <jalios:foreach name="itPortlet" type="PortletAgendaInfolocale" array="<%= box.getPortletsAgenda() %>">
        <div class="ds44-mb-std">
            <jalios:include pub="<%= itPortlet %>" usage="box"/>
        </div>
    </jalios:foreach>
</section>