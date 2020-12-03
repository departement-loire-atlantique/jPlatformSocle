# jPlatformSocle

<p>
  <a href="https://travis-ci.com/organizations/departement-loire-atlantique">
    <img src="https://travis-ci.com/departement-loire-atlantique/jPlatformSocle.svg?branch=master" />
  </a>
  <a href="https://sonarcloud.io/organizations/departement-loire-atlantique">
    <img src="https://sonarcloud.io/api/project_badges/measure?project=departement-loire-atlantique_jPlatformSocle&metric=ncloc" />
    <img src="https://sonarcloud.io/api/project_badges/measure?project=departement-loire-atlantique_jPlatformSocle&metric=bugs" />
    <img src="https://sonarcloud.io/api/project_badges/measure?project=departement-loire-atlantique_jPlatformSocle&metric=code_smells" />
    <img src="https://sonarcloud.io/api/project_badges/measure?project=departement-loire-atlantique_jPlatformSocle&metric=coverage" />
    <img src="https://sonarcloud.io/api/project_badges/measure?project=departement-loire-atlantique_jPlatformSocle&metric=duplicated_lines_density" />
    <img src="https://sonarcloud.io/api/project_badges/measure?project=departement-loire-atlantique_jPlatformSocle&metric=sqale_rating" />
    <img src="https://sonarcloud.io/api/project_badges/measure?project=departement-loire-atlantique_jPlatformSocle&metric=alert_status" />
    <img src="https://sonarcloud.io/api/project_badges/measure?project=departement-loire-atlantique_jPlatformSocle&metric=reliability_rating" />
    <img src="https://sonarcloud.io/api/project_badges/measure?project=departement-loire-atlantique_jPlatformSocle&metric=security_rating" />
    <img src="https://sonarcloud.io/api/project_badges/measure?project=departement-loire-atlantique_jPlatformSocle&metric=sqale_index" />
    <img src="https://sonarcloud.io/api/project_badges/measure?project=departement-loire-atlantique_jPlatformSocle&metric=vulnerabilities" />
    </a>
</p>

Ce module regroupe tous les types de contenu « socle éditorial » pour les sites JCMS du Département ainsi que les gabarits d'affichage associés.

Socle des contenus éditorial :

-	Accueil de rubrique (WelcomSection)
-	Article de rubrique (CollectivityArticle)
-	Article géolocalisé (ArticleGeolocalie)
-	Fiche lieux (Place)
- Fiche aide (Help)
-	Actualité (News)
-	Dossier d'actualités (Directory)
-	Carousel (Carousel)
-	Élément carrousel (CarouselElement)
-	Alerte (AlertCG)
-	Résultat de recherche (ResultatDeRecherche)
-	Chapitre de vidéo YouTube (Chapitre)

Un nouveau type de contenu "**VideoChapitree**" a été créée pour faciliter la saisie et fonctionner avec l'insertion unifiée.

**LE GABARIT EST A REVOIR : js inclus dans le corps de la JSP + bug si plusieurs vidéos ajoutées dans un article**

Socle des contenus représentant le découpage territorial (synchronisés entre tous les sites depuis le site institutionnel) :

-	Canton (Canton)
-	Délégation (Delegation)
-	Commune (City)
-	Commune hors département (CommuneHorsDepartement)
-	Élu (ElectedMember)

# Personnalisation de l'éditeur wysiwyg et des styles wysiwyg

Fichiers :
+ configuration-charteconfig.conf
+ configuration-styles.conf

=> Ajout du fichier configuration-charteconfig.conf pour surcharger les options de la configuration par defaut du wysiwyg.

Permet notamment de personnaliser la liste des types de blocs à appliquer au texte sélectionné (**paragraphe**, **titre 2-6**, **encadré**, **bouton**...)

=> Ajout du fichier configuration-styles.conf pour ajouter une liste de styles "**Formats**" à l'éditeur wysiwyg.

Permet de choisir le type style à appliquer (**h1/h2/h3/h4-like**, **bouton noir/vert/jaune**,...). Agit en complément de la liste des types de blocs.

Ex : je sélectionne mon texte puis je choisi "**En-tête 2**" dans la liste des blocs, puis je choisis "**h1-like**" dans la liste des formats.


Pour le rendu graphique en mode édition, la css du design system a été chargée.

Choix des boutons et fonctionalités : désactivation de H1 seulement.


**TODO** : revoir le style de l'encadré pour suivre les recon (div + classe css) >> Script si on change le code pour les encadrés (simple DIV)

+ Style utiles ?
+ Reprise des styles ?
+ Mieux comprendre comment faire des nouveaux styles
   
Désormais les liens vers les documents internes sont des jalios:link
=> migration des URLs possible (Question SEO ?) 

# Affichage de la topbar pour un groupe d'utilisateurs uniquement

L'affichage de la topbar est conditionné par l'appartenance à un groupe spécifique ("Groupe avec la topbar visible"). Si le groupe n'existe pas, il est créé via un ChannelListener.

# Désactivation des CSS et JS natifs

Les fichiers doEmptyHeader.jspf et doEmptyFooter.jspf sont surchargés (webapp-file) afin de désactiver les css et js natifs. 

Pour des raisons pratiques, on laisse ces ressources actives pour les membres ayant accès à la topbar (cf ci-dessus).

# Chargement des CSS et JS du design system

Les styles du design system sont chargés en tête, via la target **EMPTY_HEADER**

Les scripts du design system sont chargés en pied de page, via la target **EMPTY_FOOTER**

Ces ressources ne font pas partie du packer JPlatform.

# Tags personnalisés pour le design system

Nos utilisons la notion de fichiers "**.tag**" de la norme **JSP Taglibs 2.0** pour créer notre propre bibliothèque de composants.

Ce sont en fait des fichiers JSP à déposer sous "**WEB-INF/tags/**". Le serveur d'application les reconnait automatiquement.

Pour passer des variables à un tag depuis un gabarit par exemple, la bibliothèque **c.tld** (JSTL core) est nécessaire et doit être ajoutée à la section des taglibs dans le fichier **web.xml**. Nécessite églament la lib **taglibs-standard-impl-1.2.5.jar**.

# Gabarits personnalisés

Le module contient les gabarits d'affichage des différents types de contenus / portlets.

# Gabarits embed

Des exemples de gabarits "embed" ont été faits pour les articles de rubrique, les documents, et les vidéos chapitrées. C'est juste pour illustrer la notion d'insertion unifiée.

Ces gabarits seront à recharter.e

## TODO 

A quoi servent les interfaces (fr.cg44.plugin.socle.interfaces) ?

