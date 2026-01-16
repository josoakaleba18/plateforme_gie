Projet **GIE – Gestion Intégrée des Églises**
-Titre : Dévéloppement d'une plateforme GIE
-Contexte : Les églises possèdent une organisation complexe comprenant plusieurs niveaux hiérarchiques (région, paroisse, église, cellule) et gèrent quotidiennement des informations variées : membres, finances, matériels, événements, sacrements, etc.
Cependant, ces données sont souvent dispersées ou traitées manuellement, ce qui entraîne un manque de cohérence, de visibilité et de traçabilité.
Le projet **GIE (Gestion Intégrée des Églises)** vise à centraliser toutes ces informations au sein d’une **plateforme web (bilingue (Français/Malagasy))**, accessible selon les rôles et responsabilités des utilisateurs.

---
-Hiérarchie et rôles d’utilisateurs
| Niveau hiérarchique | Rôle utilisateur | Portée d’action |
| **Région** | **Admin régional** | Gère toutes les paroisses, églises et utilisateurs. Consolide les données paroissiales, génére les rapports régionaux, envoie les rapports nationaux |
| **Paroisse** | **Admin paroissial** | Gère les églises et responsables sous sa paroisse. Suivre les activités des églises, ajouter remarques, synthétiser rapports paroissiaux |
| **Église** | **Responsable d’église** | Gère localement ses membres, cellules, finances, matériels |
| **Cellule** | Pas de rôle autonome. Gérée par l’église | Simple structure interne à l’église. |
----

-Modules de Gestion Principaux
1. Gestion des Personnes
* CRUD des **membres** : identité, contact, appartenance à une église.
* CRUD des **postes** (pré-définis : pasteur, diacre, trésorier, etc.).
* **Affectation des membres à un poste** (via une table d’affectation).
* Pas de “statut” — la responsabilité découle uniquement d’une affectation active.
* Possibilité de désaffecter ou d’affecter à nouveau à tout moment.
2. Gestion Matérielle (décentralisée)
Chaque église gère **ses propres matériels** :
* CRUD du matériel (nom, état, quantité, date d’acquisition,…)
* Aucun échange inter-églises.
* Possibilité de **recensement périodique** pour inventaire ou contrôle.
* L’admin paroissial et régional **consultent uniquement**.
3. Gestion Logistique
Deux événements majeurs :
* **Événement paroissial** (tous les 3 mois)
* **Événement régional** (tous les 6 mois)
Ces événements concernent la planification, l’utilisation des ressources
4.Gestion Financière
* Suivi des **recettes**, **dépenses**, et **soldes** par église.
* Consultation consolidée par paroisse et région.
* Rapports financiers automatiques à partir des données.
* Catégories de transactions (dîmes, dons, dépenses logistiques, etc.).
5.Rapports
Pas de soumission manuelle !
Le système permet :
* Génération automatique de rapports par niveau :
  * rapport paroissial → agrégation des données d’églises,
  * rapport régional → agrégation des données de paroisses.
  * Possibilité d’ajouter des remarques ou commentaires.
  * Export PDF.
  * **Envoi par mail** du rapport régional au **responsable national** (contact externe).
6.Communication Externe
  * CRUD de **contacts externes nationaux** (pour l’envoi de rapports).
  * Fonction **“Envoyer par mail”** depuis le module Rapport.
* L’admin régional peut donc :
  * choisir un contact national,
  * envoyer le rapport PDF généré par mail depuis l’application.
-Flux Global des Données
Église (données locales)
     ↓ (consultation directe)
Paroisse (agrégation + remarques)
     ↓ (consultation directe)
Région (agrégation finale)
     ↓ (export PDF + envoi mail)
National (contact externe)
NB : Aucun transfert technique de rapport, tout est **calculé dynamiquement** à partir de la base centralisée.
---
-Technologies envisagées :
* **Front-end :** React + Vite, Tailwind CSS, i18n (internationalisation)
* **Back-end :** Symfony 7 (PHP), API REST
* **Base de données :** MySQL
* **Méthodologie :** UML + méthode **2TUP**
* **Déploiement :** Hébergeur Hostinger
* **Gestion de code :** Git / GitHub


ANALYSE DES BESOINS : ce que le système doit faire et à qui il s’adresse.

