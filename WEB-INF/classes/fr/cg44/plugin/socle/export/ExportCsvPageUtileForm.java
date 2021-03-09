package fr.cg44.plugin.socle.export;

import java.io.PrintWriter;
import java.io.Writer;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;
import java.util.Set;
import java.util.SortedSet;

import com.jalios.jcms.Category;
import com.jalios.jcms.Channel;
import com.jalios.jcms.Member;
import com.jalios.jcms.Publication;
import com.jalios.util.Util;

import fr.cg44.plugin.socle.SocleUtils;
import generated.PageUtileForm;

public class ExportCsvPageUtileForm {

	private static final String SEPARATOR = ";";
	private static final char DOUBLE_QUOTE = '"';


	/**
	 * Ajoute les headers CSV pour le type PageUtileForm
	 * @param printWriter
	 */
	private static void printHeader(PrintWriter printWriter){

		List<String> listStrHeader = Arrays.asList("ID du contenu", "Date", "Heure", "Titre du contenu", "Type du contenu", "Catégorie de navigation", 
				"Libellé catégorie de navigation", "Sous-catégorie", "Libellé sous-catégorie", "Rédacteur du contenu", "Type d'avis", "L'information n'est pas assez complète", 
				"L'information est trop compliqué", "Il y a trop à lire", "Commentaires", "Message", "Email", "Email de l'internaute");

		StringBuilder header = new StringBuilder();

		for(String strHeader : listStrHeader) {
			header.append(DOUBLE_QUOTE).append(strHeader).append(DOUBLE_QUOTE).append(SEPARATOR);
		}

		printWriter.println(header);
	}

	/**
	 * Ajoute les données CSV pour le type PageUtileForm
	 * @param itMember
	 * @param paramString
	 * @param paramWriter
	 */
	public static void generateCsv(Member itMember, String paramString, Writer paramWriter) {
		PrintWriter localPrintWriter = new PrintWriter(paramWriter);

		Channel channel = Channel.getChannel();
		String userLang = channel.getCurrentUserLang();

		printHeader(localPrintWriter);

		SortedSet<Publication> sortedPubs = ExportCsvUtils.getPublicationsOfType("PageUtileForm", itMember);

		for (Iterator<Publication> iter = sortedPubs.iterator(); iter.hasNext();) {
			Publication itPub = iter.next();
			if (Util.isEmpty(itPub) || !(itPub instanceof PageUtileForm)) {
				continue;
			}

			PageUtileForm itPageUtileForm = (PageUtileForm) itPub;
			
			SimpleDateFormat sdfDate = new SimpleDateFormat("dd/MM/yyyy");
			SimpleDateFormat sdfHeure = new SimpleDateFormat("hh:mm");
			
			Publication contenu = channel.getPublication(itPageUtileForm.getIdContenu());
			
			Set<Category> listCategorieNavigation = SocleUtils.getCategorieDeNavigation(contenu);
			Set<Category> listSousCategorieNavigation = SocleUtils.getCategorieDeNavigation(contenu, 1);


			String idDuContenu = itPageUtileForm.getIdContenu();

			String date  = sdfDate.format(itPub.getCdate());
			String heure = sdfHeure.format(itPub.getCdate());

			String titreDuContenu = Util.notEmpty(contenu) ? contenu.getTitle(userLang) : "";

			String typeDuContenu  = Util.notEmpty(contenu) ? contenu.getTypeLabel(userLang) : "";

			String categorieDeNavigation        = SocleUtils.listCategoriesId(listCategorieNavigation);
			String libelleCategorieDeNavigation = SocleUtils.formatCategories(listCategorieNavigation);

			String sousCategorie        = SocleUtils.listCategoriesId(listSousCategorieNavigation);
			String libelleSousCategorie = SocleUtils.formatCategories(listSousCategorieNavigation);

			String redacteurDuContenu = Util.notEmpty(contenu) ? contenu.getAuthor().getFullName() : "";

			String typeDAvis = itPageUtileForm.getUtileLabel(userLang);

			String lInformationNEstPasAssezComplete = Boolean.toString(itPageUtileForm.getMotif(userLang).contains("pasAssezComplet"));
			String lInformationEstTropComplique     = Boolean.toString(itPageUtileForm.getMotif(userLang).contains("tropComplique"));
			String ilYATropALire                    = Boolean.toString(itPageUtileForm.getMotif(userLang).contains("tropLong"));

			String commentaires = Boolean.toString(Util.notEmpty(itPageUtileForm.getCommentaire()));
			String message = itPageUtileForm.getCommentaire();

			String email = Boolean.toString(Util.notEmpty(itPageUtileForm.getEmail()));
			String emailDeLInternaute = itPageUtileForm.getEmail();

			// Remplir les champs CSV
			List<String> listStrBody = Arrays.asList(idDuContenu, date, heure, titreDuContenu, typeDuContenu, categorieDeNavigation, 
					libelleCategorieDeNavigation, sousCategorie, libelleSousCategorie, redacteurDuContenu, typeDAvis, lInformationNEstPasAssezComplete, 
					lInformationEstTropComplique, ilYATropALire, commentaires, message, email, emailDeLInternaute);

			StringBuilder body = new StringBuilder();

			for(String strBody : listStrBody) {
				body.append(ExportCsvUtils.getFormattedCsvValue(strBody, true));
			}

			localPrintWriter.println(body);
		}
	}

}