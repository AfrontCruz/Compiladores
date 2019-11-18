#include <stdio.h>
#include <stdlib.h>

typedef struct elemento *elemento;
typedef struct tabla *tabla;
typedef union tipo tipo;

union tipo{
	int entero;
	char caracter;
	double real;
	float flotante;
};

struct elemento
{
	char* type;
	char* nombre;
	int id;
	tipo valor;
	elemento* next;
};

struct tabla{
	elemento* inicio;
	elemento* ultimo;
	int elementos;
};

int main(){
	char* name = "ESCOM";
	printf("%i\n", sizeof(name) );
	/*elemento e = malloc(sizeof(elemento));
	if( e == NULL)
		printf("No se pudo reservar memoria\n");
	

	e->type = "ENTERO";
	e->valor.entero = 1;
	e->nombre = "myvar";
	e->id = 1;
	e->next = NULL;
	printf("ID: %i\n", e->id);*/
	return 0;
}

//void push(tabla){
//}