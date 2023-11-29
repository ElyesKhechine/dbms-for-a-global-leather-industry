--C-1) Creation d'un utilisateur nomme organisme_elyes_nermine identifie par le mot de passe "system"
CONNECT system/system;
CREATE USER organisme_elyes_nermine IDENTIFIED BY system;

--C-2) Attribution des privileges requis pour la creation du schema relationnel et sa gestion
GRANT CREATE SESSION TO organisme_elyes_nermine;
GRANT CREATE TABLE TO organisme_elyes_nermine;
GRANT UNLIMITED TABLESPACE TO organisme_elyes_nermine;
GRANT CREATE ANY TABLE TO organisme_elyes_nermine;
GRANT CREATE ANY VIEW TO organisme_elyes_nermine;
GRANT ALTER ANY TABLE TO organisme_elyes_nermine;    
GRANT SELECT ANY TABLE TO organisme_elyes_nermine;    
GRANT UPDATE ANY TABLE TO organisme_elyes_nermine;    
GRANT DROP ANY TABLE TO organisme_elyes_nermine;
GRANT DELETE ANY TABLE TO organisme_elyes_nermine;

--C-3) Connexion a la session utilisateur organisme_elyes_nermine creee
CONNECT organisme_elyes_nermine/system;

--C-4) Creation du schema relationnel defini dans B
CREATE TABLE Secteur(
codesect NUMBER(8) CONSTRAINT PK_Secteur PRIMARY KEY,
libelle VARCHAR2(20));

CREATE TABLE Pays(
codepays NUMBER(8) CONSTRAINT PK_Pays PRIMARY KEY,  
nompays VARCHAR2(20));

CREATE TABLE Entreprise(
identreprise NUMBER(8) CONSTRAINT PK_Entreprise PRIMARY KEY,
nom VARCHAR2(10),
nomresponsable VARCHAR2(10),
numtel NUMBER(15) CONSTRAINT CHK_numtel CHECK (numtel > 10000000),
numfax NUMBER(15) CONSTRAINT CHK_numfax CHECK (numfax > 10000000),
adresse VARCHAR2(20),
codesect NUMBER(8),
CONSTRAINT FK_Entreprise_Secteur FOREIGN KEY(codesect) REFERENCES Secteur(codesect));

CREATE TABLE Article(
codearticle NUMBER(8) CONSTRAINT PK_Article PRIMARY KEY,
designation VARCHAR2(20),
prix NUMBER(8));

CREATE TABLE Employe(
codeemploye NUMBER(8) CONSTRAINT PK_Employe PRIMARY KEY,
nom VARCHAR2(20),
prenom VARCHAR2(20),
grade VARCHAR2(20) ,
daterecrut DATE );

CREATE TABLE Collecte(
codepays NUMBER(8),
identreprise NUMBER(8),
codearticle NUMBER(8),
qtearticle NUMBER(8),
qteexpo NUMBER(8),
valexpo NUMBER(8),
annee  NUMBER(8) CONSTRAINT CHK_annee CHECK (annee > 1900),
CONSTRAINT PK_Collecte PRIMARY KEY(codepays,identreprise,codearticle),
CONSTRAINT FK_Collecte_Pays FOREIGN KEY(codepays) REFERENCES Pays(codepays),
CONSTRAINT FK_Collecte_Entreprise FOREIGN KEY(identreprise) REFERENCES Entreprise(identreprise),
CONSTRAINT FK_Collecte_Article FOREIGN KEY(codearticle) REFERENCES Article(codearticle));

CREATE TABLE Produit(
codearticle NUMBER(8),
identreprise NUMBER(8),
CONSTRAINT PK_Produit PRIMARY KEY(codearticle,identreprise),
CONSTRAINT FK_Produit_Article FOREIGN KEY(codearticle) REFERENCES Article(codearticle),
CONSTRAINT FK_Produit_Entreprise FOREIGN KEY(identreprise) REFERENCES Entreprise(identreprise));

CREATE TABLE Suivre(
codeemploye Number(8),
codesect Number(8),
identreprise Number(8),
CONSTRAINT PK_Suivre PRIMARY KEY(codeemploye,identreprise,codesect),
CONSTRAINT FK_Suivre_Employe FOREIGN KEY(codeemploye) REFERENCES Employe(codeemploye),
CONSTRAINT FK_Suivre_Secteur FOREIGN KEY(codesect) REFERENCES Secteur(codesect),
CONSTRAINT FK_Suivre_Entreprise FOREIGN KEY(identreprise) REFERENCES Entreprise(identreprise)) ;

CREATE TABLE Contient(
codepays NUMBER(8),
identreprise NUMBER(8),
CONSTRAINT PK_Contient PRIMARY KEY(codepays,identreprise),
CONSTRAINT FK_Contient_Pays FOREIGN KEY(codepays) REFERENCES Pays(codepays),
CONSTRAINT FK_Contient_Entreprise FOREIGN KEY(identreprise) REFERENCES Entreprise(identreprise)) ;

