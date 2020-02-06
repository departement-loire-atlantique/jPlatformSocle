package fr.cg44.plugin.junit.facettes;

import static org.junit.Assert.assertEquals;

import static fr.cg44.plugin.junit.facettes.SocleDataInit.createCity;
import static fr.cg44.plugin.junit.facettes.SocleDataInit.createCanton;
import static fr.cg44.plugin.junit.facettes.SocleDataInit.createFicheLieu;
import static fr.cg44.plugin.junit.facettes.SocleDataInit.createElu;
import static fr.cg44.plugin.junit.facettes.SocleDataInit.getResultSearchCity;

import java.util.HashSet;
import java.util.Set;

import org.junit.BeforeClass;
import org.junit.Test;

import com.jalios.jcms.Publication;
import com.jalios.jcms.test.JcmsTestCase4;

import generated.Canton;
import generated.City;
import generated.ElectedMember;
import generated.FicheLieu;

/**
 * Test unitaire de la classe PublicationFacetedSearchCityEnginePolicyFilter pour la ré-indexation complète (sur les communes)
 * Et de la classe CityQueryFilter pour la recherche sur le code commune
 */
public class SearchCityTest extends JcmsTestCase4  {

	/**
	 * TU 1 recherchePubDirectCommune
	 */
	// Création des communes sans canton
	static City city1_1 = createCity("Commune 1.1", 110);
	static City city1_2 = createCity("Commune 1.2", 120);
	// Création des fiches lieux sur commune 1.1
	static FicheLieu ficheLieu1_1 = createFicheLieu("FicheLieu 1.1", city1_1);
	static FicheLieu ficheLieu1_2 = createFicheLieu("FicheLieu 1.2", city1_1);
	// Création des fiches lieux sur commune 1.2
	static FicheLieu ficheLieu1_3 = createFicheLieu("FicheLieu 1.3", city1_2);
	
	/**
	 * TU 2 recherchePubRefCantonCommune
	 */
	// Création des cantons sans commune
	static Canton canton2_1 = createCanton("Canton 2.1");
	static Canton canton2_2 = createCanton("Canton 2.2");
	// Création des communes avec le canton 2.1
	static City city2_1 = createCity("Commune 2.1", 210, canton2_1);
	static City city2_2 = createCity("Commune 2.2", 220, canton2_1);
	// Création des communes avec le canton 2.2
	static City city2_3 = createCity("Commune 2.3", 230, canton2_2);
	// Fiche lieux sur canton 2.1
	static ElectedMember elu2_1 = createElu("FicheLieu 2.1", canton2_1);
	static ElectedMember elu2_2 = createElu("FicheLieu 2.2", canton2_1);
	// Fiche lieux sur canton 2.2
	static ElectedMember elu2_3 = createElu("FicheLieu 2.3", canton2_2);
	
	/**
	 * TU 3 recherchePubRefInverseCantonCommune
	 */
	// Commune sans canton
	static City city3_1 = createCity("Commune 3.1", 310);
	static City city3_2 = createCity("Commune 3.2", 320);
	// Canton sur commune 3.1
	static Canton canton3_1 = createCanton("Canton 3.1", city3_1);
	static Canton canton3_2 = createCanton("Canton 3.2", city3_1);
	// Canton sur commune 3.2
	static Canton canton3_3 = createCanton("Canton 3.3", city3_2);
	static Canton canton3_4 = createCanton("Canton 3.4", city3_2);
	// Fiche FicheLieu sur chaque canton
	static ElectedMember elu3_1 = createElu("FicheLieu 3.1", canton3_1);
	static ElectedMember elu3_2 = createElu("FicheLieu 3.2", canton3_2);
	static ElectedMember elu3_3 = createElu("FicheLieu 3.3", canton3_3);
	static ElectedMember elu3_4 = createElu("FicheLieu 3.4", canton3_4);
	
