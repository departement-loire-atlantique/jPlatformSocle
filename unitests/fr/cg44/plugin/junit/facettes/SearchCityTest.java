package fr.cg44.plugin.junit.facettes;

import static org.junit.Assert.assertEquals;

import static fr.cg44.plugin.junit.facettes.SocleDataInit.createCity;
import static fr.cg44.plugin.junit.facettes.SocleDataInit.createCanton;
import static fr.cg44.plugin.junit.facettes.SocleDataInit.createDelegation;
import static fr.cg44.plugin.junit.facettes.SocleDataInit.createPub;
import static fr.cg44.plugin.junit.facettes.SocleDataInit.createCategoryEpci;
import static fr.cg44.plugin.junit.facettes.SocleDataInit.getResultSearchCity;

import java.util.HashSet;
import java.util.Set;

import org.junit.BeforeClass;
import org.junit.Test;

import com.jalios.jcms.Category;
import com.jalios.jcms.Publication;
import com.jalios.jcms.test.JcmsTestCase4;

import generated.Canton;
import generated.City;
import generated.Delegation;
import generated.ContenuDeTest;

/**
 * Test unitaire de la classe PublicationFacetedSearchCityEnginePolicyFilter pour la ré-indexation complète (sur les communes)
 * Et de la classe CityQueryFilter pour la recherche sur le code commune
 */
public class SearchCityTest extends JcmsTestCase4  {

	/**
	 * TU 1 recherchePubDirectCommune -> indexCommune
	 * Test 2 : Publications reliées à une commune
	 */
	// Création des communes sans canton
	static City city1_1 = createCity("Commune 1.1", 110);
	static City city1_2 = createCity("Commune 1.2", 120);
	// Création des fiches lieux sur commune 1.1
	static ContenuDeTest pub1_1 = createPub("ContenuDeTest 1.1", city1_1);
	static ContenuDeTest pub1_2 = createPub("ContenuDeTest 1.2", city1_1);
	// Création des fiches lieux sur commune 1.2
	static ContenuDeTest pub1_3 = createPub("ContenuDeTest 1.3", city1_2);
	
