*voir les info de la table dont la colonne "variable" est triée par ordre ABC;
PROC CONTENTS DATA= SASHELP.CARS;
RUN;

*voir les info de la table dont la colonne "variable" est triée par ordre 123;
PROC CONTENTS DATA= SASHELP.CARS VARNUM;
RUN;
