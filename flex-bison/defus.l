%{
#include "global.h"
#include "sintatico.h"
#include <stdlib.h>
#include <stdio.h>
#include "msg_error_list.h"


int num_comments = 0;
int line_number = 1;

%}

white [ \t\r]+
digit [0-9]
integer {digit}+
string  [a-z][a-z0-9]*
real {integer}("."{integer})?
%%

"//"	{ SingleLineComment(); }
"/*"	{ MultiLineComment(); }

"int" {return (INT) ;}
"float" {return (FLOAT) ;} 
"char" {return (CHAR) ; }
"double" {return (DOUBLE);}

";" {return (COLON) ; }
"," {return (COMA) ;}
"\n" { ++line_number ; return (END) ;}
"[" {return (LEFT_BRACKET) ;}
"]" {return (RIGHT_BRACKET) ;}
"(" return (LEFT_PARENTHESIS);
")" return (RIGHT_PARENTHESIS);

"+" return (PLUS);
"=" return (EQUAL);
"-" return (MINUS);
"*" return (TIMES);
"/" return (DIVIDE);
"pow" return (POW);
"sqrt" return (SQRT);


{white} { /* We ignore white characters */ }
{string} {yylval.symbol = strdup(yytext);return IDENTIFIER ;}
{real} {yylval.val = atof(yytext); return(REAL); }

%%

yywrap(){
  return 1;
}

MultiLineComment(){
	char c, c1;
	loop:
		while ((c = input()) != '*' && c != 0){	}
		if ((c1 = input()) != '/' && c != 0){
			unput(c1);
			goto loop;
		}
		if (c != 0){
			num_comments++;
			char msg[100];
			snprintf (msg, 100, "ml comment") ;
			insert_msg(list_msg_sucess, msg, line_number);
	}		
}

SingleLineComment(){
	char c;

		while ((c = input()) != '\n' && c != 0){}
		num_comments++;
		
		char msg[100];
		snprintf (msg, 100, "sl comment") ;

		insert_msg(list_msg_sucess, msg, line_number);

	
}