1.Objectif général
L’application **GIE (Gestion Intégrée des Églises)** a pour but de centraliser et d’automatiser la gestion administrative, matérielle, logistique et financière des structures ecclésiales, tout en respectant leur hiérarchie (région → paroisse → église → cellule).
Elle doit permettre aux responsables de suivre les membres, les activités et les ressources matérielles/financières, dans un système bilingue (Français / Malagasy) et accessible en ligne.

2.Types d’utilisateurs et leurs besoins :
--Administrateur régional :
* Crée, modifie et supprime les **paroisses**, **églises**, et **comptes utilisateurs** associés.
* Supervise toutes les activités (financières, matérielles, membres, événements) des paroisses et églises de la région.
* Consulte les **rapports consolidés** et statistiques globales.
* Gère la **traduction et configuration générale** de l’application.
* Envoie rapports nationaux aux contacts externes.

--Administrateur paroissial :
* Gère les **églises** rattachées à sa paroisse.
* Supervise les **responsables d’église** et leurs activités.
* Valide ou commente les rapports financiers et matériels provenant des églises, ajoute remarques, synthétise rapports paroissiaux

--Responsable d’église :
* Gère les **membres** de son église (inscription, mise à jour, radiation).
* Gère les **cellules**, si elles existent dans son église.
* Enregistre les **sacrements** (baptême, mariage, bénédiction).
* Gère le **matériel**, les **transactions financières**
* Peut **exporter ou importer des fichiers Excel** (ex : membres, transactions).

3.Besoins fonctionnels principaux :

--Authentification et rôles :
   * Accès sécurisé selon le rôle et le niveau hiérarchique.
   * Gestion des comptes utilisateurs (création, modification, activation/désactivation).

--Gestion des membres :
   * Enregistrement, modification, suppression et recherche de membres.
   * Rattachement obligatoire à une église, optionnel à une cellule.
   * Affectation des membres à un poste (postes pré-définis dans la base de données) (via une table d’affectation).
   * Possibilité de désaffecter ou d’affecter à nouveau à tout moment.

--Gestion des sacrements :
   * Enregistrement du **baptême** (≥ 14 ans, avec baptiseur, date, lieu).
   * Enregistrement du **mariage** (époux1, époux2, pasteur, date, lieu, type).
   * Enregistrement de la **bénédiction (tso-drano)** (membre, pasteur, date, lieu).

--Gestion matérielle (décentralisée) :
   Chaque église gère **ses propres matériels** :
   * CRUD du matériel (nom, état, quantité, date d’acquisition,…)
   * Aucun échange inter-églises.
   * Possibilité de **recensement périodique** pour inventaire ou contrôle.
   * Indication de l’état (bon, endommagé, perdu) et quantité.
   * L’admin paroissial et régional **consultent uniquement**.

--Gestion logistique :
   * Planification d’événements majeurs
   * Consultation du calendrier des activités.
   * Utilisation des ressources

--Gestion financière :
   * Suivi des recettes, dépenses, soldes.
   * Consultation consolidée par paroisse et région.
   * Rapports financiers automatiques à partir des données.
   * Import/export des données financières en Excel.

--Multilingue :
   * Interface disponible en Français et en Malagasy.
   * Choix de la langue par l’utilisateur (préférences sauvegardées).

-REGLES DE GESTION : les contraintes, logiques métier et conditions qui régissent les fonctionnalités.

1.Rôles et hiérarchie :
* Un **admin régional** peut accéder à toutes les données de la région.
* Un **admin paroissial** ne voit que les églises de sa paroisse.
* Un **responsable d’église** ne gère que les données de sa propre église.
* Les **cellules** sont gérées uniquement par le responsable de l’église (pas de rôle utilisateur propre).

2.Gestion des membres :
* Un membre appartient **à une seule église**, mais peut être associé à **une cellule**.
* La date de naissance est obligatoire.
* L’âge doit être calculé automatiquement pour validation du baptême.

3.Sacrements :
* **Baptême :** autorisé uniquement si le membre a **≥ 14 ans**.
* **Mariage :** nécessite deux membres enregistrés (sauf si mariage mixte).
* **Bénédiction :** nécessite au moins un membre bénéficiaire et un pasteur (même non membre).
* Le **pasteur** peut être saisi manuellement (nom + région d’origine).

4.Finances :
* Chaque transaction appartient à **une église**.
* Les montants doivent être positifs.
* Les types de transaction sont limités à *recette*, *dépense*, *contribution*.
* Un rapport consolidé peut être généré par paroisse ou région.