	/**
	 * TU 2 recherchePubRefCantonCommune -> indexCommunesDuCanton
	 * Test 2 : Publications reliées à un canton
	 */
	// Création des cantons
	static Canton canton2_1 = createCanton("Canton 2.1");
	static Canton canton2_2 = createCanton("Canton 2.2");
	// Création des communes avec le canton 2.1
	static City city2_1 = createCity("Commune 2.1", 210, canton2_1);
	static City city2_2 = createCity("Commune 2.2", 220, canton2_1);
	// Création des communes avec le canton 2.2
	static City city2_3 = createCity("Commune 2.3", 230, canton2_2);
	// Fiche lieux sur canton 2.1
	static ContenuDeTest pub2_1 = createPub("ContenuDeTest 2.1", canton2_1);
	static ContenuDeTest pub2_2 = createPub("ContenuDeTest 2.2", canton2_1);
	// ContenuDeTest sur canton 2.2
	static ContenuDeTest pub2_3 = createPub("ContenuDeTest 2.3", canton2_2);
	
	
	/**
	 * TU 3 recherchePubRefCantonsCommune -> indexCommunesDesCantons
	 * Test 3 : Publications reliées à plusieurs cantons
	 */
	// Création des cantons
	static Canton canton3_1 = createCanton("Canton 3.1");
	static Canton canton3_2 = createCanton("Canton 3.2");
	static Canton canton3_3 = createCanton("Canton 3.3");
	// Création des communes
	static City city3_1 = createCity("Commune 3.1", 310, canton3_1);
	static City city3_2 = createCity("Commune 3.2", 320, canton3_2);
	static City city3_3 = createCity("Commune 3.3", 330, canton3_3);
	// Fiche lieux sur canton 3.1 et 3.2
	static ContenuDeTest pub3_1 = createPub("ContenuDeTest 3.1", canton3_1, canton3_2);
	
	
	/**
	 * TU 5 recherchePubRefEpciCommune -> indexCommunesDesEPCI
	 * Test 5 : Publications reliées à plusieurs EPCI
	 */
	// Création des EPCI
	static Category epci5_1 = createCategoryEpci("epci5_1");
	static Category epci5_2 = createCategoryEpci("epci5_2");
	static Category epci5_3 = createCategoryEpci("epci5_3");
	// Création des communes sur l EPCI 5.1
	static City city5_1 = createCity("Commune 5.1", 510, epci5_1);
	static City city5_2 = createCity("Commune 5.2", 520, epci5_1);
	static City city5_3 = createCity("Commune 5.3", 530, epci5_1, epci5_3);
	// Création des communes sur l EPCI 5.2
	static City city5_4 = createCity("Commune 5.4", 540, epci5_2);
	static City city5_5 = createCity("Commune 5.5", 550, epci5_2);
	static City city5_6 = createCity("Commune 5.6", 560, epci5_2);
	// Fiche lieux sur l'EPCI 5.1
	static ContenuDeTest pub5_1 = createPub("ContenuDeTest 5.1", epci5_1);
	// Fiche lieux sur l'EPCI 5.2
	static ContenuDeTest pub5_2 = createPub("ContenuDeTest 5.2", epci5_2);
	// Fiche lieux sur l'EPCI 5.1 et 5.2
	static ContenuDeTest pub5_3 = createPub("ContenuDeTest 5.3", epci5_1, epci5_2);
	// Fiche lieux sur l'EPCI 5.3
	static ContenuDeTest pub5_4 = createPub("ContenuDeTest 5.4", epci5_3);
	
	
	/**
	 * TU 6 recherchePubDirectCommunes -> indexCommunes
	 * Test 6 : Publications reliées à plusieurs communes
	 */
	// Création des communes
	static City city6_1 = createCity("Commune 6.1", 610);
	static City city6_2 = createCity("Commune 6.2", 620);
	static City city6_3 = createCity("Commune 6.3", 630);
	static City city6_4 = createCity("Commune 6.4", 640);
	static City city6_5 = createCity("Commune 6.5", 650);
	static City city6_6 = createCity("Commune 6.6", 660);
	// Fiche lieux
	static ContenuDeTest pub6_1 = createPub("ContenuDeTest 6.1", new City[] {city6_1, city6_2, city6_3, city6_4});
	static ContenuDeTest pub6_2 = createPub("ContenuDeTest 6.2", new City[] {city6_4, city6_5, city6_6});

	
	/**
	 * TU 7 recherchePubRefDelegationsCommune -> indexCommunesDesDelegations
	 * Test 7 : Publications reliées à plusieurs délégations
	 */
	// Création des délégations
	static Delegation delegation7_1 = createDelegation("Delegation 7.1");
	static Delegation delegation7_2 = createDelegation("Delegation 7.2");
	static Delegation delegation7_3 = createDelegation("Delegation 7.3");
	// Création des communes
	static City city7_1 = createCity("Commune 7.1", 710, delegation7_1);
	static City city7_2 = createCity("Commune 7.2", 720, delegation7_2);
	static City city7_3 = createCity("Commune 7.3", 730, delegation7_3);
	// Fiche lieux sur delegation 3.1 et 3.2
	static ContenuDeTest pub7_1 = createPub("ContenuDeTest 7.1", delegation7_1, delegation7_2);
	
	
	/**
	 * Création des données de test pour chaque test unitaire
	 */
	@BeforeClass
	public static void avantTest() {			
		// L'indexation des publications ayant lieu de manière asynchrone dans un thread dédié.
		// la recherche textuelle d'une publication immédiatement après sa création pourrait ne pas renvoyer de résultat.
		// Il est alors nécessaire de faire appel à une temporisation.
		try { Thread.sleep(1000); } catch(Exception ex) { }		
	}
		 
	
	/*-----------------------------------------------------------------------------------/
	 * Test 1
	 * Fiche lieux -> Commune
	 * Test de recherche sur des fiches lieux
	 * Les fiches lieux référencement directement la commune dans leur champ "commune"
	 *-----------------------------------------------------------------------------------*/

	@Test
	/**
	 * Test recherche sur commune 1.1
	 */
	public void recherchePubDirectCommune1_1() {			
		// Recherche sur commune 1.1
		// city 1.1 est référencée par : ContenuDeTest 1.1 et ContenuDeTest 1.2
		Set<Publication> resultatTestSet = new HashSet<Publication>();
		resultatTestSet.add(pub1_1);
		resultatTestSet.add(pub1_2);   	    
		assertEquals("Recherche sur commune 1.1 invalide", resultatTestSet, getResultSearchCity(city1_1));
	}

	@Test
	/**
	 * Test recherche sur commune 1.2
	 */
	public void recherchePubDirectCommune1_2() {
		// Recherche sur commune 1.2
		// city 1.2 est référencée par : ContenuDeTest 1.3
		Set<Publication> resultatTestSet = new HashSet<Publication>();
		resultatTestSet.add(pub1_3);    
		assertEquals("Recherche sur commune 1.2 invalide", resultatTestSet, getResultSearchCity(city1_2));
	}
	
		
	/*-----------------------------------------------------------------------------------/
	 * Test 2
	 * ContenuDeTest -> Canton <- Commune
	 * Test de recherche sur des ContenuDeTests
	 * Les ContenuDeTests référencement indirectement la commune dans leur champ "canton" (le canton référence la commune)
	 * Chaque commune référence son canton (exemple réel : ((Commune) Saint-Lumine-de-Clisson, Clisson, Gétigné) -> ((Canton) Clisson) )
	 *-----------------------------------------------------------------------------------*/
	
