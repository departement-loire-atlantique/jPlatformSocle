<%@page import="com.jalios.jcms.unifiedinsert.InsertionContext"%><%
request.setAttribute(InsertionContext.UNIFIED_INSERT_ATTR, Boolean.TRUE);
request.setAttribute(InsertionContext.UNIFIED_INSERT_TRIGGER_CLASS_ATTR, "unifiedinsert-media");
%>
<!-- Affiche le "docChooser" de jPlatform dans la fen�tre de choix de contenu int�gr� de l"�diteur wysiwyg,
    plut�t que l'affichage standard en tuiles.
 -->
<%@include file="/work/pubChooser.jsp" %>