CREATE TABLE CLIENT
   		 ( login varchar(10) Primary Key,
   		   nom varchar(30) Not Null,
   		   prenom varchar(30) Not Null,
   		   adresse varchar(100) Not Null,
   		   adresse_mail varchar(50) Not Null Unique check (adresse_mail like '%_@%_.__%'),
   		   telephone number(10),
   		   date_naissance date Not Null check (date_naissance like '%__/__/__%')
   		 );	   
   		   
CREATE TABLE VENDEUR
   		 ( id_vendeur number(8) Primary Key,
   		   nom_vendeur varchar(100) Not Null,
   		   mail_vendeur varchar(100) Not Null,
   telephone_vendeur int Not Null,
		   login varchar(10) Not Null References CLIENT
   		 );
 	 
CREATE TABLE PRODUITS
   		 ( id_produit number(8) Primary Key,
   		   nom_produit varchar(100) Not Null,
		   img_produit blob Not Null,
   		   prix_prod number(5,2) Not Null,
   		   description_prod clob Not Null,
   		   id_vendeur number(8) Not Null References VENDEUR
   		 );    		   
   		   
CREATE TABLE AVIS
   		 ( id_avis number(8) Primary Key,
   		   description_avis_produit varchar(300),
   		   note number(1) Not Null check (note > 0 And note <= 5),
    		   login varchar(10) Not Null References CLIENT,
   		   id_produit number(8) Not Null References PRODUITS   	 
   		 );

CREATE TABLE CATEGORIE_PRODUIT
  		  (id_categorie number(8) Primary Key,
  		  nom_categorie varchar(25) Not Null,
  		  descriptif_categorie clob,
  		  id_produit number(8) Not Null References PRODUITS
  		  );
  		 
CREATE TABLE PANIER_CLIENT
  		  (panier_item int Primary Key,
  id_panier number(8),
  		  login varchar(10) Not Null References CLIENT,
  		  id_produit number(8) Not Null References PRODUITS
  		  );
  	 
CREATE TABLE COMPOSITION_COMMANDE
  		  (item int Primary Key,
  		  quantite_produit int Not Null,
  		  id_produit number(8) Not Null References PRODUITS
		   id_commande number(8) Not Null References COMMANDE
  		  );
  	 
CREATE TABLE COMMANDE
  		  ( id_commande number(8) Primary Key,
  prix_total_commande int Not Null,
  		  date_commande date Default current_date Not Null check (date_commande like'%__/__/__%'),
  		  etat_commande varchar(75) Not Null,
  		  adresse_livraison varchar(100) Not Null,
  		  login varchar(10) Not Null References CLIENT
  		  );
  		 
CREATE TABLE CONSULTATION_CLIENT
  		  (date_consultation date Not Null check (date_consultation like'%__/__/__%'),
  		  login varchar(10) Not Null References CLIENT,
  		  id_produit number(8) Not Null References PRODUITS,
  		  Primary Key(login,id_produit)
  		  );

CREATE TABLE PROMOTION
  		  (id_promotion number(8) Not Null,
  		  descriptif_promo clob Not Null,
  		  date_debut_promo date Not Null check (date_debut_promo like'%__/__/__%'),
  		  date_fin_promo date Not Null check (date_fin_promo like'%__/__/__%'),
  		  id_produit number(8) Not Null References PRODUITS
  Primary Key(id_produit)
  		  );
  		 
CREATE TABLE STOCK
  		  (quantite_stock int check(quantite_stock >= 0),
  		  date_reapprovisionnement date Not Null check (date_reapprovisionnement like'%__/__/__%'),
  		  id_produit number(8) Not Null References PRODUITS,
  		  Primary Key(id_produit)
  		  );



CREATE TABLE MODERATION
		  (login varchar(10) Not Null References CLIENT,
		   id_categorie number(8) Not Null References CATEGORIE_PRODUIT,
		   Primary Key(login, id_categorie)
   );