	@Test
	/**
	 * Test recherche sur commune 2.1
	 */
	public void recherchePubRefCantonCommune2_1() {			
		// Recherche sur commune 2.1
		// city 2.1 est référencée par : ContenuDeTest 2.1 et ContenuDeTest 2.2
		Set<Publication> resultatTestSet = new HashSet<Publication>();
		resultatTestSet.add(pub2_1);
		resultatTestSet.add(pub2_2);   	    
	    assertEquals("Recherche sur commune 2.1 invalide", resultatTestSet, getResultSearchCity(city2_1));		    
	}
	
	@Test
	/**
	 * Test recherche sur commune 2.2
	 */
	public void recherchePubRefCantonCommune2_2() {			
		// Recherche sur commune 2.2
		// city 2.2 est référencée par : ContenuDeTest 2.1 et ContenuDeTest 2.2
		Set<Publication> resultatTestSet = new HashSet<Publication>();
		resultatTestSet.add(pub2_1);
		resultatTestSet.add(pub2_2);		    	    	    
	    assertEquals("Recherche sur commune 2.2 invalide", resultatTestSet, getResultSearchCity(city2_2));		    
	}
	
	@Test
	/**
	 * Test recherche sur commune 2.2
	 */
	public void recherchePubRefCantonCommune2_3() {			
		// Recherche sur commune 2.2
		// city 2.3 est référencée par : ContenuDeTest 2.3
		Set<Publication> resultatTestSet = new HashSet<Publication>();
		resultatTestSet.add(pub2_3);    	    
	    assertEquals("Recherche sur commune 2.3 invalide", resultatTestSet, getResultSearchCity(city2_3));		    
	}
	
	
	/*-----------------------------------------------------------------------------------/
	 * Test 3 : Publication reliées à plusieurs cantons
	 * Fiche lieux -> Cantons <- Commune
	 * Test de recherche sur des Fiche lieux
	 * Les Fiche lieux référencement indirectement des communes dans leur champ "cantons" 
	 *-----------------------------------------------------------------------------------*/
	
	@Test
	/**
	 * Test recherche sur commune 3.1, 3.2 et 3.3
	 */
	public void recherchePubRefCantonsCommune() {			
		Set<Publication> resultatTestSet = new HashSet<Publication>();
		resultatTestSet.add(pub3_1);    
	    assertEquals("Recherche sur commune 3.1 invalide", resultatTestSet, getResultSearchCity(city3_1));	
	    assertEquals("Recherche sur commune 3.2 invalide", resultatTestSet, getResultSearchCity(city3_2));
	    resultatTestSet.clear();
	    assertEquals("Recherche sur commune 3.3 invalide", resultatTestSet, getResultSearchCity(city3_3));
	    
	}
	
	
	/*-----------------------------------------------------------------------------------/
	 * Test 4 : Publication reliées à toutes les communes
	 * Fiche lieux -> toutes les communes
	 * Test de recherche sur des Fiche lieux
	 *-----------------------------------------------------------------------------------*/
	
	@Test
	/**
	 * Test recherche sur commune 4.1 et 4.2 et 4.3
	 */
	public void recherchePubToutesCommune() {	
		
		/**
		 * Création d'un contenu indéxé sur toute les communes
		 * Création isolé dans le test car impact les autres tests
		 */
		// Création d'une communes avec le canton 3.1
		City city4_1 = createCity("Commune 4.1", 410);
		// Création d'une communes avec le canton 3.2
		City city4_2 = createCity("Commune 4.2", 420);
		// Création d'une communes avec le canton 3.3
		City city4_3 = createCity("Commune 4.3", 430);
		// Fiche lieux sur canton 3.1 et 3.2
		ContenuDeTest pub4_1 = createPub("ContenuDeTest 4.1", null, null, true, new Category[] {}, new Delegation[] {});	
		
		avantTest();
		
		// Recherche sur commune 3.1
		// city 3.1 est référencée par : ContenuDeTest 3.1
		Set<Publication> resultatTestSet = new HashSet<Publication>();
		resultatTestSet.add(pub4_1);    
	    assertEquals("Recherche sur commune 4.1 invalide", resultatTestSet, getResultSearchCity(city4_1));	
	    assertEquals("Recherche sur commune 4.2 invalide", resultatTestSet, getResultSearchCity(city4_2));
	    assertEquals("Recherche sur commune 4.3 invalide", resultatTestSet, getResultSearchCity(city4_3));	
	    
	    // Supprime le contenu indexé sur toutes les communes
	    city4_1.performDelete(channel.getDefaultAdmin());
	    city4_2.performDelete(channel.getDefaultAdmin());
	    city4_3.performDelete(channel.getDefaultAdmin());
	    pub4_1.performDelete(channel.getDefaultAdmin());	    
	}
	
	
	/*-----------------------------------------------------------------------------------/
	 * Test 5 : Publication reliées à des EPCI
	 * Fiche lieux -> EPCI <- Commune
	 * Test de recherche sur des Fiche lieux
	 * Les Fiche lieux référencement indirectement des communes dans leur champ "EPCI" 
	 *-----------------------------------------------------------------------------------*/
	
