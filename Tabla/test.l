
PALABRA [a-z]|[A-Z]
NUM [0-9]
SIMBOLO _

%%

"int"|"float"|"char"|"double" printf("Tipo de datos\n");

({PALABRA}+{NUM}*|{SIMBOLO}+{NUM}*{PALABRA}*)+ printf("Variable valida\n");

"=" printf("Asignacion\n");

{NUM}+ printf("Numero\n");

";" printf("Fin de expresion\n");

" " printf("SPACE\n");

%%



/*({ABC}*|{DIG}*|" ")*   {
                        printf("Cadena %s\n",yytext );
                        yylval.cadena = yytext;
                        return(CADENA);
                        }

| nom_var			{
						elemento e = search(tSim, $1);
						if( e == NULL )
							printf("\tNo existe la variable en la tabla\n");
						$$ = e->valor.entero;
						}


						
                        */