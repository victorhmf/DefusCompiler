%{
#include "global.h"
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

extern FILE *yyin;
extern int line_number;
extern node *list;
extern char * yytext;

void newList(){
	list = createList(list);
}

void add_symbol_to_table (char * symbol){

    if(findSymbol(list,symbol)){
    	printf("Variável %s já declarada\n", symbol);
    }				
    else
    {
    	insertSymbol(list,symbol);
    }    
 }

 void check_variable_declaration(char * symbol){

 		if(!findSymbol(list,symbol)){
    	printf("Variável %s não foi declarada\n", symbol);
    }
    else 
    {

    }				
 }

%}

%union {
  double val;
  char * symbol;
}

%token END COLON COMA EQUAL
%token <symbol> IDENTIFIER
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
	| Atribution COLON { printf ("Atribuição encontrada! \n") ;}
	;


Declaration:
	 INT IDENTIFIER { add_symbol_to_table(yytext);}
	| FLOAT IDENTIFIER  { add_symbol_to_table(yytext);}
	| DOUBLE IDENTIFIER  { add_symbol_to_table(yytext);}
	| CHAR IDENTIFIER  { add_symbol_to_table(yytext);}
	| Declaration COMA IDENTIFIER { add_symbol_to_table(yytext);}

	;	

	Expression:
		REAL
		|	IDENTIFIER {check_variable_declaration(yytext);}
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
		IDENTIFIER EQUAL Expression {check_variable_declaration($1);}
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

int main(int argc, char *argv[]){
	newList();
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
		newList();
		yyparse();
	}

}
