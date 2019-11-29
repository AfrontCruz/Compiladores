%{
#include "practica.tab.h"
#include <string.h>
#include <stdlib.h>
#include "simbolos.h"

%}
 
NUM [0-9]+
DIG [0-9]
ABC [a-z]|[A-Z]
SIMBOLO _

%%

"@"                     {
                        print(tSim);
                        }

" "                                   {}

\"[^\"]*\"               {
                        printf("String: %s\n", yytext);
                        int i = 0;
                        while( yytext[i] )
                                i++;
                        char* aux = malloc(sizeof(char)*i);
                        for(int j = 1; j < i - 1; j++)
                                aux[j-1] = yytext[j];
                        printf("String: %s\n", aux);
                        yylval.cadena = aux;
                        return(CADENA);
                        }
                        
"POW"                   {
                        printf("Potencia\n");
                        return(POTENCIA);
                        }


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
"if"                                    {
                                        printf("Aquí hay un if...\n");
                                        return(IF);
                                        }

"=="                                    {
                                        return(EQ);
                                        }

"<"                                     {
                                        return(MENOR);
                                        }
">"                                     {
                                        return(MAYOR);
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
"string"                                {
                                        printf("Tipo de dato %s\n",yytext);
                                        yylval.cadena = "string";
                                        return(TIPO);
                                        }

({ABC}+{DIG}*|{SIMBOLO}+{DIG}*{ABC}*)+" "*"="   {
                                                int i = 0;
                                                while( yytext[i] != '=' ){
                                                        if( yytext[i] == ' ' )
                                                                break;
                                                        i++;
                                                }
                                                char *aux = malloc( sizeof(char)*i );
                                                for(int j = 0; j < i; j++)
                                                        aux[j] = yytext[j];
                                                printf("Variable sin espacio igual: %s\n", aux);
                                                
                                                yylval.cadena = aux;
                                                return (VARIABLE_B);
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
                                        elemento e = search(tSim, aux);
                                        if( e ==  NULL){
                                                printf("No se encontro\n");
                                                return (VARIABLE);
                                        }
                                        else{
                                                if( strcmp(e->type, "int") == 0 ){
                                                        yylval.entero = e->valor.entero;
                                                        return(VAR_INT);
                                                }
                                                else if( strcmp(e->type, "float") == 0 ){
                                                        yylval.flotante = e->valor.flotante;
                                                        return(VAR_FLOAT);
                                                }
                                                else if( strcmp(e->type, "char") == 0 ){
                                                        yylval.caracter = e->valor.caracter;
                                                        return(VAR_CHAR);
                                                }
                                                else if( strcmp(e->type, "double") == 0 ){
                                                        yylval.real = e->valor.real;
                                                        return(VAR_DOUBLE);
                                                }
                                                else{
                                                        yylval.cadena = e->valor.cadena;
                                                        return(VAR_CADENA);
                                                }
                                        }

                                        }

"-"{NUM}|{NUM}                   {
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

%%

