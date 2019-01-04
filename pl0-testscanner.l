%{
#include <stdio.h>
%} 

IDENTIFIER [a-zA-Z][a-zA-Z0-9]*
DIGIT [0-9]
COMMENT [(][*]([^*]|[*]+[^*)])*[*]+[)] 

%% 
"CONST"	{printf("t_const\n");}
"VAR"	{printf("t_var\n");}
"PROCEDURE"	{printf("t_procedure\n");}
":="	{printf("t_assign\n");}
"CALL"	{printf("t_call\n");}
"?"	{printf("t_read\n");}
"!"		{printf("t_write\n");}
"BEGIN"	{printf("t_begin\n");}
"END"	{printf("t_end\n");}
"IF"	{printf("t_if\n");}
"THEN"	{printf("t_then\n");}
"WHILE"	{printf("t_while\n");}
"DO"	{printf("t_do\n");}
"ODD"	{printf("t_odd\n");}
";"	{printf("t_semicolon\n");}
","		{printf("t_comma\n");}
"+"	{printf("t_add\n");}
"-"	{printf("t_sub\n");}
"*"	{printf("t_mult\n");}
"/"	{printf("t_div\n");}
"="	{printf("t_equals\n");} 
"#"	{printf("t_unequal\n");}
"<"	{printf("t_smaller\n");}
"<="	{printf("t_smaller_equ\n");}
">"	{printf("t_bigger\n");}
">="	{printf("t_bigger_equ\n");}
"("	{printf("t_bracket_open\n");}
")"	{printf("t_bracket_close\n");}
{DIGIT}*	{printf("t_digit\n");}
{IDENTIFIER}*		{printf("t_identifier\n");}
{COMMENT}	{;}
[\t\f \r]	{;}
.	{;}
%%     

int yywrap(){} 
       
int main(int argc, char*argv[]) 
{ 
	yyin= fopen("fakultaet.pl0","r");
	yylex();  
  
	return 0; 
} 
