*KEEP= choisir les colonnes, DROP= supprimer les colonnes;
DATA PRICE(KEEP= MODEL TYPE MSRP) FEATURES(DROP= MODEL TYPE MSRP);
SET SASHELP.CARS;
*IF THEN OUTPUT/ ELSE OUTPUT: conditions;
IF MSRP < 19000 THEN OUTPUT PRICE;
ELSE OUTPUT FEATURES;
RUN;

*_N_= index de lignes;
DATA LINE_NUMBER;
SET PRICE;
IF _N_ >= 10 AND _N_ < 20;
RUN;

*OBS= nombre de premières lignes à afficher;
DATA OBSS;
SET PRICE(OBS=15);
RUN;

*FIRSTOBSS: la première ligne à afficher;
DATA FIRSTOBSS;
SET PRICE(OBS=15 FIRSTOBS=7);
RUN;

*INPUT DATALINES: enregistrer des données;
DATA FIRST_DATA;
INPUT EMPLOYEE $6. SALARY;
DATALINES;
SAMuel 1200
ROHAN 4300
LUCAS 500
MICHEL 200
;
RUN;

*PROC IMPORT: importer un fichier ou téléchager le fichier vers le serveur;
*Fichier "Customers.xlsx";
PROC IMPORT DATAFILE="/home/u63990573/Customers.xlsx"
			OUT=CUSTOMERS
			DBMS=XLSX 
			REPLACE;
			SHEET="CUSTOMERS";
RUN;

*afficher des données & ajouter une colonne PRICE;
DATA TESTING;
SET MYLIB.ORDERDETAILS;
PRICE= QUANTITY*5;
RUN;

*DATA SET: créer un new dataset pour modifier, transformer, ou créer de nouvelles variables, le dataset original reste intact;
DATA CUSTOMERS;
SET MYLIB.CUSTOMERS;
RUN;

*PROC PRINT: affiche le dataset, ne modifie pas les données;
PROC PRINT 	DATA=MYLIB.CUSTOMERS(OBS=10);
			VAR CONTACTNAME COUNTRY TRANSACTION_AMOUNT;
			TITLE 'CUSTOMER DATA';
			BY COUNTRY;
			SUM TRANSACTION_AMOUNT;
/* 			WHERE COUNTRY='USA'; */
			FOOTNOTE 'THIS IS HOW PRINT WORKS';
RUN;

/* Importation du fichier Excel */
* Fichier "Categories.xlsx";
PROC IMPORT DATAFILE='/home/u63990573/Categories.xlsx'
		    OUT=Categories
		    DBMS=XLSX
		    REPLACE;
		    SHEET='Categories'; /* Remplacez 'Sheet1' par le nom de la feuille que vous souhaitez importer */
		    GETNAMES=YES;
RUN;

*importer un fichier dans une bibliothèque; 
*Fichier "customer_details.xlsx";
PROC IMPORT DATAFILE='/home/u63990573/customer_details.xlsx'
		    OUT=MYLIB.customer_details
		    DBMS=XLSX /*Database Management System => type de BDD pour interagir*/
		    REPLACE; *écraser un fichier ou une table existante, sinon l'opération n'a pas été effectuée parce qu'un fichier ou une table portant ce nom existe déjà;
		    SHEET='data'; /* Remplacez 'Sheet1' par le nom de la feuille que vous souhaitez importer */
		    GETNAMES=YES;
RUN;

*PROC SORT: trier la colonne "Country" par ordre décroissant sans index doublons et nommner la table "Sorted";
PROC SORT 	DATA=MYLIB.CUSTOMERS NODUPKEY OUT=SORTED;
			BY DESCENDING COUNTRY;
RUN;

*PROC SORT: trier la colonne "Country" par ordre croissant sans valeurs doublons et nommner la table "Sorted";
PROC SORT DATA=MYLIB.CUSTOMERS NODUP OUT=SORTED;
BY COUNTRY;
RUN;

*PROC SORT: trier toutes les colonnes par ordre décroissant sans valeurs doublons et nommner la table "Sorted";
PROC SORT DATA=MYLIB.CUSTOMERS NODUP OUT=SORTED;
BY _ALL_;
RUN;

*PROC SORT: trier toutes les colonnes par ordre croissant sans valeurs doublons, les metter dans une table nomméee "Duplicates";
PROC SORT DATA=MYLIB.CUSTOMERS NODUP OUT=SORTED DUPOUT=DUPLICATES;
BY _ALL_;
RUN;

*PROC FREQ: compter le nombre d'occurence des valeurs;
PROC FREQ 	DATA=MYLIB.CUSTOMER_DETAILS;
			TABLES CITY;
