defus: defus.l defus.y
	bison -d defus.y
	mv defus.tab.h sintatico.h
	mv defus.tab.c sintatico.c
	flex defus.l
	mv lex.yy.c lexico.c
	gcc -o defus -lm sintatico.c lexico.c

clean:
	rm lexico.* sintatico.* defus
