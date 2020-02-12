<%@page import="fr.cg44.plugin.socle.infolocale.InfolocaleEntityUtils"%>
<%@page import="fr.cg44.plugin.socle.infolocale.singleton.TokenManager"%>
<%@page import="fr.cg44.plugin.socle.infolocale.RequestManager"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.apache.http.client.methods.HttpGet"%>
<%@page import="org.apache.http.util.EntityUtils"%>
<%@page import="org.apache.http.impl.client.CloseableHttpClient"%>
<%@page import="org.apache.http.impl.client.HttpClients"%>
<%@page import="org.apache.http.client.methods.CloseableHttpResponse"%>
<%@page import="org.apache.http.client.entity.UrlEncodedFormEntity"%>
<%@page import="org.apache.http.message.BasicNameValuePair"%>
<%@page import="org.apache.commons.httpclient.NameValuePair"%>
<%@page import="org.apache.http.client.methods.HttpPost"%>
<%@ page contentType="text/html; charset=UTF-8"%><%
%><%@ include file='/jcore/doInitPage.jsp'%>

<h1>Liste de tests de flux</h1>

<h2>Requête de connexion</h2>
<p>Méthode POST-> https://api.infolocale.fr/auth/signin</p>

<%
RequestManager.initTokens();
%>

<p>Token d'accès : <%= TokenManager.getInstance().getAccessToken() %></p>
<p>Token de rafraîchissement : <%= TokenManager.getInstance().getRefreshToken() %></p>
<p>Username : <%= TokenManager.getInstance().getUsername() %></p>

<h2>Requête de rafraîchissement</h2>
<p>Méthode POST-> https://api.infolocale.fr/auth/refresh-token</p>

<%
RequestManager.regenerateTokens();
%>

<p>Token d'accès : <%= TokenManager.getInstance().getAccessToken() %></p>
<p>Token de rafraîchissement : <%= TokenManager.getInstance().getRefreshToken() %></p>
<p>Username : <%= TokenManager.getInstance().getUsername() %></p>

<h2>Requête de flux</h2>
<p>Méthode POST-> https://api.infolocale.fr/flux/f24ba875-a641-47aa-b1b5-01c23a1b6812/data</p>

<%
JSONObject extractedFlux = RequestManager.extractFluxData("f24ba875-a641-47aa-b1b5-01c23a1b6812");
%>

<%= Util.notEmpty(extractedFlux) %>

<p>Transformation des résultats en événements</p>

<%
EvenementInfolocale[] evenements = InfolocaleEntityUtils.createEvenementInfolocaleArrayFromJsonArray(extractedFlux.getJSONArray("result"));
%>
<jalios:foreach name="itEvent" type="EvenementInfolocale" array="<%= evenements %>">
    <%= itEvent %><br/>
</jalios:foreach>

<h2>Requête de flux avec filtre</h2>
<p>Méthode POST -> https://api.infolocale.fr/flux/f24ba875-a641-47aa-b1b5-01c23a1b6812/data</p>

<%
Map<String, Object> parameters = new HashMap<String, Object>();
parameters.put("page", 2);

extractedFlux = RequestManager.filterFluxData("f24ba875-a641-47aa-b1b5-01c23a1b6812", parameters);
%>

<%= extractedFlux %>

<p>Transformation des résultats en événements</p>

<%
evenements = InfolocaleEntityUtils.createEvenementInfolocaleArrayFromJsonArray(extractedFlux.getJSONArray("result"));
%>
<jalios:foreach name="itEvent" type="EvenementInfolocale" array="<%= evenements %>">
    <%= itEvent %><br/>
</jalios:foreach>
