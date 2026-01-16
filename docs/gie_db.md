-- Création de la base GIE
CREATE DATABASE IF NOT EXISTS gie_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE gie_db;

-- Table Région
CREATE TABLE Region (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(30) NOT NULL,
    code INT UNIQUE NOT NULL,
);

-- Table Paroisse
CREATE TABLE Paroisse (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(50) NOT NULL,
    date_creation DATE NULL,
    region_id INT NOT NULL,
    FOREIGN KEY (region_id) REFERENCES Region(id) ON DELETE CASCADE
);

-- Table Église
CREATE TABLE Eglise (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(50) NOT NULL,
    adresse VARCHAR(50) NOT NULL,
    date_creation DATE NULL,
    paroisse_id INT NOT NULL,
    FOREIGN KEY (paroisse_id) REFERENCES Paroisse(id) ON DELETE CASCADE
);

-- Table Cellule
CREATE TABLE Cellule (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(50) NOT NULL,
    description TEXT NULL,
    eglise_id INT NOT NULL,
    FOREIGN KEY (eglise_id) REFERENCES Eglise(id) ON DELETE CASCADE
);

-- Table Membre
CREATE TABLE Membre (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(30) NOT NULL,
    prenom VARCHAR(80) NOT NULL,
    date_naissance DATE NOT NULL,
    lieu_naissance VARCHAR(50) NOT NULL,
    genre ENUM('M', 'F') NOT NULL,
    adresse VARCHAR(80) NULL,
    telephone VARCHAR(13) NULL,
    email VARCHAR(80) NULL,
    eglise_id INT NOT NULL,
    cellule_id INT NULL,
    FOREIGN KEY (eglise_id) REFERENCES Eglise(id) ON DELETE CASCADE,
    FOREIGN KEY (cellule_id) REFERENCES Cellule(id) ON DELETE SET NULL
);

-- Table Poste
CREATE TABLE Poste (
    id INT AUTO_INCREMENT PRIMARY KEY,
    libelle VARCHAR(50) NOT NULL
);

-- Table AffectationPoste
CREATE TABLE AffectationPoste (
    id INT AUTO_INCREMENT PRIMARY KEY,
    date_debut DATE NOT NULL,
    date_fin DATE NULL,
    membre_id INT NOT NULL,
    poste_id INT NOT NULL,
    FOREIGN KEY (membre_id) REFERENCES Membre(id) ON DELETE CASCADE,
    FOREIGN KEY (poste_id) REFERENCES Poste(id) ON DELETE CASCADE
);

-- Table Sacrement (abstraite, mais en SQL on utilise une table par hériter)
-- Table Bapteme
CREATE TABLE Bapteme (
    id INT AUTO_INCREMENT PRIMARY KEY,
    date DATE NOT NULL,
    lieu VARCHAR(50) NOT NULL,
    pasteur VARCHAR(50) NOT NULL,
    membre_id INT NOT NULL,
    FOREIGN KEY (membre_id) REFERENCES Membre(id) ON DELETE CASCADE,
    CHECK (DATEDIFF(date, (SELECT dateNaissance FROM Membre WHERE id = membre_id)) / 365 >= 14)
);

-- Table Benediction
CREATE TABLE Benediction (
    id INT AUTO_INCREMENT PRIMARY KEY,
    date DATE NOT NULL,
    lieu VARCHAR(50) NOT NULL,
    pasteur VARCHAR(50) NOT NULL,
    membre_id INT NOT NULL,
    FOREIGN KEY (membre_id) REFERENCES Membre(id) ON DELETE CASCADE
);

-- Table Mariage
CREATE TABLE Mariage (
    id INT AUTO_INCREMENT PRIMARY KEY,
    type VARCHAR(20) NOT NULL,
    date DATE NOT NULL,
    lieu VARCHAR(50) NOT NULL,
    pasteur VARCHAR(50) NOT NULL,
    epoux1_id INT NOT NULL,
    epoux2_id INT NULL,
    FOREIGN KEY (epoux1_id) REFERENCES Membre(id) ON DELETE CASCADE,
    FOREIGN KEY (epoux2_id) REFERENCES Membre(id) ON DELETE SET NULL
);

-- Table Materiel
CREATE TABLE Materiel (
    id INT AUTO_INCREMENT PRIMARY KEY,
    libelle VARCHAR(50) NOT NULL,
    description TEXT NULL,
    quantite INT NOT NULL CHECK (quantite >= 0),
    etat ENUM('bon', 'endommagé', 'hors service') NOT NULL,
    date_acquisition DATE NOT NULL,
    eglise_id INT NOT NULL,
    FOREIGN KEY (eglise_id) REFERENCES Eglise(id) ON DELETE CASCADE
);

