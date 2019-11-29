														{
														elemento e = search(tSim, $1);
														if( e == NULL )
															printf("\tNo existe la variable en la tabla\n");
														else{
															if( strcmp(e->type, "int") == 0 ){
																if( e->valor.entero == $5)
																	$$ = "TRUE";
																else
																	$$ = "FALSE";
															}
															else if( strcmp(e->type, "float") == 0 ){
																if( e->valor.entero == $5)
																	$$ = "TRUE";
																else
																	$$ = "FALSE";
															}
															else if( strcmp(e->type, "char") == 0 ){
																if( e->valor.caracter == $5)
																	$$ = "TRUE";
																else
																	$$ = "FALSE";
															}
															else if( strcmp(e->type, "double") == 0 ){
																if( e->valor.real == $5)
																	$$ = "TRUE";
																else
																	$$ = "FALSE";
															}
															else{
																yyerror("Types String incompatible");
															}
															printf("\n\n\t----Tabla de Simbolos----\n\n");
															print(tSim);
														}
														if( $3 == $5 )
															$$ = "TRUE";
														else
															$$ = "FALSE";
														}