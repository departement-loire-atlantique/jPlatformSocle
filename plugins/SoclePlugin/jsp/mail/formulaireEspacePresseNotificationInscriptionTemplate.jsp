<%@ include file='/jcore/doInitPage.jspf' %>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title><%= glp("jcmsplugin.socle.email.inscription-presse.notification-creation.objet") %></title>
  
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
                            <p>Bonjour,</p>
                            <p>Une nouvelle inscription à l'espace presse a été enregistrée :</p>
                            <p><%= glp("jcmsplugin.socle.nom") %> : <%=request.getAttribute("nom") %><br>
                            <%= glp("jcmsplugin.socle.prenom") %> : <%=request.getAttribute("prenom") %><br>
                            <%= glp("jcmsplugin.socle.mail") %> : <%=request.getAttribute("mail") %><br>
                            <%= glp("jcmsplugin.socle.telephone") %> : <%=request.getAttribute("telephone") %><br>
                            <% if(Util.notEmpty(request.getAttribute("medium"))) { %>
                                <%= glp("jcmsplugin.socle.media") %> : <%=request.getAttribute("medium") %>
                            <% } %>
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



