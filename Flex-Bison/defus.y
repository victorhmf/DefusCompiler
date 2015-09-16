%{
#include "global.h"
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
%}

%token END
%token STRING
%token VARIABLE
%token DIGIT
%token INT FLOAT
%token COLON
%start Input

%%

Input:
   /* Empty */
   | Input Line
   ;	
	
Line:
	END
	| Declaration COLON
	;

Declaration:
	INT STRING {printf ("Declaração de variável encontrada!\n"); }
	| FLOAT STRING {printf ("Declaração de variável encontrada!\n"); }	
;	

%%

int yyerror(char *s) {
   printf("%s\n",s);
}

int main(void) {
   yyparse();
}


