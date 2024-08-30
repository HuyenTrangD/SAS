*créer un table;
DATA CARD_INFO;
INPUT CARD_NUMBER $ 1-50;
DATALINES;
4444999932332322
4565434354313233
5454796368213213
5453486498761516
5466897896351648
5669858796531316
;
RUN;

*SUBSTR: extraire 4 chiffres à partir de l'index 12,
SUBSTR: remplacer 8 caractères à partir de l'index 9 par *;
DATA SAMPLE;
SET CARD_INFO;
LAST_DIGITS= SUBSTR(CARD_NUMBER, 12, 4);
SUBSTR(CARD_NUMBER, 5, 8)= "********";
RUN;

*créer une liste de noms
CARDS: 1ère version, assurer la compatibilité avec les anciens programmes SAS
DATALINES: nouvelle version, préféré; 
DATA SAMPLE;
INPUT NAME $ 1-25;
CARDS;
thomas
cruise
mapother
john
ROMAN
MAGGY
;
RUN;

*UPCASE: transformer en majuscules
LOWCASE: transformer en minuscules
PROPCAS: 1ère lettre du mot en majuscule;
DATA CHANGE_CASE;
SET SAMPLE;
UPPER= UPCASE(NAME);
LOWER= LOWCASE(NAME);
PROPER= PROPCASE(NAME);
SUBSTR(NAME, 3, 5)= 'DD';
RUN;

*TRANWRD: remplacer des mots;
DATA SAMPLE;
NAME="Thomas Cruise Mapother";
CHANGED=TRANWRD(NAME, "Mapother", "Enough");
SECOND_EXAMPLE= "John is a good boy. That boy is naughty.";
CHANGED_2= TRANWRD(SECOND_EXAMPLE, 'boy', 'girl');
RUN;

*espace = séparer des valeurs;
DATA NAME_LIST;
    INPUT NAME $ GENDER $;
    DATALINES;
MS.RAJEEV M
MR.JULLY F
MS.MALHOTRA F
MR.KARTIK M
MS.SINHA F
MS.DIVA F
;
RUN;

*TRANWRD & IF THEN ELSE IF THEN ELSE;
DATA SAMPLE2;
SET NAME_LIST;

IF UPCASE(GENDER)= 'M' THEN NAME2= TRANWRD(NAME, "MS", "MR");
ELSE IF UPCASE(GENDER)= 'F' THEN NAME2= TRANWRD(NAME, "MR", "MS");
ELSE NAME2= NAME;

RUN;

*TRANSLATE: remplacer 'AM' par 'IX';
DATA TRANSLATE;
NAME='SAMEER';
NAME2= TRANSLATE(NAME, 'IX', 'AM');
RUN;

*remplacer uniquement A par I car Z n'existe pas;
DATA TRANSLATE;
NAME='SAMEER';
NAME2= TRANSLATE(NAME, 'IX', 'AZ');
RUN;

*INDEX: afficher l'index de 'A' (pas 'a') et 
avoir un seul argument(on ne peut pas ajouter 'i' pour ignorer la casse);
DATA NEW;
SET NAME_LIST;
EXISTS= INDEX(NAME, 'A');
*afficher seulement les lignes où exisent 'A';
IF EXISTS > 0 THEN OUTPUT;

RUN;

*FIND: afficher l'index de 'A' et 'a' avec 'i';
DATA NEW;
SET NAME_LIST;
EXISTS= FIND(NAME, 'a', 'i');

IF EXISTS > 0 THEN OUTPUT;

RUN;

*chercher l'index de la 1ère lettre du 1er 'country'(sans indiquer l'index);
DATA SAMPLE2;
STRING= "India is a great country to live. This is the country of festivals";
EXISTS= FIND(STRING, 'country');
RUN;

*chercher l'index de la 1ère lettre du 2è 'country'(indiquer l'index après le 1er 'country');
DATA SAMPLE2;
STRING= "India is a great country to live. This is the country of festivals";
EXISTS= FIND(STRING, 'country', 20);
RUN;

/*
REGULAR EXPRESSIONS
^: commencer par,
$: finir par,
\D: tout sauf digits,
\d: digits,
?: question,
|: or,
*: repeating,
( i:): turn on the case search
(-i:): turn off the case search
*/

*PRXMATCH: dans la colonne 'Remarks', chercher les lignes qui commencent par 's' ou 'f' et ignorer la casse 'i';
DATA TEST;
SET TRANSACTIONS;
FLAG_1= PRXMATCH("/^s|^f/i", REMARKS); *index= 0 car ils sont au début des lignes;
FLAG_2= PRXMATCH("/\d/", REMARKS); *renvoyer la position des 1ers digits dans les lignes;
RUN;

DATA TEST;
INPUT COMMENTS $ 1-100;
DATALINES; *il faut laisser l'espace d'une ligne pour il prend en compte de la 1ère ligne;

the customer called from his no. 9765543331 and made the pmt of rs. 989782
registered the customer's number as 8844993366 residing in the zip code ares 998855
date of birth in ddmmyy format was 08081988 and the number updated was 9988998855
;
RUN;

*PRXMATCH: chercher le numéro de téléphone de 10 digits {10};
DATA TEST2;
SET TEST;
MOBILE_NUMBER= SUBSTR(COMMENTS, PRXMATCH("/\d{10}/", COMMENTS), 10);
RUN;








