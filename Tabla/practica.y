%{
	#include <math.h>
	#include <string.h>
	#include <stdlib.h>
	#include "simbolos.h"

%}
             
/* Declaraciones de BISON */
%union{
	int entero;
	float flotante;
	char caracter;
	double real;
	char* cadena;
}

%token <entero> ENTERO
%token <flotante> FLOTANTE
%token <caracter> CARACTER
%token ABRE
%token CIERRA
%token SEPARA
%token MODULO
%token POTENCIA
%token <cadena> CADENA
%token <cadena> VARIABLE
%token <cadena> VARIABLE_B
%token <entero> VAR_INT
%token <flotante> VAR_FLOAT
%token <real> VAR_DOUBLE
%token <cadena> VAR_CADENA
%token <caracter> VAR_CHAR
%token <cadena> TIPO
%token <caracter> EQUALS
%token <caracter> FIN_EXP
%token EQ
%token MAYOR
%token MENOR
%token IF

%type <entero> exp_entera
%type <flotante> exp_float
%type <caracter> exp_char
%type <cadena> string
%type <cadena> tipo
%type <caracter> fin
%type <cadena> condicion
%type <caracter> op_cond
             
%left '+' '-'
%left '*' '/'
%left '^' POTENCIA
             
/* Gramática */
%%
             
input:    /* cadena vacía */
        | input line             
;

