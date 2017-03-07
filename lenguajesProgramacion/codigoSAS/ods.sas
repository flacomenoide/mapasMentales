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
	SERIES X = cajasVendidas Y = ubicacion / MARKERS;
RUN;

 /*
CURVAS DE AJUSTE (variables contínuas)
================
Existen varios tipos de curvas de ajuste:
	REG - Líneas de regresión
	LOESS - Curvas Loess
	PBSPLINE - SP-lines personalizados

Sintaxis:
	PROC SGPLOT;
		<tipo de curva> X = <variable horizontal>
				Y = <variable vertical> / <opciones>;
Opciones:
ALPHA = <n>
	Nivel de confianza (0 - 1), el default es 0.05 (95% de confianza)
CLI
	Agrega límites para valores individuales predichos (REG o PBSPLINE)
CLM
	Agrega límites de confianza para valores medio predichos
CURVELABEL = <'etiqueta'>
	Agrega una etiqueta a la curva, si no se especifica nada usa los valore de Y
GROUP = <variable>
	Define una variable para agrupar los datos
NOLEGCLI
	Elimina leyendas para la banda CLI
NOLEGCLM
	Elimina leyendas para la banda CLM
NOLEGFIT
	Elimina leyendas para la Curva de ajuste
NOMARKERS
	Elimina los marcadores de los puntos de datos
CLMTRANSPARENCY = <n>
	Grado de transparencia para los límites de confianza (0 - 1)
*/
PROC SGPLOT;
	PBSPLINE X = cajasVendidas
			Y = ubicacion;
RUN;

 /*
Personalización de Gráficos
===========================
Ejes de referencia
Sintaxis:
	PROC SGPLOT;
		XAXIS <opciones>;
		YAXIS <opciones>;

Opciones:
GRID
	Genera una malla en cada marca del eje
LABEL = <'texto'>
	Especifica una etiqueta para el eje
TYPE = <tipo de eje>
	Especifica el tipo de eje:
	- DISCRETE (Default) >> caracteres
	- LINEAR >> números
	- TIME >> tipos de datos asociados a tiempo
	- LOG >> Escala Logarítmica
VALUES = (lista de valores)
	Especifica valores para las marcas en los ejes, puede ser una lista específica o un rango
	Ejemplo: (0 5 10 15 20 25) o (0 TO 25 BY 5)

Líneas de referencia
Sintaxis:
	PROC SGPLOT;
		REFLINE <valores> / <opciones>;
Los valores pueden ser una lista específica o un rango.
Ejemplo: (0 5 10 15 20 25) o (0 TO 25 BY 5)

Opciones:
AXIS = <eje>
	Especifica el eje que contiene la línea de referencia (X o Y - Default)
LABEL = (<lista de etiquetas>)
	Especifica uno o más valores de texto para ser usados como etiquetas de las líneas de referencia
TRANSPARENCY = <n>
	Grado de transparencia (0 - 1)

Leyendas
Sintaxis:
	PROC SGPLOT;
		KEYLEGEND / <opciones>;

Opciones:
ACROSS = <n>
	Cantidad de columnas en la leyenda
DOWN = <n>
	Cantidad de de filas en la leyenda
LOCATION = <valor>
	Especifica la ubicación de la leyenda:
	- INSIDE
	- OUTSIDE (Default)
NOBORDER
	Elimina los bordes
POSITION = <valor>
	Especifica la posición de la leyendo en el gráfico:
	- TOP
	- TOP LEFT
	- TOP RIGHT
	- BOTTOM (Default)
	- BOTTOM LEFT
	- BOTTOM RIGHT
	- LEFT
	- RIGHT
	Si queremos eliminar la leyenda hay que especificar la sentencia NOAUTOLEGEND.
	Ejemplo PROG SGPLOT NOAUTOLEGEND;

Insets
Es el texto en el área de los ejes
Sintaxis:
	INSET <lista de textos> / <opciones>
Opciones:
BORDER
	Adiciona un borde
POSITION = <valor>
	Posición del INSET:
	- TOP
	- TOP LEFT
	- TOP RIGHT
	- BOTTOM (Default)
	- BOTTOM LEFT
	- BOTTOM RIGHT
	- LEFT
	- RIGHT

Opciones para controlar atributos Gráficos
FILLATTRS = (<atributo> = <valor>)
	Especifica la apariencia de un área rellenada, el único atributo es COLOR
LABELATTRS = (<atributo> = <valor>)
	Apariencia de las etiquetas de los ejes:
	- COLOR =
	- SIZE =
	- STYLE =
	- WEIGHT =
LINEATTRS = (<atributo> = <valor>)
	Apariencia de líneas:
	- COLOR =
	- PATTERN =
	- THICKNESS =
MARKERATTRS = (<atributo> = <valor>)
	Apariencia del marcador:
	- COLOR =
	- SIZE =
	- SYMBOL =
VALUEATTRS = (<atributo> = <valor>)
	Apariencia de las marcas de los ejes:
	- COLOR = (Notación RGB #FF0000)
	- PATTERN = (SOLID, DASH, SHORTDASH, LONGDASH, DOT, DASHDASHDOT, DASHDOTDOT)
	- SIZE = (Valores numéricos en CM, IN, MM, PCT, PT o PX - Default)
	- STYLE = (ITALIC, NORMAL -Default)
	- SYMBOL = (CIRCLE, CIRCLEFILLED, DIAMOND, DIAMONDFILLED, PLUS, SQUARE, SQUAREFILLED, STAR, STARFILLED, TRIANGLE, TRIANGLEFILLED)
THICKNESS = <valor>
WEIGHT = (BOLD, NORMAL)
*/

 /*
GRAFICOS CON PANELES
====================
PROC SGPANEL
	Tiene casi los mismos gráficos que SGPLOT, pero estos oueden ser ubicados en diferentes paneles.
	La palabra clave es: PANELBY
	Usa COLAXIS o ROWAXIS en lugar de XAXIS e YAXIS

Sintaxis:
	SGPANEL;
		PANELBY <lista de variables> / <opciones>;
		<sentencia plot>;

Opciones:
COLUMNS = <n>
	Cantidad de columnas en el panel
MISSING
	Incluye MISSING en los paneles
NOVARNAME
	Elimina los nombres de las variables de las cabeceras de las celdas
ROWS = <n>
	Cantidad de filas en los paneles
SPACING = <n>
	Cantidad de pixeles entre filas y columnas
UNISCALE = <valor>
	Especifica qué ejes comparten el mismo rango:
	- COLUMN
	- ROW
	- BOTH (Default)
*/

PROC SGPANEL;
	PANELBY sabor;
	PBSPLINE X = cajasVendidas
			Y = ubicacion;
RUN;

 /*
ODS GRAPHICS - Propiedades de Imágenes
============
Sintaxis:
	ODS GRAPHICS / <opciones>;

Opciones:
HEIGHT = <n>
	Alto de la imagen en CM, IN, MM, PT, PX
IMAGENAME = <'nombre del archivo'>
	Nombre del archivo que se generará
OUTPUTFMT = <tipo de archivo>
	Formato del archivo de salida: BMP, GIF, JPEG, PDF, PNG, PS, SVG, TIFF y otros
RESET
	Resetea las opciones a los valores Default
WIDTH = <n>
	Ancho de la imagen en CM, IN, MM, PT, PX
Valores Default:
	640 x 480
	Si no se especifica una medida se mantiene la proporción 4:3
*/
ODS GRAPHICS / RESET;
