%{
	#include <math.h>
	#include <string.h>
	#include <stdlib.h>
	#include "simbolos.h"

	tabla tSim;
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
%token COMILLA
%token <cadena> CADENA
%token <cadena> VARIABLE
%token <cadena> TIPO
%token <caracter> EQUALS
%token <caracter> FIN_EXP

%type <entero> exp_entera
%type <flotante> exp_float
%type <caracter> exp_char
%type <cadena> string
%type <cadena> nom_var
%type <cadena> tipo
%type <caracter> fin
%type <caracter> equal

             
%left '+' '-'
%left '*' '/'
%left '^'
             
/* Gramática */
%%
             
input:    /* cadena vacía */
        | input line             
;

line:     '\n'
		| tipo nom_var fin '\n' 	{
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
		| tipo nom_var equal exp_entera fin '\n' 	{
													printf("\tAsignacion entera...\n");
													elemento e = malloc( sizeof(struct elemento) );
													if( e == NULL)
														printf("No se pudo reservar memoria\n");
													e->type = $1;
													e->nombre = $2;
													e->id = tSim->elementos;
													e->next = NULL;
													if( strcmp($1, "int") == 0 ){
														e->valor.entero = $4;
													}
													else if( strcmp($1, "float") == 0 ){
														e->valor.flotante = (float)$4;
													}
													else if( strcmp($1, "char") == 0 ){
														e->valor.caracter = (char)$4;
													}
													else if( strcmp($1, "double") == 0 ){
														e->valor.real = (double)$4;
													}

													if( add(tSim, e) == 1 ){
														printf("\n\n\t----Tabla de Simbolos----\n\n");
														print(tSim);
														tSim->elementos++;
														printf("\n\n");
													}
													}
		| tipo nom_var equal exp_float fin '\n' 	{
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
														e->valor.entero = (int)$4;
													}
													else if( strcmp($1, "float") == 0 ){
														e->valor.flotante = (float)$4;
													}
													else if( strcmp($1, "char") == 0 ){
														printf("\tSe pueden perder datos en este cast...\n");
														e->valor.caracter = (char)$4;
													}
													else if( strcmp($1, "double") == 0 ){
														e->valor.real = (double)$4;
													}

													if( add(tSim, e) == 1 ){
														printf("\n\n\t----Tabla de Simbolos----\n\n");
														print(tSim);
														tSim->elementos++;
														printf("\n\n");
													}
													}
		| nom_var equal exp_entera fin '\n'			{
													elemento e = search(tSim, $1);
													if( e == NULL )
														printf("\tNo existe la variable en la tabla\n");
													else{
														if( strcmp(e->type, "int") == 0 ){
															e->valor.entero = (int)$3;
														}
														else if( strcmp(e->type, "float") == 0 ){
															e->valor.flotante = (float)$3;
														}
														else if( strcmp(e->type, "char") == 0 ){
															e->valor.caracter = (char)$3;
														}
														else if( strcmp(e->type, "double") == 0 ){
															e->valor.real = (double)$3;
														}
														printf("\n\n\t----Tabla de Simbolos----\n\n");
														print(tSim);
													}
													}
		| nom_var equal exp_char fin '\n'			{
													printf("\tIgualacion char\n");
													elemento e = search(tSim, $1);
													if( e == NULL )
														printf("\tNo existe la variable en la tabla\n");
													else{
														if( strcmp(e->type, "int") == 0 ){
															e->valor.entero = (int)$3;
														}
														else if( strcmp(e->type, "float") == 0 ){
															e->valor.flotante = (float)$3;
														}
														else if( strcmp(e->type, "char") == 0 ){
															e->valor.caracter = (char)$3;
														}
														else if( strcmp(e->type, "double") == 0 ){
															e->valor.real = (double)$3;
														}
														printf("\n\n\t----Tabla de Simbolos----\n\n");
														print(tSim);
													}
													}
		| nom_var equal exp_float fin '\n'			{
													printf("\tgualacion float or double\n");
													elemento e = search(tSim, $1);
													if( e == NULL )
														printf("\tNo existe la variable en la tabla\n");
													else{
														if( strcmp(e->type, "int") == 0 ){
															e->valor.entero = (int)$3;
														}
														else if( strcmp(e->type, "float") == 0 ){
															e->valor.flotante = (float)$3;
														}
														else if( strcmp(e->type, "char") == 0 ){
															e->valor.caracter = (char)$3;
														}
														else if( strcmp(e->type, "double") == 0 ){
															e->valor.real = (double)$3;
														}
														printf("\n\n\t----Tabla de Simbolos----\n\n");
														print(tSim);
													}
													}
		| tipo nom_var equal exp_char fin '\n' 		{
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
														e->valor.entero = (int)$4;
													}
													else if( strcmp($1, "float") == 0 ){
														printf("\tSe pueden perder datos en este cast...\n");
														e->valor.flotante = (float)$4;
													}
													else if( strcmp($1, "char") == 0 ){
														e->valor.caracter = (char)$4;
													}
													else if( strcmp($1, "double") == 0 ){
														printf("\tSe pueden perder datos en este cast...\n");
														e->valor.real = (double)$4;
													}

													if( add(tSim, e) == 1 ){
														printf("\n\n\t----Tabla de Simbolos----\n\n");
														print(tSim);
														tSim->elementos++;
														printf("\n\n");
													}
													}
		| tipo nom_var equal string fin '\n' 		{
													printf("\tAsignacion cadena\n");
													elemento e = malloc( sizeof(struct elemento) );
													if( e == NULL)
														printf("No se pudo reservar memoria\n");
													e->type = $1;
													e->nombre = $2;
													e->id = tSim->elementos;
													e->next = NULL;
													e->valor.cadena = $4;
													int i = add(tSim,e);
													print(tSim);
													tSim->elementos++;
													}
        | exp_entera '\n'  { printf ("\tresultado: %d\n", $1); }
        | nom_var '\n' { printf("\tVar: %s", $1 ); }
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