RUN;

*PROC FREQ: compter le nombre d'occurence des valeurs, supprimer le pourcentage et cumulé de la colonne "CIty";
PROC FREQ 	DATA=MYLIB.CUSTOMER_DETAILS;
			TABLES CITY/NOPERCENT NOCUM;
RUN;

*PROC FREQ: compter le nombre d'occurence des valeurs, supprimer le pourcentage, le cumulative de la colonne "CIty" 
où les transactions est supérieures ou égales à 500;
PROC FREQ 	DATA=MYLIB.CUSTOMER_DETAILS;
			TABLES CITY * COUNTRY/NOPERCENT NOROW NOCOL;
				WHERE TRANSACTION_AMOUNT >= 500;
RUN;

*créer un newdataset de la table "Customers", nommer "UNI_CUST" et afficher les 3 colonnes;
DATA UNI_CUST;
SET MYLIB.CUSTOMERS(KEEP= CITY COUNTRY TRANSACTION_AMOUNT);
RUN;

*trier les colonnes "City" et "Country" de la table "Customers", 
afficher 3 colonnes sans doublons et nommer la table "UNI_COST";
PROC SORT 	DATA=MYLIB.CUSTOMERS NODUP OUT=UNI_CUST(KEEP=CITY COUNTRY TRANSACTION_AMOUNT);
			BY CITY COUNTRY;
RUN;

*PROC TRANSPOSE: transposer la table par colonne "City", nommer la nouvelle table "Transposed";
PROC TRANSPOSE 	DATA=UNI_CUST OUT=TRANSPOSED;
				BY CITY;
				ID COUNTRY;
				VAR TRANSACTION_AMOUNT;
RUN;

*importer le sheet "data" du fichier "Customer_details" dans la biblio "Mylib", nommer le UNI_COST;
PROC IMPORT DATAFILE='/home/u63990573/customer_details.xlsx'
		    OUT=MYLIB.UNI_CUST
		    DBMS=XLSX
		    REPLACE;
		    SHEET='data'; /* Remplacez 'Sheet1' par le nom de la feuille que vous souhaitez importer */
		    GETNAMES=YES;
RUN;

*afficher les 3 colonnes de la table "UNI_COST" et trier par colonne "city" et "country";
PROC SORT 	DATA=MYLIB.UNI_CUST OUT=UNI_CUST(KEEP= CITY COUNTRY TRANSACTION_AMOUNT);
			BY city country;
RUN;

*transposer la colonne "CIty", ajouter le préfix et le suffix, supprimer "_:" ;
PROC TRANSPOSE 	DATA=UNI_CUST PREFIX=TRANS_ SUFFIX=_DONE OUT=TRANSPOSED5(DROP= _:);
				BY CITY;
				ID COUNTRY;
				VAR TRANSACTION_AMOUNT;
RUN;

*trier la table "Customer_details" par "city" et ensuite par "country" sans index doublons ;
PROC SORT 	DATA=MYLIB.CUSTOMER_DETAILS NODUPKEY OUT=CUSTOMER_DETAILS;
			BY CITY COUNTRY;
RUN;

*transposer la colonne "City" et "ContactName", supprimer "_:";
PROC TRANSPOSE 	DATA=CUSTOMER_DETAILS OUT=TRANSPOSED2(DROP= _:);
				BY CITY CONTACTNAME;
				ID COUNTRY;
				VAR TRANSACTION_AMOUNT;
RUN;

*trier la colonne CONTACTNAME CITY COUNTRY sans valeurs clés doublons, supprimer la colonne COUNTER;
PROC SORT 	DATA=MYLIB.CUSTOMER_DETAILS NODUPKEY OUT=CUST_DETAILS(DROP= COUNTER);
			BY CONTACTNAME CITY COUNTRY;
RUN;

*transposer la colonne CONTACTNAME CITY, supprimer "_:";
PROC TRANSPOSE 	DATA=CUST_DETAILS OUT=TRANSPOSED1(DROP=_:);
				BY CONTACTNAME CITY;
				ID COUNTRY;
				VAR TRANSACTION_AMOUNT;
RUN;

*transposer la colonne CONTACTNAME CITY, supprimer "_:";
PROC TRANSPOSE 	DATA=CUST_DETAILS OUT=TRANSPOSED1(DROP=_:);
				BY CONTACTNAME;
				ID COUNTRY CITY;
				VAR TRANSACTION_AMOUNT;
RUN;

*afficher la table TRANSPOSE;
PROC PRINT DATA=TRANSPOSED;
RUN;

*FIN J2: 2:17:57;