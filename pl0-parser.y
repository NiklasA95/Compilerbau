%{
#include <stdio.h>
int yylex(void);
void yyerror(char *);
%}

%token t_const
%token t_var
%token t_procedure
%token t_assign
%token t_call
%token t_read
%token t_write
%token t_begin
%token t_end
%token t_if
%token t_then
%token t_while
%token t_do
%token t_odd
%token t_semicolon
%token t_comma
%token t_dot
%token t_plus
%token t_minus
%token t_mult
%token t_div
%token t_equal
%token t_unequal
%token t_smaller
%token t_smaller_equ
%token t_bigger
%token t_bigger_equ
%token t_bracket_open
%token t_bracket_close
%token t_digit
%token t_ident
%%

PROGRAMM	:	BLOCK
		|	t_dot
				{printf("Parsen beendet!\n")}
		;
			
BLOCK		:	t_const t_ident t_equal t_digit CONSTINIT t_semicolon t_var t_ident VARDECL t_semicolon PROCDECL STATEMENT
		|	t_const t_ident t_equal t_digit CONSTINIT t_semicolon t_var t_ident VARDECL t_semicolon STATEMENT
		|	t_const t_ident t_equal t_digit CONSTINIT t_semicolon PROCDECL STATEMENT
		|	t_var t_ident VARDECL t_semicolon PROCDECL STATEMENT
		|	t_var t_ident VARDECL t_semicolon STATEMENT
		|	t_const t_ident t_equal t_digit CONSTINIT t_semicolon STATEMENT
		|	PROCDECL STATEMENT
		|	STATEMENT
		;

CONSTINIT	:	t_comma t_ident t_equal t_digit CONSTINIT
		|	EPSILON
		;
				
VARDECL		:	t_comma t_ident VARDECL
		|	EPSILON
		;
				
PROCDECL	:	t_procedure t_ident t_semicolon BLOCK t_semicolon PROCDECL
		|	EPSILON
		;
					
STATEMENT	:	t_ident t_assign EXPRESSION 
		|	t_call t_ident
		|	t_read t_ident
		|	t_write EXPRESSION
		|	t_begin STATEMENT MULTSTATEMENTS t_end
		|	t_if CONDITION t_then STATEMENT
								{if($2) printf("True");
									else printf("False");} 
		|	t_while CONDITION t_do STATEMENT
		|	EPSILON
		;
					
MULTSTATEMENTS	:	t_semicolon STATEMENT MULTSTATEMENTS
		|	EPSILON
		;

CONDITION	:	t_odd EXPRESSION 
		|	EXPRESSION t_equal EXPRESSION
							{if($1 == $3) printf("Equal");
								else printf("Unequal");}
		|	EXPRESSION t_smaller Expression	
							{if($1 < $3) printf("IsSmaller");
								else printf("IsNotSmaller");}
		|	EXPRESSION t_smaller_equ Expression	
							{if($1 <= $3) printf("IsSmallerEqu");
								else printf("IsNotSmallerEqu");}
		|	EXPRESSION t_bigger Expression	
							{if($1 > $3) printf("IsBigger");
								else printf("IsNotBigger");}
		|	EXPRESSION t_bigger_equ Expression	
							{if($1 >= $3) printf("IsBiggerEqu");
								else printf("IsNotBiggerEqu");}
		;
						
EXPRESSION	:	SIGN TERM t_plus TERM
		|	SIGN TERM t_plus TERM
		|	SIGN TERM t_minus TERM

		;

SIGN		:	t_plus
		|	t_minus
		|	EPSILON
		;
		
MULTTERM	:			|	t_minus TERM
		|	t_plus TERM MULTTERM
		|	t_minus TERM MULTTERM
		|	EPSILON
		;

TERM		:	FACTOR MULTFACTOR
		;
			
MULTFACTOR	:	t_mult FACTOR MULTFACTOR
		|	t_div FACTOR MULTFACTOR
		|	EPSILON
		;
						
FACTOR		:	t_ident
		|	t_digit
		|	t_bracket_open EXPRESSION t_bracket_close
		;
				
EPSILON	:	;			

%%

void yyerror(char *s) {
	fprintf(stderr, "%s\n", s);
}

int main(void) {
	yyparse();
	return 0;
}
