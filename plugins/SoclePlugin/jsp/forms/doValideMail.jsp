<%@ page contentType="text/html; charset=UTF-8" %><%
%><%@ include file='/jcore/doInitPage.jspf' %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title><%= glp("jcmsplugin.socle.newletter.title.lbl") %></title>
  <style type="text/css">
    /* Based on The MailChimp Reset INLINE: Yes. */
    /* Client-specific Styles */
    #outlook a {
      padding: 0;
    }

    /* Force Outlook to provide a "view in browser" menu link. */
    body {
      font-family: Arial, Verdana, Geneva, sans-serif;
      width: 100% !important;
      -webkit-text-size-adjust: 100%;
      -ms-text-size-adjust: 100%;
      margin: 0;
      padding: 0;
    }

    /* Prevent Webkit and Windows Mobile platforms from changing default font sizes.*/
    .ExternalClass {
      width: 100%;
    }

    /* Force Hotmail to display emails at full width */
    .ExternalClass,
    .ExternalClass p,
    .ExternalClass span,
    .ExternalClass font,
    .ExternalClass td,
    .ExternalClass div {
      line-height: 100%;
    }

    /* Forces Hotmail to display normal line spacing.  More on that: http://www.emailonacid.com/forum/viewthread/43/ */
    #backgroundTable {
      margin: 0;
      padding: 0;
      width: 100% !important;
      line-height: 100% !important;
    }

    /* End reset */

    /* Some sensible defaults for images
Bring inline: Yes. */
    img {
      outline: none;
      text-decoration: none;
      -ms-interpolation-mode: bicubic;
      width: 100%;
    }

    a img {
      border: none;
    }

    /* Yahoo paragraph fix
Bring inline: Yes. */
    p {
      margin: 1em 0;
    }

    /* Hotmail header color reset
Bring inline: Yes. */
     h1,
     h2,
     h3,
     h4,
     h5,
     h6 {
      color: #000000 !important;
      text-align: left;
    }

    h1 {
      font-size: 36px;
      line-height:43px;
    }

    h2 {
      font-size: 24px;
    }

    h3 {
      font-size: 20px;
    }

    h4, h5, h6 {
      font-size: 17px;
    }

     h1 a,
     h2 a,
     h3 a,
     h4 a,
     h5 a,
     h6 a {
      color: #000000 !important;
      text-decoration: none;
    }

     h1 a:hover,
     h2 a:hover,
     h3 a:hover,
     h4 a:hover,
     h5 a:hover,
     h6 a:hover {
      text-decoration: underline;
    }

    /* Outlook 07, 10 Padding issue fix
Bring inline: No.*/
    table td {
      border-collapse: collapse;
    }

    /* Remove spacing around Outlook 07, 10 tables
Bring inline: Yes */
    table {
      border-collapse: collapse;
      mso-table-lspace: 0pt;
      mso-table-rspace: 0pt;
    }

    .vTop {
        vertical-align: top;
    }

    /* Styling your links has become much simpler with the new Yahoo.  In fact, it falls in line with the main credo of styling in email and make sure to bring your styles inline.  Your link colors will be uniform across clients when brought inline.
Bring inline: Yes. */
    a {
      color: #000000;
      text-decoration: underline;
    }

    a:hover {
      text-decoration: none;
    }

    a:hover,
    a:active,
    a:focus,
    a:visited {
      color: #000000 !important;
    }


    ul.list.noMrg {
        padding-left: 30px !important;
    }

    .noMrg,
    ul p {
        margin:0 !important;
    }

    .col-left,
    .col-right {
        width:50%;
        vertical-align: top;
    }

    .col-left {
        padding-right:15px;
    }

    .col-right {
        padding-left:15px;
    }

    .ds44-introduction {
      font-size: 19px;
      font-weight: 700;
      margin-top: 0;
      margin-bottom: 2rem;
      line-height: 27px;
  }


    /***************************************************
****************************************************
MOBILE TARGETING
****************************************************
***************************************************/

    @media only screen and (max-width: 639px) {
      TABLE.content {
        width: 240px !important;
      }

      P,
      DIV,
      LI,
      UL,
      span {
        font-size: 14px;
      }

      h1 {
        font-size: 30px;
        line-height:38px;
      }

      h2 {
        font-size: 20px;
      }

      h3 {
        font-size: 18px;
      }

      h4, h5, h6 {
        font-size: 16px;
      }


      .thumbnail IMG {
        display: block;
      }

      .col-left,
      .col-right {
          width:100%;
          padding:0;
          display: block;
      }

      .col-right {
          margin-top: 20px;
          text-align: center;
      }

      .ds44-introduction {
        font-size: 16px;
        line-height: 23px;
    }


}

  </style>
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
                  <th>
                    <table style="margin: 15px 0 ; color: #000000;">
                      <tbody>
                        <tr>
                          <td>
                              <a href="#">
                                  <img src="http://design.loire-atlantique.fr/assets/images/newsletter/logo-loire-atlantique-information.svg" style="height=62px;" alt="image" class="" />
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
                        <%= glp("jcmsplugin.socle.newletter.mail.confirme.content", new String[]{url, mailTheme}) %>
                      </tr>
                    </tbody>
                  </table>
                </td>
              </tr>
              

              <tr>
                <td>
                  <div style="font-size: 11px; color: #999; width: 100%; text-align: center;"><%= glp("jcmsplugin.socle.newletter.mail.conrfirm.footer") %></div>
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
