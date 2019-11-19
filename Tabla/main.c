#include <stdio.h>
#include <stdlib.h>
#include "simbolos.h"
#include <string.h>

int main(){
	tabla tSim = malloc( sizeof(struct tabla) );
	tSim->inicio = NULL;
	tSim->elementos = 0;

	elemento e = malloc( sizeof(struct elemento) );
	if( e == NULL)
		printf("No se pudo reservar memoria\n");
	e->type = "ENTERO";
	e->valor.entero = 1;
	e->nombre = "myvar";
	e->id = 1;
	e->next = NULL;

	elemento a = malloc( sizeof(struct elemento) );
	if( a == NULL)
		printf("No se pudo reservar memoria\n");
	a->type = "ENTERO";
	a->valor.entero = 1;
	a->nombre = "myvar_2";
	a->id = 2;
	a->next = NULL;

	elemento b = malloc( sizeof(struct elemento) );
	if( b == NULL)
		printf("No se pudo reservar memoria\n");
	b->type = "ENTERO";
	b->valor.entero = 1;
	b->nombre = "myvar_1";
	b->id = 3;
	b->next = NULL;	

	elemento w = malloc( sizeof(struct elemento) );
	if( w == NULL)
		printf("No se pudo reservar memoria\n");
	w->type = "CHAR";
	w->valor.caracter = 'a';
	w->nombre = "let_a";
	w->id = 4;
	w->next = NULL;	

	if( add(tSim, e) == 1 ){
		tSim->elementos++;
		printf("Se agrego sin problema!!!\n");
	}
	else
		printf("No se agrego :o\n");

	if( add(tSim, a) == 1 ){
		tSim->elementos++;
		printf("Se agrego sin problema!!!\n");
	}
	else
		printf("No se agrego :o\n");

	if( add(tSim, b) == 1 ){
		tSim->elementos++;
		printf("Se agrego sin problema!!!\n");
	}
	else
		printf("No se agrego :o\n");

	if( add(tSim, w) == 1 ){
		tSim->elementos++;
		printf("Se agrego sin problema!!!\n");
	}
	else
		printf("No se agrego :o\n");

	printf("%i\n",tSim->elementos );

	print(tSim);

	free(tSim);
	free(e);
	free(b);
	free(a);
	return 0;
}

int add(tabla tSim, elemento new){
	/*Este if inserta el primer tope de la tabla de símbolos*/
	if( tSim->inicio == NULL ){
		tSim->inicio = new;
		return 1;
	}
	elemento aux = tSim->inicio;

	while( aux->next != NULL ){
		aux = aux->next;
	}
	if( strcmp( aux->nombre, new->nombre ) == 0 ){
		printf("Ya existe el elemento en la tabla de simbolos\n");
		return -1;
	}
	aux->next = new;
	return 1;
}

void print(tabla tSim){
	elemento e = tSim->inicio;
	printf("ID\tNombre\tTipo\tValor\n");
	while( e != NULL ){
		if( strcmp(e->type,"ENTERO") == 0 )
			printf("%i\t%s\t%s\t%i\n", e->id, e->nombre, e->type, e->valor.entero);
		else if( strcmp(e->type,"CHAR") == 0 )
			printf("%i\t%s\t%s\t%c\n", e->id, e->nombre, e->type, e->valor.caracter);
		else if( strcmp(e->type,"FLOAT") == 0 )
			printf("%i\t%s\t%s\t%f\n", e->id, e->nombre, e->type, e->valor.flotante);
		else
			printf("%i\t%s\t%s\t%lf\n", e->id, e->nombre, e->type, e->valor.real);
		e = e->next;
	}
}


/*
elemento e = malloc(sizeof(struct elemento));
	
	if( e == NULL)
		printf("No se pudo reservar memoria\n");

	e->type = "ENTERO";
	e->valor.entero = 1;
	e->nombre = "myvar";
	e->id = 1;
	e->next = NULL;

	printf("ID\tNombre\tTipo\tValor\n");
	printf("%i\t%s\t%s\t%i\n", e->id, e->nombre, e->type, e->valor);

	free(e);

*/

