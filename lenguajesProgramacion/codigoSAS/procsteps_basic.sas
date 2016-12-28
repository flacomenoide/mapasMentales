* PROC Steps ;
 /*
Sintaxis General:

PROC <nombre> [opciones] [DATA = <dataset>];
RUN;

- Si no se define el DATA SAS usará el data set más recientemente creado
- La opción BY es obligatoria solamente en el PROC sort, ya que le dice a SAS cómo ordenar los datos
- El uso de BY en otros PROC indica que se debe ejecutar un análisis seperado por cada valor de la variable definida en la opción
- Todos los PROC SAS asumen que los Data sets ya se encuentran ordenados a excepción del PROC sort
- TITLE y FOOTNOTE aplican a la salida del PROC ejecutado
- Se pueden agregar hasta 10 títulos o notas al pie
- Por default SAS usa los nombres de las variables como etiquetas, pero si especificamos la opción LABEL se pueden crear descripciones más específicas (hasta 256 caracteres)
- Si se especifica un label dentro de un PROC step estos existirán solamente durante la ejecución del PROC step
- Todo PROC tiene la capacidad de almacenar su salida en un Data Set usando la sentencia OUT = <dataset>
- Cuando se invoca un Data set en un proc se puede usar la opción WHERE que permite limitar las observaciones del data set antes de usarlo
*/
* Una manera para poder chequear las opciones del sistema es usar el PROC options;
PROC OPTIONS;
RUN;

 /*
PROC CONTENTS
=============
- Imprime el contenidode la estructura de un Data set.
*/

PROC CONTENTS DATA=helados;
	TITLE "Data Set: Helados";
	TITLE2 "Agregando un Título";
	FOOTNOTE "Nota al Pie agregada";
RUN;
/*
PROC IMPORT
===========
- Tiene la capacidad de identificar automáticamente los tipos de datos basado en las 20 primeras líneas de datos.
- Asigna automáticamente la longitud de las variables.
- Reconoce automáticamente algunos formatos de datos de acuerdo a la extensión del archivo (csv o txt).
- Reconoce 2 delimitadores consecutivos como un campo NULL.
- Lee datos entrecomillados, tomando solo el valor de los mismos sin las comillas.
- Si una línea termina antes de lo esperado asigna NULL a los campos faltantes.
- Permite usar la primer línea para asignar los nombres de las variables.
- Para importar archivos EXCEL es necesario tener instalado SAS/ACCESS
OPCIONES
	DBMS =, se usa si un archivo no es csv o txt.
		EXCEL, XLS, XLSX (Excel)
		Opciones:
			SHEET = "Nombre de hoja"
				Especifica que hoja de la planilla se necesita leer.
			RANGE = "Nombre de hoja$UL:BR"
				Permite leer solamente un rango de datos de una hoja determinada de la planilla.
				UL = Upper Left (Celda Inicial del rango)
				BR = Bottom Right (Celda Final del rango)
			MIXED = YES
				Permite tener una celda mixta, con valores caractér y numéricos en lugar de convertirlos a NULL	
	REPLACE, si el data set ya existe este es reemplazado.
	OUT =, Especifica el nombre del data set de salida.
	DATAROWS = n, Inicia a leer los datos en la línea n.
	DELIMITER = 'c', permite definir un delimitador personalizado, el default es espacio en blanco.
	GETNAMES = NO, evita asignar el nombre de las variables a partir de la primera fila del archivo, el default es YES.
	GUESSINROWS = n, usa n filas para determinar los tipos de datos de las variables, el default es 20.
*/
PROC IMPORT
	DATAFILE = "C:\Users\MiguelJ\Documents\tests\archivoxls.csv"
	OUT = excel0;
RUN;

PROC IMPORT
	DATAFILE = "C:\Users\MiguelJ\Documents\tests\archivoxls.csv"
	OUT = excel1 REPLACE
	DBMS = CSV;
	GETNAMES = NO;
RUN;

/*
PROC SORT
=========
Permite organizar los datos, para reportes, combinar data sets o antes de usar la sentencia BY en algún PROC.
Por default se ordenan los datos de manera ascendente, si necesitamos ordenar de manera descendente se debe especificar la opción DESCENDING
antes del nombre de cada variable a cambiar el orden
Sintaxis:
PROC SORT [DATA = <data set origen>] [OUT = <data set destino>];
	BY [ASCENDING/DESCENDING] <lista de variables>;
RUN;

OPCIONES:
	DATA =
		Permite definir el data set de entrada
	OUT =
		Permite definir el data set de salida
		Si no se especifica esta opción se reemplazará el data set original
		Si se especifica NODUPKEY se eliminan las observaciones duplicadas
	DUPOUT =
		Especifica el data set en donde se van a poner las observaciones duplicadas

	OPCIONES DE ORDENAMIENTOS
		SORTSEQ = ASCII
			Orden: blancos, números, mayúsculas, minúsculas
		SORTSEQ = EBCDIC
			Orden: blancos, minúsculas, mayúsculas, números
		SORTSEQ = LINGUISTIC (...)
			Permite ordenar letras sin importar si son mayúsculas o minúsculas
			(STRENGTH = PRIMARY)
				Los caracteres numéricos que están almacenados como string se pueden ordenar numéricamente
			(NUMERIC_COLLATION = ON)
				
*/

PROC SORT DATA = excel0;
	BY DESCENDING col1;
RUN;

PROC SORT DATA = excel0 OUT = excel2;
	BY col3;
RUN;

PROC SORT DATA = excel1 OUT = excel3 SORTSEQ = EBCDIC;
	BY DESCENDING var4;
RUN;

PROC SORT DATA = excel1 OUT = excel4 SORTSEQ = ASCII;
	BY DESCENDING var4;
RUN;

PROC SORT DATA = excel1 OUT = excel5 SORTSEQ = LINGUISTIC (NUMERIC_COLLATION = ON);
	BY DESCENDING var4;
RUN;

 /*
PROC PRINT
==========
Permite imprimir el contenido de un data set.
Sintaxis:
PROC PRINT [DATA = <data set>] [OPCIONES];
	[SENTENCIAS OPCIONALES];
RUN;

OPCIONES
	NOOBS
		Evita que se impriman los números de las observaciones

SENTENCIAS OPCIONALES
	BY
		Inicia una nueva sección de impresión por cada valor de la variable listada
	ID
		Cambia los números de observaciones por los valores de las variables definidas en el ID
	SUM
		Imprime la suma de las variables listadas
	VAR
		Indica las variables a imprimir y su orden
	FORMAT
		Permite interpretar los valores originales con formatos particulares
*/

PROC PRINT NOOBS;
RUN;

PROC PRINT DATA = excel0;
	ID col2;
	FORMAT col1 PERCENT8.;
RUN;

 /*
PROC FORMAT
===========

*/
