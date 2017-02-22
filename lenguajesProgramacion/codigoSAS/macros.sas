 /*
SAS MACRO
=========
Antes de usar macros el sistema debe tener habilitada la opción "MACRO", por defecto esta opción está deshabilitada. Para conocer el estado del sistema se puede ejecutar el PROC OPTIONS
*/
PROC OPTIONS OPTION=MACRO;
RUN;

 /*
Las Macro de SAS consisten de:
- Macros
	Sus nombres empiezan con %
	Es una porción de código que puede contener una lógica compleja incluyendo steps completos O %DO, %END, %IF - %THEN/%ELSE
- Macro Variables
	Sus nombres inician con &
	Una macro variable es como una variable estándar pero mantiene un valor escalar, no pertenece a un data set y su valor es texto, pero puede representar valores numéricos
	Pueden existir macro variables Locales o Globales:
		Usualmente una macro variable local está definida dentro de una macro.
		Una macro variable global se define fuera de una macro y puede ser usada en cualquier lugar.
	Asignación de Valores
		Se usa la sentencia %LET con la siguiente sintaxis:
			%LET <macro variable> = <valor>;
		El valor asignado no necesita estar entre comillas, excepto cuando el valor tiene espacios en blanco a su inicio o final.
		Para usar la macro variable es necesario agregar & al nombre de la variable.
		El procesador de macros no busca macros dentro de texto entrecomillado simple, si en texto entrecomillado doble
*/

%LET var0 = prueba;
%LET var1 = " prueba ";
%LET var2 = &var0. &var1;
%LET var3 = "&var0";
%LET var4 = '&var0';
