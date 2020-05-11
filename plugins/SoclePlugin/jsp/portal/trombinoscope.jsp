<%@page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@page import="com.jalios.jcms.handler.QueryHandler"%>


<%@ page contentType="text/html; charset=UTF-8" %><%
%><%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%><%
%><%@ include file='/jcore/doInitPage.jspf' %><%

SortedSet tmpCantonsSet = channel.getPublicationSet(Canton.class, loggedMember, false);
SortedSet cantonsSet = new TreeSet(ComparatorManager.getComparator(Publication.class, "title", false));
cantonsSet.addAll(tmpCantonsSet);

%>

<section id="sectionTrombi" class="ds44-contenuArticle">

	<div class="ds44-flex-container ds44-results">
		<div class="ds44-listResults ds44-innerBoxContainer ds44-innerBoxContainer--list">
				
			<ul class="ds44-list ds44-list--results ds44-flex-container">
			
                <jalios:foreach collection="<%= cantonsSet %>" name="itCanton" type="Canton">
					<li class="ds44-fg1 ds44-js-results-item">
					    <jalios:media data="<%= itCanton %>" template="cardFull"/>
					</li>
                </jalios:foreach>

               </ul>

	    </div>
	</div>

</section>

