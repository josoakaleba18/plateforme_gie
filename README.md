# GIE – Gestion Intégrée des Églises
**Plateforme web bilingue (Français/Malagasy) pour la gestion hiérarchique des structures ecclésiales malgaches**  
Région - Paroisse - Église - Cellule - Membre

## Aperçu
GIE est une application web sécurisée et responsive développée dans le cadre d'un mémoire de fin d'études (Licence Professionnelle en Informatique – Parcours Génie Logiciel et Base de Données, ENI Fianarantsoa).

**Objectif** : Centraliser la gestion des membres, finances, matériels, sacrements, événements et rapports, avec une hiérarchie stricte (Régional > Paroissial > Église) et une interface bilingue FR/MG.

**Stack** :
- Backend : Symfony 7 + API Platform + MySQL
- Frontend : React Vite + JavaScript pur + Tailwind CSS + daisyUI
- Auth : JWT + rôles hiérarchiques
- Déploiement : Hostinger

## Fonctionnalités principales
- Authentification sécurisée (pas d'inscription publique – comptes créés par admin supérieur + code/lieu temporaire par mail)
- Gestion membres, cellules, sacrements (baptême ≥14 ans, mariage mixte, bénédiction)
- Gestion matériels + inventaire périodique (écarts auto-calculés)
- Finances (recettes/dépenses, soldes dynamiques)
- Événements (planification, récurrence 3/6 mois)
- Rapports PDF dynamiques + envoi mail depuis admin régional
- Import/Export Excel
- Interface bilingue + thème clair/sombre

## Prérequis
- PHP 8.2+
- Composer
- Node.js 18+
- MySQL 8+ (XAMPP local ou Hostinger)
- Symfony CLI (optionnel mais recommandé)

## Installation locale (XAMPP)
1. Clone le repo
    - git clone https://github.com/josoakaleba18/plateforme-gie.git
    - cd plateforme-gie

2. Backend
    - cd ../backend_gie
    - composer install

3. Configure .env
    - DATABASE_URL="mysql://root:@127.0.0.1:3306/gie_db?serverVersion=8.0"
    - Crée la base sur phpMyAdmin (gie_db, utf8mb4_unicode_ci)

4. Importe gie_db.sql (script fourni)

5. Migrations & fixtures
    - php bin/console doctrine:migrations:migrate
    - php bin/console doctrine:fixtures:load

6. Lance le serveur
    Bashsymfony serve
    - http://127.0.0.1:8000/api (doc API)

7. Frontend
    - cd ../frontend_gie
    - npm install
    - npm run dev
    - http://localhost:5173
