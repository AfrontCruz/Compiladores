%{
	#include<stdio.h>
%}

NATURALES [0-9]

MIN [a-z]
MAY [A-Z]
DIG [0-9]

ARR "@"

OCTETO [0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5]

PALABRA [a-z]|[A-Z]
NUM [0-9]
SIMBOLO _

%%

{OCTETO}"."{OCTETO}"."{OCTETO}"."{OCTETO} printf("IP Valida");

\"({MIN}+|{MAY}+|{DIG}+|{ARR}+)+\" printf("Cadena Valida");



-?{NATURALES}+ printf("Numero");
-?{NATURALES}*"."{NATURALES}+ printf("Numero Decimal");
-?{NATURALES}+"+"-?{NATURALES}+ printf("Suma");
-?{NATURALES}+"-"-?{NATURALES}+ printf("Resta");
-?{NATURALES}+"*"-?{NATURALES}+ printf("Multiplicacion");
-?{NATURALES}+"/"-?{NATURALES}+ printf("Division");
-?{NATURALES}+"^"-?{NATURALES}+ printf("Exponente");
-?{NATURALES}+"%"-?{NATURALES}+ printf("Modulo");

({PALABRA}+{NUM}*|{SIMBOLO}+{NUM}*{PALABRA}*)+ printf("Variable");

%%
