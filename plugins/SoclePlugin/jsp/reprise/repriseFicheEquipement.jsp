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
	<h1>Reprise des fiches Equipement</h1>
</div>


<h3>Reprise des fiches Equipement</h3>
<form>
	<input type="hidden" name="reprise" value="true"> <input
		class="btn btn-danger modal confirm" type="submit"
		value="Lancer la reprise" />
</form>


<%
  if (getBooleanParameter("reprise", false)) {
    
    TreeSet<Equipement> result = channel.getAllDataSet(Equipement.class);
    
    logger.warn("Nombre de contenus : " + result.size());
    

    for (Publication itPub : result) {

    	Equipement itOldContent = (Equipement) itPub;
        
    	
    	Set<Category> categories = new HashSet<Category>();
        categories.addAll(itOldContent.getCategorySet());
        
        FicheEquipement itNewContent = new FicheEquipement();

        itNewContent.setTitle(itOldContent.getTitle());
        itNewContent.setChapo(itOldContent.getIntro());
        itNewContent.setImagePrincipale(itOldContent.getMainIllustration());
        itNewContent.setCopyright(itOldContent.getIllustrationCopyright());
        itNewContent.setLegende(itOldContent.getIllustrationLegend());
        itNewContent.setMontantDeLaSubvention(itOldContent.getMontantDeLaSubvention());
        itNewContent.setMontantTotalDesTravaux(itOldContent.getMontantTotalDesTravaux());
        itNewContent.setPourcentageDepartement(itOldContent.getPourcentageDepartement());
        
        itNewContent.setCommunes(itOldContent.getCommunes());
        itNewContent.setCanton(itOldContent.getCanton());
        
        // Reprise de toutes les catégories
        itNewContent.setCategorySet(categories);
        
        // extradata : on ne récupère que la première valeur de long/lat.
        itNewContent.setExtraData("extra.FicheEquipement.plugin.tools.geolocation.longitude", itOldContent.getExtraData("extra.Equipement.plugin.tools.geolocation.longitude").split("_")[0]);
        itNewContent.setExtraData("extra.FicheEquipement.plugin.tools.geolocation.latitude", itOldContent.getExtraData("extra.Equipement.plugin.tools.geolocation.latitude").split("_")[0]);

        // refferer : les liens vers les Equipement doivent pointer vers les Fiche Equipement. 
        // NOTE 04/08/2020 : pas de referrer trouvés (sauf page de test pourles tuiles). On ne gère pas cet aspect.
        
        if(Util.notEmpty(itOldContent.getAllReferrerSet())){
        	logger.warn(itOldContent.getAllReferrerSet()+"\r\n");
        }
        
        
        // meta donnÃ© et Ã©criture
        TreeSet<Group> groupSet = new TreeSet<Group>();
        if(Util.notEmpty(itOldContent.getAuthorizedGroupSet())){
            groupSet.addAll(itOldContent.getAuthorizedGroupSet());
        }
        
        TreeSet<Member> memberSet = new TreeSet<Member>();
        if(Util.notEmpty(itOldContent.getAuthorizedMemberSet())){
        	memberSet.addAll(itOldContent.getAuthorizedMemberSet());
        }
        
        itNewContent.setAuthor(itOldContent.getAuthor());
        itNewContent.setAuthorizedGroupSet(groupSet);
        itNewContent.setAuthorizedMemberSet(memberSet);
        itNewContent.setWorkspace(itOldContent.getWorkspace());
        itNewContent.performCreate(itOldContent.getAuthor());

    }
    

  }
%>


<%@ include file='/admin/doAdminFooter.jspf'%>
