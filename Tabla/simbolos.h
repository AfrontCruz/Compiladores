typedef struct elemento *elemento;
typedef struct tabla *tabla;
typedef union tipo tipo;

union tipo{
	int entero;
	char caracter;
	double real;
	float flotante;
	char* cadena;
};

struct elemento
{
	char* type;
	char* nombre;
	int id;
	tipo valor;
	elemento next;
};

struct tabla{
	elemento inicio;
	int elementos;
};

tabla tSim;
char* invert(char* s1);
char* concat(char *a1, char *a2);
int add(tabla, elemento);
void print(tabla);
elemento search(tabla, char*);