-- Table InventaireMateriel
CREATE TABLE InventaireMateriel (
    id INT AUTO_INCREMENT PRIMARY KEY,
    date DATE NOT NULL,
    observations TEXT NULL,
    effectueur INT NOT NULL,
    eglise_id INT NOT NULL,
    FOREIGN KEY (effectueur) REFERENCES Membre(id) ON DELETE SET NULL,
    FOREIGN KEY (eglise_id) REFERENCES Eglise(id) ON DELETE CASCADE
);

-- Table DetailInventaire
CREATE TABLE DetailInventaire (
    id INT AUTO_INCREMENT PRIMARY KEY,
    quantite_recensee INT NOT NULL CHECK (quantite_recensee >= 0),
    remarques TEXT NULL,
    inventaireMateriel_id INT NOT NULL,
    materiel_id INT NOT NULL,
    FOREIGN KEY (inventaireMateriel_id) REFERENCES InventaireMateriel(id) ON DELETE CASCADE,
    FOREIGN KEY (materiel_id) REFERENCES Materiel(id) ON DELETE CASCADE
);

-- Table TransactionFinanciere
CREATE TABLE TransactionFinanciere (
    id INT AUTO_INCREMENT PRIMARY KEY,
    type ENUM('recette', 'dépense') NOT NULL,
    categorie VARCHAR(50) NOT NULL,
    montant DECIMAL(10,2) NOT NULL CHECK (montant > 0),
    date DATE NOT NULL,
    eglise_id INT NOT NULL,
    FOREIGN KEY (eglise_id) REFERENCES Eglise(id) ON DELETE CASCADE
);

-- Table Evenement
CREATE TABLE Evenement (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titre VARCHAR(200) NOT NULL,
    description TEXT NULL,
    type ENUM('régional', 'paroissial') NOT NULL,
    lieu VARCHAR(50) NOT NULL,
    date_debut DATE NOT NULL,
    date_fin DATE NOT NULL,
    recurrent BOOLEAN DEFAULT FALSE,
    intervalle_mois INT NULL CHECK (intervalle_mois IN (3,6)),
    fin_recurrence DATE NULL
    region_id INT NULL,
    paroisse_id INT NULL,
    FOREIGN KEY (region_id) REFERENCES Region(id) ON DELETE CASCADE,
    FOREIGN KEY (paroisse_id) REFERENCES Paroisse(id) ON DELETE CASCADE
);

-- Table ContactNational
CREATE TABLE ContactNational (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(30) NOT NULL,
    prenom VARCHAR(80) NOT NULL,
    email VARCHAR(80) NOT NULL,
    telephone VARCHAR(13) NULL
);

-- Table Mail (lié à Région)
CREATE TABLE Mail (
    id INT AUTO_INCREMENT PRIMARY KEY,
    destinataire VARCHAR(255) NOT NULL,
    objet TEXT NOT NULL,
    message sTEXT NOT NULL,
    date DATE NOT NULL,
    statut ENUM('envoyé', 'échec') NOT NULL,
    region_id INT NOT NULL,
    FOREIGN KEY (region_id) REFERENCES Region(id) ON DELETE CASCADE
);

-- Table Utilisateur
CREATE TABLE Utilisateur (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(80) UNIQUE NOT NULL,
    mot_de_passe VARCHAR(254) NOT NULL,
    role ENUM('admin régional', 'admin paroissial','responsable église') NOT NULL,
    nom VARCHAR(30) NOT NULL,
    prenom VARCHAR(80) NOT NULL,
    actif BOOLEAN DEFAULT TRUE,
    date_creation DATE NOT NULL DEFAULT CURDATE(),
    region_id INT NULL,
    paroisse_id INT NULL,
    eglise_id INT NULL,
    FOREIGN KEY (region_id) REFERENCES Region(id) ON DELETE SET NULL,
    FOREIGN KEY (paroisse_id) REFERENCES Paroisse(id) ON DELETE SET NULL,
    FOREIGN KEY (eglise_id) REFERENCES Eglise(id) ON DELETE SET NULL
);

-- Indexes et Vues pour rapports (ex. solde finances, écarts inventaire)
CREATE INDEX idx_region_nom ON Region(nom);
CREATE INDEX idx_membre_nom ON Membre(nom, prenom);

CREATE VIEW vue_solde_eglise AS
SELECT e.id AS eglise_id, SUM(IF(t.type = 'recette', t.montant, -t.montant)) AS solde
FROM Eglise e LEFT JOIN TransactionFinanciere t ON e.id = t.eglise_id
GROUP BY e.id;

CREATE VIEW vue_ecart_inventaire AS
SELECT d.id, m.quantite - d.quantite_recensee AS ecart_quantite
FROM DetailInventaire d JOIN Materiel m ON d.materiel_id = m.id;