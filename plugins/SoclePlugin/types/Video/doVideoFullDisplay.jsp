<%@ page contentType="text/html; charset=UTF-8" %><%
%><%@ page import="fr.cg44.plugin.socle.SocleUtils" %><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
%><% Video obj = (Video)request.getAttribute(PortalManager.PORTAL_PUBLICATION); %><%
%><%@ include file='/front/doFullDisplay.jspf' %>
<div class="fullDisplay Video <%= obj.canBeEditedFieldByField(loggedMember) ? "unitFieldEdition" : "" %>" itemscope="itemscope">
<%@ include file='/front/publication/doPublicationHeader.jspf' %>

<% //jcmsContext.addJavaScript("plugins/SoclePlugin/js/video.js"); %>
<%
String uniqueIDiframe = UUID.randomUUID().toString();
String urlVideo = Util.decodeUrl(SocleUtils.buildYoutubeUrl(obj.getUrlVideo()));

%>
<H2>Gabarit FULL</H2>
<iframe id="<%=uniqueIDiframe%>" width="853" height="480" src="<%=urlVideo%>" frameborder="0" allowfullscreen></iframe>

<script>
var tag = document.createElement('script');

tag.src = "https://www.youtube.com/iframe_api";
var firstScriptTag = document.getElementsByTagName('script')[0];
firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

var player;
function onYouTubeIframeAPIReady() {
  player = new YT.Player('<%=uniqueIDiframe%>', {
    events: {
      'onReady': onPlayerReady } });
}

function onPlayerReady(event) {

  var lienChapitre = document.getElementsByClassName('lienChapitre');
  for (i = 0; i < lienChapitre.length; i++){
      lienChapitre[i].addEventListener("click", function () {
          console.log("clic");
          var videoTime = this.getAttribute("data-videoTime");
            player.seekTo(videoTime, true);
            player.playVideo();
            return false;
          });
  }
  

}

</script>


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
                <p><a id="#video<%=uniqueID%>" class="lienChapitre" href="#" data-videoId="#video<%=uniqueID%>" data-videoTime="<%=SocleUtils.getSecondesByTimecode(timecode)%>" title="Aller à <%=timecode %>, chapitre concernant : <%=itChapitre %>"><p class=\"paragrapheChapitre\"><%=libelletimecode%></a> / <%= timecode %> / <%=SocleUtils.getSecondesByTimecode(timecode) %></p>
                <%
                }
            } catch (IndexOutOfBoundsException e) {
                timecode = "";
                libelletimecode = "";
                }
       
      %>
      
    </jalios:foreach>

</jalios:if>

