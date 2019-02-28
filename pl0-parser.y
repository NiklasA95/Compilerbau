%{
#include <stdio.h>
#include "lex.yy.c"
int yylex(void);
void yyerror(char *);
%}
%token t_dot
%token t_equal
%token t_comma
%token t_semicolon
%token t_assign
%token t_read
%token t_write
%token t_unequal
%token t_smaller
%token t_smaller_equ
%token t_bigger
%token t_bigger_equ
%token t_plus
%token t_minus
%token t_mult
%token t_div
%token t_bracket_open
%token t_bracket_close
%token t_const
%token t_var
%token t_procedure
%token t_call
%token t_begin
%token t_end
%token t_if
%token t_then
%token t_while
%token t_do
%token t_odd
%token t_ident
%token t_digit
%%
PROGRAMM        :   BLOCK t_dot
                    {printf("Grammatik akzeptiert. Parsen beendet!\n");}
                ;

BLOCK           :   t_const t_ident t_equal t_digit CONSTINIT t_semicolon t_var t_ident VARDECL t_semicolon PROCDECL STATEMENT
                    {printf("Const Initialisierung, Var Deklaration\n");}
                |   t_const t_ident t_equal t_digit CONSTINIT t_semicolon PROCDECL STATEMENT
                    {printf("Const Initialisierung\n");}
                |   t_var t_ident VARDECL t_semicolon PROCDECL STATEMENT
                    {printf("Var Deklaration\n");}
                |   PROCDECL STATEMENT
                    {printf("Statement\n");}
                ;

CONSTINIT       :   t_comma t_ident t_equal t_digit CONSTINIT
                    {printf("Const Initialisierung\n");}
                |   EPSILON
                ;

VARDECL         :   t_comma t_ident VARDECL
                    {printf("Var Deklaration\n");}
                |   EPSILON
                ;

PROCDECL        :   t_procedure t_ident t_semicolon BLOCK t_semicolon PROCDECL
                    {printf("Prozess Deklaration\n");}
                |   EPSILON
                ;

STATEMENT           :   t_ident t_assign EXPRESSION
                    {$$ = $3;}
                |   t_call t_ident
                |   t_read t_ident
                    {scanf("%i", &$2);}
                |   t_write EXPRESSION
                    {printf("%i\n", $2);}
                |   t_begin STATEMENT MULTSTATEMENTS t_end
                |   t_if CONDITION t_then STATEMENT
                    {if ($2) printf("True\n"); else printf("False\n");}
                |   t_while CONDITION t_do STATEMENT
                    {/*while ($2) {}*/}
                |   EPSILON
                ;

MULTSTATEMENTS  :   t_semicolon STATEMENT MULTSTATEMENTS
                    {printf("Mehrere Beginn End Statements\n");}
                |   EPSILON
                    {printf("Einzelnes Begin End Statement\n");}
                ;

CONDITION       :   t_odd EXPRESSION
                    {if (($2 % 2) != 0) {
                        printf("Odd\n");
                        $$ = 1;
                    }
                    else {
                        printf("NotOdd\n");
                        $$ = 0;
                    }}
                |   EXPRESSION t_equal EXPRESSION
                    {if ($1 == $3) {
                        printf("Equal\n");
                        $$ = 1;
                    }
                    else {
                        printf("Unequal\n");
                        $$ = 0;
                    }}
                |   EXPRESSION t_unequal EXPRESSION
                    {if ($1 != $3) {
                        printf("Unequal\n");
                        $$ = 1;
                    }
                    else {
                        printf("NotUnequal\n");
                        $$ = 0;
                    }}
                |   EXPRESSION t_smaller EXPRESSION
                    {if ($1 < $3) {
                        printf("IsSmaller\n");
                        $$ = 1;
                    }
                    else {
                        printf("IsNotSmaller\n");
                        $$ = 0;
                    }}
                |   EXPRESSION t_smaller_equ EXPRESSION
                        {if ($1 <= $3) {
                            printf("IsSmallerEqu\n");
                            $$ = 1;
                        }
                        else {
                            printf("IsNotSmallerEqu\n");
                            $$ = 0;
                        }}
                |   EXPRESSION t_bigger EXPRESSION
                    {if ($1 > $3) {
                        printf("IsBigger\n");
                        $$ = 1;
                    }
                    else {
                        printf("IsNotBigger\n");
                        $$ = 0;
                    }}
                |   EXPRESSION t_bigger_equ EXPRESSION
                    {if ($1 >= $3) {
                        printf("IsBiggerEqu\n");
                        $$ = 1;
                    }
                    else {
                        printf("IsNotBiggerEqu\n");
                        $$ = 0;
                    }}
                ;

EXPRESSION      :   SIGN TERM t_plus MULTTERM
                    {if ($1) {
                        $$ = (-1 * $2) + $4;
                        printf("%i + %i = %i\n", -1*$2, $4, $$);
                    }
                    else {
                        $$ = $2 + $4;
                        printf("%i + %i = %i\n", $2, $4, $$);
                    }}

                |   SIGN TERM t_minus MULTTERM
                    {if ($1) {
                        $$ = (-1 * $2) - $4;
                        printf("%i - %i = %i\n", -1*$2, $4, $$);
                    }
                    else {
                        $$ = $2 - $4;
                        printf("%i - %i = %i\n", $2, $4, $$);
                    }}
                |   SIGN TERM
                    {if ($1) {
                        $$ = -1 * $2;
                        printf("%i\n", $$);
                    }
                    else {
                        $$ = $2;
                        printf("%i\n", $$);
                    }}
                ;

SIGN            :   t_plus
                    {$$ = 0; printf("+SIGN\n");}
                |   t_minus
                    {$$ = 1; printf("-SIGN\n");}
                |   EPSILON
                    {$$ = 0; printf("NOSIGN\n");}
                ;

MULTTERM        :
                |   TERM t_plus MULTTERM
                    {$$ = $1 + $3; printf("%i + %i = %i\n", $1, $3, $$);}
                |   TERM t_minus MULTTERM
                    {$$ = $1 - $3; printf("%i - %i = %i\n", $1, $3, $$);}
                |   TERM
                ;

TERM            :   FACTOR t_mult TERM
                    {$$ = $1 * $3; printf("%i * %i = %i\n", $1, $3, $$);}
                |   FACTOR t_div TERM
                    {$$ = $1 / $3; printf("%i / %i = %i\n", $1, $3, $$);}
                |   FACTOR
                ;

FACTOR          :   t_ident
                    {printf("Identifikator\n");}
                |   t_digit
                    {printf("Digit\n");}
                |   t_bracket_open EXPRESSION t_bracket_close
                    {printf("Expression\n"); $$ = $2;}
                ;

EPSILON         :
                ;
%%
int main() {
    yyparse();
    return yylex();
}

void yyerror(char *s) {
    fprintf(stderr, "%s\n", s);
}

int yywrap() {
    printf("Scannen beendet");
    return 1;
}


