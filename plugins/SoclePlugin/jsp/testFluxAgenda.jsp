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

<%

String infoLocaleLogin = "";
String infoLocalePwd = "";

String jetonAcces ="";
String jetonRefresh ="";

HttpPost post;
HttpGet get;

String input;
String output;

BufferedReader br;

List<BasicNameValuePair> urlParameters;

CloseableHttpClient httpClient;
CloseableHttpResponse httpResponse;

JSONObject jsonObject;

%>

<h1>Liste de tests de flux</h1>

<h2>Requête de connexion</h2>
<p>Méthode POST-> https://api.infolocale.fr/auth/signin</p>

<%

post = new HttpPost("https://api.infolocale.fr/auth/signin");
urlParameters = new ArrayList<>();
urlParameters.add(new BasicNameValuePair("login", infoLocaleLogin));
urlParameters.add(new BasicNameValuePair("password", infoLocalePwd));

post.setEntity(new UrlEncodedFormEntity(urlParameters));

httpClient = HttpClients.createDefault();
httpResponse =httpClient.execute(post);

jsonObject = new JSONObject(EntityUtils.toString(httpResponse.getEntity()));
%>

<%= jsonObject.toString(2) %>

<jalios:if predicate="<%= jsonObject.get(key) %>"