5.Matériels :
* Chaque matériel est associé à une église.
* Le stock ne peut pas être négatif.
* Les états possibles : *bon*, *endommagé*, *hors service*.

6.Import/Export :
* L’importation des fichiers Excel doit être validée avant insertion définitive (prévisualisation possible).
* L’export respecte le format standard `.xlsx`.

7.Multilingue
* Tous les textes statiques de l’interface sont traduits (via fichiers i18n).
* La langue par défaut est le **Français**, mais l’utilisateur peut la changer.

-Besoins non fonctionnels :
Ces besoins définissent **la qualité du système**, ses performances, sa sécurité, son ergonomie et sa maintenabilité.
Ils sont aussi importants que les besoins fonctionnels, car ils déterminent la **robustesse et la durabilité** de l’application.

1.Sécurité :
--Authentification & autorisation
   * L’accès à l’application nécessite une **connexion sécurisée** (identifiant + mot de passe).
   * Les mots de passe sont **hachés (bcrypt)** dans la base de données.
   * Les actions et données visibles dépendent strictement du **rôle utilisateur** (admin régional, admin paroissial, responsable d’église).
   * La création de comptes Utilisateur est réservée aux administrateurs supérieurs (régional crée paroissial, paroissial crée église).
   * À la création, un code temporaire (6-8 caractères) et un lien d’activation unique sont générés automatiquement et envoyés par email à l’utilisateur.
   * Ce lien/code expire après 24 heures. Lors de la première connexion, l’utilisateur définit son mot de passe définitif via ce lien/code.

--Protection des données
   * Les communications client-serveur doivent être sécurisées (HTTPS lors du déploiement).
   * Les données sensibles (emails, mots de passe, transactions) ne doivent pas être exposées dans les requêtes.
   * Journalisation (logs) des actions importantes (connexion, suppression, export, etc.).

--Gestion des sessions:
   * Déconnexion automatique après une période d’inactivité.
   * Prévention du double login sur plusieurs appareils (optionnel).

2.Performance et fiabilité :
--Le système doit supporter **au moins 200 utilisateurs simultanés** sans dégradation notable.
--Le chargement des pages principales doit se faire en **moins de 3 secondes** sur une connexion moyenne.
--L’application doit pouvoir être **hébergée facilement sur Hostinger** avec base MySQL distante.
--Les opérations d’import/export Excel doivent être optimisées pour **au moins 5000 lignes**.
--Les sauvegardes automatiques de la base de données sont prévues (quotidiennes ou hebdomadaires).

3.Ergonomie et expérience utilisateur :
--Interface **bilingue (Français / Malagasy)** avec bascule instantanée.
--Design moderne, simple, mode clair/sombre grâce à **Tailwind CSS + React Vite**.
--Accessibilité adaptée aux écrans d’ordinateurs, tablettes et smartphones.
--Tableau de bord personnalisé selon le rôle de l’utilisateur.
--Notifications et alertes visuelles pour les actions réussies, erreurs ou rappels.
--Navigation intuitive avec barre latérale, recherche rapide et pagination.--
--
4.Maintenabilité et extensibilité :
--Le code doit être **structuré par modules** (MVC côté Symfony, composants côté React).
--La base de données doit être normalisée (au moins 3ᵉ forme normale).
--Le code doit être **versionné sur GitHub** avec branches de développement claires.
--L’architecture doit permettre **l’ajout futur de nouveaux modules** (ex. gestion des chorales, formation, etc.).
--Une **documentation technique** (PDF ou Wiki GitHub) doit accompagner le projet.

5.Compatibilité et déploiement :
--Compatible avec les navigateurs récents : Chrome, Edge, Firefox.
--Fonctionne sur les serveurs **PHP 8.2+**, **Symfony 7**, et **MySQL 8+**.
--Déploiement prévu sur **Hostinger** avec gestion de domaine (ex : gie.mg ou giechurch.org).

6.Sauvegarde et continuité :
--Sauvegarde automatique de la base MySQL (fichier `.sql`) via CRON.
--Possibilité de restaurer manuellement une version précédente de la base.
--Export des rapports et sauvegardes locales en Excel ou PDF.
--Un fichier `.env` gère la configuration de connexion (base, langue, etc.) sans exposition publique.

6.Internationalisation (i18n) :
--Tous les libellés et les menus sont gérés via des **fichiers de traduction JSON**.
--L’utilisateur choisit la langue (FR/MG) au premier accès ou via un menu de préférence.
--La langue est conservée dans la session ou le profil utilisateur.
