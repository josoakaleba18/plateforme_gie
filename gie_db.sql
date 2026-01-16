-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : jeu. 15 jan. 2026 à 14:57
-- Version du serveur : 10.4.32-MariaDB
-- Version de PHP : 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `gie_db`
--

-- --------------------------------------------------------

--
-- Structure de la table `affectationposte`
--

CREATE TABLE `affectationposte` (
  `id` int(11) NOT NULL,
  `date_debut` date NOT NULL,
  `date_fin` date DEFAULT NULL,
  `membre_id` int(11) NOT NULL,
  `poste_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `bapteme`
--

CREATE TABLE `bapteme` (
  `id` int(11) NOT NULL,
  `date` date NOT NULL,
  `lieu` varchar(50) NOT NULL,
  `pasteur` varchar(50) NOT NULL,
  `membre_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `benediction`
--

CREATE TABLE `benediction` (
  `id` int(11) NOT NULL,
  `date` date NOT NULL,
  `lieu` varchar(50) NOT NULL,
  `pasteur` varchar(50) NOT NULL,
  `membre_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `cellule`
--

CREATE TABLE `cellule` (
  `id` int(11) NOT NULL,
  `nom` varchar(50) NOT NULL,
  `description` text DEFAULT NULL,
  `eglise_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `contactnational`
--

CREATE TABLE `contactnational` (
  `id` int(11) NOT NULL,
  `nom` varchar(30) NOT NULL,
  `prenom` varchar(80) NOT NULL,
  `email` varchar(80) NOT NULL,
  `telephone` varchar(13) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `detailinventaire`
--

CREATE TABLE `detailinventaire` (
  `id` int(11) NOT NULL,
  `quantite_recensee` int(11) NOT NULL CHECK (`quantite_recensee` >= 0),
  `remarques` text DEFAULT NULL,
  `inventaireMateriel_id` int(11) NOT NULL,
  `materiel_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `eglise`
--

CREATE TABLE `eglise` (
  `id` int(11) NOT NULL,
  `nom` varchar(50) NOT NULL,
  `adresse` varchar(50) NOT NULL,
  `date_creation` date DEFAULT NULL,
  `paroisse_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `evenement`
--

CREATE TABLE `evenement` (
  `id` int(11) NOT NULL,
  `titre` varchar(200) NOT NULL,
  `description` text DEFAULT NULL,
  `type` enum('régional','paroissial') NOT NULL,
  `lieu` varchar(50) NOT NULL,
  `date_debut` date NOT NULL,
  `date_fin` date NOT NULL,
  `recurrent` tinyint(1) DEFAULT 0,
  `intervalle_mois` int(11) DEFAULT NULL CHECK (`intervalle_mois` in (3,6)),
  `fin_recurrence` date DEFAULT NULL,
  `region_id` int(11) DEFAULT NULL,
  `paroisse_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `inventairemateriel`
--

CREATE TABLE `inventairemateriel` (
  `id` int(11) NOT NULL,
  `date` date NOT NULL,
  `observations` text DEFAULT NULL,
  `effectueur` int(11) DEFAULT NULL,
  `eglise_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `mail`
--

CREATE TABLE `mail` (
  `id` int(11) NOT NULL,
  `destinataire` varchar(255) NOT NULL,
  `objet` text NOT NULL,
  `message` text NOT NULL,
  `date` date NOT NULL,
  `statut` enum('envoyé','échec') NOT NULL,
  `region_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `mariage`
--

CREATE TABLE `mariage` (
  `id` int(11) NOT NULL,
  `type` varchar(20) NOT NULL,
  `date` date NOT NULL,
  `lieu` varchar(50) NOT NULL,
  `pasteur` varchar(50) NOT NULL,
  `epoux1_id` int(11) NOT NULL,
  `epoux2_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `materiel`
--

CREATE TABLE `materiel` (
  `id` int(11) NOT NULL,
  `libelle` varchar(50) NOT NULL,
  `description` text DEFAULT NULL,
  `quantite` int(11) NOT NULL CHECK (`quantite` >= 0),
  `etat` enum('bon','endommagé','hors service') NOT NULL,
  `date_acquisition` date NOT NULL,
  `eglise_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `membre`
--

CREATE TABLE `membre` (
  `id` int(11) NOT NULL,
  `nom` varchar(30) NOT NULL,
  `prenom` varchar(80) NOT NULL,
  `date_naissance` date NOT NULL,
  `lieu_naissance` varchar(50) NOT NULL,
  `genre` enum('M','F') NOT NULL,
  `adresse` varchar(80) DEFAULT NULL,
  `telephone` varchar(13) DEFAULT NULL,
  `email` varchar(80) DEFAULT NULL,
  `eglise_id` int(11) NOT NULL,
  `cellule_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `paroisse`
--

CREATE TABLE `paroisse` (
  `id` int(11) NOT NULL,
  `nom` varchar(50) NOT NULL,
  `date_creation` date DEFAULT NULL,
  `region_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `poste`
--

CREATE TABLE `poste` (
  `id` int(11) NOT NULL,
  `libelle` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `region`
--

CREATE TABLE `region` (
  `id` int(11) NOT NULL,
  `nom` varchar(30) NOT NULL,
  `code` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `transactionfinanciere`
--

CREATE TABLE `transactionfinanciere` (
  `id` int(11) NOT NULL,
  `type` enum('recette','dépense') NOT NULL,
  `categorie` varchar(50) NOT NULL,
  `montant` decimal(10,2) NOT NULL CHECK (`montant` > 0),
  `date` date NOT NULL,
  `eglise_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `utilisateur`
--

CREATE TABLE `utilisateur` (
  `id` int(11) NOT NULL,
  `email` varchar(80) NOT NULL,
  `mot_de_passe` varchar(254) NOT NULL,
  `role` enum('admin régional','admin paroissial','responsable église') NOT NULL,
  `nom` varchar(30) NOT NULL,
  `prenom` varchar(80) NOT NULL,
  `actif` tinyint(1) DEFAULT 1,
  `date_creation` date NOT NULL DEFAULT curdate(),
  `region_id` int(11) DEFAULT NULL,
  `paroisse_id` int(11) DEFAULT NULL,
  `eglise_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `vue_ecart_inventaire`
-- (Voir ci-dessous la vue réelle)
--
CREATE TABLE `vue_ecart_inventaire` (
`id` int(11)
,`ecart_quantite` bigint(12)
);

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `vue_solde_eglise`
-- (Voir ci-dessous la vue réelle)
--
CREATE TABLE `vue_solde_eglise` (
`eglise_id` int(11)
,`solde` decimal(32,2)
);

-- --------------------------------------------------------

--
-- Structure de la vue `vue_ecart_inventaire`
--
DROP TABLE IF EXISTS `vue_ecart_inventaire`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vue_ecart_inventaire`  AS SELECT `d`.`id` AS `id`, `m`.`quantite`- `d`.`quantite_recensee` AS `ecart_quantite` FROM (`detailinventaire` `d` join `materiel` `m` on(`d`.`materiel_id` = `m`.`id`)) ;

-- --------------------------------------------------------

--
-- Structure de la vue `vue_solde_eglise`
--
DROP TABLE IF EXISTS `vue_solde_eglise`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vue_solde_eglise`  AS SELECT `e`.`id` AS `eglise_id`, sum(if(`t`.`type` = 'recette',`t`.`montant`,-`t`.`montant`)) AS `solde` FROM (`eglise` `e` left join `transactionfinanciere` `t` on(`e`.`id` = `t`.`eglise_id`)) GROUP BY `e`.`id` ;

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `affectationposte`
--
ALTER TABLE `affectationposte`
  ADD PRIMARY KEY (`id`),
  ADD KEY `membre_id` (`membre_id`),
  ADD KEY `poste_id` (`poste_id`);

--
-- Index pour la table `bapteme`
--
ALTER TABLE `bapteme`
  ADD PRIMARY KEY (`id`),
  ADD KEY `membre_id` (`membre_id`);

--
-- Index pour la table `benediction`
--
ALTER TABLE `benediction`
  ADD PRIMARY KEY (`id`),
  ADD KEY `membre_id` (`membre_id`);

--
-- Index pour la table `cellule`
--
ALTER TABLE `cellule`
  ADD PRIMARY KEY (`id`),
  ADD KEY `eglise_id` (`eglise_id`);

--
-- Index pour la table `contactnational`
--
ALTER TABLE `contactnational`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `detailinventaire`
--
ALTER TABLE `detailinventaire`
  ADD PRIMARY KEY (`id`),
  ADD KEY `inventaireMateriel_id` (`inventaireMateriel_id`),
  ADD KEY `materiel_id` (`materiel_id`);

--
-- Index pour la table `eglise`
--
ALTER TABLE `eglise`
  ADD PRIMARY KEY (`id`),
  ADD KEY `paroisse_id` (`paroisse_id`);

--
-- Index pour la table `evenement`
--
ALTER TABLE `evenement`
  ADD PRIMARY KEY (`id`),
  ADD KEY `region_id` (`region_id`),
  ADD KEY `paroisse_id` (`paroisse_id`);

--
-- Index pour la table `inventairemateriel`
--
ALTER TABLE `inventairemateriel`
  ADD PRIMARY KEY (`id`),
  ADD KEY `effectueur` (`effectueur`),
  ADD KEY `eglise_id` (`eglise_id`);

--
-- Index pour la table `mail`
--
ALTER TABLE `mail`
  ADD PRIMARY KEY (`id`),
  ADD KEY `region_id` (`region_id`);

--
-- Index pour la table `mariage`
--
ALTER TABLE `mariage`
  ADD PRIMARY KEY (`id`),
  ADD KEY `epoux1_id` (`epoux1_id`),
  ADD KEY `epoux2_id` (`epoux2_id`);

--
-- Index pour la table `materiel`
--
ALTER TABLE `materiel`
  ADD PRIMARY KEY (`id`),
  ADD KEY `eglise_id` (`eglise_id`);

--
-- Index pour la table `membre`
--
ALTER TABLE `membre`
  ADD PRIMARY KEY (`id`),
  ADD KEY `eglise_id` (`eglise_id`),
  ADD KEY `cellule_id` (`cellule_id`),
  ADD KEY `idx_membre_nom` (`nom`,`prenom`);

--
-- Index pour la table `paroisse`
--
ALTER TABLE `paroisse`
  ADD PRIMARY KEY (`id`),
  ADD KEY `region_id` (`region_id`);

--
-- Index pour la table `poste`
--
ALTER TABLE `poste`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `region`
--
ALTER TABLE `region`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`),
  ADD KEY `idx_region_nom` (`nom`);

--
-- Index pour la table `transactionfinanciere`
--
ALTER TABLE `transactionfinanciere`
  ADD PRIMARY KEY (`id`),
  ADD KEY `eglise_id` (`eglise_id`);

--
-- Index pour la table `utilisateur`
--
ALTER TABLE `utilisateur`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `region_id` (`region_id`),
  ADD KEY `paroisse_id` (`paroisse_id`),
  ADD KEY `eglise_id` (`eglise_id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `affectationposte`
--
ALTER TABLE `affectationposte`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `bapteme`
--
ALTER TABLE `bapteme`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `benediction`
--
ALTER TABLE `benediction`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `cellule`
--
ALTER TABLE `cellule`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `contactnational`
--
ALTER TABLE `contactnational`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `detailinventaire`
--
ALTER TABLE `detailinventaire`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `eglise`
--
ALTER TABLE `eglise`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `evenement`
--
ALTER TABLE `evenement`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `inventairemateriel`
--
ALTER TABLE `inventairemateriel`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `mail`
--
ALTER TABLE `mail`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `mariage`
--
ALTER TABLE `mariage`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `materiel`
--
ALTER TABLE `materiel`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `membre`
--
ALTER TABLE `membre`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `paroisse`
--
ALTER TABLE `paroisse`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `poste`
--
ALTER TABLE `poste`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `region`
--
ALTER TABLE `region`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `transactionfinanciere`
--
ALTER TABLE `transactionfinanciere`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `utilisateur`
--
ALTER TABLE `utilisateur`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `affectationposte`
--
ALTER TABLE `affectationposte`
  ADD CONSTRAINT `affectationposte_ibfk_1` FOREIGN KEY (`membre_id`) REFERENCES `membre` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `affectationposte_ibfk_2` FOREIGN KEY (`poste_id`) REFERENCES `poste` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `bapteme`
--
ALTER TABLE `bapteme`
  ADD CONSTRAINT `bapteme_ibfk_1` FOREIGN KEY (`membre_id`) REFERENCES `membre` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `benediction`
--
ALTER TABLE `benediction`
  ADD CONSTRAINT `benediction_ibfk_1` FOREIGN KEY (`membre_id`) REFERENCES `membre` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `cellule`
--
ALTER TABLE `cellule`
  ADD CONSTRAINT `cellule_ibfk_1` FOREIGN KEY (`eglise_id`) REFERENCES `eglise` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `detailinventaire`
--
ALTER TABLE `detailinventaire`
  ADD CONSTRAINT `detailinventaire_ibfk_1` FOREIGN KEY (`inventaireMateriel_id`) REFERENCES `inventairemateriel` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `detailinventaire_ibfk_2` FOREIGN KEY (`materiel_id`) REFERENCES `materiel` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `eglise`
--
ALTER TABLE `eglise`
  ADD CONSTRAINT `eglise_ibfk_1` FOREIGN KEY (`paroisse_id`) REFERENCES `paroisse` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `evenement`
--
ALTER TABLE `evenement`
  ADD CONSTRAINT `evenement_ibfk_1` FOREIGN KEY (`region_id`) REFERENCES `region` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `evenement_ibfk_2` FOREIGN KEY (`paroisse_id`) REFERENCES `paroisse` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `inventairemateriel`
--
ALTER TABLE `inventairemateriel`
  ADD CONSTRAINT `inventairemateriel_ibfk_1` FOREIGN KEY (`effectueur`) REFERENCES `membre` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `inventairemateriel_ibfk_2` FOREIGN KEY (`eglise_id`) REFERENCES `eglise` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `mail`
--
ALTER TABLE `mail`
  ADD CONSTRAINT `mail_ibfk_1` FOREIGN KEY (`region_id`) REFERENCES `region` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `mariage`
--
ALTER TABLE `mariage`
  ADD CONSTRAINT `mariage_ibfk_1` FOREIGN KEY (`epoux1_id`) REFERENCES `membre` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `mariage_ibfk_2` FOREIGN KEY (`epoux2_id`) REFERENCES `membre` (`id`) ON DELETE SET NULL;

--
-- Contraintes pour la table `materiel`
--
ALTER TABLE `materiel`
  ADD CONSTRAINT `materiel_ibfk_1` FOREIGN KEY (`eglise_id`) REFERENCES `eglise` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `membre`
--
ALTER TABLE `membre`
  ADD CONSTRAINT `membre_ibfk_1` FOREIGN KEY (`eglise_id`) REFERENCES `eglise` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `membre_ibfk_2` FOREIGN KEY (`cellule_id`) REFERENCES `cellule` (`id`) ON DELETE SET NULL;

--
-- Contraintes pour la table `paroisse`
--
ALTER TABLE `paroisse`
  ADD CONSTRAINT `paroisse_ibfk_1` FOREIGN KEY (`region_id`) REFERENCES `region` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `transactionfinanciere`
--
ALTER TABLE `transactionfinanciere`
  ADD CONSTRAINT `transactionfinanciere_ibfk_1` FOREIGN KEY (`eglise_id`) REFERENCES `eglise` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `utilisateur`
--
ALTER TABLE `utilisateur`
  ADD CONSTRAINT `utilisateur_ibfk_1` FOREIGN KEY (`region_id`) REFERENCES `region` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `utilisateur_ibfk_2` FOREIGN KEY (`paroisse_id`) REFERENCES `paroisse` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `utilisateur_ibfk_3` FOREIGN KEY (`eglise_id`) REFERENCES `eglise` (`id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
