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

*/

* Una manera para poder chequear las opciones del sistema es usar el PROC options;
PROC options;
RUN;

 /* Librerías SAS
    =============
Son ubicaciones donde se almacenan los Data sets SAS se definen con LIBNAME
WORK es la librería default, la cual es temporal, por lo que su contenido se borra al cerrar la sesion
Si no se especifica una librería SAS usará el default (WORK)
*/
LIBNAME MJ '<path/to/file>';

 /* DATA STEP
    =========
Sentencia INPUT:
- Se definen las variables del Data set
- Le dice a SAS como leer los datos crudos
- Seguido a la palabra INPUT se escribe la lista de variables separadas por espacio en el orden de aparicion
- Si las variables son caracteres se debe poner el símbolo $ después del nombre de la variable
*/

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
 - En el archivo externo los valores NULL deben estar especificados como .
 - Si en la sentencia INPUT hay más variables definidas que campos en el archivo externo
   SAS buscará las variables faltantes en la siguiente línea del archivo
*/
