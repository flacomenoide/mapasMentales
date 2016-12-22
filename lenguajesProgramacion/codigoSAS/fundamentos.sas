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
Los nombres de los Data sets no son case sensitive.
Los nombres de los Data sets solo pueden tener hasta 32 caracteres.
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
 - Los nombres de las variables pueden tener hasta 32 caracteres
 - Los nombres de las variables deben empezar con letras o _
 - Los nombres de las variables soportan: letras, numeros y _, no soportan caracteres especiales
 - Los nombres de las variables no son case sensitive, en el caso de impresion de un avariable usa la primera ocurrencia
Principales componentes de un programa SAS
==========================================
Cada uno trae sus propios Steps que en su mayoría son excluyentes.
Un Step SAS termina cuando encuentra:
 - un nuevo step
 - RUN;
 - QUIT;
 - STOP;
 - ABORT;
O cuando termina el programa
Tipos de Steps:
- Data Steps (Data Sets)
	>> Lee y modifica datos
	>> Permite incluir:
		* DO LOOPs
		* IF ... THEN / ELSE
	>> Tiene un Loop interno que se ejecuta línea a línea y observacion por observacion
 - Proc Steps (Ejecucion de Procesos)
	>> Analiza datos, ejecuta funciones o imprime reportes
	
Librerías SAS
=============
- Son ubicaciones donde se almacenan los Data sets SAS se definen con LIBNAME.
- WORK es la librería default, la cual es temporal, por lo que su contenido se borra al cerrar la sesión.
- Si no se especifica una librería SAS usará el default (WORK).
- Los nombres de las librería solo pueden tener hasta 8 caracteres.
- Un sinónimo de una librería es un directorio
Sintaxis para definir una librería:
LIBNAME <nombre> <Directorio> [opciones];
*/

LIBNAME MJ 'C:\Users\MiguelJ\Documents\tests';

 /* DATA STEP
    =========
Sentencia INPUT:
- Se definen las variables del Data set
- Le dice a SAS como leer los datos crudos
- Seguido a la palabra INPUT se escribe la lista de variables separadas por espacio en el orden de aparicion
- Si las variables son caracteres se debe poner el símbolo $ después del nombre de la variable
Estilos de input
================
SAS trabaja con 3 estilos de input:
- Lista
- Columna
- Formateado
Además SAS trabaja con punteros que permiten moverse a diferentes posiciones en una línea o a diferentes líneas
	+n >> Permite moverse n caracteres a la derecha de la posición actual
	@n >> Permite moverse a la posición n de la línea actual
	@string >> Permite moverse al final de la primera aparición del string definido
	/ >> Permite continuar la lectura del registro en la siguiente línea
	#n >> Permite saltar a la línea n para continuar la lectura del registro, se puede usar para volver hacia atras
	@@ >> Indica a SAS que considere la posición actual como el fin de línea para que inicie la lectura de un nuevo registro
	@ >> Indica a SAS que debe esperar una nueva sentencia INPUT o un fin del DATA STEP para liberar la información de esa variable
Los Estilos de INPUT se pueden combinar
*/

* LIST INPUT ;
* ========== ;
* Implica la lectura de variables mediandte separadores (espacio en blanco default) ;

* Importar datos Manualmente ;
* Es necesaria la sentencia DATALINES, la misma debe ser la última del Data step ;
* A partir de la sentencia DATALINES todo es considerado dato hasta encontrar un punto y coma ;
DATA datos_manual_datalines;
	INPUT a b;
	DATALINES;
		1 2
		3 4
		5 6
		;
* La sentencia CARDS es sinonimo de DATALINES ;
DATA datos_manual_cards;
	INPUT a b c $;
	CARDS;
		1 2 a
		3 4 b
		5 6 c
		;

 /* Importar datos Externos
Es necesaria la sentencia INFILE
 - La sentencia INFILE se usa para decirle a SAS el nombre del archivo y su directorio
 - La sentencia INFILE debe estar antes que la sentencia INPUT
 - Al importar datos externos se evita que los datos originales sean alterados
 - SAS asume que la longitud máxima de las líneas de un archivo es de 256 caracteres
 - Si la longitud máxima de las líneas supera los 256 caracteres hay que especificarla en 
   la opcion LRECL = <longitud> en la sentencia INFILE
Contenido del archivo presidentes.dat:
Adams F 2
Lincoln R 16
Grant R 18
Kennedy D 35
*/

DATA Presidentes_USA;
	INFILE "C:\Users\MiguelJ\Documents\tests\presidentes.dat";
	INPUT presidente $ partido $ cantidad;
RUN;

 /*
- Si en la sentencia INPUT hay más variables definidas que campos en el archivo externo
   SAS buscará las variables faltantes en la siguiente línea del archivo
- En el archivo externo los valores NULL deben estar especificados como .
Contenido del archivo ranas.dat:
rana1 2.1 1.9 . 3.0
rana2 2.6 2.5 1.1 .5
rana3 3.1 3.8 . .
rana4 5.3 3.2 1.9 2.6
rana5 1.38 1.3 1.8
1.5
rana6 2.27 1.1 . .
*/
DATA saltos_de_ranas;
	INFILE "C:\Users\MiguelJ\Documents\tests\ranas.dat";
	INPUT
		nombre $
		peso
		salto1
		salto2
		salto3;
