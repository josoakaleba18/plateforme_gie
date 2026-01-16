# PRD – Product Requirements Document  
**GIE – Gestion Intégrée des Églises**  
**Version 1.0**  
**Date : 13 janvier 2026**  

## 1. Résumé Exécutif
La plateforme **GIE** est une application web bilingue (Français/Malagasy) visant à centraliser et automatiser la gestion administrative, matérielle, financière et logistique des structures ecclésiales malgaches organisées en hiérarchie (Région → Paroisse → Église → Cellule).  

**Objectif principal** : Remplacer les processus manuels (cahiers, Excel dispersés) par un système sécurisé, accessible en ligne, respectant strictement les rôles et la confidentialité des données.  

**Bénéficiaires** : Administrateurs régionaux, paroissiaux et responsables d’églises.  
**Valeur ajoutée** : Gain de temps, traçabilité, rapports automatiques, réduction des erreurs humaines.  

**Technologies** : Symfony 7 + API Platform (backend), React Vite + Tailwind CSS (frontend), MySQL, déploiement Hostinger.

## 2. Contexte & Problématique
Les églises malgaches gèrent quotidiennement :
- Membres, cellules, sacrements
- Finances (dîmes, dépenses)
- Matériels (inventaire périodique)
- Événements (paroissiaux tous les 3 mois, régionaux tous les 6 mois)
- Rapports consolidés vers niveau national

**Problèmes actuels** :
- Données dispersées (cahiers, fichiers Excel par église)
- Manque de visibilité et traçabilité
- Erreurs humaines fréquentes
- Pas de centralisation ni de rapports automatiques
- Pas d’accès contrôlé par rôle hiérarchique

**Solution proposée** : Une plateforme web unique, accessible selon rôle, avec calculs dynamiques et exports, imports automatisés.

## 3. Objectifs du Produit
**Objectif principal** :  
Centraliser et automatiser la gestion administrative des églises malgaches tout en respectant leur structure hiérarchique.

**Objectifs secondaires** :
- Permettre une gestion décentralisée des matériels (chaque église gère les siens)
- Automatiser les rapports consolidés (paroissial → régional → national)
- Garantir la sécurité et la confidentialité (accès restreint par rôle)
- Offrir une interface bilingue FR/MG intuitive
- Faciliter le déploiement sur hébergeur low-cost (Hostinger)

**KPIs de succès** :
- 80 % des responsables d’église utilisent la plateforme après 3 mois
- Temps de génération d’un rapport réduit de 4 h à < 5 min
- Zéro fuite de données sensibles (audit logs)

## 4. Personas & Utilisateurs
| Persona                        | Rôle                     | Besoins principaux                                                                 | Fréquence d’utilisation |
|--------------------------------|--------------------------|-------------------------------------------------------------------------------------|--------------------------|
| Admin Régional                 | Superviseur régional     | Vue globale, rapports consolidés, envoi national, gestion contacts                  | Quotidienne             |
| Admin Paroissial               | Superviseur paroissial   | Gestion églises, validation rapports, planification événements paroissiaux         | Quotidienne             |
| Responsable d’Église           | Gestionnaire local       | Gestion membres, cellules, sacrements, matériels, finances, inventaire             | Quotidienne             |

## 5. Fonctionnalités Prioritaires (MoSCoW)
### Must-have (obligatoires)
- Authentification JWT + rôles hiérarchiques
- CRUD membres (avec affectation postes)
- Enregistrement sacrements (baptême ≥14 ans, mariage mixte possible)
- Gestion matériels + inventaire périodique (InventaireMateriel + DetailInventaire)
- Transactions financières (recettes/dépenses) + solde calculé
- Planification événements (récurrence 3/6 mois)
- Rapports PDF dynamiques (consolidés par niveau)
- Envoi mail rapports depuis admin régional vers ContactNational
- Import/Export Excel (membres, transactions, inventaire)
- Interface bilingue FR/MG

### Should-have (fortement souhaitables)
- Dashboard par rôle (stats membres, solde, prochains événements)
- Thème clair/sombre
- Web responsive
- Notifications toast (succès/erreur)
- Historique modifications (audit logs)

### Could-have (si temps)
- Recherche avancée (membres par cellule, matériel par catégorie)
- Calendrier événements partagé
- Export CSV/Excel avancé

### Won't-have (V2)
- Gestion chorales, formations, dons en ligne
- Application mobile native

## 6. Règles de Gestion & Contraintes
- Un membre appartient à **une seule église** (optionnel : une cellule)
- Baptême : âge ≥ 14 ans (vérification automatique)
- Mariage : au moins un époux membre (époux2 nullable si mixte)
- Matériels : décentralisés (pas d’échange inter-églises)
- Inventaire : écarts calculés automatiquement (quantité réelle vs attendue)
- Rapports : dynamiques (jamais stockés), export PDF + mail régional
- Sécurité : accès strict par rôle (Voter Symfony)
- Performance : < 3 s chargement pages, support 200 utilisateurs simultanés

## 7. Non-Functional Requirements
- **Sécurité** : HTTPS, mots de passe hachés (bcrypt), JWT, logs audit
- **Performance** : Réponse API < 500 ms, import Excel jusqu’à 5000 lignes
- **Disponibilité** : 99 % (Hostinger)
- **Compatibilité** : Navigateurs récents (Chrome, Firefox, Edge)
- **Internationalisation** : Français/Malagasy (i18next)
- **Déploiement** : Hostinger (PHP 8.2+, MySQL 8+)
- **Documentation** : README + commentaires code + README déploiement

## 8. Roadmap & Priorisation
- **Sprint 1** : Auth + rôles + CRUD membres
- **Sprint 2** : Sacrements + matériels + inventaire
- **Sprint 3** : Finances + rapports PDF + mail
- **Sprint 4** : Frontend complet + tests + déploiement

**Version 1.0 – Approuvé pour développement** 
Date : 13 janvier 2026