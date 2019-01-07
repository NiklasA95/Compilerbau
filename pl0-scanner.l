%{
#include <stdio.h>
#inlcude "y.tab.h"
void yyerror(char *);
%} 

IDENTIFIER [a-zA-Z][a-zA-Z0-9]*
DIGIT [0-9]+
COMMENT [(][*]([^*]|[*]+[^*)])*[*]+[)] 

%%
{COMMENT}	{;}
"CONST"	{return T_CONST;}
"VAR"	{return T_VAR;}
"PROCEDURE"	{return T_PROCEDURE;}
":="	{return T_ASSIGN;}
"CALL"	{return T_CALL;}
"?"	{return T_READ;}
"!"		{return T_WRITE;}
"BEGIN"	{return T_BEGIN;}
"END"	{return T_END;}
"IF"	{return T_IF;}
"THEN"	{return T_THEN;}
"WHILE"	{return T_WHILE;}
"DO"	{return T_DO;}
"ODD"	{return T_ODD;}
";"	{return T_SEMICOLON;}
","		{return T_COMMA;}
"."	{return T_DOT;}
"+"	{return T_ADD;}
"-"	{return T_SUB;}
"*"	{return T_MULT;}
"/"	{return T_DIV;}
"="	{return T_EQUAL;} 
"#"	{return T_UNEQUAL;}
"<"	{return T_SMALLER;}
"<="	{return T_SMALLER_EQU;}
">"	{return T_BIGGER;}
">="	{return T_BIGGER_EQU;}
"("	{return T_BRACKET_OPEN;}
")"	{return T_BRACKET_CLOSE;}
{DIGIT}*	{yylval = atoi(yytext); return T_DIGIT;}
{IDENTIFIER}*		{ yylval = yytext[0] - 'a'; return T_IDENTIFIER;}
[\t\f \r]	{;}
.	{ yyerror("Nicht zulässiger Token"); }
%%     

int yywrap(){} 
       
int main(int argc, char*argv[]) 
{ 
	yyin= fopen("fakultaet.pl0","r");
	yylex();  
  
	return 0; 
} 
