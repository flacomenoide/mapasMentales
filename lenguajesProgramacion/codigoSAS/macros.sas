 /*
SAS MACRO
=========
Antes de usar macros el sistema debe tener habilitada la opción "MACRO", por defecto esta opción está deshabilitada.
Para conocer el estado del sistema se puede ejecutar el PROC OPTIONS
*/
PROC OPTIONS OPTION=MACRO;
RUN;

 /*
Las Macro de SAS consisten de:
Macros
======
	Sus nombres empiezan con %
	Es una porción de código que puede contener una lógica compleja incluyendo steps completos O %DO, %END, %IF - %THEN/%ELSE
	Sintaxis:
		%MACRO <nombre de la macro>;
		...
		%MEND [<nombre de la macro>];
	MAUTOSOURCE y SASAUTOS =
		Son opciones del sistema que le dicen a SAS dónde buscar MACROS.
	Las macros pueden hacer uso de parámetros
		Sintaxis:
		%MACRO <nombre de la macro> (par1= , par2= , par3= );
		...
		%MEND [<nombre de la macro>];
	Las macros de SAS permiten usar lógica condicional.
		Sintaxis:
		%IF <condición> %THEN;
		...
		%ELSE %IF <condición> %THEN;
		...
		%END;

Macro Variables
===============
	Sus nombres inician con &
	Una macro variable es como una variable estándar pero mantiene un valor escalar, no pertenece a un data set y su valor es texto,
	pero puede representar valores numéricos
	Pueden existir macro variables Locales o Globales:
		Usualmente una macro variable local está definida dentro de una macro.
		Una macro variable global se define fuera de una macro y puede ser usada en cualquier lugar.
	Asignación de Valores
		Se usa la sentencia %LET con la siguiente sintaxis:
			%LET <macro variable> = <valor>;
		El valor asignado no necesita estar entre comillas, excepto cuando el valor tiene espacios en blanco a su inicio o final.
		Para usar la macro variable es necesario agregar & al nombre de la variable.
		El procesador de macros no busca macros dentro de texto entrecomillado simple, si en texto entrecomillado doble
	Concatenación de macro variables:
		Para concatenar macro variables con otro texto es necesario definir los límites de la macro variable.
		Una macro variable se identifica con & como su inicio hasta encontrar:";", espacio en blanco, otro & o "."
		Para concatenar una macro variable con otro texto es necesario usar el "." al final de su nombre.
	Existen macro variables que SAS trae por defecto:
		&SYSDATE	-> Fecha de inicio de la sesión
		&SYSDAY		-> Día de la semana
		&SYSNOBS	-> Número de observaciones del último data set creado
*/

%LET var0 = prueba;
%LET var1 = " prueba ";
%LET var2 = &var0. &var1;
%LET var3 = "&var0";
%LET var4 = '&var0';
%LET var5 = &var0.no es&var2.;

 /*
CALL SYMPUT
===========
Permite tomar un valos de un Data set y asignarlo a una macro variable.
Sintaxis:
	CALL SYMPUT("<macro variable>", valor);

No se puede usar una macro variabledentro del mismo data step ya que SAS asigna los valores después que el Data Step se ejecuta.
*/

 /*
Opciones del sistema para debugging:

MERROR - NOMERROR
	Permite mostrar Warnings si se invocan macros que SAS no encuentra.
SERROR - NOSERROR
	Permite mostrar mensajes de error cuando SAS no encuentra macro variables.
MLOGIC - NOMLOGIC
	Permite imprimir detalles de la ejecución de las macros.
MPRINT - NOMPRINT
	Permite imprimir en el log el código SAS generado por las macros.
SYMBOLGEN - NOSYMBOLGEN
	Permite imprimir en el log los valores de las macro variables.

Para activar o desactivar las opciones de sistema se puede ejecutar la sentencia OPTIONS
Sintaxis:
	OPTIONS <lista de opciones de sistema>;
*/

OPTIONS MPRINT SYMBOLGEN NOMLOGIC;
