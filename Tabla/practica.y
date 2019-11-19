%{
	#include <math.h>
	#include <string.h>
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
%token ABRE
%token CIERRA
%token SEPARA
%token MODULO
%token COMILLA
%token <cadena> CADENA
%token <cadena> VARIABLE

%type <entero> exp_entera
%type <flotante> exp_float
%type <cadena> string
%type <cadena> nom_var

             
%left '+' '-'
%left '*' '/'
%left '^'
             
/* Gramática */
%%
             
input:    /* cadena vacía */
        | input line             
;

line:     '\n'
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

nom_var:	VARIABLE {$$ = $1;}
             
exp_entera:     ENTERO	{ $$ = $1; }
	| exp_entera '+' exp_entera        { $$ = $1 + $3;  }
	| exp_entera '*' exp_entera        { $$ = $1 * $3;	}
	| exp_entera '-' exp_entera        { $$ = $1 - $3;	}
	| exp_entera '^' exp_entera        { $$ = $1 ^ $3;	}
	| MODULO ABRE exp_entera SEPARA exp_entera CIERRA 	{$$ = $3%$5;}
;

exp_float: FLOTANTE                		 	{ $$ = $1; }
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
	|	MODULO ABRE exp_float SEPARA exp_float CIERRA 	{$$ = fmod($3,$5);}
	|	MODULO ABRE exp_entera SEPARA exp_float CIERRA 	{$$ = fmod($3,$5);}
	|	MODULO ABRE exp_float SEPARA exp_entera CIERRA 	{$$ = fmod($3,$5);}
;


string: COMILLA CADENA COMILLA 				{$$ = $2;}
	|	COMILLA COMILLA 					{$$ = "";}
	|	string '+' string 					{}

%%

int main() {
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
