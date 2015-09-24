defus: flex-bison/defus.l flex-bison/defus.y
	bison -d flex-bison/defus.y
	mv defus.tab.h output/sintatico.h
	mv defus.tab.c output/sintatico.c
	flex flex-bison/defus.l
	mv lex.yy.c output/lexico.c
	gcc -o defus output/sintatico.c output/lexico.c symbol_table.c -lm -I headers

clean:
	rm output/lexico.* output/sintatico.* defus output/defus.c defus.output
