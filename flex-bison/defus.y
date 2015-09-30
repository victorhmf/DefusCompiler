%{
#include "global.h"
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

extern FILE *yyin;
extern int line_number;
extern node *list;
extern char * yytext;
int id_error = 0;

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
%token SPACE TAB
%token RIGHT_BRACE LEFT_BRACE

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


Space:
	{id_error = 1 ;} SPACE 
	
	;


Declaration:
	 INT Space IDENTIFIER { add_symbol_to_table(yytext);
	 												id_error = 0;
	 											}
	| FLOAT Space IDENTIFIER  { add_symbol_to_table(yytext);
															id_error = 0;
														}
	| DOUBLE Space IDENTIFIER  { add_symbol_to_table(yytext);
																id_error = 0;
															}
	| CHAR Space IDENTIFIER  { add_symbol_to_table(yytext);
																id_error = 0;
														}	
	| Declaration COMA Space IDENTIFIER { add_symbol_to_table(yytext);
																				id_error = 0;
																			}

	;	

	Expression:
		REAL
		|	IDENTIFIER {check_variable_declaration(yytext);}
		|	Expression Space PLUS Space Expression { id_error = 0;}
		|	Expression Space MINUS Space Expression { id_error = 0;}
		|	Expression Space DIVIDE Space Expression { id_error = 0;}
		|	Expression Space TIMES Space Expression { id_error = 0;}
		| POW LEFT_PARENTHESIS Expression Space COMA Space Expression RIGHT_PARENTHESIS { id_error = 0;}
		| SQRT LEFT_PARENTHESIS Expression RIGHT_PARENTHESIS { id_error = 0;}
		|	LEFT_PARENTHESIS Expression RIGHT_PARENTHESIS { id_error = 0;}
		| MINUS Expression %prec NEG { id_error = 0;}
		;

	Atribution:
		IDENTIFIER Space EQUAL Space Expression {check_variable_declaration($1);
																							id_error = 0;
																						}
		|	Declaration Space EQUAL Space Expression { id_error = 0;}
		;


%%

int yyerror(char *message) {

	switch (id_error){
	 
	 	case 1:
	 		printf("Erro de indentação! (line: %d) \n", line_number);
	 	break;

	 	default:
			printf("Message error: %s (line: %d)\n" , message , line_number);
		break ;
	}
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
	} 
	else 
	{
		yyparse();
	}

  while (!feof(yyin)){
    yyparse();
  }


}
	