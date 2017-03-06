* ODS - Output Delivery System ;
* ============================ ;
 /*
SAS siempre usa ODS para imprimir sus resultados.
ODS es configurable y se puede elegir como usarlo.
A partir de SAS 9.3 el destino por defecto es HTML, versiones anteriores usaban LISTING.

Posibles destinos de ODS:
- HTML
- LISTING
- PDF
- PS
- PRINTER
- RTF
- MARKUP (XML, EXCELXP, LaTeX, CSV, etc)
- DOCUMENT
- OUTPUT (Dataset SAS)

ODS usa diferentes tipos de templates y estilos:
- Tablas: Se encargan de la estructura de la salida.
- Estilos: Se encargan del diseño de toda la salida.
/*

 /*
Sentencias Usadas con ODS
=========================
ODS TRACE
=========
- Permite seleccionar o excluir los objetos OUTPUT que ODS recibe.
- Indica a SAS si imprime la información de los objetos en los logs.

*/

* Habilitar el TRACE ;
ODS TRACE ON;

* Deshabilitar el TRACE ;
ODS TRACE OFF;

 /*
ODS SELECT
==========
- Permite seleccionar los objetos (nombre, label o path) a imprimir
Sintaxis:
ODS SELECT (<lista de objetos a imprimir>);
*/

/*
ODS EXCLUDE
===========
- Permite excluir los objetos (nombre, label o path) a imprimir

Sintaxis:
ODS EXCLUDE (<lista de objetos a imprimir>);
*/

 /*
ODS OUTPUT
==========
Permite almacenar los objetos de la salida en Data sets

Sintaxis:
ODS OUTPUT objeto = <Nuevo Dataset>;
*/

 /*
ODS LISTING
===========
Permite habilitar o desabilitar la impresión de resultados en modo Texto

Sintaxis:
ODS LISTING [FILE = '<archivo.lst>'];
...
ODS LISTING CLOSE;
*/

ODS LISTING; * Inicia ODS LISTING e imprime los resultados en texto plano, se puede definir el nombre del archivo con FILE =;
ODS LISTING CLOSE; * Deja de imprimir los resultados en modo texto;

 /*
ODS NOPROCTITLE
===============
Permite eliminar los títulos de los procs
*/

ODS NOPROCTITLE;

 /*
ODS HTML
========
Permite imprimir los resultados en HTML

Sintaxis:
ODS HTML
	BODY = '<archivo.html>';
o
	FILE = '<archivo.html>'

FILE y BODY son sinónimos

Opciones:
	CONTENTS =
	PAGE =
	FRAME =
	STYLE =
*/

ODS HTML
	FILE = 'reporte.html'
	STYLE = Plateau;
ODS HTML CLOSE;

 /*
ODS RTF
=======
Permite imprimir los resultados en RTF

Sintaxis:
ODS RTF
	FILE = '<archivo>';

Opciones:
	BODYTITLE
	COLUMNS = n
	SASDATE
	STARTPAGE = <valor>
	STYLE = <valor de style> (El default es RTF)
*/

ODS RTF
	FILE = 'reporte.rtf'
	STYLE = SANSPRINTER;
ODS RTF CLOSE;

 /*
ODS PDF
=======
Permite imprimir los resultados en PDF

Sintaxis:
ODS PDF
	FILE = '<archivo>';

Opciones:
	COLUMNS = n
	STARTPAGE = <valor>
	STYLE = <valor de style> (El default es PRINTER)
*/

ODS PDF
	FILE = 'reporte.pdf'
	STYLE = SANSPRINTER;
ODS PDF CLOSE;

 /*
ODS Graphics
============
Permite crear gráficos, a partir de SAS 9.3 es parte de SAS Base (no necesita licencia adicional)
Para habilitar esta opción se ejecuta:
	ODS GRAPHICS ON;

Permite realizar diferentes tipos de gráficos:
	- Gráficos X-Y
	- Distribuciones Continuas
	- Distribuciones Categóricas

Los gráficos se pueden realizar usando el PROC SGPLOT.
*/
ODS GRAPHICS ON;

 /*
BAR CHAR (variables categóricas)
========
Sintaxis:
	PROC SGPLOT;
		<HBAR|VBAR> <variable> / <opciones>;

HBAR - Barras Horizontales
VBAR - Barras Verticales

Opciones:
ALPHA = <n>
	Nivel de los límites de confianza, valor por Defecto 0.05 (5%)
	0 >> 100% de confianza
	1 >> 0% de confianza
BARWIDTH = <n>
	Ancho de las barras
	Mínimo: 0.01
	Máximo: 1
	Default: 0.8
DATALABEL = <variable>
	Permite asignar los valores de la etiqueta que serán usados en cada barra basados en los valores de una variable, si el valor
	tiene diferentes valores en diferentes filas usará el primero.
DISCRETEOFFSET = <n>
	Desplazamiento de las barras desde su punto medio.
	Mínimo: -0.5
	Máximo: 0.5
	Default: 0
LIMITSTAT = <estadistica>
	Especifica el tipo de límite a mostrar.
	Esta opción no se puede usar con la opción GROUP =
	Estadísticas posibles de usar:
	- CLM
	- STDDEV
	- STDERR
MISSING
	Incluye una barra para los valores MISSING
GROUP = <variable>
	Define la agrupación de los datos en relación a una variable definida.
GROUPDISPLAY = <tipo>
	Especifica como mostrar las barras:
	- STACK (Default)
	- CLUSTER
RESPONSE = <variable>
	Especifica la variable numérica a ser sumarizada
STAT = <estadstico>
	Define el estadístico a usar para la sumarización de los valores.
	- FREQ >> Default en los casos que existe RESPONSE
	- MEAN
	- SUM >> Default para los casos que RESPONSE NO existe
TRANSPARENCY = <n>
	Indica el grado de transparencia de la barra
	Mínimo: 0 (Default) >> Sin transparencia
	Máximo: 1 >> 100% de transparencia
*/

