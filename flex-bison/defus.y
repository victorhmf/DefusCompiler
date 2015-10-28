%{
#include "global.h"
#include "error_list.h"
#include "msg_error_list.h"
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>

extern FILE *yyin;
extern int line_number;
extern int num_comments;
extern node *list;
extern line *list_error;
extern line *list_msg_sucess;
extern char * yytext;

void beforexit(){
	check_initialized_var(list);
	generate_log(list_error);
	print_msg(list_error);
	
}

void check_lenght_variable(char * symbol){
	int lenght_variable = strlen(symbol);
	
	if(lenght_variable <= 3){
		char msg[100];
		snprintf(msg, 100, "A variável '%s' não possui um nome significativo" , symbol);
		insert_msg(list_error, msg, line_number);

	}
	else
	{

	}
}

void add_symbol_to_table (char * symbol){

    if(findSymbol(list,symbol)){
    	char msg [100];

    	snprintf(msg, 100, "Variável '%s' já declarada", symbol);
    	insert_msg(list_error, msg, line_number);
    	exit(1);
    }				
    else
    {
    	node *new_node = (node*) malloc(sizeof(node));
    	new_node->initialized = 0;
    	new_node->line_number = line_number;
    	insertSymbol(list,symbol,new_node);
    }    
 }


 void check_variable_declaration(char * symbol){

 		if(!findSymbol(list,symbol)){
    	char msg[100];

    	snprintf(msg, 100, "Variável '%s' não foi declarada", symbol);
    	insert_msg(list_error , msg, line_number);

    	exit(1);
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
%token QUIT


%start Input

%%

Input:
   /* Empty */
   | Input Line
   ;	
	
Line:
	END
	| Declaration COLON { char msg[100];
												snprintf (msg, 100, "Declaração de variável encontrada!"); 
												insert_msg(list_msg_sucess, msg, line_number);}

	| Atribution COLON {	char msg[100];
		 										snprintf (msg, 100, "Atribuição encontrada!") ;
		 										insert_msg(list_msg_sucess, msg, line_number);}
	;

Declaration:
	 INT IDENTIFIER { add_symbol_to_table(yytext);
	 									check_lenght_variable(yytext);}
	
	| FLOAT IDENTIFIER  { add_symbol_to_table(yytext);
											check_lenght_variable(yytext);}
	
	| DOUBLE IDENTIFIER  { add_symbol_to_table(yytext);
											check_lenght_variable(yytext);}
	
	| CHAR IDENTIFIER  { add_symbol_to_table(yytext);
										check_lenght_variable(yytext);}
	
	| Declaration COMA IDENTIFIER { add_symbol_to_table(yytext);
																check_lenght_variable(yytext);}

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
		IDENTIFIER EQUAL Expression {check_variable_declaration($1); set_initialized_1(list, $1);}
		|	Declaration EQUAL Expression 

		;


%%

int yyerror(char *message) {
	 char msg[100];
	 snprintf(msg, 100, "Message error: %s" , message);
	 insert_msg(list_error, msg, line_number);
}

void createOutput(FILE * in_file){
	FILE *output_file;
	FILE *source;
	char ch;

	mkdir("output/", 0700);
	output_file = fopen( "output/log.c" , "w");

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
	
	list = createList(list);
	list_error = create_list_msg(list_error);
	list_msg_sucess = create_list_msg(list_msg_sucess);
	atexit(beforexit);

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
	    while (!feof(yyin)){
	        yyparse();
	    }
	    if(num_comments == 0)
	    {
	    	char msg [100];
	    	snprintf(msg, 100 , "Nenhum comentario foi encontrado no código");

	    	insert_msg(list_error, msg, line_number);
	    }
	} else {
		
		yyparse();
	
	}

	return 0;
}
