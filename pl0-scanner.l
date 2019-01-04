%{
#include <stdio.h>
#inlcude "y.tab.h"
%} 

IDENTIFIER [a-zA-Z][a-zA-Z0-9]*
DIGIT [0-9]
COMMENT [(][*]([^*]|[*]+[^*)])*[*]+[)] 

%%
{COMMENT}	{;}
"CONST"	{return t_const;}
"VAR"	{return t_var;}
"PROCEDURE"	{return t_procedure;}
":="	{return t_assign;}
"CALL"	{return t_call;}
"?"	{return t_read;}
"!"		{return t_write;}
"BEGIN"	{return t_begin;}
"END"	{return t_end;}
"IF"	{return t_if;}
"THEN"	{return t_then;}
"WHILE"	{return t_while;}
"DO"	{return t_do;}
"ODD"	{return t_odd;}
";"	{return t_semicolon;}
","		{return t_comma;}
"+"	{return t_add;}
"-"	{return t_sub;}
"*"	{return t_mult;}
"/"	{return t_div;}
"="	{return t_equals;} 
"#"	{return t_unequal;}
"<"	{return t_smaller;}
"<="	{return t_smaller_equ;}
">"	{return t_bigger;}
">="	{return t_bigger_equ;}
"("	{return t_bracket_open;}
")"	{return t_bracket_close;}
{DIGIT}*	{yylval = atoi(yytext); return t_digit;}
{IDENTIFIER}*		{ yylval = yytext[0] - 'a'; return t_identifier;}
\t	{;}
.	{ yyerror("Nicht zulässiger Token"); }
%%     

int yywrap(){} 
       
int main(int argc, char*argv[]) 
{ 
	yyin= fopen("fakultaet.pl0","r");
	yylex();  
  
	return 0; 
} 
