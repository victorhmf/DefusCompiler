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

%%

{white} { /* We ignore white characters */ }

"int" {return INT ;}
"float" {return FLOAT ;} 
"char" {return CHAR ; }
"double" {return DOUBLE;}
";" {return COLON ; }
"\n" {return END ;}
"[" {return LEFT_BRACKET ;}
"]" {return RIGHT_BRACKET ;}

{string} {return STRING ;}
{integer} {return INTEGER ;}

%%

yywrap(){
  return 1;
}
