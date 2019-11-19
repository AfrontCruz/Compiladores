main: practica.l practica.y
	flex practica.l
	bison -d practica.y
	gcc -w lex.yy.c practica.tab.c main.c -lm
	./a.out

clean:
	rm -rf lex.yy.c practica.tab.h practica.tab.c *.out 