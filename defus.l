%{
#include "global.h"
#include "sintatico.h"
#include <stdlib.h>
%}
white [ \t]+
digit [0-9]
integer {digit}+
exponant [eE][+-]?{integer}
real {integer}("."{integer})?{exponant}?

%%

{white} { /* We ignore white characters */ }
{real} {
  yylval = atof(yytext);
  return(NUMBER);
}

"/" return(DIVIDE);
"-" return(MINUS);
"\n" return(END);

%%

yywrap () {
return 0;
}
