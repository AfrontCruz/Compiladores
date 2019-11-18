main: practica.l practica.y
	flex practica.l
	bison -d practica.y
	gcc -w lex.yy.c practica.tab.c -lm
	./a.out

clean:
	rm -rf *.c *.h *.out