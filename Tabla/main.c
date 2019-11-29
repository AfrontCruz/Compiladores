#include <stdio.h>
#include <stdlib.h>
#include "simbolos.h"
#include <string.h>


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

elemento search(tabla tSim, char* nombre){
	elemento e = tSim->inicio;
	while( e != NULL ){
		if( strcmp(e->nombre, nombre) == 0 ){
			return e;
		}
		e = e->next;
	}
	return NULL;
}

void update(elemento aux, tipo t){
	aux->valor = t;
}

void print(tabla tSim){
	elemento e = tSim->inicio;
	printf("\tID\tNombre\tTipo\tValor\n");
	while( e != NULL ){
		if( strcmp(e->type,"int") == 0 )
			printf("\t%i\t%s\t%s\t%i\n", e->id, e->nombre, e->type, e->valor.entero);
		else if( strcmp(e->type,"char") == 0 )
			printf("\t%i\t%s\t%s\t%c\n", e->id, e->nombre, e->type, e->valor.caracter);
		else if( strcmp(e->type,"float") == 0 )
			printf("\t%i\t%s\t%s\t%f\n", e->id, e->nombre, e->type, e->valor.flotante);
		else if( strcmp(e->type,"double") == 0 )
			printf("\t%i\t%s\t%s\t%lf\n", e->id, e->nombre, e->type, e->valor.real);
		else
			printf("\t%i\t%s\t%s\t%s\n", e->id, e->nombre, e->type, e->valor.cadena);
		e = e->next;
	}
}

char* concat(char *a1, char *a2){
	int i = 0, j = 0;
	while( a1[i] )
		i++;
	while( a2[j] )
		j++;
	char* aux = malloc(sizeof(char)*(i+j));
	aux = strcat(a1, a2);
	return;
}

char* invert(char* s1){
	int i = 0;
	while(s1[i])
		i++;
	char *aux = malloc(sizeof(char)*i);
	printf("\tTest..\n");
	for( int j = 0; j < i; j++ )
		aux[j] = s1[i-1-j];
	printf("\tTest..\n");
	return aux;

}

/*

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

	elemento aux = search(tSim, "myvar");
	printf("Elemento buscado... \n");
	printf("%i\t%s\t%s\t%i\n", aux->id, aux->nombre, aux->type, aux->valor.entero);
	tipo t;
	t.entero = 5;
	aux->valor = t;

	printf("Nueva ----\n\n\n");
	print(tSim);

	free(tSim);
	free(e);
	free(b);
	free(a);
	return 0;
}*/