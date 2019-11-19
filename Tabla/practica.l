%{
#include "practica.tab.h"
%}
 
NUM [0-9]+
DIG [0-9]
ABC [a-z]|[A-Z]
SIMBOLO _

%%

" "                                   {}


"MOD"                   {
                        printf("Modulo\n");
                        return(MODULO);
                        }

"'"."'"                                 {
                                        printf("Cualquier cosa\n");
                                        yylval.caracter = yytext[1];
                                        return(CARACTER);
                                        }

";"                                     {
                                        printf("Punto y coma %c\n",yytext[0]);
                                        yylval.caracter = yytext[0];
                                        return(FIN_EXP);
                                        }

"="                                     {
                                        printf("Igual\n");
                                        yylval.caracter = yytext[0];
                                        return(EQUALS);
                                        }       

"int"                                   {
                                        printf("Tipo de dato %s\n",yytext);
                                        yylval.cadena = "int";
                                        return(TIPO);
                                        }
"float"                                 {
                                        printf("Tipo de dato %s\n",yytext);
                                        yylval.cadena = "float";
                                        return(TIPO);
                                        }
"char"                                  {
                                        printf("Tipo de dato %s\n",yytext);
                                        yylval.cadena = "char";
                                        return(TIPO);
                                        }
"double"                                {
                                        printf("Tipo de dato %s\n",yytext);
                                        yylval.cadena = "double";
                                        return(TIPO);
                                        }

({ABC}+{DIG}*|{SIMBOLO}+{DIG}*{ABC}*)+  {
                                        int i = 0;
                                        while( yytext[i] ){
                                                i++;
                                        }
                                        char *aux = malloc( sizeof(char)*i );
                                        strcpy(aux, yytext);
                                        printf("Variable: %s\n",aux);
                                        yylval.cadena = aux;
                                        return(VARIABLE);
                                        }

{NUM}                   {
                        printf("Numero entero %s\n",yytext);
                        yylval.entero = atoi(yytext);
                        return (ENTERO);
                        }


{NUM}"."{NUM}           {
                        printf("Numero flotante %s\n",yytext);
                        yylval.flotante = atof(yytext);
                        return (FLOTANTE);
                        }

"+"|"*"|"/"|"^"|"-"     {
                        printf("Signo op\n");
                        return (yytext[0]);
                        }

"("                     {
                        printf("Agrupacion\n");
                        return(ABRE);
                        }

")"                     {
                        printf("Agrupacion\n");
                        return(CIERRA);
                        }

","                     {
                        printf("Separador\n");
                        return(SEPARA);
                        }

"\n"                    {
                        printf("Salto de linea\n");
                        return (yytext[0]);
                        }
"\""                    {
                        printf("Comilla\n");
                        return(COMILLA);
                        }

%%