RUN;

* COLUMN INPUT ;
* ============ ;
* Implica la lectura de variables de acuerdo a la posición de los caracteres en la línea del archivo ;
* No se requiere separadores de campos ;
* Variables con valor NULL pueden ser espacios en blanco ;
* Variables de tipo caracter pueden tener espacios en blanco ;
* Se pueden omitir variables no deseadas ;
* Formato: ;
* INPUT <variable> [$] <n>-<m> ... ;
 /*
Contenido del archivo arosCebolla.dat:
Columbia Peaches      35  67  1 10  2  1
Plains Peanuts       210      2  5  0  2
Gilroy Garlics        151035 12 11  7  6
Sacramento Tomatoes  124  85 15  4  9  1
*/

DATA Venta_Aros;
	INFILE "C:\Users\MiguelJ\Documents\tests\arosCebolla.dat";
	INPUT
		visitante $ 1-20
		ventasAros 21-24
		ventasBebidas 25-28
		hitsLocal 29-31
		hitsVisita 32-34
		carrerasLocales 35-37
		carrerasVisita 38-40;
RUN;

 /*
FORMATTED INPUT - INFORMATS
===========================
- Permiten que SAS interprete los datos de entrada de acuerdo al formato con el que fueron escritos
- Son muy útiles cuando se trabaja con datos no estándar (un número no estándar puede ser un número hexadecimal)
- SAS interpreta las fechas como un número que cuenta la cantidad de días a partir del 01-01-
- Todos los informat incluyen el . sin este se considera al informat como un nombre de variable
- Los INFORMATS van seguido al nombre de la variable en la sentencia INPUT
- Se puede definir un informat una solaa vez agrupando las variables entre paréntesis
Tipos de INFORMATS (formas generales):
 > caracter $INFORMATw.
 > numérico INFORMATw.d
 > fecha INFORMATw.
	$ >> indica que es un INFORMAT de tipo caracter
	w >> indica el ancho total de la variable
	d >> indica la cantidad de decimales
	. >> identifica que es un INFORMAT
Los INFORMATS pueden usar modificadores, los cuales permiten leer un formato hasta encontrar un separador o el fin de línea.
Contenido del archivo competencia.dat:
Alicia Grossman  13 c 10-28-2012 7.8 6.5 7.2 8.0 7.9
Matthew Lee       9 D 10-30-2012 6.5 5.9 6.8 6.0 8.1
Elizabeth Garcia 10 C 10-29-2012 8.9 7.9 8.5 9.0 8.8
Lori Newcombe     6 D 10-30-2012 6.7 5.6 4.9 5.2 6.1
Jose Martinez     7 d 10-31-2012 8.9 9.510.0 9.7 9.0
Brian Williams   11 C 10-29-2012 7.8 8.4 8.5 7.9 8.0
*/

DATA respuesta;
   INFILE "C:\Users\MiguelJ\Documents\tests\competencia.dat";
   INPUT
	Nombre $16.
	Edad 3. +1
	Tipo $1. +1
	Fecha MMDDYY10.
	(Score1 Score2 Score3 Score4 Score5) (4.1);
RUN;

 /*
Contenido del archivo trafico.dat
freeway 408                          3684 3459
surface Martin Luther King Jr. Blvd. 1590 1234
surface Broadway                     1259 1290
surface Rodeo Dr.                    1890 2067
freeway 608                          4583 3860
freeway 808                          2386 2518
surface Lake Shore Dr.               1590 1234
surface Pennsylvania Ave.            1259 1290
*/

DATA trafico;
   INFILE "C:\Users\MiguelJ\Documents\tests\trafico.dat";
   INPUT tipo $ @;                        
   	IF tipo = 'surface' THEN DELETE;       
   		INPUT nombre $ 9-38 trafico_maniana trafico_tarde; 
RUN;

 /*
OPCIONES DE INFILE
===================
Permite controlar el input
- FIRSTBOS > Indica a partir de qué línea se comienzan a leer los datos
- OBS > Indica hasta qué línea leer observaciones
- MISSOVER > Le idica a SAS que no hace falta ir a buscar las variables faltantes en la siguiente línea (INPUT tipo lista)
- TRUNCOVER > Le indica a SAS que no pase a la siguiente línea a buscar variables faltantes (INPUT columna o formato)
- DLM o DELIMITER > Permite definir un delimitador diferente al default
- DLMSTR > Permite usar un string como delimitador en lugar de un caracter simple ('09'x por ejemplo que representa a TAB)
- DSD > "Delimiter Sensitive Data" tiene varias características:
	Omite los delimitadores que se encuentren entre comillas
	No toma en cuenta las comillas como parte del dato
	Interpreta 2 delimitadores seguidos como NULL
	Asume , como delimitador
Contenido del archivo helados.dat
Ice-cream sales data for the summer
Flavor     Location    Boxes sold
Chocolate  213         123
Vanilla    213         512
Chocolate  415         242
*/

