%{
#include "global.h"
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

extern FILE *yyin;
extern int line_number;
extern node *list;


%}


%union {
  double val;
  char * symbol;
}

%token END COLON COMA EQUAL
%token <symbol> IDENTIFIER
%token INTEGER
%token INT FLOAT CHAR DOUBLE
%token <val> REAL
%token PLUS MINUS TIMES DIVIDE POW SQRT NEG
%token LEFT_PARENTHESIS RIGHT_PARENTHESIS LEFT_BRACKET RIGHT_BRACKET


%start Input

%%

Input:
   /* Empty */
   | Input Line
   ;	
	
Line:
	END
	| Declaration COLON { printf ("Declaração de variável encontrada!\n"); }
	| Expression COLON { printf ("Expressão encontrada!\n"); }
	| Atribution COLON { printf ("Atribuição encontrada! \n") ;}
	;

Declaration:
	IDENTIFIER {puts ("SYMBOL"); puts($1);}
	| INT IDENTIFIER  
	| FLOAT IDENTIFIER  
	| DOUBLE IDENTIFIER  
	| CHAR IDENTIFIER  
	| CHAR IDENTIFIER LEFT_BRACKET INTEGER RIGHT_BRACKET
	| Declaration COMA IDENTIFIER 

	;	

	Expression:
		REAL
		| INTEGER
		|	IDENTIFIER
		|	Expression PLUS Expression
		|	Expression MINUS Expression
		|	Expression DIVIDE Expression
		|	Expression TIMES Expression
		| POW LEFT_PARENTHESIS Expression COMA Expression RIGHT_PARENTHESIS
		| SQRT LEFT_PARENTHESIS Expression RIGHT_PARENTHESIS
		|	LEFT_PARENTHESIS Expression RIGHT_PARENTHESIS
		| MINUS Expression %prec NEG
		;

	Atribution:
		IDENTIFIER EQUAL Expression
		|	Declaration EQUAL Expression

		;


%%

int yyerror(char *message) {
	 printf("Message error: %s (line: %d)\n" , message , line_number);
}

void createOutput(FILE * in_file){
	FILE *output_file;
	FILE *source;
	char ch;

	mkdir("output/", 0700);
	output_file = fopen( "output/defus.c" , "w");

	while(1){
		ch = fgetc(in_file);
		if(ch == EOF){
			fclose(in_file);
			break;
		} else
		fputc(ch, output_file);
	}

	fclose(output_file);
}

int main(int argc, char *argv[]){
	if(argc == 2){
		FILE *input = fopen(argv[1],"r");
		FILE * copy_input = fopen(argv[1],"r");
		createOutput(copy_input);
		yyin = input;
		if(input == 0)
		{
			printf( "Could not open file\n" );
			exit -1;
		}
	} else {
		yyparse();
	}

}
