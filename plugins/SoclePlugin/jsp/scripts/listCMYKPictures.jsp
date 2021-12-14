<%@page import="javax.imageio.ImageTypeSpecifier"%>
<%@page import="java.awt.image.BufferedImage"%>
<%@page import="javax.imageio.ImageIO"%>
<%@page import="com.jalios.io.ImageUtil"%>
<%@page import="com.jalios.io.ImageInfo"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file='/jcore/doInitPage.jspf'%>

<style>
th {
    border: 2px solid black;
}
td {
    border: solid 1px black;
}
</style>

<jalios:select>
    <jalios:if predicate="<%= Util.isEmpty(loggedMember) || !loggedMember.isAdmin() %>">
        <h2>Page accessible uniquement aux administateurs.</h2>
        
        <p><a href="<%= channel.getUrl() %>">Retour à l'accueil</a></p>
    </jalios:if>
    
    <jalios:default>
       <h2>Liste des images au format CMYK (ou juste incompatible)</h2>
       <table>
           <tr>
               <th>
                   ID FileDocument
               </th>
               <th>
                   Nom FileDocument
               </th>
               <th>
                   Path Image
               </th>
           </tr>
           <%
           TreeSet<FileDocument> allFiledocs = channel.getAllDataSet(FileDocument.class);
           %>
           <jalios:foreach type="FileDocument" name="itFiledoc" collection="<%= allFiledocs %>">
               <jalios:if predicate="<%= itFiledoc.isImage() && itFiledoc.getFile().exists() %>">
                   <%
                   try {
	                   BufferedImage bufferedImg = ImageIO.read(itFiledoc.getFile());
                   } catch (Exception e) {
                       // Si la ligne au dessus 'casse' alors l'image n'est pas compatible
                       %>
                       <tr>
			               <td>
			                   <%= itFiledoc.getId() %>
			               </td>
			               <td>
			                   <%= itFiledoc.getTitle() %>
			               </td>
			               <td>
			                   <%= itFiledoc.getFile().getPath() %>
			               </td>
			           </tr>
                       <%
                   }
                   %>
               </jalios:if>
           </jalios:foreach>
       </table>
    </jalios:default>
</jalios:select>