%{
#include "global.h"
#include "sintatico.h"
#include <stdlib.h>
#include <stdio.h>
%}

white [ \t\r]+
digit [0-9]
integer {digit}+
string  [a-z][a-z0-9]*
real {integer}("."{integer})?

%%

"int" {return (INT) ;}
"float" {return (FLOAT) ;} 
"char" {return (CHAR) ; }
"double" {return (DOUBLE);}

";" {return (COLON) ; }
"," {return (COMA) ;}
"\n" {return (END) ;}
"[" {return (LEFT_BRACKET) ;}
"]" {return (RIGHT_BRACKET) ;}
"(" return(LEFT_PARENTHESIS);
")" return(RIGHT_PARENTHESIS);

"+" return(PLUS);
"-" return(MINUS);
"*" return(TIMES);
"/" return(DIVIDE);
"pow" return(POW);
"sqrt" return(SQRT);


{white} { /* We ignore white characters */ }
{string} {return IDENTIFIER ;}
{integer} {return INTEGER ;}
{real} {yylval = atof(yytext); return(REAL); }

%%

yywrap(){
  return 1;
}
