%{
#include "global.h"
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
%}

%token END COLON COMA
%token IDENTIFIER
%token INTEGER
%token INT FLOAT CHAR DOUBLE
%token REAL
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
	;

Declaration:
	  INT IDENTIFIER   
	| FLOAT IDENTIFIER  
	| DOUBLE IDENTIFIER  
	| CHAR IDENTIFIER  
	| CHAR IDENTIFIER LEFT_BRACKET INTEGER RIGHT_BRACKET 

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

%%

int yyerror(char *s) {
	 printf("%s\n",s);
}


int main(void) {
   yyparse();
}


