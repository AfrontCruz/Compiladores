%{
#include "practica.tab.h"
%}

NUM [0-9]+
DIG [0-9]
ABC [a-z]|[A-Z]


%%

"MOD"                   {
                        printf("Modulo\n");
                        return(MODULO);
                        }

{NUM}                   {
                        printf("Numero entero %s\n",yytext);
                        yylval.entero = atoi(yytext);
                        return (ENTERO);
                        }

({ABC}*|{DIG}*|" ")*   {
                        printf("Cadena %s\n",yytext );
                        int i = 0;
                        yylval.cadena = yytext;
                        return(CADENA);
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
