defus: flex-bison/defus.l flex-bison/defus.y
	bison -d flex-bison/defus.y
	mv defus.tab.h output/sintatico.h
	mv defus.tab.c output/sintatico.c
	flex flex-bison/defus.l
	mv lex.yy.c output/lexico.c
	gcc -o defus output/sintatico.c output/lexico.c source/symbol_table.c source/msg_error_list.c -lm -I headers

clean:
	rm output/lexico.* output/sintatico.* defus output/defus.c output/log.*

test:
	./defus < tests/declaration/testeDeclaration01.c
	./defus < tests/declaration/testeDeclaration02.c
	./defus < tests/atribution/exemplo01.c
	./defus < tests/atribution/exemplo02.c
	./defus < tests/expression/Teste01.c
	./defus < tests/expression/Teste02.c
