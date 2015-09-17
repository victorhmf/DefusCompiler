%{
#include "global.h"
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
%}

%token END COLON
%token IDENTIFIER
%token INTEGER
%token INT FLOAT CHAR DOUBLE
%token REAL
%token PLUS MINUS TIMES DIVIDE POWER SQRT
%token LEFT_PARENTHESIS RIGHT_PARENTHESIS LEFT_BRACKET RIGHT_BRACKET

%left PLUS MINUS
%left TIMES DIVIDE
%right POWER

%start Input

%%

Input:
   /* Empty */
   | Input Line
   ;	
	
Line:
	END
	| Declaration COLON { printf ("Declaração de variável encontrada!\n"); }
	| Expression
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
	|	Expression POWER Expression
	|	LEFT_PARENTHESIS Expression RIGHT_PARENTHESIS
	;

%%

int yyerror(char *s) {
	 printf("%s\n",s);
}


int main(void) {
   yyparse();
}


