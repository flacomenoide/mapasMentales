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
Personalización de Títulos y Pie de Páginas
===========================================
Los procs que permiten imprimir información usualmente pueden ser personalizados, estos procs pueden hacer uso de las sentencias:
	TITLE
	FOOTNOTE

Sintaxis:
	TITLE opciones 'texto' ... opciones 'texto';
	FOOTNOTE opciones 'texto' ... opciones 'texto';

Opciones:
	COLOR =
	BCOLOR =
	HEIGHT =
	JUSTIFY =
	FONT =
	BOLD
	ITALIC

La altura soporta PT, IN, CM
*/

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

OPCIONES:
	NOOBS
		Evita que se impriman los números de las observaciones

SENTENCIAS OPCIONALES:
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

PERSONALIZACION:
	Se necesita especificar Ubicación y Atributo.
	Ubicación:
		DATA - Todos los datos
		HEADER - Nombres de las variables
		OBS - Datos de las observaciones
		OBSHEADER - Cabecera de las observaciones
		TOTAL - Fila de Totales
		GRANDTOTAL - Fila de los gran totales
*/

PROC PRINT NOOBS;
RUN;

PROC PRINT DATA = EXCEL0;
	ID col2;
	SUM COL1 COL2 COL4;
	FORMAT col1 PERCENT8.;
RUN;

PROC PRINT DATA = EXCEL0
	STYLE(DATA) = {BACKGROUND = GRAY FOREGROUND = WHITE};
	ID col2;
	SUM COL1 COL2 COL4;
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

 /*
PROC FREQ
=========
Permite generar tablas de frecuencia a partir de las variables de un dataset

Sintaxis:
	PROC FREQ;
		TABLES <lista de variables a combinar> / [OPCIONES]
Ejemplo:
	TABLES SEX * YEARSofEDUCATION

OPCIONES:
- LIST
	Imprime las tablas en formato lista en lugar de grid
- MISSPRINT
	Incluye valores missing en las frecuencias, pero no en los porcentajes
- MISSING
 	Incluye valores missing en las frecuencias y en los porcentajes
- NOCOL
	No imprime la columna de porcentajes en las tablas de frecuencias
- NOPERCENT
	No imprime ningún porcenaje
- NOROW
	No imprime los porcentajes en las filas
- OUT = <data set>
	Genera unata Set con los datos de las tablas de frecuencia
*/

PROC FREQ data = excel_format;
	TABLE col1 * col2 / NOROW NOCOL;
RUN;

 /*
PROC TABULATE
=============
- Permite generar reportes tabulares
- Está basado en Table Producing Language

Sintaxis:
	PROC TABULATE [MISSING];
		CLASS <lista de variables de clase>;
		TABLE [<dimensión página>,] [<dimensión fila>,] <dimensión columna>;
	RUN;

TABLE
	Se puede especificar varias veces
	Cada especificación puede llegar a tener 3 dimensiones
	La dimensión default es la de columna
CLASS
	Lista las variables categóricas (Dimensiones) del Data Set
VAR
	Lista las variables continuas del Data Set

Keywords válidos para las dimensiones:
	ALL - Totales
	MAX
	MIN
	MEAN
	MODE
	N
	NMISS
	PCTN - Porcentaje de observaciones para un grupo
	PCTSUM
	STDDEV
	SUM

Se puede personalizar las tablas generadas por PROC TABULATE
OPCIONES:
	FORMAT = <formato>
		Mejora el formato de las tablas generadas
		Se puede especificar formato por variable
	TABLE:
	Estas opciones deben estar separadas por el caracter "/" de la dimensión
	BOX =
		Permite escribir una breve frase que aparece en la esquina superior izquierda de cada reporte
	MISSTEXT =
		Especifica un valor default para las celdas vacías
	ROW = FLOAT
		Permite eliminar las cajas vacías

*/

PROC TABULATE data = excel0 MISSING;
	CLASS col1;
	VAR col4;
	TABLE col1, col4 * MEAN;
