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

PROC PRINT DATA=TEST2;
VAR MOBILE_NUMBER;
TITLE 'NUMEROS DE TELEPHONE EXTRAITS';
RUN;
