* PROC Steps ;
 
* Una manera para poder chequear las opciones del sistema es usar el PROC options;
PROC options;
RUN;

 /*
PROC CONTENTS
=============
- Imprime el contenidode la estructura de un Data set.
*/

PROC contents DATA=helados;
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