nom_var: VARIABLE 	{$$ = $1;}

tipo: TIPO			{$$ = $1;}

equal: EQUALS		{$$ = $1;}

fin: FIN_EXP		{$$ = $1;}
             
exp_entera:     ENTERO	{ $$ = $1; }
	| exp_entera '+' exp_entera        { $$ = $1 + $3;  }
	| exp_entera '*' exp_entera        { $$ = $1 * $3;	}
	| exp_entera '-' exp_entera        { $$ = $1 - $3;	}
	| exp_entera '^' exp_entera        { $$ = $1 ^ $3;	}
	| MODULO ABRE exp_entera SEPARA exp_entera CIERRA 	{$$ = $3%$5;}
;

exp_float: FLOTANTE                		 	{ $$ = $1; }
	  | nom_var								{
	  										elemento e = search(tSim, $1);
											if( e == NULL )
												printf("\tNo existe la variable en la tabla\n");
											if( strcmp(e->type, "int") == 0 ){
												$$ = (float) e->valor.entero;
											}
											else if( strcmp(e->type, "float") == 0 ){
												$$ = (float) e->valor.flotante;
											}
											else if( strcmp(e->type, "char") == 0 ){
												$$ = (float) e->valor.caracter;
											}
											else if( strcmp(e->type, "double") == 0 ){
												$$ = (float) e->valor.real;
											}
											printf("\tFloat: %f\n", $$);
										    }
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
	  | exp_entera '^' exp_float        	{ $$ = pow($1,$3);	}
	  | exp_float '^' exp_float        		{ $$ = pow($1,$3);	}
	  | exp_float '^' exp_entera        		{ $$ = pow($1,$3);	}

	|	MODULO ABRE exp_float SEPARA exp_float CIERRA 	{$$ = fmod($3,$5);}
	|	MODULO ABRE exp_entera SEPARA exp_float CIERRA 	{$$ = fmod($3,$5);}
	|	MODULO ABRE exp_float SEPARA exp_entera CIERRA 	{$$ = fmod($3,$5);}
;

exp_char: CARACTER {$$ = $1;}

string: CADENA 				{
							printf("\tCadena: %s\n",$1);
							$$ = $1;
							}
	|	 					{$$ = "";}
	|	string '^' string 	{
							int i = 0;
							while( $1[i] )
								i++;
							char* aux = malloc(sizeof(char)*2*i);
							for(int j = 0; j < 2*i; i++)
								aux[j] = $1[j%i];
							printf("%s\n", aux);
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
