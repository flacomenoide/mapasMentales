* Fundamentos de SAS ;
* ================== ;
* https://support.sas.com/delwiche ;

 /*
Los comentarios en SAS se pueden realizar de 2 maneras:
 1) Para comentar una línea de codigo se usa "*" an inicio y ";" al final
 2) Para comentar varias líneas de codigo inicia con /* y se finaliza con * /
	- Si se opta por la segunda manera no comenzar el comentario en la 1er columna
	  ya que algunos SO interpretan /* como final de un job.

SAS Data Sets
=============
Los nombres de los Data sets no son case sensitive

Los Data sets se autodocumentan y almacenan:
 - Nombre del Data set
 - Fecha de Creacion
 - Informacion de cada variable
	>> Nombre
	>> Label (Si existe)
	>> Tipo
	>> Longitud
	>> Posicion en el Data set

Los data sets de SAS son el sinonimo de una tabla en una base de datos consta de:
 - Observaciones (filas)
 - Variables (columnas)
	>> Hasta la version 9.1 los Data sets se limitaban a 32676 variables
	>> Despues de la version 9.1 la cantidad de variables dependen de los recursos disponibles

Las variables pueden ser de 2 tipos:
 - Numerico
	>> Pueden contener + - . y E
	>> Los datos perdidos son representados por un punto "."
 - Caracter
	>> Tienen un límite de 32767 caracteres
	>> Los datos perdidos son representados por un espacio en blanco

Reglas que deben cumplir las variables:
 - Los nombres de las variables pueden tebner hasta 32 caracteres
 - Los nombres de las variables deben empezar con letras o _
 - Los nombres de las variables soportan: letras, numeros y _, no soportan caracteres especiales
 - Los nombres de las variables no son case sensitive, en el caso de impresion de un avariable usa la primera ocurrencia
*/


LIBNAME mj 'C:\Users\MiguelJ\Documents\tests';

data mj.prueba;
	input a b;
	datalines;
		1 2
		3 4
		5 6

proc print data=mj.Prueba;
run;
