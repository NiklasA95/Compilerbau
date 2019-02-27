%{
#include <stdio.h>
#include <string.h>
#include "y.tab.h"
void yyerror(char *);
FILE * pIF;
%} 

IDENTIFIER [a-zA-Z][a-zA-Z0-9]*
DIGIT [0-9]
COMMENT [(][*]([^*]|[*]+[^*)])*[*]+[)] 

%%
 
{COMMENT}	{;}
"CONST"		{printf("t_const\n");}
"VAR"		{printf("t_var\n");}
"PROCEDURE"	{printf("t_procedure\n");}
":="		{printf("t_assign\n");}
"CALL"		{printf("t_call\n");}
"?"		{printf("t_read\n");}
"!"		{printf("t_write\n");}
"BEGIN"		{printf("t_begin\n");}
"END"		{printf("t_end\n");}
"IF"		{printf("t_if\n");}
"THEN"		{printf("t_then\n");}
"WHILE"		{printf("t_while\n");}
"DO"		{printf("t_do\n");}
"ODD"		{printf("t_odd\n");}
";"		{printf("t_semicolon\n");}
","		{printf("t_comma\n");}
"+"		{printf("t_add\n");}
"-"		{printf("t_sub\n");}
"*"		{printf("t_mult\n");}
"/"		{printf("t_div\n");}
"="		{printf("t_equals\n");} 
"#"		{printf("t_unequal\n");}
"<"		{printf("t_smaller\n");}
"<="		{printf("t_smaller_equ\n");}
">"		{printf("t_bigger\n");}
">="		{printf("t_bigger_equ\n");}
"("		{printf("t_bracket_open\n");}
")"		{printf("t_bracket_close\n");}
{DIGIT}*	{yylval.number=atoi(yytext);
		printf("t_digit = %i\n", yylval);}
{IDENTIFIER}*	{yylval.string=strdup(yytext);
		printf("t_identifier = %s\n", yylval);}
[ \t\f\r]	{;}
.		{yyerror("Nicht zulaessiger Token");}
%%     

int Lex() {
	return yylex();
}

int yywrap( ) { 
	return 1;
}

int initLex(char* fname) {
	char vName[128+1];
	strcpy(vName,fname);
	if (!strstr(vName,".pl0")) strcat(vName,".pl0");
	pIF=fopen(vName,"rt");
	if (pIF) {
		yyin=pIF; 
		return 1;
	}

	return 0;
}

