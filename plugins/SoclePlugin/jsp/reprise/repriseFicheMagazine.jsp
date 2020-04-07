<%@page import="java.util.regex.Matcher"%>
<%@page import="java.util.regex.Pattern"%>
<%@page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@page import="com.jalios.jcms.handler.QueryHandler"%>
<%@page import="java.io.IOException"%>
<%
  
%><%@ include file="/jcore/doInitPage.jsp"%>
<%
  if (!isAdmin) {
    sendForbidden(request, response);
    return;
  }
%>
<%@ include file='/admin/doAdminHeader.jspf'%>

<div class="page-header">
	<h1>Reprise des fiches lieux</h1>
</div>


<h3>Reprise des fiche magazine</h3>
<form>
	<input type="hidden" name="reprise" value="true"> <input
		class="btn btn-danger modal confirm" type="submit"
		value="Lancer la reprise" />
</form>


<%
  if (getBooleanParameter("reprise", false)) {

    QueryHandler qh = new QueryHandler();
    qh.setExactType(true);
    qh.setTypes(Magazine.class.getSimpleName());
    qh.setCheckPstatus(false);
    QueryResultSet result = qh.getResultSet();

    for (Publication itPub : result) {

        Magazine itMagazine = (Magazine) itPub;

        Set<Category> categories = new HashSet<Category>();
        categories.addAll(itMagazine.getCategorySet());
        
        FichePublication itFiche = new FichePublication();

        itFiche.setTitle(itMagazine.getTitle());
        itFiche.setImagePrincipale(itMagazine.getImageDeUne());
        itFiche.setLibelleBoutonLiseuse("Lire le magazine en ligne");
        itFiche.setUrlLiseuse(itMagazine.getUrlLiseuse());
        itFiche.setDocumentPdf(itMagazine.getDocumentPdf());
        itFiche.setVersionDaisy(itMagazine.getVersionDaisy());
        if(Util.notEmpty(itMagazine.getCodeEmbedSoundcloud())){
         itFiche.setCodeEmbedSoundcloud(JcmsUtil.unescapeHtml(itMagazine.getCodeEmbedSoundcloud()).replaceAll("&gt",">"));
         logger.warn(itMagazine.getTitle());
        }
        itFiche.setTitreUne(itMagazine.getTitreDossier());
        itFiche.setChapo(itMagazine.getTitreDossier());
        
        // Sioox
        if(Util.notEmpty(itMagazine.getRubriqueSioox1())){
          categories.add(channel.getCategory("c_1274310"));
          categories.add(channel.getCategory("p1_929991"));

          // Rubrique 1
          if(Util.notEmpty(itMagazine.getTitreDossier()) && Util.notEmpty(itMagazine.getUrlDossier())){
            itFiche.setTitreRubrique1("La story");
            itFiche.setLibelleLienRubrique1(new String[]{itMagazine.getTitreDossier()});
            itFiche.setLienExterneRubrique1(new String[]{itMagazine.getUrlDossier()});
           }
          
          // Rubrique 2
          itFiche.setTitreRubrique2(itMagazine.getRubriqueSioox1());
          itFiche.setLibelleLienRubrique2(new String[]{itMagazine.getTitreRubriqueSioox1()});
          itFiche.setLienExterneRubrique2(new String[]{itMagazine.getUrlRubriqueSioox1()});
          
          // Rubrique 3
          if(Util.notEmpty(itMagazine.getRubriqueSioox2())){
	          itFiche.setTitreRubrique3(itMagazine.getRubriqueSioox2());
	          itFiche.setLibelleLienRubrique3(new String[]{itMagazine.getTitreRubriqueSioox2()});
	          itFiche.setLienExterneRubrique3(new String[]{itMagazine.getUrlRubriqueSioox2()});          
          }
          if(Util.notEmpty(itMagazine.getClasseParticipante())){
          	itFiche.setTitreComplement("Classe participante");
           itFiche.setComplement(itMagazine.getClasseParticipante());          
           }
          
          
        }
        // Magazine
        else if(Util.notEmpty(itMagazine.getPortrait1())){
          categories.add(channel.getCategory("c_1274309"));
          categories.add(channel.getCategory("p1_1012858"));
          
          ArrayList<String> libellesArray = new ArrayList<String>();
          ArrayList<String> liensArray = new ArrayList<String>();
          
          if(Util.notEmpty(itMagazine.getPortrait1()) && Util.notEmpty(itMagazine.getUrlPortrait1())){
            libellesArray.add(itMagazine.getPortrait1());
            liensArray.add(itMagazine.getUrlPortrait1());
          }
          if(Util.notEmpty(itMagazine.getPortrait2()) && Util.notEmpty(itMagazine.getUrlPortrait2())){
            libellesArray.add(itMagazine.getPortrait2());
            liensArray.add(itMagazine.getUrlPortrait2());
          }
          if(Util.notEmpty(itMagazine.getPortrait3()) && Util.notEmpty(itMagazine.getUrlPortrait3())){
            libellesArray.add(itMagazine.getPortrait3());
            liensArray.add(itMagazine.getUrlPortrait1());
          }
          
          String[] libelles = new String[libellesArray.size()];
          String[] liens = new String[liensArray.size()];
          
          for(int i=0; i < libellesArray.size(); i++){
            libelles[i] = libellesArray.get(i);
            }
        
	        for(int j=0; j < liensArray.size(); j++){
	          liens[j] = liensArray.get(j);
	          }

         // Rubrique 1
         if(Util.notEmpty(itMagazine.getTitreDossier()) && Util.notEmpty(itMagazine.getUrlDossier())){
           itFiche.setTitreRubrique1("Dossier");
           itFiche.setLibelleLienRubrique1(new String[]{itMagazine.getTitreDossier()});
           itFiche.setLienExterneRubrique1(new String[]{itMagazine.getUrlDossier()});
          }
         
          // Rubrique 2
          if(Util.notEmpty(libelles) && Util.notEmpty(liens)){
            itFiche.setTitreRubrique2("Portrait");
            itFiche.setLibelleLienRubrique2(libelles);
            itFiche.setLienExterneRubrique2(liens);
           }
          
          // Rubrique 3
          if(Util.notEmpty(itMagazine.getGrosseActu()) && Util.notEmpty(itMagazine.getUrlGrosseActu())){
	          itFiche.setTitreRubrique3("Actualit�s");
	          itFiche.setLibelleLienRubrique3(new String[]{itMagazine.getGrosseActu()});
	          itFiche.setLienExterneRubrique3(new String[]{itMagazine.getUrlGrosseActu()});
          }
          
          // Rubrique 4
          if(Util.notEmpty(itMagazine.getQuestion()) && Util.notEmpty(itMagazine.getUrlQuestion())){
	          itFiche.setTitreRubrique4("La question");
	          itFiche.setLibelleLienRubrique4(new String[]{itMagazine.getQuestion()});
	          itFiche.setLienExterneRubrique4(new String[]{itMagazine.getUrlQuestion()});
          }
        }
        



        categories.add(channel.getCategory("p1_314847"));
        
        // Reprise de toutes les catégories
        itFiche.setCategorySet(categories);

        // meta donné et écriture
        itFiche.setAuthor(itMagazine.getAuthor());
        itFiche.performCreate(itMagazine.getAuthor());

    }

  }
%>


<%@ include file='/admin/doAdminFooter.jspf'%>
