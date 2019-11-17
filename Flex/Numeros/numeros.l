%{
	#include<stdio.h>
%}

NATURALES [0-9]



%%

-?{NATURALES}+ printf("Numero Entero");
-?{NATURALES}*"."{NATURALES}+ printf("Numero Decimal");
-?{NATURALES}+"+"-?{NATURALES}+ printf("Suma");
-?{NATURALES}+"+"-?{NATURALES}+ printf("Resta");
-?{NATURALES}+"*"-?{NATURALES}+ printf("Multiplicacion");
-?{NATURALES}+"/"-?{NATURALES}+ printf("Division");
-?{NATURALES}+"^"-?{NATURALES}+ printf("Exponente");
-?{NATURALES}+"%"-?{NATURALES}+ printf("Modulo");

"exit" return 0;

%%

