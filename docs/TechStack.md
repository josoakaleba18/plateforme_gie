# Tech Stack – Technologies Utilisées  
**Projet GIE – Gestion Intégrée des Églises**  
**Version 1.0 – Janvier 2026**

## 1. Vue d'ensemble
Le projet GIE est une application web full-stack moderne, bilingue (Français / Malagasy), sécurisée et responsive, conçue pour répondre aux besoins de gestion hiérarchique des structures ecclésiales malgaches.

L'architecture suit le modèle **API REST + Frontend SPA** (Single Page Application), avec une séparation claire entre backend et frontend.

## 2. Backend
| Technologie                  | Version    | Rôle / Justification                                                                 |
|------------------------------|------------|---------------------------------------------------------------------------------------|
| **Symfony**                  | 7.x        | Framework PHP principal – robuste, mature, MVC, très utilisé en entreprise           |
| **API Platform**             | 3.x        | Génération automatique d'API REST (CRUD, filtres, pagination, documentation OpenAPI) |
| **Doctrine ORM**             | 3.x        | Gestion des entités, migrations et relations avec MySQL                              |
| **LexikJWTAuthenticationBundle** | 3.x    | Authentification JWT sécurisée + gestion des rôles                                   |
| **KnpSnappyBundle**          | 1.x        | Génération de rapports PDF (basé sur wkhtmltopdf)                                    |
| **PhpSpreadsheet**           | 2.x        | Import/Export Excel pour membres, transactions et inventaires                       |
| **Symfony Mailer**           | 7.x        | Envoi d’emails pour rapports régionaux vers contacts nationaux                       |
| **PHP**                      | 8.2+       | Version minimale requise pour Symfony 7                                              |

**Serveur & Déploiement**  
- Hébergement : **Hostinger** (PHP 8.2+, MySQL 8+)  
- Serveur local de développement : **Symfony local server** (`symfony serve`)  
- Serveur de production : Apache (via Hostinger)

## 3. Frontend
| Technologie                  | Version    | Rôle / Justification                                                                 |
|------------------------------|------------|---------------------------------------------------------------------------------------|
| **React**                    | 18.x       | Bibliothèque JavaScript pour interfaces dynamiques et réactives                      |
| **Vite**                     | 5.x        | Bundler ultra-rapide pour le développement et la production                         |
| **JavaScript**               | ES2022+    | Langage principal (sans TypeScript)		                                   |
| **Tailwind CSS**             | 3.x        | Framework CSS utilitaire pour un design rapide et personnalisable                    |
| **daisyUI**                  | 4.x        | Composants prêts à l’emploi basés sur Tailwind (boutons, modals, thèmes)            |
| **i18next**                  | 23.x       | Internationalisation (bilingue FR/MG)                                                |
| **Axios**                    | 1.x        | Client HTTP pour appels API avec gestion JWT et interceptors                        |
| **React Router**             | 6.x        | Gestion des routes et navigation SPA                                                |
| **Zustand**                  | 4.x        | Gestion d’état légère (user, rôle, langue, thème)                                   |

**Serveur de développement** : Vite (`npm run dev`)  
**Build de production** : `npm run build` → dossier `dist` déployé sur Hostinger

## 4. Base de données
| Technologie                  | Version    | Justification                                                                        |
|------------------------------|------------|---------------------------------------------------------------------------------------|
| **MySQL**                    | 8.x        | SGBDR relationnel performant, supporté par Hostinger et XAMPP                       |
| **phpMyAdmin**               | (via XAMPP) | Administration locale de la base pendant le développement                           |

## 5. Outils de développement & Qualité
- **IDE** : **Cursor AI** (fork de VS Code avec IA intégrée)
- **Gestion de versions** : **Git + GitHub** (repo privé `plateforme-gie`)
- **Tests** : PHPUnit (backend), Jest + React Testing Library (frontend)
- **Documentation** : README.md + commentaires code en français
- **Déploiement** : Hostinger (FTP, SSH, cron jobs)

## 6. Contraintes & Choix techniques
- Pas de TypeScript (Javascript pur)
- Déploiement low-cost (Hostinger)
- Performance : < 3 s de chargement pages
- Sécurité : HTTPS, JWT, hachage bcrypt, Voter pour hiérarchie
- Bilingue : tous les libellés traduits via i18next

**Ce stack a été choisi pour sa maturité, sa facilité de maintenance et son adéquation avec les exigences académiques et professionnelles.**

Fin du document Tech Stack – Projet GIE  
[Date : 13 janvier 2026]  