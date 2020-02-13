<%@page import="org.json.JSONArray"%>
<%@page import="fr.cg44.plugin.socle.infolocale.InfolocaleEntityUtils"%>
<%@page import="fr.cg44.plugin.socle.infolocale.RequestManager"%>
<%@page import="org.json.JSONObject"%>
<%@ include file='/jcore/doInitPage.jsp'%>

<%
if(!isAdmin) {
    sendForbidden(request, response);
    return;
}

response.setHeader("Content-Type", "application/json");
%>

<%@ include file='performFluxRequest.jspf' %>

<jalios:select>
    <jalios:if predicate='<%= extractedFlux.get("success").equals("false") %>'>
        <%= extractedFlux %>
    </jalios:if>
    <jalios:default>
        <%
        EvenementInfolocale[] allEvents = InfolocaleEntityUtils.createEvenementInfolocaleArrayFromJsonArray(extractedFlux.getJSONArray("result"));
        JSONArray sentData = new JSONArray();
        %>
        <jalios:foreach name="itEvent" type="EvenementInfolocale" array="<%= allEvents %>">
            <jalios:buffer name="itEventHtml">
                <jalios:include pub="<%= itEvent %>" usage="list"/>
            </jalios:buffer>
            <%
            JSONObject itEventJson = new JSONObject();
            itEventJson.put("evenement", new JSONObject(itEvent));
            itEventJson.put("html", itEventHtml);
            sentData.put(itEventJson);
            %>
        </jalios:foreach>
        <%= sentData %>
    </jalios:default>
</jalios:select>