RUN;

 /*
PROC REPORT
===========
Permite generar reportes

Sintaxis:
	PROC REPORT NOWINDOWS [MISSING];
		COLUMN <lista de variables>;
		DEFINE <variable> / [OPCIONES] 'COLUMN HEADER';
	RUN;

OPCIONES:
- ACROSS
	Imprime una columna por cada valor de la variable (Sumariza columnas)
- ANALYSIS
	Calcula estadísticas de la variable
- COMPUTED
	Crea una nueva variable que se calcula dentro del bloque compute
- DISPLAY
	Crea una fila por cada observación en el Data Set
- GROUP
	Crea una fila por cada valor único de la variable (Sumariza Filas)
- ORDER
	Crea una fila por observación con los valores ordenados acorde a los valores de la variable

Para cambiar el encabezado de una columna en particular luego de / escribimos entre comillas el texto deseado.
El comportamiento por defecto omite los valores MISSING en las sentencias ORDER y GROUP, para cambiar este comportamiento
se debe agregar la palabra MISSING al PROC.

Se puede insertar saltos de página usando las sentencias, necesita una ubicación (BEFORE o AFTER):
	- BREAK
		Inserta un salto de página por cada valor de la variable
	- RBREAK
		Inserta un salto de página por cada grupo o reporte, necesita una sección GROUP U ORDER

	Los saltos de página pueden usar SUMMARIZE, que imprime los totales en el caso de variables numéricas.

Sintaxis:
BREAK AFTER <variable> / SUMMARIZE;
RBREAK AFTER / SUMMARIZE;

Estadísticas disponibles:
	MAX
	MIN
	MEAN
	MEDIAN
	MODE
	N
	NMISS
	PCTN
	PCTSUM
	STD
	SUM
Para imprimir varios estadísticos hay que separarlos por una "," de la variable deseada en la sentencia COLUMN.

Permite calcular nuevas variables usando el bloque COMPUTE ... ENDCOMP, en este bloque se puede agregar código para calcular una nueva variable.
Sintaxis:
	DEFINE nuevaVariable / COMPUTED;
	COMPUTE nuevaVariable / opciones;
		<cálculos>
	ENDCOMP;

	- Al usar una variable preexistente se debe usar una estadística asociada (Default = SUM)
	- Para usar variables de texto hay que agregar la opción CHAR y en lo posible también la opción LENGTH
	- Es conveniente usar formatos personalizados para generar agrupaciones para evitar crear nuevas variables

PERSONALIZACION:
	Se pueden personalizar diferentes ubicaciones:
		HEADER
		COLUMN
		SUMMARY
*/

PROC REPORT data = excel0 NOWINDOWS MISSING;
	COLUMN col1 col2,(MEAN N MIN MAX) col4 X TEXTO;
	BREAK AFTER COL1 / summarize style=[font_weight=bold];
	DEFINE COL1 / GROUP;
	DEFINE COL2 / ANALYSIS MEAN;
	DEFINE COL4 / DISPLAY "Columna 4";
	DEFINE X / COMPUTED;
	COMPUTE X;
		X = col4/2;
	ENDCOMP;
	DEFINE TEXTO / COMPUTED;
	COMPUTE TEXTO / CHAR LENGTH = 200;
		TEXTO = "Se puede personalizar este texto por línea usando IF";
	ENDCOMP;
RUN;

 /*
PROC TEMPLATE
=============
Permite crear templates usando PROC TEMPLATE, pero su uso es muy arcaico.
Existen tamplates preestablecidos que se pueden usar.
Los estilos se pueden usar en diferentes PROCs (PRINT, REPORT y TABULATE) mediante la sentencia STYLE=.
*/
PROC TEMPLATE;
	LIST styles;
RUN;

 /*
PROC TRANSPONSE
===============
Permite convertir las filas en columnas y viceversa.

Sintaxis:
PROC TRANSPOSE
	DATA = <data set>
	OUT = <data set resultante>;

Sentencias adicionales:
BY <lista de variables>
	Permite especificar las variables que se quieren mantener como tal.
	Existirá una observación por cada nivel del BY.
	El data set debe estar ordenado previamente por la variable BY.
ID <lista de variables>
	Lista las variables que se van a usar para construir nuevas.
	El contenido de estas variables se usa como el nombre de las nuevas columnas.
VAR <lista de variables>
	Lista las variables cuyo valor se quiere trasponer.
*/

PROC TRANSPOSE
	DATA = excel2
	OUT = excel_t;
	ID col4;
	VAR col1-col3;
