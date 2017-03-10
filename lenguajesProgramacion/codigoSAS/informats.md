Informats disponibles en SAS
============================

**Informat** | **Definición** | **Longhitud Default** | **Datos de Entrada** | **Datos de Salida** | **Ejemplo de Input**
--- | --- | --- | --- | --- | ---
**Caracteres** |
$CHARw. | Lee datos caracteres tal como se persentan, NO elimina caracteres en blanco del inicio ni del final | 8 o la longitud de la variable |   un gato  |   un gato | INPUT variable *$CHAR10.*
$UPCASEw. | Convierte a todos los caracteres a Mayúsculas | 8 | un gato | UN GATO | INPUT variable *$UPCASE10.*
$w. | Lee datos caracteres eliminando caracteres en blanco del inicio ni del final | none |   un gato | un gato | INPUT variable *$10.*
**Date, Time y Datetime** |
ANYDTDTEw. | Lee fechas en varios formatos | 9 | 1jan1961 01/01/61 | 366 366 | INPUT variable ANYDTDTE10.
