# Informats disponibles en SAS
============================

| ## **Informat** | **Definición** | **Longhitud Default** | **Datos de Entrada** | **Datos de Salida** | **Ejemplo de Input** |
| --- | --- | --- | --- | --- | --- |
| ### **Caracteres** |
| ###### $CHAR*w.* | Lee datos caracteres tal como se persentan, NO elimina caracteres en blanco del inicio ni del final | 8 o la longitud de la variable |   un gato  |   un gato | INPUT variable *$CHAR10.* |
###### $UPCASE*w.* | Convierte a todos los caracteres a Mayúsculas | 8 | un gato | UN GATO | INPUT variable *$UPCASE10.*
###### $*w.* | Lee datos caracteres eliminando caracteres en blanco del inicio ni del final | none |   un gato | un gato | INPUT variable *$10.*
### **Date, Time y Datetime** |
###### ANYDTDTE*w.* | Lee fechas en varios formatos | 9 | 1jan1961 01/01/61 | 366 366 | INPUT variable ANYDTDTE10.
###### DATE*w.* | Lee fechas en la forma *ddmmmyy o ddmmmyyyy* | 7 | 1jan1961 1 jan 61 | 366 366 | INPUT variable DATE10.
###### DATETIME*w.* | Lee fechas en la forma *ddmmmyy hh:mm:ss.ss* | 18 | 1jan1960 10:30:15 o 1jan61,10:30:15 | 37815 31660215 | INPUT variable DATETIME18.
###### DDMMYY*w.* | Lee fechas en la forma *ddmmyy o ddmmyyyy* | 6 | 01.01.1961 o 02/01/61 | 366 367 | INPUT variable DDMMYY8.
###### JULIAN*w.* | Lee fechas del calendario Juliano en la forma *yyddd o yyyyddd* | 5 | 61001 o 1961001 | 366 366 | INPUT variable JULIAN7.
###### MMDDYY*w.* | Lee fechas en la forma *mmddyy o mmddyyyy* | 6 | 01-01-61 01/01/61 | 366 366 | INPUT variable MMDDYY8.
###### STIMER*w.* | Lee tiempo en la forma *hh:mm:ss.ss o mm:ss.ss o ss.ss* | 10 | 10:30 10:30:15 | 630 37815 | INPUT variable STIMER8.
###### TIME*w.* | Lee tiempo en la forma *hh:mm:ss.ss o hh:mm* | 8 | 10:30 10:30:15 | 37800 37815 | INPUT variable TIME8.
### **Números** |
###### COMMA*w.d* | Elimina comas y el símbolo $, convierte el paréntesis izquierdo en signo - | 1 | 1,000,001 (1,234) | 1000001 -1234 | INPUT variable COMMA10.
###### COMMAX*w.d* | Similar a COMMAw.d pero invierte los roles de puntos y comas | 1 | 1.000.001 (1.234,25) | 1000001 -1234.25 | INPUT variable COMMAX10.
###### PERCENT*w.* | Convierte porcentajes a números | 6 | 5% (20%) | 0.05 -0.2 | INPUT variable PERCENT5.
*w.d* | Lee datos numéricos estándar | none | 1234 -12.3 | 123.4 -12.3 | INPUT variable 5.1
