%{
#define YYSTYPE int 
#include <stdio.h>
#include "pl0-parser.tab.h"
void yyerror(char *);
%} 

IDENTIFIER [A-Za-z][0-9A-Za-z]*
DIGIT [0-9]
COMMENT [(][*]([^*]|[*]+[^*)])*[*]+[)] 

%%
"."		    {return t_dot;}
"="		    {return t_equal;}
","		    {return t_comma;}
";"		    {return t_semicolon;}
":="		{return t_assign;}
"?"		    {return t_read;}
"!"		    {return t_write;}
"#"		    {return t_unequal;}
"<"		    {return t_smaller;}
"<="		{return t_smaller_equ;}
">"		    {return t_bigger;}
">="		{return t_bigger_equ;}
"+"		    {return t_plus;}
"-"		    {return t_minus;}
"*"		    {return t_mult;}
"/"		    {return t_div;}
"("		    {return t_bracket_open;}
")"		    {return t_bracket_close;}
"CONST"		{return t_const;}
"VAR"		{return t_var;}
"PROCEDURE" {return t_procedure;}
"CALL"		{return t_call;}
"BEGIN"		{return t_begin;}
"END"		{return t_end;}
"IF"		{return t_if;}
"THEN"		{return t_then;}
"WHILE"		{return t_while;}
"DO"		{return t_do;}
"ODD"		{return t_odd;}
{IDENTIFIER}*	{/*yylval.string=strdup(yytext);*/ return t_ident;}
{DIGIT}*	{yylval = atoi(yytext); return t_digit;}
{COMMENT}	;

[ \t\f\r]	{;}
.		    {yyerror("Ungueltiges Zeichen!");}
%%     


       



