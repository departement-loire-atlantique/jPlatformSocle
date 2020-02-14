package fr.cg44.plugin.junit.socle;

import static org.junit.Assert.assertEquals;

import java.util.Calendar;
import java.util.Date;
import java.util.TreeSet;

import org.junit.Assert;
import org.junit.Test;

import com.jalios.jcms.Category;
import com.jalios.jcms.Channel;
import com.jalios.jcms.test.JcmsTestCase4;

import fr.cg44.plugin.junit.facettes.SocleDataInit;
import fr.cg44.plugin.socle.SocleUtils;
import generated.ContenuDeTest;

public class SocleUtilsTest extends JcmsTestCase4 {
	
	/* NullPointerException au sein de la méthode qu'importe les valeurs en entrée (NPE a la 2e ligne de la methode)
	 * a regler en suivant la solution dans ce lien : https://community.jalios.com/jcms/410_SocialQuestion/fr/-junit-definition-du-contexte-d-execution
	 */ 
	@Test
	public void getOrderedAuthorizedChildrenSetNominal() {
		
		assertEquals("SocleUtils.getOrderedAuthorizedChildrenSet avec une Category inexistante doit rendre un SortedSet vide", 
				new TreeSet<Category>(), 
				SocleUtils.getOrderedAuthorizedChildrenSet(null));
		
		Category cat1 = SocleDataInit.createCategory("cat1", Channel.getChannel().getRootCategory());
		
		assertEquals("SocleUtils.getOrderedAuthorizedChildrenSet avec une Category sans enfants doit rendre un SortedSet vide", 
				new TreeSet<Category>(), 
				SocleUtils.getOrderedAuthorizedChildrenSet(cat1));
		
		Category cat2 = SocleDataInit.createCategory("cat2", cat1);
		Category cat3 = SocleDataInit.createCategory("cat3", cat1);
		
		TreeSet<Category> listCat = new TreeSet<Category>();
		listCat.add(cat2);
		listCat.add(cat3);
		
		assertEquals("SocleUtils.getOrderedAuthorizedChildrenSet avec une Category avec enfants doit rendre un SortedSet avec les enfants", 
				listCat, 
				SocleUtils.getOrderedAuthorizedChildrenSet(cat1));
		
		cat1.delete(admin);
		cat2.delete(admin);
		cat3.delete(admin);
	}
	
	@Test
	public void getSecondesByTimecodeNominal() {
		
		assertEquals("SocleUtils.getSecondesByTimecode avec un String vide doit rendre 0", 
				0, 
				SocleUtils.getSecondesByTimecode(""));

		assertEquals("SocleUtils.getSecondesByTimecode avec un String bien formaté doit rendre le bon nombre de seconde", 
				3661, 
				SocleUtils.getSecondesByTimecode("01:01:01"));
	}
	
	@Test
	public void getContenuPrincipalNominal() {
		
		assertEquals("SocleUtils.getContenuPrincipal avec une Category null doit rendre null", 
				null, 
				SocleUtils.getContenuPrincipal(null));
		
		Category cat1 = SocleDataInit.createCategory("cat1", Channel.getChannel().getRootCategory());
		
		assertEquals("SocleUtils.getContenuPrincipal avec une Category sans contenu doit rendre null", 
				null, 
				SocleUtils.getContenuPrincipal(cat1));
		
		channel.getCategory("$id.plugin.socle.page-principale.cat").getAllReferrerSet();
		
		ContenuDeTest contenu = SocleDataInit.createPub("contenu", channel.getCategory("$id.plugin.socle.page-principale.cat"), cat1);
		
		assertEquals("SocleUtils.getContenuPrincipal avec une Category avec un contenu principal associé doit rendre ce contenu", 
				contenu, 
				SocleUtils.getContenuPrincipal(cat1));
		
		cat1.delete(admin);
		contenu.performDelete(admin);
	}
	
	@Test
	public void cleanNumberStringNominal() {			

		assertEquals("SocleUtils.cleanNumber(String) avec un String vide doit rendre un String vide", 
				"", 
				SocleUtils.cleanNumber(""));
		
		assertEquals("SocleUtils.cleanNumber(String) avec du texte doit rendre un String vide", 
				"", 
				SocleUtils.cleanNumber("texte"));
		
		assertEquals("SocleUtils.cleanNumber(String) avec un nombre pur doit rendre la String identique", 
				"40000", 
				SocleUtils.cleanNumber("40000"));
		
		assertEquals("SocleUtils.cleanNumber(String) avec un nombre avec d'autres caractères doit rendre le nombre pur", 
				"0240448512", 
				SocleUtils.cleanNumber("02 40-44-85 12"));
	}
	