line:     '\n'
		| condicion fin '\n'			{
									printf("\tLa condicion es: %s\n",$1);
									}
		| tipo VARIABLE fin '\n' 	{
									elemento e = malloc( sizeof(struct elemento) );
									if( e == NULL)
										printf("No se pudo reservar memoria\n");
									e->type = $1;
									e->nombre = $2;
									e->id = tSim->elementos;
									e->next = NULL;
									if( strcmp($1, "int") == 0 ){
										e->valor.entero = 0;
									}
									else if( strcmp($1, "float") == 0 ){
										e->valor.flotante = 0.0;
									}
									else if( strcmp($1, "char") == 0 ){
										e->valor.caracter = 'a';
									}
									else if( strcmp($1, "double") == 0 ){
										e->valor.real = 0.0;
									}
									else if( strcmp($1, "string") == 0 ){
										e->valor.cadena = "";
									}

									if( add(tSim, e) == 1 ){
										printf("\n\n\t----Tabla de Simbolos----\n\n");
										print(tSim);
										tSim->elementos++;
										printf("\n\n");
									}

									}
		| tipo VARIABLE_B exp_entera fin '\n' 	{
													printf("\tAsignacion entera...\n");
													elemento e = malloc( sizeof(struct elemento) );
													if( e == NULL)
														printf("No se pudo reservar memoria\n");
													e->type = $1;
													e->nombre = $2;
													e->id = tSim->elementos;
													e->next = NULL;
													if( strcmp($1, "int") == 0 ){
														e->valor.entero = $3;
													}
													else if( strcmp($1, "float") == 0 ){
														e->valor.flotante = (float)$3;
													}
													else if( strcmp($1, "char") == 0 ){
														e->valor.caracter = (char)$3;
													}
													else if( strcmp($1, "double") == 0 ){
														e->valor.real = (double)$3;
													}

													if( add(tSim, e) == 1 ){
														printf("\n\n\t----Tabla de Simbolos----\n\n");
														print(tSim);
														tSim->elementos++;
														printf("\n\n");
													}
													}
		| tipo VARIABLE_B exp_float fin '\n' 		{
													printf("\tAsignacion float or double\n");
													elemento e = malloc( sizeof(struct elemento) );
													if( e == NULL)
														printf("No se pudo reservar memoria\n");
													e->type = $1;
													e->nombre = $2;
													e->id = tSim->elementos;
													e->next = NULL;
													if( strcmp($1, "int") == 0 ){
														printf("\tSe pueden perder datos en este cast...\n");
														e->valor.entero = (int)$3;
													}
													else if( strcmp($1, "float") == 0 ){
														e->valor.flotante = (float)$3;
													}
													else if( strcmp($1, "char") == 0 ){
														printf("\tSe pueden perder datos en este cast...\n");
														e->valor.caracter = (char)$3;
													}
													else if( strcmp($1, "double") == 0 ){
														e->valor.real = (double)$3;
													}

													if( add(tSim, e) == 1 ){
														printf("\n\n\t----Tabla de Simbolos----\n\n");
														print(tSim);
														tSim->elementos++;
														printf("\n\n");
													}
													}
		| VARIABLE_B exp_entera fin '\n'			{
													elemento e = search(tSim, $1);
													if( e == NULL )
														printf("\tNo existe la variable en la tabla\n");
													else{
														if( strcmp(e->type, "int") == 0 ){
															e->valor.entero = (int)$2;
														}
														else if( strcmp(e->type, "float") == 0 ){
															e->valor.flotante = (float)$2;
														}
														else if( strcmp(e->type, "char") == 0 ){
															e->valor.caracter = (char)$2;
														}
														else if( strcmp(e->type, "double") == 0 ){
															e->valor.real = (double)$2;
														}
														else{
															yyerror("Types String incompatible");
														}
														printf("\n\n\t----Tabla de Simbolos----\n\n");
														print(tSim);
													}
													}
		| VARIABLE_B exp_char fin '\n'			{
													printf("\tIgualacion char\n");
													elemento e = search(tSim, $1);
													if( e == NULL )
														printf("\tNo existe la variable en la tabla\n");
													else{
														if( strcmp(e->type, "int") == 0 ){
															e->valor.entero = (int)$2;
														}
														else if( strcmp(e->type, "float") == 0 ){
															e->valor.flotante = (float)$2;
														}
														else if( strcmp(e->type, "char") == 0 ){
															e->valor.caracter = (char)$2;
														}
														else if( strcmp(e->type, "double") == 0 ){
															e->valor.real = (double)$2;
														}
														else{
															yyerror("Types String incompatible");
														}
														printf("\n\n\t----Tabla de Simbolos----\n\n");
														print(tSim);
													}
													}
		| VARIABLE_B exp_float fin '\n'			{
													printf("\tIgualacion float or double\n");
													elemento e = search(tSim, $1);
													if( e == NULL )
														printf("\tNo existe la variable en la tabla\n");
													else{
														if( strcmp(e->type, "int") == 0 ){
															e->valor.entero = (int)$2;
														}
														else if( strcmp(e->type, "float") == 0 ){
															e->valor.flotante = (float)$2;
														}
														else if( strcmp(e->type, "char") == 0 ){
															e->valor.caracter = (char)$2;
														}
														else if( strcmp(e->type, "double") == 0 ){
															e->valor.real = (double)$2;
														}
														else{
															yyerror("Types String incompatible");
														}
														printf("\n\n\t----Tabla de Simbolos----\n\n");
														print(tSim);
													}
													}
		| tipo VARIABLE_B exp_char fin '\n' 		{
													printf("\tAsignacion char\n");
													elemento e = malloc( sizeof(struct elemento) );
													if( e == NULL)
														printf("No se pudo reservar memoria\n");
													e->type = $1;
													e->nombre = $2;
													e->id = tSim->elementos;
													e->next = NULL;
													if( strcmp($1, "int") == 0 ){
														printf("\tSe pueden perder datos en este cast...\n");
														e->valor.entero = (int)$3;
													}
													else if( strcmp($1, "float") == 0 ){
														printf("\tSe pueden perder datos en este cast...\n");
														e->valor.flotante = (float)$3;
													}
													else if( strcmp($1, "char") == 0 ){
														e->valor.caracter = (char)$3;
													}
													else if( strcmp($1, "double") == 0 ){
														printf("\tSe pueden perder datos en este cast...\n");
														e->valor.real = (double)$3;
													}

													if( add(tSim, e) == 1 ){
														printf("\n\n\t----Tabla de Simbolos----\n\n");
														print(tSim);
														tSim->elementos++;
														printf("\n\n");
													}
													}
		| tipo VARIABLE_B string fin '\n' 		{
													printf("\tAsignacion cadena\n");
													elemento e = malloc( sizeof(struct elemento) );
													if( e == NULL)
														printf("No se pudo reservar memoria\n");
													e->type = $1;
													e->nombre = $2;
													e->id = tSim->elementos;
													e->next = NULL;
													e->valor.cadena = $3;
													int i = add(tSim,e);
													print(tSim);
													tSim->elementos++;
													}
		| VARIABLE_B string fin '\n' 			{
													printf("\tIgualacion cadena\n");
													elemento e = search(tSim, $1);
													if( e == NULL )
														printf("\tNo existe la variable en la tabla\n");
													else{
														if( strcmp(e->type, "string" ) == 0 ){
															e->valor.cadena = $2;
															print(tSim);
														}
														else
															printf("Está asignando mal un string\n");
													}
													}
        | exp_entera '\n'  { printf ("\tresultado: %d\n", $1); }
        | exp_float '\n'  { printf ("\tresultado: %f\n", $1); }
        | string '\n'  {
        				printf ("\tresultado: "); 
        				int i = 0; 
        				while($1[i] != '\0'){
        					if( $1[i] != '"' && $1[i] != '+' && $1[i] != '\n' )
                            	printf("%c",$1[i]);
                            i++;
                        }
                        printf ("\n"); 
                        }
