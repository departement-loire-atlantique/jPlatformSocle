<%@page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@ page import="fr.cg44.plugin.socle.VideoUtils" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%>
<%@ include file='/jcore/doInitPage.jspf' %>
<% Video obj = (Video)request.getAttribute(PortalManager.PORTAL_PUBLICATION); %>
<%@ include file='/front/doFullDisplay.jspf' %>

<%
String urlVideo = Util.decodeUrl(VideoUtils.buildYoutubeUrl(obj.getUrlVideo()));
FileDocument fichierTranscriptVideo = obj.getFichierTranscript();
String cheminFichierTranscriptVideo = "";
String typeFichierTranscript = "";
String tailleFichierTranscript = "";

// Récupération des infos du fichier de transcription
if(Util.notEmpty(fichierTranscriptVideo)){
  cheminFichierTranscriptVideo = fichierTranscriptVideo.getDownloadUrl();
  typeFichierTranscript = FileDocument.getExtension(fichierTranscriptVideo.getFilename()).toUpperCase();
  tailleFichierTranscript = Util.formatFileSize(fichierTranscriptVideo.getSize());
}
%>

<main id="content" role="main">
    <article class="ds44-container-large">
        <ds:titleSimple titreVideo="<%= obj.getTitle() %>" urlVideo="<%= urlVideo %>" fichierTranscript="<%= cheminFichierTranscriptVideo %>"
            typeFichierTranscript="<%= typeFichierTranscript %>" tailleFichierTranscript="<%= tailleFichierTranscript %>"  
            title="<%= obj.getTitle() %>" chapo="<%= obj.getChapo() %>" legend="<%= obj.getLegende() %>" copyright="<%= obj.getCopyright() %>" 
            userLang="<%= userLang %>" breadcrumb="true">
        </ds:titleSimple>
        <section class="ds44-contenuArticle">
            <div class="ds44-inner-container ds44-mtb3">
                <div class="ds44-grid12-offset-2">
                    <jalios:if predicate="<%= Util.notEmpty(obj.getDescription()) %>">
	                    <div class="ds44-introduction"><jalios:wysiwyg><%= obj.getDescription() %></jalios:wysiwyg></div>
                    </jalios:if>
                    
                    <%-- Chapitres --%>
                    <%-- TODO : en attente maquette et implémentation du JS pour piloter la vidéo. --%>
			        <jalios:if predicate="<%= obj.getHasChapters() && Util.notEmpty(obj.getChapitre()) && Util.notEmpty(obj.getTimecode()) && Util.notEmpty(obj.getLibelleTimecode()) %>">
			            <%
			            List<String> chapitres = Arrays.asList(obj.getChapitre());
			            String[] timecodes = obj.getTimecode();
			            String[] libellestimecodes = obj.getLibelleTimecode();
			            String tmpChapitre = "";
			            %>
                        <%-- Si plusieurs chapitres du même nom, on n'affiche le nom du chapitre qu'une fois. On classe les timecodes par chapitre. --%>
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
			                        libelletimecode = libellestimecodes[itCounter-1]; %>
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
                    
                </div>
            </div>
        </section>



        
        <%-- TODO : bloc des réseaux sociaux --%>
        
        <%-- TODO : bloc Je m'abonne --%>
        
        <%-- TODO : bloc "Sur le même thème --%>
    </article>
</main>
