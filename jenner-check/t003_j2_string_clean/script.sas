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
NEW_VALUE= COMPRESS(VALUES, 'a', 'i');
RUN;

DATA SAMPLE2;
VALUES= "as dlkfjA127394;%";
*modificateur 'i'(ignore case): ignore la casse, donc supprimer 'a' & 'A';
NEW_VALUE= COMPRESS(VALUES, ,'iad');
RUN;

PROC PRINT DATA=SAMPLE2;
TITLE 'COMPRESS AVEC MODIFICATEURS';
RUN;