;

tipo: TIPO			{$$ = $1;}

fin: FIN_EXP		{$$ = $1;}

op_cond:

EQ  		{$$ = '='; }
| MAYOR 	{$$ = '>';}
| MENOR		{$$ = '<';}

condicion: 

IF ABRE exp_entera  op_cond exp_entera CIERRA			{
														switch( $4 ){
															case '=' :
																if( $3 == $5 )
																	$$ = "TRUE";
																else
																	$$ = "FALSE";
															case '<' :
																if( $3 < $5 )
																	$$ = "TRUE";
																else
																	$$ = "FALSE";
															case '>' :
																if( $3 > $5 )
																	$$ = "TRUE";
																else
																	$$ = "FALSE";
														}
														}
| IF ABRE exp_entera  op_cond exp_float CIERRA			{
														switch( $4 ){
															case '=' :
																if( $3 == $5 )
																	$$ = "TRUE";
																else
																	$$ = "FALSE";
															case '<' :
																if( $3 < $5 )
																	$$ = "TRUE";
																else
																	$$ = "FALSE";
															case '>' :
																if( $3 > $5 )
																	$$ = "TRUE";
																else
																	$$ = "FALSE";
														}
														}
| IF ABRE exp_float  op_cond exp_entera CIERRA			{
														switch( $4 ){
															case '=' :
																if( $3 == $5 )
																	$$ = "TRUE";
																else
																	$$ = "FALSE";
															case '<' :
																if( $3 < $5 )
																	$$ = "TRUE";
																else
																	$$ = "FALSE";
															case '>' :
																if( $3 > $5 )
																	$$ = "TRUE";
																else
																	$$ = "FALSE";
														}
														}
| IF ABRE exp_float  op_cond exp_float CIERRA			{
														switch( $4 ){
															case '=' :
																if( $3 == $5 )
																	$$ = "TRUE";
																else
																	$$ = "FALSE";
															case '<' :
																if( $3 < $5 )
																	$$ = "TRUE";
																else
																	$$ = "FALSE";
															case '>' :
																if( $3 > $5 )
																	$$ = "TRUE";
																else
																	$$ = "FALSE";
														}
														}
| IF ABRE exp_char  op_cond exp_char CIERRA				{
														switch( $4 ){
															case '=' :
																if( $3 == $5 )
																	$$ = "TRUE";
																else
																	$$ = "FALSE";
															case '<' :
																if( $3 < $5 )
																	$$ = "TRUE";
																else
																	$$ = "FALSE";
															case '>' :
																if( $3 > $5 )
																	$$ = "TRUE";
																else
																	$$ = "FALSE";
														}
														}
| IF ABRE exp_char  op_cond exp_entera CIERRA			{
														switch( $4 ){
															case '=' :
																if( $3 == $5 )
																	$$ = "TRUE";
																else
																	$$ = "FALSE";
															case '<' :
																if( $3 < $5 )
																	$$ = "TRUE";
																else
																	$$ = "FALSE";
															case '>' :
																if( $3 > $5 )
																	$$ = "TRUE";
																else
																	$$ = "FALSE";
														}
														}
| IF ABRE exp_entera  op_cond exp_char CIERRA			{
														switch( $4 ){
															case '=' :
																if( $3 == $5 )
																	$$ = "TRUE";
																else
																	$$ = "FALSE";
															case '<' :
																if( $3 < $5 )
																	$$ = "TRUE";
																else
																	$$ = "FALSE";
															case '>' :
																if( $3 > $5 )
																	$$ = "TRUE";
																else
																	$$ = "FALSE";
														}
														}