--C-5) Insertion de donnees de notre choix
INSERT INTO Secteur VALUES(100,'chaussures');
INSERT INTO Secteur VALUES(101,'Habillement Cuir');
INSERT INTO Secteur VALUES(102,'Tannerie');
INSERT INTO Secteur VALUES(103,'Maroquinerie');
INSERT INTO Secteur VALUES(104,'Sellerie');
INSERT INTO Secteur VALUES(105,'Fourrure');

INSERT INTO Pays VALUES(1, 'Germany');
INSERT INTO Pays VALUES(2, 'France');
INSERT INTO Pays VALUES(3, 'Tunisia');
INSERT INTO Pays VALUES(4, 'Italy');
INSERT INTO Pays VALUES(5 , 'Belgium');
INSERT INTO Pays VALUES(6 ,'Brazil');

INSERT INTO Entreprise VALUES(1000,'TCS','Amin',26999123,71225111,'tunis',100);
INSERT INTO Entreprise VALUES(2000,'Expensya','Ahmed',98636152,71999222,'Centre Urbain',101);  
INSERT INTO Entreprise VALUES(3000,'Valeo','Jean',25698123,74295333,'Zaghoune',102);
INSERT INTO Entreprise VALUES(4000,'thinkIT','Mohamed',98754123,71121444,'Sousse',103);

INSERT INTO Article VALUES(10,'Veste',300);
INSERT INTO Article VALUES(11,'Chaussures',400);
INSERT INTO Article VALUES(12,'Sac',500);
INSERT INTO Article VALUES(13,'Pontalon',600);
INSERT INTO Article VALUES(14,'Porte-monnaie',700);
INSERT INTO Article VALUES(15,'Ceinture',700);

INSERT INTO Employe VALUES(20,'Amin','Said','Chef Service','10/10/2000');
INSERT INTO Employe VALUES(21,'Cyrine','Bennour','Chef Relation','12/08/1999');
INSERT INTO Employe VALUES(22,'Mohamed','Ben Nour','Directeur','12/09/1997');
INSERT INTO Employe VALUES(23,'Dorra','Djobbi','Secretaire','11/11/1998');
INSERT INTO Employe VALUES(24,'Elyes','Arbi','Chef Reltaion','01/05/2005');
INSERT INTO Employe VALUES(25,'Wijden','Salahi','Responsable IT','12/01/2014');
INSERT INTO Employe VALUES(26,'Ahmed','Belhaj','Chef Communication', '09/12/2001');

INSERT INTO Collecte VALUES(1,1000,10, 100,10000,500,2000);
INSERT INTO Collecte VALUES(1,2000,10, 200,20000,100,2004);
INSERT INTO Collecte VALUES(2,2000,11, 300,30000,200,2005);
INSERT INTO Collecte VALUES(3,2000,12, 400,40000,300,2020);
INSERT INTO Collecte VALUES(4,2000,13, 500,50000,400,2006);
INSERT INTO Collecte VALUES(5,2000,14, 600,60000,500,2007);
INSERT INTO Collecte VALUES(6,2000,15, 700,70000,600,2020);
INSERT INTO Collecte VALUES(5,3000,13, 400,40000,700,2015);
INSERT INTO Collecte VALUES(4,3000,13, 500,80000,200,2020);
INSERT INTO Collecte VALUES(6,4000,14, 500,50000,800,2016);
INSERT INTO Collecte VALUES(6,4000,15, 600,60000,900,2022);
INSERT INTO Collecte VALUES(4,4000,12, 600,60000,900,2020);

INSERT INTO Produit VALUES(10,1000);
INSERT INTO Produit VALUES(11,2000);
INSERT INTO Produit VALUES(12,3000);
INSERT INTO Produit VALUES(13,3000);
INSERT INTO Produit VALUES(14,4000);
INSERT INTO Produit VALUES(15,4000);
    
INSERT INTO Suivre VALUES(20,100,1000);
INSERT INTO Suivre VALUES(21,100,1000);
INSERT INTO Suivre VALUES(22,101,2000);
INSERT INTO Suivre VALUES(23,102,3000);
INSERT INTO Suivre VALUES(24,103,4000);
INSERT INTO Suivre VALUES(25,104,4000);

INSERT INTO Contient VALUES(1,1000);
INSERT INTO Contient VALUES(1,2000);
INSERT INTO Contient VALUES(2,3000);
INSERT INTO Contient VALUES(3,3000);
INSERT INTO Contient VALUES(4,4000);
INSERT INTO Contient VALUES(5,4000);

--C-6-a) Affichage de la liste des cinq plus anciens employes.
SELECT S.*
FROM (SELECT a.*
FROM Employe a
ORDER BY daterecrut ASC) S
WHERE ROWNUM<=5;

--C-6-b) Affichage de la liste des secteurs et des entreprises auxquels elles appartiennent classee par ordre croissant du libelle du secteur et par ordre decroissant du nom de l’entreprise.
SELECT a.codesect,a.libelle, b.nom
FROM Secteur a, Entreprise b
WHERE a.codesect=b.codesect
ORDER BY a.libelle ASC,b.nom DESC;

