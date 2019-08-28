# jPlatformSocle

<p>
  <a href="https://travis-ci.org/organizations/departement-loire-atlantique">
    <img src="https://travis-ci.org/departement-loire-atlantique/jPlatformSocle.svg?branch=master" />
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

Socle des contenus représentant le découpage territorial (synchronisés entre tous les sites depuis le site institutionnel) :

-	Canton (Canton)
-	Délégation (Delegation)
-	Commune (City)
-	Commune hors département (CommuneHorsDepartement)
-	Élu (ElectedMember)

# Personnalisation de l'éditeur wysiwyg et des styles wysiwyg

Fichiers :
+ configuration-charteconfig.conf
+ wysiwyg.css


TODO : revoir le style de l'encadré pour suivre les recon (div + classe css) >> Script si on change le code pour les encadrés (simple DIV)
Style utiles ?
Reprise des styles ?
Mieux comprendre comment faire des nouveaux styles (exemple puor le message warning)
   
Désormais les liens vers les documents interne sont des jalios:link
=> migration des URLs possible (Question SEO ?)   




=> Ajout du fichier configuration-charteconfig.conf pour surcharger les options de la configuration par defaut du wysiwyg.


CSS pour rendu en back office :
Choix des styles pour les WYSIWYG (content_css: 'plugins/ChartePlugin/css/wysiwyg.css, css/jalios/core/fonts/webfont-roboto.css, css/jalios/core/font-icons.css,css/jalios/core/bootstrap.css,css/jalios/core/core.css,css/jalios/core/jalios-wysiwyg-editor.css,js/jalios/core/wysiwyg/plugins/mention/css/rte-content.css'

Choix des boutons et fonctionalités : désactivation de H1 seulement, le reste est par défaut

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

Pour passer des variables à un tag depuis un gabarit par exemple, la bibliothèque **c.tld** (JSTL core) est nécessaire et doit être ajoutée à la section des taglibs dans le fichier web.xml.

# Gabarits personnalisés

Le module contient les gabarits d'affichage des différents types de contenus / portlets.

## TODO 

A quoi servent les interfaces (fr.cg44.plugin.socle.interfaces) ?

