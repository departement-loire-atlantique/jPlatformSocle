package fr.cg44.plugin.junit.socle;

import static org.junit.Assert.assertEquals;

import java.util.TreeSet;

import org.junit.Assert;
import org.junit.Test;

import com.jalios.jcms.Category;
import com.jalios.jcms.Channel;
import com.jalios.jcms.test.JcmsTestCase4;

import fr.cg44.plugin.junit.facettes.SocleDataInit;
import fr.cg44.plugin.socle.SocleUtils;

public class SocleUtilsTest extends JcmsTestCase4 {

	
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
	public void formatAddressNominal() {
		
		assertEquals("SocleUtils.formatAddressNominal avec que des String vide retourne une String vide", 
				"", 
				SocleUtils.formatAddress("", "", "", "", "", "", "", "", "", ""));
		
		assertEquals("SocleUtils.formatAddressNominal avec des String remplis retourne une String bien formaté", 
				"libelle<br>etageCouloirEscalier<br>entreBatimentImmeuble<br>nDeVoie libelleDeVoie<br>lieuDit<br>CS cs<br>codePostal commune Cedex cedex", 
				SocleUtils.formatAddress("libelle", "etageCouloirEscalier", "entreBatimentImmeuble",
						"nDeVoie", "libelleDeVoie", "lieuDit", "cs", "codePostal", "commune", "cedex"));
	}
	
	@Test
	public void formatOpenStreetMapLinkTroisStringNominal() {
		
		assertEquals("SocleUtils.formatOpenStreetMapLink(String, String, String) avec que des String vide retourne une String vide", 
				"", 
				SocleUtils.formatOpenStreetMapLink("", "", ""));
		
		assertEquals("SocleUtils.formatOpenStreetMapLink(String, String, String) avec des String remplis retourne une url bien formaté", 
				"https://www.openstreetmap.org/directions?engine=graphhopper_car&route=5%2C45#map=10/5/45", 
				SocleUtils.formatOpenStreetMapLink("5", "45", "10"));
	}
	
	@Test
	public void formatOpenStreetMapLinkDeuxStringNominal() {
		
		assertEquals("SocleUtils.formatOpenStreetMapLink(String, String) avec que des String vide retourne une String vide", 
				"", 
				SocleUtils.formatOpenStreetMapLink("", ""));
		
		assertEquals("SocleUtils.formatOpenStreetMapLink(String, String) avec des String remplis retourne une url bien formaté", 
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
