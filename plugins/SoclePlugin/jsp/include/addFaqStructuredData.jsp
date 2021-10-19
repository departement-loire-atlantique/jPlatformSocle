<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file='/jcore/doInitPage.jsp'%>

<%--    Sur les pages de FAQ, ajoute des données structurées au format json qui serviront à l'amélioration SEO
        https://developers.google.com/search/docs/advanced/structured-data/faqpage
--%>

<jalios:if predicate='<%= Util.notEmpty(request.getAttribute("jsonFaq")) %>'>
    <script type="application/ld+json">
        <%= request.getAttribute("jsonFaq") %>
    </script>
</jalios:if>