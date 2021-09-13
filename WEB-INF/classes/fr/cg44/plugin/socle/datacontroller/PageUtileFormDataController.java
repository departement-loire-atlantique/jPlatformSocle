package fr.cg44.plugin.socle.datacontroller;

import java.util.Calendar;
import java.util.Map;

import com.jalios.jcms.BasicDataController;
import com.jalios.jcms.Data;
import com.jalios.jcms.DataController;
import com.jalios.jcms.Member;
import com.jalios.jcms.QueryResultSet;
import com.jalios.jcms.handler.QueryHandler;
import com.jalios.jcms.plugin.PluginComponent;
import com.jalios.util.Util;

import generated.PageUtileForm;

public class PageUtileFormDataController extends BasicDataController implements PluginComponent {
	
    /**
     * En cas de création, il faut comparer avec le dernier élément créé.
     * Si le nouveau et le dernier créé sont identiques en contenus, et créés avec un délai suffisamment court,
     * il faut annuler l'écriture du contenu
     */
    @Override
    public void beforeWrite(Data data, int op, Member mbr, Map context) {
        
        if(op==OP_CREATE){
             PageUtileForm itForm = (PageUtileForm) data;
             QueryHandler qh = new QueryHandler();
             qh.setTypes("PageUtileForm");
             qh.setSort("cdate");
             QueryResultSet qrs = qh.getResultSet();
             PageUtileForm mostRecentForm = (PageUtileForm) qrs.getAsSortedSet().first();
             Calendar nowCal = Calendar.getInstance();
             int allowedDifference = channel.getIntegerProperty("jcmsplugin.socle.formpageutile.alloweddelay", 3) * 1000; // prop en millisecondes
             if (nowCal.getTimeInMillis() - mostRecentForm.getCdate().getTime() > allowedDifference) {
                 return;
             }
             // Il y a très peu de temps entre la création du dernier formulaire et celui que l'on souhaite créer
             // Il faut vérifier si les contenus sont identiques
             if (
                 itForm.getUtile() == mostRecentForm.getUtile()
                 && itForm.getMotif().equals(mostRecentForm.getMotif())
                 && Util.notEmpty(itForm.getCommentaire()) ? itForm.getCommentaire().equals(mostRecentForm.getCommentaire()) : Util.isEmpty(mostRecentForm.getCommentaire())
                 && Util.notEmpty(itForm.getIdContenu()) ? itForm.getIdContenu().equals(mostRecentForm.getIdContenu()) : Util.isEmpty(mostRecentForm.getIdContenu())
                 && Util.notEmpty(itForm.getUrl()) ? itForm.getUrl().equals(mostRecentForm.getUrl()) : Util.isEmpty(mostRecentForm.getUrl())
                 && Util.notEmpty(itForm.getEmail()) ? itForm.getEmail().equals(mostRecentForm.getEmail()) : Util.isEmpty(mostRecentForm.getEmail())
             ) {
                 // Tous les champs sont identiques ET ils ont été créés très récemment : on doit donc annuler l'écriture du contenu
                 // pour éviter les doublons
                 context.put(DataController.DO_NOT_STORE, Boolean.TRUE);
             }
        }
         
    }
}