<%@page import="fr.cg44.plugin.socle.infolocale.util.InfolocaleUtil"%>
<%@page import="fr.cg44.plugin.socle.infolocale.entities.DateInfolocale"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%>
<%@ include file='/jcore/doInitPage.jspf' %><%
%><%@ page import="com.jalios.jcms.taglib.card.*" %><%
%><%@ include file='/jcore/media/mediaTemplateInit.jspf' %><%
%><%

if (data == null) {
  return;
}

EvenementInfolocale itEvent = (EvenementInfolocale) data;

DateInfolocale currentDisplayedDate = InfolocaleUtil.getClosestDate(itEvent);

String cssCard = Util.notEmpty(request.getAttribute("cssCard")) ? request.getAttribute("cssCard").toString() : "";

%>

   <div class="ds44-flex-container">
      <div class="ds44-card__section--horizontal ds44-flex-valign-center ds44-flex-align-center">
         <%
         String dateIndexParam = Util.notEmpty(itEvent.getIndexDate()) ? "?dateIndex=" + itEvent.getIndexDate() : "";
         %>
         <p class="ds44-card__title"><a href="<%= itEvent.getDisplayUrl(userLocale) %><%= dateIndexParam %>" class="ds44-card__globalLink"><%= itEvent.getTitre() %></a></p>
		<p>
			<span class="ds44-docListElem ds44-inlineBlock"> <i class="icon icon-date icon--sizeM ds44-docListIco ds44-posTop7" aria-hidden="true"></i>
			    <jalios:select>
                    <jalios:if
                        predicate="<%=InfolocaleUtil.infolocaleDateIsSingleDay(currentDisplayedDate)%>">
                        <%=InfolocaleUtil.getDayOfMonthLabel(currentDisplayedDate.getDebut())%>
                        <%=InfolocaleUtil.getMonthLabel(currentDisplayedDate.getDebut(), false)%>
                    </jalios:if>
                    <jalios:default>
                        <%=InfolocaleUtil.getDayOfMonthLabel(currentDisplayedDate.getDebut())%>
                        <%=InfolocaleUtil.getMonthLabel(currentDisplayedDate.getDebut(), false)%>
                                -
                                <%=InfolocaleUtil.getDayOfMonthLabel(currentDisplayedDate.getFin())%>
                        <%=InfolocaleUtil.getMonthLabel(currentDisplayedDate.getFin(), false)%>
                    </jalios:default>
                </jalios:select>
			</span>
		</p>
         <%@ include file="../include/doMetadataEventInfolocale.jspf" %>
         <span class="visually-hidden"><%= itEvent.getTitre() %></span></a>
      </div>
   </div>
