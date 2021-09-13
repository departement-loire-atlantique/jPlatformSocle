<%@ page contentType="text/html; charset=UTF-8" %><%
%><%@ include file='/jcore/doInitPage.jspf' %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title><%= glp("jcmsplugin.socle.newletter.title.lbl") %></title>
  
  <jsp:include page="/plugins/SoclePlugin/jsp/mail/stylesEmail.jsp" />
  
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
                  <th style="text-align: left;">
                    <table style="margin: 15px 0 ; color: #000000;">
                      <tbody>
                        <tr>
                          <td>
                              <a href="<%= channel.getUrl() %>">
                                  <img src="https://design.loire-atlantique.fr/assets/images/newsletter/logo-loire-atlantique-information.png" style="height=62px;" alt="image" class="" />
                              </a>
                          </td>
                        </tr>
                      </tbody>
                    </table>
                  </th>
                </tr>
              <tr>
                <th style="background-color:#99E6D1">
                  <table style="margin: 0 25px; color: #000000;">
                    <tbody>
                      <tr>
                        <td>
                          <h1 style="margin: 20px 0; padding: 0;"><%= glp("jcmsplugin.socle.newletter.title.lbl") %></h1>
                        </td>
                      </tr>
                    </tbody>
                  </table>
                </th>
              </tr>
              <tr>
                <td style="background: #fff; color: #000000;" class="vTop">
                  <table class="mail-body" width="100%" cellpadding="0" style="margin:30px 0;">
                    <tbody>
                      <tr>
                        <td>
                        <%
                        String url = (String) request.getAttribute("mailUrl");
                        String mailTheme = (String) request.getAttribute("mailTheme");
                        %>
                        <jalios:buffer name="footerLink">
                            <a href="<%= channel.getUrl() %>"><%= channel.getUrl() %></a>
                        </jalios:buffer>
                        <%= glp("jcmsplugin.socle.newletter.mail.confirme.content", new String[]{url, mailTheme, footerLink}) %>
                      </tr>
                    </tbody>
                  </table>
                </td>
              </tr>
              

              <tr>
                <td>                 
                  <div style="font-size: 11px; color: #999; width: 100%; text-align: center;"><%= glp("jcmsplugin.socle.newletter.mail.confirme.footer", new String[]{channel.getUrl()}) %></div>
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
