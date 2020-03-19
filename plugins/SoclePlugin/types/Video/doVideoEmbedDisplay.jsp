<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="fr.cg44.plugin.socle.VideoUtils" %>
<%--    Génère une iframe de la vidéo incluse
        TODO : voir si on laisse comme ça ou si on génère l'iframe en JS via l'api Youtube mais 
        aujourd'hui le script plante si on insère plusieurs vidéo.
        
        TODO : rendre le chapitrage fonctionnel (hors sprint).
--%>
<%@ include file='/jcore/doInitPage.jspf' %>

<% Video obj = (Video)request.getAttribute(PortalManager.PORTAL_PUBLICATION); %>

<%
String uniqueIDiframe = UUID.randomUUID().toString();
String urlVideo = Util.decodeUrl(VideoUtils.buildYoutubeUrl(obj.getUrlVideo()));
String fichierTranscript = Util.notEmpty(obj.getFichierTranscript()) ? obj.getFichierTranscript().getDownloadUrl() : "";

%>
<div class="ds44-negativeOffset-2 ds44-mtb3">
    <iframe id="<%=uniqueIDiframe%>" width="100%" height="480" src="<%=urlVideo%>" frameborder="0" allowfullscreen></iframe>
    <jalios:if predicate="<%=Util.notEmpty(fichierTranscript)%>">
        <a href="<%=fichierTranscript%>" target="blank" title="<%= glp("jcmsplugin.socle.video.telecharger-transcript") %> <%= glp("jcmsplugin.socle.accessibily.newTabLabel") %>"><%= glp("jcmsplugin.socle.video.telecharger-transcript") %></a>
    </jalios:if>
</div>

<jalios:if predicate="<%=Util.notEmpty(obj.getChapitre()) && Util.notEmpty(obj.getTimecode()) && Util.notEmpty(obj.getLibelleTimecode()) %>">
    <%
    List<String> chapitres = Arrays.asList(obj.getChapitre());
    String[] timecodes = obj.getTimecode();
    String[] libellestimecodes = obj.getLibelleTimecode();
    String tmpChapitre = "";
    %>
    
    <jalios:foreach name="itChapitre" type="String" array="<%=obj.getChapitre()%>">
        <jalios:if predicate="<%=Util.notEmpty(itChapitre) && !itChapitre.equals(tmpChapitre) %>">
            <% tmpChapitre = itChapitre; %>
            <p><strong><%=itChapitre %></strong></p>
        </jalios:if>
        <%
        String uniqueID = UUID.randomUUID().toString();
        String timecode = "";
        String libelletimecode = "";
        try {
            if (Util.notEmpty(timecodes[itCounter-1]) && Util.notEmpty(libellestimecodes[itCounter-1])) {
                timecode = timecodes[itCounter-1];
                libelletimecode = libellestimecodes[itCounter-1];
                %>
                <p><a id="#video<%=uniqueID%>" class="lienChapitre" href="#" data-videoId="#video<%=uniqueID%>" data-videoTime="<%=VideoUtils.getSecondesByTimecode(timecode)%>" title="Aller à <%=timecode %>, chapitre concernant : <%=itChapitre %>"><p class=\"paragrapheChapitre\"><%=libelletimecode%></a> / <%= timecode %> / <%=VideoUtils.getSecondesByTimecode(timecode) %></p>
                <%
                }
            } catch (IndexOutOfBoundsException e) {
                timecode = "";
                libelletimecode = "";
                }
       
      %>
    </jalios:foreach>

</jalios:if>