| IF ABRE exp_char  op_cond exp_float CIERRA			{
														switch( $4 ){
															case '=' :
																if( $3 == $5 )
																	$$ = "TRUE";
																else
																	$$ = "FALSE";
															case '<' :
																if( $3 < $5 )
																	$$ = "TRUE";
																else
																	$$ = "FALSE";
															case '>' :
																if( $3 > $5 )
																	$$ = "TRUE";
																else
																	$$ = "FALSE";
														}
														}
| IF ABRE exp_float  op_cond exp_char CIERRA			{
														switch( $4 ){
															case '=' :
																if( $3 == $5 )
																	$$ = "TRUE";
																else
																	$$ = "FALSE";
															case '<' :
																if( $3 < $5 )
																	$$ = "TRUE";
																else
																	$$ = "FALSE";
															case '>' :
																if( $3 > $5 )
																	$$ = "TRUE";
																else
																	$$ = "FALSE";
														}
														}


exp_entera:     ENTERO	{ $$ = $1; }
	| VAR_INT							{ $$ = $1;}
	| exp_entera '+' exp_entera        	{ $$ = $1 + $3;  }
	| exp_entera '*' exp_entera        	{ $$ = $1 * $3;	}
	| exp_entera '-' exp_entera        	{ $$ = $1 - $3;	}
	| MODULO ABRE exp_entera SEPARA exp_entera CIERRA 	{$$ = $3%$5;}
	| POTENCIA ABRE exp_entera SEPARA exp_entera CIERRA 	{$$ = pow($3,$5);}
;

exp_float: FLOTANTE                		 	{ $$ = $1; }
	| VAR_FLOAT								{ $$ = $1;}
	| VAR_DOUBLE							{ $$ = $1;}
	| exp_float '+' exp_float	 			{ $$ = $1 + $3; }
	| exp_float '-' exp_float	 			{ $$ = $1 - $3; }
	| exp_float '*' exp_float 			{ $$ = $1 * $3; }
	| exp_float '/' exp_float	 			{ $$ = $1 / $3; }
	| exp_entera '+' exp_float	 	 	{ $$ = $1 + $3; }
	| exp_entera '-' exp_float	 	 	{ $$ = $1 - $3; }
	| exp_entera '*' exp_float 			{ $$ = $1 * $3; }
	| exp_entera '/' exp_float	 		{ $$ = $1 / $3; }
	| exp_float '+' exp_entera	 	 	{ $$ = $1 + $3; }
	| exp_float '-' exp_entera	 	 	{ $$ = $1 - $3; }
	| exp_float '*' exp_entera 			{ $$ = $1 * $3; }
	| exp_float '/' exp_entera	 		{ $$ = $1 / $3; }
	| exp_entera '/' exp_entera			{ $$ = $1 / (float)$3; }
	|	MODULO ABRE exp_float SEPARA exp_float CIERRA 	{$$ = fmod($3,$5);}
	|	MODULO ABRE exp_entera SEPARA exp_float CIERRA 	{$$ = fmod($3,$5);}
	|	MODULO ABRE exp_float SEPARA exp_entera CIERRA 	{$$ = fmod($3,$5);}
	|	POTENCIA ABRE exp_float SEPARA exp_entera CIERRA 	{ $$ = pow($3,$5); }
	|	POTENCIA ABRE exp_entera SEPARA exp_float CIERRA 	{ $$ = pow($3,$5); }
	|	POTENCIA ABRE exp_float SEPARA exp_float CIERRA 	{ $$ = pow($3,$5); }

;

exp_char: CARACTER {$$ = $1;}
| VAR_CHAR { $$ = $1; }

string: CADENA 				{
							printf("\tCadena: %s\n",$1);
							$$ = $1;
							}
	| VAR_CADENA			{$$ = $1;}
	|	string '+' string  	{$$ = concat($1, $3);}
	| string '^' exp_entera {
							if( $3 > 0 ){
								$$ = $1;
								for(int i = 1; i < $3; i++)
									$$ = concat($$, $$);
							}
							else if ( $3 < 0){
								$$ = invert($1);
								for(int i = 1; i < -$3; i++)
									$$ = concat($$, $$);
							}
							}

%%

int main() {
	tSim = malloc( sizeof( struct tabla ) );
	tSim->inicio = NULL;
	tSim->elementos = 0;
	yyparse();
}
             
yyerror (char *s)
{
  printf ("\t--%s--\n", s);
}
            
int yywrap()  
{  
  return 1;  
}  
