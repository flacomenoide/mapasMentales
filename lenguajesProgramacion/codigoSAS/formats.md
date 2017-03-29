Listado de FORMATS en SAS
=========================

**Format** | **Definición** | **Longitud Default** | **Datos de Entrada** | **Datos de Salida** | **Ejemplo de Input**
--- | --- | --- | --- | --- | ---
*Caracteres*
$UPCASE*w.* | Convierte a todos los caracteres a Mayúsculas | 8 | un gato | UN GATO | PUT variable *$UPCASE10.*
$*w.* |Escribe datos caracteres manteniendo caracteres en blanco del inicio y del final | none |   un gato  |   un gato   | PUT variable *$10.*
*Date, Time y Datetime* |
DATE*w.* | Escribe fechas en la forma *ddmmmyy* o *ddmmmyyyy* | 7 | 366 | 01JAN1961 | PUT variable DATE7.
DATETIME*w.d* | Escribe fechas en la forma *ddmmmyy:hh:mm:ss.ss* | 16 | 12182 | 01JAN60:03:23 | PUT variable DATETIME13.
DTDATEw. | Escribe fechas en la forma *ddmmmyy* o *ddmmmyyyy* | 7 | 12182 | 01JAN60 | PUT variable DTDATE7.
EURDFDDw. | Escribe fechas en la forma *dd.mm.yy* o *dd.mm.yyyy* | 8 | 8966 | 19.07.84 | PUT variable EURDFDD8.
JULIAN*w.* | Escribe fechas del calendario Juliano en la forma *yyddd* o *yyyyddd* | 5 | 8966 | 84201 | PUT variable JULIAN5.
MMDDYY*w.* | Escribe fechas en la forma *mm/dd/yy* o *mm/dd/yyyy* | 8 | 8966 | 7/19/84 | PUT variable MMDDYY8.
TIME*w.d* | Escribe tiempo en la forma *hh:mm:ss.ss* | 8 | 12182 | 3:23:02 | PUT variable TIME8.
WEEKDATE*w.* | Escribe fechas en la forma *día-de-la-semana, nombre-del-mes dd, yy* o *yyyy* | 29 | 8966 | Thu, Jul 19, 84 | PUT variable WEEKDATE15.
WORDDATE*w.* | Escribe fechas en la forma *nombre-del-mes dd, yyyy* | 18 | 8966 | Jul 19, 1984 | PUT variable WORDDATE12.
*Números* 
BEST*w.* | SAS elige el mejor formato para datos numéricos | 12 | 1200001 | 1.20E6 | PUT BEST6.
COMMA*w.d* | Escribe números con comas | 6 | 1200001 | 1,200,001 | PUT variable COMMA9.
DOLLAR*w.d* | Escribe números con comas cada 3 dígitos y $ como prefijo | 6 | 1200001 | $1,200,001 | PUT variable DOLLAR10.
E*w.* | Escribe números en notación científica | 12 | 1200001 | 1.2E+06 | PUT variable E7.
EUROX*w.d* | Escribe números con puntos cada 3 dígitos y € como prefijo | 6 | 1200001 | €1.200.001,00 | PUT variable EUROX13.2
PERCENT*w.d* | Escribe datos numéricos como porcentajes | 6 | 0.05 | 5.00% | PUT variable PERCENT9.2
*w.d* | Escribe datos numéricos estándar | none | 23.635 | 23.635 | PUT variable 6.3

