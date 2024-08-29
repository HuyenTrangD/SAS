*libname nom_lib chemin: créer une nouvelle bibliothèque de façon permanente; 
libname mylib '/home/u63990573';

PROC CONTENTS DATA= MYLIB.UNI_CUST;
RUN;

*voir les info de la table dont la colonne "variable" est triée par ordre ABC;
PROC CONTENTS DATA= SASHELP.CARS;
RUN;

*voir les info de la table dont la colonne "variable" est triée par ordre 123;
PROC CONTENTS DATA= SASHELP.CARS VARNUM;
RUN;

PROC CONTENTS DATA= MYLIB._ALL_;
RUN;

DATA SAMPLE;
NAME="Thomas    Cruise    Mapothe";
LEN= LENGTH(NAME);

DATA SAMPLE1;
NAME =" Thomas ";
LEN = LENGTH(NAME);
NEW = TRIMN(NAME);
LEN1 = LENGTH(NEW);
RUN;

DATA SAMPLE1;
NAME =" Thomas ";
LEN = LENGTH(NAME);
NEW = STRIP(NAME);
LEN1 = LENGTH(NEW);
RUN;

*COMPRESS: supprimer tous les espaces vides;
COMPRESS= COMPRESS(NAME);
LEN_1= LENGTH(COMPRESS);

*COMPBL(compress blank): supprimer les espaces vides et garder un seul espace;
COMPBL= COMPBL(NAME);
LEN_2= LENGTH(COMPBL);
RUN;

*COMPRESS: supprimer les caractères souhaités;
DATA SAMPLE2;
VALUES= "asdlkfja127394;%";
NEW_VALUE= COMPRESS(VALUES, ';%');
RUN;

*il faut respecter la casse 'a' ou "A";
DATA SAMPLE2;
VALUES= "asdlkfjA127394;%";
NEW_VALUE= COMPRESS(VALUES, 'a');
RUN;

*il faut respecter la casse 'a' ou "A";
DATA SAMPLE2;
VALUES= "asdlkfjA127394;%";
NEW_VALUE= COMPRESS(VALUES, 'a', 'i');
RUN;

DATA SAMPLE2;
VALUES= "as dlkfjA127394;%";
*modificateur 'i'(ignore case): ignore la casse, donc supprimer 'a' & 'A';
NEW_VALUE= COMPRESS(VALUES, ,'iad');
RUN;

/*D'autres modificateurs:
'k'= keep: garder les caractères mentionnés ou 'ak' pour garder abc ou "kd" pour garder 123
's'= space: supprimer les espaces blancs
'a'= alphabetic: supprimer toutes les lettres (A-Z, a-z)
'l'= lowercase: supprimer les minuscules
'u'= uppercase: supprimer les majuscules
'd'= digit: supprimer tous les chiffres (0-9)
'p'= punctuation: supprimer . , ,, ;, %, etc.
'iad': ignore la casse, supprime (A-Z et a-z) et (0-9)*/

DATA NAME;
FIRST= "THOMAS";
LAST= "CRUISE";
FULL= FIRST ||" "|| LAST;
RUN;

DATA NAME1;
FIRST= "THOMAS";
LAST= "CRUISE";
FULL= CAT(FIRST, LAST);
RUN;

DATA NAME2;
FIRST="THOMAS";
LAST="CRUISE";
FULL1=CATX(FIRST, LAST);
RUN;

DATA NAME2;
FIRST= "THOMAS";
LAST= "CRUISE";
FULL1=CATX('-',FIRST, LAST);
RUN;

