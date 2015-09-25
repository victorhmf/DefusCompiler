defus: Flex-Bison/defus.l Flex-Bison/defus.y
	bison -d Flex-Bison/defus.y
	mv defus.tab.h sintatico.h
	mv defus.tab.c sintatico.c
	flex Flex-Bison/defus.l
	mv lex.yy.c lexico.c
	gcc -o defus sintatico.c lexico.c -lm

clean:
	rm lexico.* sintatico.* defus output/defus.c
