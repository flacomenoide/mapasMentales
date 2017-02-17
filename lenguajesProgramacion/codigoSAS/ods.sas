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
