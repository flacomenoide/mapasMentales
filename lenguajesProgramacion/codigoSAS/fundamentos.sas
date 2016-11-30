* Comentarios entre Asterisco y punto y coma ;
LIBNAME mj 'C:\Users\MiguelJ\Documents\tests';

data mj.prueba;
	input a b;
	datalines;
		1 2
		3 4
		5 6
run;