PROC SGPLOT DATA = helados;
	VBAR sabor / alpha = 0.1 barwidth = 0.5 DATALABEL = sabor DISCRETEOFFSET = -0.2 RESPONSE = cajasVendidas;
RUN;

/*
HISTOGRAMAS (variables contínuas)
===========
Usualmente los valores se dividen en intervalos
Sintaxis:
	PROC SGPLOT;
		HISTOGRAM <variable> / <opciones>;

Opciones:
BINSTART = <n>
	Punto medio del primer intervalo
BINWIDTH = <n>
	Ancho del intervalo, no se puede usar junto a la opción NBINS
NBINS = <n>
	Cantidad de intervalos
SCALE = <tipo>
	Define las escalas para los ejes verticales
	Posibles valores:
	- PERCENT (Default)
	- SCALE
	- PROPORTION
SHOWBINS
	Muestra marcas en los puntos medios de los intervalos
TRANSPARENCY = <n>
	Grado de transparencia
	0 (Default) >> 0% de transparencia
	1 >> 100% de transparencia
*/

PROC SGPLOT DATA = helados;
	HISTOGRAM cajasVendidas;
RUN;

 /*
CURVAS DE DENSIDAD (variables contínuas)
==================
Sintaxis:
	PROC SGPLOT;
		DENSITY <variable> / <opciones>;

Opciones:
TYPE = <tipo de distribucion>
	Especifica el tipo de distribución a usar:
	- NORMAL (Default)
	- KERNEL
TRANSPARENCY = <n>
	Grado de transparencia para la curva de densidad (0 - 1)
*/

PROC SGPLOT DATA = helados;
	DENSITY cajasVendidas / TYPE = kernel;
RUN;

 /*
BOXPLOTS (variables contínuas)
========
Sintaxis:
	PROC SGPLOT;
		<VBOX|HBOX> <variable> / <opciones>;

VBOX >> Verticales
HBOX >> Horizontales

Opciones:
CATEGORY = <variable>
	Variable categórica que define de acuerdo a sus valores los diferentex BOXPLOTs que se generarán
EXTREME
	Indica que los bigoets se deben extender hasta el mínimo y máximo, por lo que los outliers no son identificados
GROUP = <variable>
	Especifica una segunda variable categórica
	Esto genera una BOXPLOT por cada valor de esta variable dentro de cada categoría
MISSING
	Incluye un BOXPLOT para la categoría o grupo MISSING
TRANSPARENCY = <n>
	Grado de transparencia para el BOXPLOT (0 - 1)
*/

PROC SGPLOT DATA = helados;
	VBOX cajasVendidas;
RUN;

 /*
SCATTER PLOTS (variables contínuas)
=============
Sintaxis:
	PROC SGPLOT;
		SCATTER X = <variable horizontal>
				Y = <variable vertical> / <opciones>;

Opciones:
DATALABEL = <variable>
	Etiqueta para cada data point, si no se especifica una variable se presenta los valores de Y
GROUP = <variable>
	Define una variable para agrupar los datos
NOMISSINGGROUP
	Especifica que no genere un grupo con valores MISSING
TRANSPARENCY = <n>
	Grado de transparencia (0 - 1)
*/

PROC SGPLOT DATA = helados;
	SCATTER X = cajasVendidas Y = ubicacion;
RUN;

 /*
SERIES (variables contínuas)
======
Para poder realizar estos gráficos es necesario que los datos se encuentren previamente ordenados.
Sintaxis:
	PROC SGPLOT;
		SERIES X = <variable horizontal>
				Y = <variable vertical> / <opciones>;

Opciones:
CURVELABEL = <'etiqueta'>
	Agrega una etiqueta a la curva, se puede definir una variable, si no se especifica usa los valore de Y
DATALABEL = <variable>
	Etiquetas para cada punto de dato, si no se especifica una variable se usarán los valores de Y
GROUP = <variable>
	Define una variable para agrupar los datos
MARKERS
	Agrega un marcador a cada punto
NOMISSINGGROUP
	Especifica que no genere un grupo con valores MISSING
TRANSPARENCY = <n>
	Grado de transparencia (0 - 1)
*/

PROC SORT DATA = helados;
	BY cajasVendidas ubicacion;

PROC SGPLOT DATA = helados;
	SERIES X = cajasVendidas Y = ubicacion;
RUN;
