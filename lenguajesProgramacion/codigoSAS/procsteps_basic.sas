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
- Permite crear formatos propios para su posterior uso
- Pueden ser usados en sentencias PUT
- Si se definen formatos en un Data Step, estos forman parte del Data Set, si se usan en un Proc Step son temporales
- Si un formato es definido para datos de tipo caracter su nombre debe empezar con $

Sintaxis:
PROC FORMAT;
	VALUE <nombre> rango1 = 'Valor del formato 1' ... rangoN = 'Valor del formato N';

Ejemplos de Rangos Válidos
'A' = 'Asia'
1, 3, 5, 7, 9 = 'Impar'
5000 - HIGH = 'Inalcanzable'
13 -< 20 = 'Jóvenes'
0 <- HIGH = 'Positivo mayor a cero'
OTHER = 'Datos Erroneos'
*/

PROC FORMAT;
	VALUE NUMEROS
		1, 3, 5, 7, 9 = "Impar"
		2, 4, 6, 8, 10 = "Par"
		0 = "Cero"
		OTHER = "Mayor a 10 o Menor a 0";
RUN;

DATA excel_format;
	SET excel0;
	FORMAT col1 NUMEROS. col2 NUMEROS.;
RUN;

 /*
PROC MEANS
==========
Permite calcular estadísticos de variables numéricas de un Data Set, si no se define ninguna variable se calculan los estadísticos para todas las variables numéricas.
Sintaxis:
	PROC MEANS [opciones] [estadísticos];
		[Opciones de control]
	RUN;

OPCIONES:
	MAXDEC = n [MISSING]
		- Cantidad de posiciones decimales
		- Si se especifica MISSING se considera a los mising como un grupo válido

Estadísticos disponibles:
	MAX - Valor máximo
	MIN - Valor mínimo
	MEAN - Promedio
	MEDIAN - Mediana
	MODE - Moda
	N - Cantidad de valores no MISSING
	NMISS - Cantidad de valores MISSING
	RANGE - Rango de valores
	STDDEV - Desviación Estándar
	SUM - Suma

Si no se especifican estadísticos se calculan los default. Los estadísticos calculados por default son:
	N
	MEAN
	STDDEV
	MIN
	MAX

Opciones de Control:
	BY
		Calcula los estadísticos por cada valor de la variable definida
	CLASS
		Realiza un análisis separado por cada nivel de valores de la variable, su salida es más compacta que BY y los datos no necesitan estar previamente ordenados
	VAR
		Especifica qué variables numéricas se usarán para calcular los estadísticos

Opciones para exportar resultados:
	OUTPUT OUT = <data set>
		Permite exportar los resultados a un data set en particular
*/

PROC MEANS DATA = excel0 MAXDEC = 2 MISSING;
RUN;

PROC MEANS DATA = excel0 MIN MAX RANGE SUM STDDEV;
RUN;

PROC SORT DATA = excel_format;
	BY col2;

PROC MEANS DATA = excel_format;
	CLASS col1;
	BY col2;
RUN;

PROC MEANS DATA = excel_format;
	VAR COL3 COL4;
	OUTPUT OUT = excel_mean_export MIN = COL3_MIN COL4_MIN MAX = COL3_MAX COL4_MAX;
RUN;
