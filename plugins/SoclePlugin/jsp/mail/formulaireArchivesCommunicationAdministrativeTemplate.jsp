<%@ include file='/jcore/doInitPage.jspf' %>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title><%= glp("jcmsplugin.archives.email.communication.titre") %></title>
  
  <jsp:include page="stylesEmail.jsp" />

</head>

<body>
  <style media="all" type="text/css">
    td {
      font-family: Arial, Verdana, Geneva, sans-serif;
      font-size: 16px;
    }
  </style>
  <!-- Wrapper/Container Table: Use a wrapper table to control the width and the background color consistently of your email. Use this approach instead of setting attributes on the body tag. -->
  <table id="backgroundTable" style="font-size: 16px; background-color: #FFFFFF; margin: 0 auto; line-height:150%;width:800px;max-width:800px;min-width:320px;font-family:Arial, Verdana, Geneva, sans-serif;color:#000000;" width="100%" cellspacing="0" cellpadding="0">
    <tbody>
      <tr>
        <td class="vTop">
          <!-- Tables are the most common way to format your email consistently. Set your table widths inside cells and in most cases reset cellpadding, cellspacing, and border to zero. Use nested tables as a way to space effectively in your message. -->

          <table class="content" style="line-height:150%;width:600px;max-width:600px;min-width:320px;font-family:Arial, Verdana, Geneva, sans-serif;color:#000000;margin:0 auto;" width="600" cellspacing="0" cellpadding="0" align="center">
            <tbody>
              <tr>
                <td style="background: #fff; color: #000000;" class="vTop">
                  <table class="mail-body" width="100%" cellpadding="0" style="margin:30px 0;">
                    <tbody>
                      <tr>
                        <td>
                        <h1><%= glp("jcmsplugin.archives.email.communication.titre") %></h1>
                        
                        <p><%= glp("jcmsplugin.archives.email.communication.sous-titre") %> <%=request.getAttribute("date") %></p>
                        
                        <h2><%= glp("jcmsplugin.archives.form.vous-etes") %></h2>
                        
                        <p><%= glp("jcmsplugin.archives.form.nom") %> : <%=request.getAttribute("nom") %></p>
                        <p><%= glp("jcmsplugin.archives.form.prenom") %> : <%=request.getAttribute("prenom") %></p>
                        <p><%= glp("jcmsplugin.archives.form.administration") %> : <%=request.getAttribute("administration") %></p>
                        <p><%= glp("jcmsplugin.archives.form.direction") %> : <%=request.getAttribute("direction") %></p>
                        <p><%= glp("jcmsplugin.archives.form.service") %> : <%=request.getAttribute("service") %></p>
                        
                        <h2><%= glp("jcmsplugin.archives.form.coordonnees") %></h2>
                        
                        <p><%= glp("jcmsplugin.archives.form.adresse") %> : <%=request.getAttribute("adresse") %></p>
                        <% if(Util.notEmpty(request.getAttribute("complementAdresse"))) { %>
                            <p><%= glp("jcmsplugin.archives.form.complementAdresse") %> : <%=request.getAttribute("complementAdresse") %></p>
                        <% }%>
                        <p><%= glp("jcmsplugin.archives.form.codePostal") %> : <%=request.getAttribute("codePostal") %></p>
                        <p><%= glp("jcmsplugin.archives.form.ville") %> : <%=request.getAttribute("ville") %></p>
                        <p><%= glp("jcmsplugin.archives.form.telephone") %> : <%=request.getAttribute("telephone") %></p>
                        
                        <h2><%= glp("jcmsplugin.archives.form.caracteristiquesRecherche") %></h2>
                        
                        <% if(Util.notEmpty(request.getAttribute("versement"))) { %>
                            <p><%= glp("jcmsplugin.archives.form.versement") %> : <%=request.getAttribute("versement") %></p>
                        <% }%>
                        <% if(Util.notEmpty(request.getAttribute("dossier"))) { %>
                            <p><%= glp("jcmsplugin.archives.form.dossier") %> : <%=request.getAttribute("dossier") %></p>
                        <% }%>
                        <% if(Util.notEmpty(request.getAttribute("natureRecherche"))) { %>
                            <p><%= glp("jcmsplugin.archives.form.natureRecherche") %> : <%=request.getAttribute("natureRecherche") %></p>
                        <% }%>
                        <% if(Util.notEmpty(request.getAttribute("dateVersement"))) { %>
                            <p><%= glp("jcmsplugin.archives.form.dateVersement") %> : <%=request.getAttribute("dateVersement") %></p>
                        <% }%>
                        <% if(Util.notEmpty(request.getAttribute("dateRetour"))) { %>
                            <p><%= glp("jcmsplugin.archives.form.dateRetour") %> : <%=request.getAttribute("dateRetour") %></p>
                        <% }%>
  
                        </td>
                      </tr>
                    </tbody>
                  </table>
                </td>
              </tr>

    </tbody>
  </table>

</body>

</html>