DATA helados;
   INFILE 'C:\Users\MiguelJ\Documents\tests\helados.dat' FIRSTOBS = 3 OBS = 5;
   INPUT Sabor $ 1-9 Ubicacion CajasVendidas;
RUN;

 /*
LOGICA CONDICIONAL
==================
SAS permite hacer uso de lógica condicional para controlar el flujo que sigue el código.
Sintaxis:
	IF <condición> THEN [DO;]
		 <acción>;
	[END;]

	IF <condición> THEN [DO;]
		<acción>;
	[END;]
	ELSE [IF <condición> THEN] [DO;]
		<acción>;
	[END;]

- DO ... END se usa cuando existe más de una acción a ejecutar

Se pueden utilizar algunos operadores:
Operadores de comparación
=========================
Símbolo		Mnemotócnico		Significado
=======		============		===========
=				EQ				Igual a
¬=, ^=, ~=		NE				No igual a
>				GT				Mayor que
<				LT				Menor que
>=				GE				Mayor o igual que
<=				LE				Menor o igual que

Operadores lógicos
==================
Símbolo		Mnemotócnico		Significado
=======		============		===========
&			  AND				Y lógico
|, !		  OR				O lógico
Se puede usar los operadores en su formato simbólico o mnemotécnico.

Subsetting
==========
Existen varias maneras de filtrar los registros de un data set:
	- Uso de IF
		Se mantienen los registros que cumplen con la condición planteada.
		Sintaxis:
			IF <condición>;
	- Uso de DELETE
		Se eliminan los registros que cumplen con la condición planteada.
		Sintaxis:
			IF <condición> THEN DELETE;
*/

DATA helados_filtro0;
	SET helados;
	IF Sabor eq 'Chocolate';
RUN;

DATA helados_filtro1;
	SET helados;
	IF Sabor = 'Chocolate' THEN DELETE;
RUN;

 /*
Selección de Siglos con Fechas
==============================
SAS al trabajar con fechas admite años con 2 dígitos, lo cual en ciertas circunstancias puede causar confusiones.
SAS permite seleccionar un año de corte a partir del cual interpretar el siglo alque corresponde un año con 2 dígitos.

Sintaxis

OPTIONS YEARCUTOFF = <año>;

Ejemplo:
OPTIONS YEARCUTOFF = 1950;
Indica que en una fecha cuyo año tenga 2 dígitos va entre 1950 y 2049
*/
OPTIONS YEARCUTOFF = 1950;

 /*
Retención de variables
======================
SAS tiene la capacidad de mantener los valores de iteraciones previas de las variables de un Data Set.
- RETAIN
	Permite que los valores de las variables estén disponibles en la siguiente iteración.
	Es posible asignar valores iniciales a las variables
	El uso de RETAIN reordena el orden de las variables de un data set
- SUM
	Retiene los valores de las variables, pero adiciona su valor sucesivamente y o almacena en una expresión.

Sintaxis:
RETAIN <lista de variables>;
RETAIN <variable> [valor];
*/

DATA saltos_acum;
	RETAIN nombre 'no_name' salto1-salto3 peso 0 peso_acc 0;
	SET saltos_de_ranas;
	peso_acc = peso + peso_acc;
RUN;

 /*
ARRAYS
======
- Son grupos de variables del mismo tipo.
- No se almacenan en los Datasets, sólo existen mientras se ejecuta el Data Step

Sintaxis:
	ARRAY <nombreArray> (n) [$] <lista de variables>;

n
	Define la cantidad de elementos del array
	Puede ir entre () o {} o []
$
	Es necesario si las variables del array son de tipo caracter y no han sido previamente definidas
*/

DATA saltos_array;
	SET saltos_de_ranas;
	ARRAY saltos (3) salto1 salto2 salto3;
	DO i = 1 TO 3;
		salto_total = SUM(saltos(i),salto_total);
		IF saltos(i) eq . THEN saltos_null = SUM(1,saltos_null);
	END;
	DROP I;
RUN;

 /*
Listas de Variables
===================

- SAS tiene la capacidad de interpretar las variables en forma de listas, esto facilita el llamado de variables en lugar de escribirlas una a una
- SAS utiliza lista de rangos por nombre y lista de prefijo de nombre.

Lista de Rangos por Nombre:

INPUT cat8 cat9 cat10 cat11;
es similar a
INPUT cat8-cat11;

Lista de Prefijos de nombres:

variable = cat + cat9 + cat10 + cat11;
es similar a
variable = SUM(OF cat:);

Listas Especiales
_ALL_
	Todas las variables
_CHARACTER_
	Todas las variables de tipo caracter
_NUMERIC_
	Todas las variables numéricas
MEAN(OF _NUMERIC_)
	Permite usar una lista de variables en una función
*/

DATA saltos_lista;
	SET saltos_de_ranas;
	numericos = SUM(OF _NUMERIC_);
RUN;
