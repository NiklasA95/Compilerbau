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
	  							{$$ = $3;}
		|	t_call t_ident				
								
		|	t_read t_ident
								{scanf("%i", $2);}
		|	t_write EXPRESSION
								{printf("%i", $2);}
		|	t_begin STATEMENT MULTSTATEMENTS t_end	
		|	t_if CONDITION t_then STATEMENT
								{if($2) printf("True");
									else printf("False");} 
		|	t_while CONDITION t_do STATEMENT	
								{/*while($2) {
									 
								}*/}
		|	EPSILON
		;
					
MULTSTATEMENTS	:	t_semicolon STATEMENT MULTSTATEMENTS
		|	EPSILON
		;

CONDITION	:	t_odd EXPRESSION 		{if ($2 % 2) != 0 {
								printf("Odd");
								$$ = 1;
							}
							else {
								printf("NotOdd");
								$$ = 0;
							}}

		|	EXPRESSION t_equal EXPRESSION
							{if ($1 == $3) {
								printf("Equal");
								$$ = 1;
							}
							else {
								printf("Unequal");
								$$ = 0;
							}}
		|	EXPRESSION t_unequal EXPRESSION
							{if ($1 != $3) {
								printf("Unequal");
								$$ = 1;
							}
							else {
								printf("NotUnequal");
								$$ = 0;
							}}

		|	EXPRESSION t_smaller Expression	
							{if ($1 < $3) {
								printf("IsSmaller");
								$$ = 1;
							}
							else {
								printf("IsNotSmaller");
								$$ = 0;
							}}

		|	EXPRESSION t_smaller_equ Expression	
							{if ($1 <= $3) {
								printf("IsSmallerEqu");
								$$ = 1;
							}
							else {
								printf("IsNotSmallerEqu");
								$$ = 0;
							}}

		|	EXPRESSION t_bigger Expression	
							{if ($1 > $3) {
								printf("IsBigger");
								$$ = 1;
							}
							else {
								printf("IsNotBigger");
								$$ = 0;
							}}

		|	EXPRESSION t_bigger_equ Expression	
							{if ($1 >= $3) {
								printf("IsBiggerEqu");
								$$ = 1;
							}
							else {
								printf("IsNotBiggerEqu");
								$$ = 0;
							}}
		;
						
EXPRESSION	:	SIGN TERM t_plus MULTTERM
	   					{if($1) {
							$$ = (-1 * $2) + $4;
							printf("%i + %i = %i", -1*$2, $4, $$);
						}
						else {
							$$ = $2 + $4;
							printf("%i + %i = %i", $2, $4, $$);
						}}

		|	SIGN TERM t_minus MULTTERM
						{if($1) {
							$$ = (-1 * $2) - $4;
							printf("%i - %i = %i", -1*$2, $4, $$);
						}
						else {
							$$ = $2 - $4;	
							printf("%i - %i = %i", $2, $4, $$);
						}}
		|	SIGN TERM
						{if($1) {
							$$ = -1 * $2;
							printf("%i", $$);
						}
						else {
							$$ = $2;	
							printf("%i", $$);
						}}
		;

SIGN		:	t_plus
      				{$$ = 0;
				printf("+SIGN");}
		|	t_minus
				{$$ = 1;
				printf("-SIGN");}
		|	EPSILON
				{$$ = 0;
				printf("NOSIGN");}
		;
		
MULTTERM	:
		|	TERM t_plus MULTTERM
						{$$ = $1 + $3;
						printf("%i + %i = %i", $1, $3, $$);}
	 
	 	|	TERM t_minus MULTTERM
						{$$ = $1 - $3;
						printf("%i - %i = %i", $1, $3, $$);}
		|	TERM
		;

TERM		:	FACTOR t_mult TERM
      						{$$ = $1 * $3;
						printf("%i * %i = %i", $1, $3, $$);}
	
      		|	FACTOR t_div TERM
						{$$ = $1 / $3;
						printf("%i / %i = %i", $1, $3, $$);}

		|	FACTOR
		;
						
FACTOR		:	t_ident
		|	t_digit
		|	t_bracket_open EXPRESSION t_bracket_close
									{$$ = $1;}
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
