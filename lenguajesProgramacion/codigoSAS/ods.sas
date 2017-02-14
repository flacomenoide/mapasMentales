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
