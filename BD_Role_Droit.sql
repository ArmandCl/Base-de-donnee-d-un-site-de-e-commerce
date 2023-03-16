CREATE USER INVITE IDENTIFIED BY azerty;
CREATE ROLE MEMBRE;
CREATE ROLE MODERATEUR;
CREATE ROLE VENDEUR;
CREATE ROLE PREPARATEUR_COMMANDE;

GRANT SELECT ON PRODUITS,VENDEUR,AVIS,CATEGORIE_PRODUIT TO INVITE,MEMBRE,MODERATEUR,VENDEUR,PREPARATEUR_COMMANDE;

CREATE VIEW profil_public AS (SELECT login FROM CLIENT);
GRANT SELECT ON profil_public TO INVITE,MEMBRE,MODERATEUR,VENDEUR,PREPARATEUR_COMMANDE;

CREATE VIEW produits_populaires AS (
			SELECT id_produit,nom_produit,img_produit,count(login) as test 
			FROM CONSULTATION_CLIENT c,PRODUITS p
			WHERE c.id_produit = p.id_produit
			GROUP BY id_produit);
GRANT SELECT ON produits_populaires TO MEMBRE,MODERATEUR,VENDEUR,PREPARATEUR_COMMANDE;

CREATE VIEW historique_consultation_client AS(
					SELECT id_produit, date_consultation, img_produit  
					FROM PRODUITS p, CONSULTATION_CLIENT c 
					WHERE c.id_produit = p.id_produit AND USER = login
					);
GRANT SELECT ON historique_consultation_client TO MEMBRE, MODERATEUR, VENDEUR;

CREATE VIEW profil_perso AS (
       			SELECT * 
       			FROM CLIENT WHERE login = USER
       			 );
GRANT SELECT, UPDATE (adresse_mail, adresse, telephone) ON profil_perso TO MEMBRE, MODERATEUR, VENDEUR;

CREATE VIEW nouvel_avis AS (
    			SELECT description_avis_produit, note 
    			FROM AVIS
    			);
GRANT INSERT ON nouvel_avis TO MEMBRE, MODERATEUR, VENDEUR;

CREATE VIEW composer_commande AS (
				SELECT *
				FROM COMPOSITION_COMMANDE	
				  );
GRANT SELECT,INSERT,UPDATE ON composer_commande TO MEMBRE,VENDEUR,MODERATEUR;

CREATE VIEW avis_modifie AS (
        		     SELECT * 
        		     FROM AVIS
        		     );
GRANT UPDATE(description_avis_produit) ON avis_modifie TO MODERATEUR;

CREATE VIEW change_categorie(
			    SELECT * 
			    FROM CATEGORIE_PRODUIT cp,MODERATION m,PRODUITS p
			    WHERE p.id_produit = cp.id_produit and cp.id_categorie = m.id_categorie and USER = login
  			    );
GRANT SELECT,UPDATE ON change_categorie TO MODERATEUR;

CREATE VIEW produit_vendeur AS( 
				SELECT nom_produit, img_produit, prix_prod, description_prod 
				FROM PRODUITS p, VENDEUR v 
				WHERE p.id_vendeur = v.id_vendeur and USER = v.login
				);
GRANT SELECT, UPDATE,INSERT ON produit_vendeur TO VENDEUR;

CREATE VIEW etat_stock AS (
			SELECT * 
			FROM STOCK s,PRODUITS p,VENDEUR v
			WHERE s.id_produit = p.idproduit and p.idproduit = v.idproduit
			);
GRANT SELECT,UPDATE (quantite_stock, date_reapprovisionnement) ON etat_stock TO VENDEUR;

GRANT SELECT ON COMPOSITION_COMMANDE TO PREPARATEUR_COMMANDE;

CREATE VIEW etat_commande AS ( 
   			SELECT * 
   			FROM COMMANDE
   			);
GRANT SELECT,UPDATE(etat_commande) ON etat_commande TO PREPARATEUR_COMMANDE;