	/**
	 * TU 4 recherchePubRefDoubleCantonCommune
	 */
	// Commune
	static City city4_1 = createCity("Commune 4.1", 410);
	// Canton sur commune 4.1
	static Canton canton4_1 = createCanton("Canton 4.1", city4_1);
	static Canton canton4_2 = createCanton("Canton 4.2", city4_1);
	// Commune sur canton 4.2
	static City city4_2 = createCity("Commune 4.2", 420, canton4_1);
	// Fiche lieux
	static ElectedMember elu4_1 = createElu("FicheLieu 4.1", canton4_1);
	static ElectedMember elu4_2 = createElu("FicheLieu 4.2", canton4_2);
	
	
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
		// city 1.1 est référencée par : FicheLieu 1.1 et FicheLieu 1.2
		Set<Publication> resultatTestSet = new HashSet<Publication>();
		resultatTestSet.add(ficheLieu1_1);
		resultatTestSet.add(ficheLieu1_2);   	    
		assertEquals("Recherche sur commune 1.1 invalide", resultatTestSet, getResultSearchCity(city1_1));
	}

	@Test
	/**
	 * Test recherche sur commune 1.2
	 */
	public void recherchePubDirectCommune1_2() {
		// Recherche sur commune 1.2
		// city 1.2 est référencée par : FicheLieu 1.3
		Set<Publication> resultatTestSet = new HashSet<Publication>();
		resultatTestSet.add(ficheLieu1_3);    
		assertEquals("Recherche sur commune 1.2 invalide", resultatTestSet, getResultSearchCity(city1_2));
	}
	
		
	/*-----------------------------------------------------------------------------------/
	 * Test 2
	 * Elu -> Canton <- Commune
	 * Test de recherche sur des Elus
	 * Les Elus référencement indirectement la commune dans leur champ "canton" (le canton référence la commune)
	 * Chaque commune référence son canton (exemple réel : ((Commune) Saint-Lumine-de-Clisson, Clisson, Gétigné) -> ((Canton) Clisson) )
	 *-----------------------------------------------------------------------------------*/
	
	@Test
	/**
	 * Test recherche sur commune 2.1
	 */
	public void recherchePubRefCantonCommune2_1() {			
		// Recherche sur commune 2.1
		// city 2.1 est référencée par : FicheLieu 2.1 et FicheLieu 2.2
		Set<Publication> resultatTestSet = new HashSet<Publication>();
		resultatTestSet.add(elu2_1);
		resultatTestSet.add(elu2_2);   	    
	    assertEquals("Recherche sur commune 2.1 invalide", resultatTestSet, getResultSearchCity(city2_1));		    
	}
	
	@Test
	/**
	 * Test recherche sur commune 2.2
	 */
	public void recherchePubRefCantonCommune2_2() {			
		// Recherche sur commune 2.2
		// city 2.2 est référencée par : FicheLieu 2.1 et FicheLieu 2.2
		Set<Publication> resultatTestSet = new HashSet<Publication>();
		resultatTestSet.add(elu2_1);
		resultatTestSet.add(elu2_2);		    	    	    
	    assertEquals("Recherche sur commune 2.2 invalide", resultatTestSet, getResultSearchCity(city2_2));		    
	}
	
	@Test
	/**
	 * Test recherche sur commune 2.2
	 */
	public void recherchePubRefCantonCommune2_3() {			
		// Recherche sur commune 2.2
		// city 2.3 est référencée par : FicheLieu 2.3
		Set<Publication> resultatTestSet = new HashSet<Publication>();
		resultatTestSet.add(elu2_3);    	    
	    assertEquals("Recherche sur commune 2.3 invalide", resultatTestSet, getResultSearchCity(city2_3));		    
	}
	
			
	/*-----------------------------------------------------------------------------------/
	 * Test 3
	 * Fiche Lieux -> Canton -> Commune
	 * Test de recherche sur des fiches lieux
	 * Les élus référencement indirectement la commune dans leur champ "canton"
	 * La commune ne référence PAS son canton
	 * Le canton référence sa commune (exemple réel : ((Canton) Nantes 1, Nantes 2, nantes 3 etc.) -> ((Commune) Nantes) )
	 *-----------------------------------------------------------------------------------*/
	
	
	/**
	 * Test recherche sur commune 3.1
	 */
	@Test
	public void recherchePubRefInverseCantonCommune3_1() {		
		// Recherche sur commune 3.1
		// city 3.1 est référencée par : FicheLieu 3.1 et FicheLieu 3.2
		Set<Publication> resultatTestSet = new HashSet<Publication>();
		resultatTestSet.add(elu3_1);
		resultatTestSet.add(elu3_2);    	    
	    assertEquals("Recherche sur commune 3.1 invalide", resultatTestSet, getResultSearchCity(city3_1));	
	}
	
	
	/**
	 * Test recherche sur commune 3.2
	 */
	@Test
	public void recherchePubRefInverseCantonCommune3_2() {		
		// Recherche sur commune 3.2
		// city 3.2 est référencée par : FicheLieu 3.3 et FicheLieu 3.4
		Set<Publication> resultatTestSet = new HashSet<Publication>();
		resultatTestSet.add(elu3_3);
		resultatTestSet.add(elu3_4);   	    
	    assertEquals("Recherche sur commune 3.2 invalide", resultatTestSet, getResultSearchCity(city3_2));	
	}
	

	/*-----------------------------------------------------------------------------------/
	 * Test 4
	 * Elu -> Canton <-> Commune
	 * Test de recherche sur des élus
	 * Les élus référencement indirectement la commune dans leur champ "canton"
	 * La commune référence son canton et le canton référence une des ses commune (exemple réel : ((Canton) reze 1, reze 2) -> ((Commune) reze) ) ;  ((Commune) Brains, Bouaye) -> ((Canton) reze 1)
	 *-----------------------------------------------------------------------------------*/
	

	/**
	 * Test recherche sur commune 4.1
	 */
	@Test
	public void recherchePubRefDoubleCantonCommune4_1() {		
		// Recherche sur commune 4.1
		// city 4.1 (canton 4.1 et 4.2) est référencée par : FicheLieu 4.1 (canton 4.1) et FicheLieu 4.2 (canton 4.2)
		Set<Publication> resultatTestSet = new HashSet<Publication>();
		resultatTestSet.add(elu4_1);
		resultatTestSet.add(elu4_2);   	    
	    assertEquals(resultatTestSet, getResultSearchCity(city4_1));	
	}
		
		
	/**
	 * Test recherche sur commune 4.2
	 */
	@Test
	public void recherchePubRefDoubleCantonCommune4_2() {		
		// Recherche sur commune 4.2
		// city 4.2 (canton 4.1) est référencée par : FicheLieu 4.1
		Set<Publication> resultatTestSet = new HashSet<Publication>();
		resultatTestSet.add(elu4_1);    	    
	    assertEquals("Recherche sur commune 4.2 invalide", resultatTestSet, getResultSearchCity(city4_2));	
	}
	
}