	@Test
	/**
	 * Test recherche sur communes
	 */
	public void recherchePubRefEpciCommune() {			
		// Recherche sur commune 5.1, 5.2 et 5.3
		Set<Publication> resultatTestSet = new HashSet<Publication>();
		resultatTestSet.add(pub5_1);
		resultatTestSet.add(pub5_3);	    
	    assertEquals("Recherche sur commune 5.1 invalide", resultatTestSet, getResultSearchCity(city5_1));
	    assertEquals("Recherche sur commune 5.2 invalide", resultatTestSet, getResultSearchCity(city5_2));
	    resultatTestSet.add(pub5_4);
	    assertEquals("Recherche sur commune 5.3 invalide", resultatTestSet, getResultSearchCity(city5_3));
	    // Recherche sur commune 5.4, 5.5 et 5.6
	    resultatTestSet.clear();
	    resultatTestSet.add(pub5_2);
	    resultatTestSet.add(pub5_3);
	    assertEquals("Recherche sur commune 5.4 invalide", resultatTestSet, getResultSearchCity(city5_4));
	    assertEquals("Recherche sur commune 5.5 invalide", resultatTestSet, getResultSearchCity(city5_5));
	    assertEquals("Recherche sur commune 5.6 invalide", resultatTestSet, getResultSearchCity(city5_6));	    
	}
	
	
	/*-----------------------------------------------------------------------------------/
	 * Test 6 : Publication reliées à plusieurs communes
	 * Fiche lieux -> Communes
	 *-----------------------------------------------------------------------------------*/
	
	@Test
	/**
	 * Test recherche sur commune avec contenu rataché à des EPCI
	 */
	public void recherchePubDirectCommunes() {			
		// Recherche sur commune 6.1, 6.2 et 6.3
		Set<Publication> resultatTestSet = new HashSet<Publication>();
		resultatTestSet.add(pub6_1);
	    assertEquals("Recherche sur commune 6.1 invalide", resultatTestSet, getResultSearchCity(city6_1));
	    assertEquals("Recherche sur commune 6.2 invalide", resultatTestSet, getResultSearchCity(city6_2));
	    assertEquals("Recherche sur commune 6.3 invalide", resultatTestSet, getResultSearchCity(city6_3));
	    // Recherche sur commune 6.5 et 6.6
	    resultatTestSet.clear();
	    resultatTestSet.add(pub6_2);
	    assertEquals("Recherche sur commune 6.5 invalide", resultatTestSet, getResultSearchCity(city6_5));
	    assertEquals("Recherche sur commune 6.6 invalide", resultatTestSet, getResultSearchCity(city6_6));
	    // Recherche sur commune 6.4
	    resultatTestSet.clear();
	    resultatTestSet.add(pub6_1);
	    resultatTestSet.add(pub6_2);
	    assertEquals("Recherche sur commune 6.4 invalide", resultatTestSet, getResultSearchCity(city6_4));
	}
	
	
	/*-----------------------------------------------------------------------------------/
	 * Test 7 : Publication reliées à plusieurs délégation
	 * Fiche lieux -> délégations <- Commune
	 * Test de recherche sur des Fiche lieux
	 * Les Fiche lieux référencement indirectement des communes dans leur champ "délégations" 
	 *-----------------------------------------------------------------------------------*/
	
	@Test
	/**
	 * Test recherche sur commune 3.1 et 3.2
	 */
	public void recherchePubRefDelegationsCommune() {			
		Set<Publication> resultatTestSet = new HashSet<Publication>();
		resultatTestSet.add(pub7_1);    
	    assertEquals("Recherche sur commune 3.1 invalide", resultatTestSet, getResultSearchCity(city7_1));	
	    assertEquals("Recherche sur commune 3.2 invalide", resultatTestSet, getResultSearchCity(city7_2));
	    resultatTestSet.clear();
	    assertEquals("Recherche sur commune 3.3 invalide", resultatTestSet, getResultSearchCity(city7_3));
	}
	
	
}
