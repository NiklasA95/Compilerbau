%{
#include <stdio.h>
int yylex(void);
void yyerror(char *);
%}

%token T_CONST
%token T_VAR
%token T_PROCEDURE
%token T_ASSIGN
%token T_CALL
%token T_READ
%token T_WRITE
%token T_BEGIN
%token T_END
%token T_IF
%token T_THEN
%token T_WHILE
%token T_DO
%token T_ODD
%token T_SEMICOLON
%token T_COMMA
%token T_ADD
%token T_SUB
%token T_MULT
%token T_DIV
%token T_EQUAL
%token T_UNEQUAL
%token T_SMALLER
%token T_SMALLER_EQU
%token T_BIGGER
%token T_BIGGER_EQU
%token T_BRACKET_OPEN
%token T_BRACKET_CLOSE
%token T_DIGIT
%token T_IDENTIFIER

%%
%%

void yyerror(char *s) {
	fprintf(stderr, "%s\n", s);
}

int main(void) {
	yyparse();
	return 0;
}