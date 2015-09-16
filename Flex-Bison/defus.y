%{
#include "global.h"
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
%}

%token END
%token STRING
%token VARIABLE
%token INTEGER
%token INT FLOAT CHAR DOUBLE
%token COLON LEFT_BRACKET RIGHT_BRACKET
%start Input

%%

Input:
   /* Empty */
   | Input Line
   ;	
	
Line:
	END
	| Declaration
	;

Declaration:
	  INT STRING COLON {printf ("Declaração de variável encontrada!\n"); } 
	| FLOAT STRING COLON {printf ("Declaração de variável encontrada!\n"); }
	| DOUBLE STRING COLON {printf ("Declaração de variável encontrada!\n"); }
	| CHAR STRING COLON {printf ("Declaração de variável encontrada!\n"); }
	| CHAR STRING LEFT_BRACKET INTEGER RIGHT_BRACKET COLON {printf ("Declaração de variável encontrada!\n"); }

	;	

%%

int yyerror(char *s) {
   printf("%s\n",s);
}

int main(void) {
   yyparse();
}