	@Test
	public void cleanNumberArrayStringNominal() {
		
		Assert.assertArrayEquals("SocleUtils.cleanNumber(String[]) avec un Array vide doit rendre un Array vide", 
				new String[] {}, 
				SocleUtils.cleanNumber(new String[] {}));
		
		Assert.assertArrayEquals("SocleUtils.cleanNumber(String[]) avec des nombres avec d'autres caractères doit rendre les nombre purs", 
				new String[] {"", "", "40000", "0240448512"}, 
				SocleUtils.cleanNumber(new String[] {"", "texte", "40000", "02 40-44-85 12"}));
	}
	
	@Test
	public void formatDateNominal() {
		
		Calendar calendar = Calendar.getInstance();
		calendar.set(2020, 1, 14);
		Date date = calendar.getTime();
		
		assertEquals("SocleUtils.formatDate avec une date et un format vide retourne une String vide", 
				"", 
				SocleUtils.formatDate("", date));
		
		assertEquals("SocleUtils.formatDate avec une date et un format valide retourne une String contenant la date bien formatée", 
				"14/02/2020", 
				SocleUtils.formatDate("dd/MM/yyyy", date));
	}
	
	@Test
	public void formatAddressNominal() {
		
		assertEquals("SocleUtils.formatAddress avec que des String vide retourne une String vide", 
				"", 
				SocleUtils.formatAddress("", "", "", "", "", "", "", "", "", ""));
		
		assertEquals("SocleUtils.formatAddress avec des String remplis retourne une String bien formatée", 
				"libelle<br>etageCouloirEscalier<br>entreBatimentImmeuble<br>nDeVoie libelleDeVoie<br>lieuDit<br>CS cs<br>codePostal commune Cedex cedex", 
				SocleUtils.formatAddress("libelle", "etageCouloirEscalier", "entreBatimentImmeuble",
						"nDeVoie", "libelleDeVoie", "lieuDit", "cs", "codePostal", "commune", "cedex"));
	}
	
	@Test
	public void formatOpenStreetMapLinkTroisStringNominal() {
		
		assertEquals("SocleUtils.formatOpenStreetMapLink(String, String, String) avec que des String vide retourne une String vide", 
				"", 
				SocleUtils.formatOpenStreetMapLink("", "", ""));
		
		assertEquals("SocleUtils.formatOpenStreetMapLink(String, String, String) avec des String remplis retourne une url bien formatée", 
				"https://www.openstreetmap.org/directions?engine=graphhopper_car&route=5%2C45#map=10/5/45", 
				SocleUtils.formatOpenStreetMapLink("5", "45", "10"));
	}
	
	@Test
	public void formatOpenStreetMapLinkDeuxStringNominal() {
		
		assertEquals("SocleUtils.formatOpenStreetMapLink(String, String) avec que des String vide retourne une String vide", 
				"", 
				SocleUtils.formatOpenStreetMapLink("", ""));
		
		assertEquals("SocleUtils.formatOpenStreetMapLink(String, String) avec des String remplis retourne une url bien formatée", 
				"https://www.openstreetmap.org/directions?engine=graphhopper_car&route=5%2C45#map=11/5/45", 
				SocleUtils.formatOpenStreetMapLink("5", "45"));
	}
	
	@Test
	public void formatCategoriesNominal() {
		
		assertEquals("SocleUtils.formatCategories avec une liste vide retourne une String vide", 
				"", 
				SocleUtils.formatCategories(new TreeSet<Category>()));
		
		
		Category cat1 = SocleDataInit.createCategory("cat1", Channel.getChannel().getRootCategory());
		Category cat2 = SocleDataInit.createCategory("cat2", Channel.getChannel().getRootCategory());
		Category cat3 = SocleDataInit.createCategory("cat3", Channel.getChannel().getRootCategory());
		TreeSet<Category> listCat = new TreeSet<Category>();
		listCat.add(cat1);
		listCat.add(cat2);
		listCat.add(cat3);
		
		assertEquals("SocleUtils.formatCategories avec une liste de catégories retourne une String bien formaté", 
				"cat1, cat2, cat3", 
				SocleUtils.formatCategories(listCat));
		
		cat1.delete(admin);
		cat2.delete(admin);
		cat3.delete(admin);
	}
	
	@Test
	public void parseUrlNominal() {
		
		assertEquals("SocleUtils.parseUrl avec une String vide retourne une String vide", 
				"", 
				SocleUtils.parseUrl(""));
		
		assertEquals("SocleUtils.parseUrl avec une URL sans http retourne une URL avec https:// au début", 
				"https://google.fr", 
				SocleUtils.parseUrl("google.fr"));
		
		assertEquals("SocleUtils.parseUrl avec une URL avec https:// au début retourne une URL identique", 
				"https://google.fr", 
				SocleUtils.parseUrl("https://google.fr"));
	}
}