RUN;

 /*
PROCs para generación de estadísticos
=====================================
PROC UNIVARIATE
===============
Genera estadísticas y gráficos que describen la distribución de una variable simple.
Estadísticas disponibles:
- MEAN
- MEDIAN
- MODE
- Standard Deviation
- Sesgo
- Kurtosis

Sintaxis:
	PROC UNIVARIATE [opciones];
		VAR <lista de variables>;
		[PLOT_REQ <lista de variables> / <opciones>];

Si no se define VAR se calculan las estadísticas para todas las variables continuas.
Opciones ue se pueden agregar:
- NORMAL
	Produce un test de normalidad
PLOT_REQ permite generar gráficos:
- CDFPLOT	>> Distribución acumulada
- HISTOGRAM	>> Histograma
- PPPLOT	>> Gráfica de probabilidad
- QQPLOT	>> Gráfico Quantile/Quantile

Si no se define VAR se generarán gráficos para todas las variables.
Opciones de PLOT_FREQ para sobreponerlas en el gráfico:
- BETA
- EXPONENCIAL
- GAMMA
- LOGNORMAL
- NORMAL
- WEIBULL
*/

PROC UNIVARIATE DATA = helados NORMAL noprint;
	VAR ubicacion cajasVendidas;
	QQPLOT cajasVendidas / NORMAL;
RUN;

 /*
PROC MEANS
==========
Permite generar estadísticas específicas de las variables numéricas.
No genera gráficos.
Sintaxis:
	PROC MEANS <estadistica>;
		VAR <lista de variables>;
Estadísticas disponibles:
CLM			>> Límites de confianza de ambos lados
CSS			>> Suma de cuadrados corregidos
CV			>> Coeficiente de variación
KURTOSIS
LCLM		>> Límite de confianza inferior
MAX
MEAN
MIN
MODE
N
NMISS
MEDIAN
Q1 = P25
Q2 = P50 = MEDIAN
Q3 = P75
P1..P99
RANGE
SKEWNESS	>> Sesgo
STDDEV
STDERR
SUM
SUMWGT
UCLM		>> Límite de confianza superior
USS			>> Suma de cuadrados de la varianza no corregida
VAR			>> Varianza
PROBT		>> Probabilidad para t student

El valor default para los límites de confianza es 0.05 (95%)
La sentencia ALPHA permite cambiar el límite de confianza
*/

PROC MEANS DATA = helados SKEWNESS KURTOSIS;
RUN;

 /*
PROC TTEST
==========
Genera un t-test, que se usa para comparar medias
Sintaxis:
	Comparación Simple
	PROC TTEST [PLOTS = <requerimiento>] [H0 = <n>] [<opciones>];
		[CLASS <variable>;]
		[VAR <variable>;]
		[PAIRED <variable>;]

CLASS
	Identifica la variable categórica por la cual separar la muestra
VAR
	Identifica las variables a analizar
PAIRED
	Identifica los pared de variables a analizar

Opciones:
ALPHA = <n>
	Límite de confianza (0-1)
CI = <tipo>
	Tipo de intervalo de confianza para la desviasión estándar:
	- EQUAL
	- UMPU
	- NONE
H0 = <n>
	Hipótesis nula (Default 0)
NOBYVAR
	Pone los nombres de las variables en la tabla de salida
SIDES = <tipo>
	Existen 2 tipos:
	- LOWER
	- UPPERR

Requerimientos disponibles:
	ALL
	BOXPLOT
	HISTOGRAM
	INTERVALPLOT
	NONE
	QQPLOT
	SUMMARYPLOT
	PAIRED:
	- AGREEMENTPLOT
	- PROFILESPLOT
*/

* Verifica si la media es significativamente diferente de H0 ;
PROC TTEST DATA = helados H0=0;
	VAR cajasVendidas;
RUN;

* Comparación de 2 muestras independientes separando los datos por clase;
PROC TTEST DATA = helados;
	CLASS Sabor;
	VAR cajasVendidas;
RUN;

* Comparación pareada ;
PROC TTEST DATA = helados;
	PAIRED cajasVendidas * UBICACION;
RUN;

PROC TTEST DATA = helados PLOTS = BOXPLOT;
	CLASS Sabor;
	VAR cajasVendidas;
RUN;
