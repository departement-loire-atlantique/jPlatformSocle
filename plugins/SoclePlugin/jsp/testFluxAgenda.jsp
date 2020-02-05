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

<%= extractedFlux.toString() %>

<%--

Au démarrage :
    Initialiser un singleton qui gérera les tokens
    Effectuer l'authentification pour générer les deux tokens
    
Régulièrement après le démarrage :
    Effectuer le rafraîchissement du token sur le singleton

En cas de requête :
    Appeler un gestionnaire de requête qui aura la liste des requêtes
    Chaque méthode rendra son propre résultat
    Utiliser les tokens du singleton
    -> en cas de 401, faire remonter l'erreur

En back-office :
    Créer une page admin qui forcera la regénération des tokens sur un bouton

--%>