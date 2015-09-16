%{
#include "global.h"
#include "sintatico.h"
#include <stdlib.h>
#include <stdio.h>
%}

white [ \t\r\n]+
digit [0-9]
integer {digit}+
string  [a-z][a-z0-9]*

%%

{white} { /* We ignore white characters */ }

"int" {return INT ;}
"float" {return FLOAT ;} 

{string} {return STRING ;}
{digit} {return DIGIT ;}

";" {return COLON ; }
"\n" {return END ;}

%%

yywrap(){
  return 1;
}