--C-6-c) Affichage du nombre de secteurs et du nombre d’entreprises suivis par chaque employe, en utilisant des alias de colonnes pour l’affichage.
SELECT a.codeemploye, SUBSTR(a.prenom,1,1) || '. ' || a.nom AS Full_Name, COUNT(DISTINCT b.identreprise) AS Nombre_Entreprise, COUNT(DISTINCT b.codesect) AS Nombre_Secteur
FROM Employe a, Suivre b
WHERE a.codeemploye=b.codeemploye(+)
AND a.codeemploye=b.codeemploye(+)
GROUP BY a.codeemploye, (SUBSTR(a.prenom,1,1) || '. ' || a.nom);

--C-6-d) Affichage du secteur qui comporte le plus petit nombre d’entreprises rattachees.
CREATE OR REPLACE VIEW VIEW1(codesect, Nombre_Entreprise)
AS
SELECT a.codesect ,COUNT(a.identreprise)
FROM Entreprise a
GROUP BY a.codesect;

SELECT a.*
FROM Secteur a, VIEW1 b
WHERE a.codesect=b.codesect
AND b.Nombre_Entreprise=(SELECT MIN(c.Nombre_Entreprise)      
                         FROM VIEW1 c
                         );

--C-6-e) Affichage du nom de l’entreprise qui a realise la plus grande valeur d’exportation pour l’annee 2020 pour tous les articles qu’elle produit sans distinction.
CREATE OR REPLACE VIEW VIEW2(ID_Entreprise, Valeur_Exportation)
AS
SELECT a.identreprise, SUM(a.valexpo)
FROM Collecte a
WHERE a.annee = 2020
GROUP BY a.identreprise;

SELECT a.*
FROM Entreprise a, VIEW2 b
WHERE a.identreprise = b.ID_Entreprise
AND b.Valeur_Exportation = (SELECT MAX(b.Valeur_Exportation) FROM VIEW2 b);
--C-6-f) Affichage du nom de l’entreprise qui exporte a tous les pays sans exception.
SELECT a.*
FROM Entreprise a, (SELECT b.identreprise, COUNT(DISTINCT b.codepays) AS nombre_secteur        
                    FROM Collecte b
                    GROUP BY (b.identreprise)) S
WHERE a.identreprise=S.identreprise
AND S.nombre_secteur=(SELECT COUNT(codepays)
                      FROM Pays);

--C-6-g) Calcul et affichage de la somme des quantites produites par annee et par article.
SELECT a.codearticle,b.annee, SUM(b.qtearticle)
FROM Produit a, Collecte b
WHERE a.codearticle=b.codearticle
GROUP BY a.codearticle, b.annee
ORDER BY a.codearticle;

--C-6-h) Affichage pour chaque annee, du nom de l’entreprise qui possede l’article le plus produit en affichant aussi la designation de cet article et la quantite produite correspondante.
SELECT c.annee AS "Annee" , e.nom AS "Nom de l'entreprise" , a.designation AS "Designation de l’article" , c.qtearticle AS "Quantite produite"
FROM Entreprise e, Article a, Collecte c, (SELECT f.identreprise, f.annee, p.codearticle, SUM(f.qtearticle) AS somme_quantite
                                           FROM Collecte f, Produit p
                                           GROUP BY f.annee, f.identreprise, p.codearticle) S
WHERE c.annee= S.annee
AND   e.identreprise = c.identreprise
AND   e.identreprise = S.identreprise
AND   S.identreprise = e.identreprise
AND   S.identreprise = c.identreprise
AND   c.identreprise = S.identreprise
AND   S.codearticle= a.codearticle
AND   a.codearticle= c.codearticle
AND   S.somme_quantite >=  ALL(S.somme_quantite)
ORDER BY c.annee ASC, S.somme_quantite DESC;

--C-7) Les vues de la base de donnees a prevoir pour ces categories d’utilisateurs: Les privileges d’acces aux donnees qui doivent être attribues:
CREATE ROLE Service_comptabilite
        
GRANT SELECT ON organisme_elyes_nermine.Pays TO Service_comptabilite

GRANT SELECT ON organisme_elyes_nermine.Secteur TO Service_comptabilite

GRANT SELECT ON organisme_elyes_nermine.Entreprise TO Service_comptabilite ;

GRANT SELECT ON organisme_elyes_nermine.Article TO Service_comptabilite ;
 
GRANT SELECT ON organisme_elyes_nermine.Produit TO Service_comptabilite ;

GRANT SELECT ON organisme_elyes_nermine.Collecte TO Service_comptabilite ;

CREATE ROLE Client ;

GRANT SELECT ON organisme_elyes_nermine.Entreprise TO Client ;

GRANT SELECT ON organisme_elyes_nermine.Article TO Client ;

CREATE USER Amer IDENTIFIED BY system;

GRANT Client TO Amer ;

CREATE USER Dorra IDENTIFIED BY system;

GRANT Service_comptabilite TO Dorra;