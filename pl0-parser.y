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
%token t_number

%%
PROGRAMM        :   BLOCK t_dot
                    {printf("Parser terminated successfully.\n");}
                ;

BLOCK           :   {printf("level_up()\n");}
                    CONSTDECL VARDECL PROCDECL STATEMENT
                    {printf("level_down()\n");}
                    
                ;

CONSTDECL       :   t_const CONSTIDENT t_equal t_number MORECONSTDECL t_semicolon
                |   EPSILON
                ;

MORECONSTDECL   :   t_comma CONSTIDENT t_equal t_number MORECONSTDECL
                |   EPSILON
                ;

CONSTIDENT      :   t_ident
                    {printf("insert(CONST)\n");}
                ;

VARDECL         :   t_var VARIDENT MOREVARDECL t_semicolon
                |   EPSILON
                ;

MOREVARDECL     :   t_comma VARIDENT MOREVARDECL
                |   EPSILON
                ;

VARIDENT        :   t_ident
                    {printf("insert(VAR)\n");}
                ;

PROCDECL        :   t_procedure t_ident {printf("insert(PROC)\n");} t_semicolon BLOCK t_semicolon PROCDECL
                |   EPSILON
                ;

STATEMENT       :   t_ident t_assign EXPRESSION
                    {$$ = $3;
                    printf("lookup()\n");}
                |   t_call t_ident
                    {printf("lookup()\n");}
                |   t_read t_ident
                    {printf("lookup()\n");}
                |   t_write EXPRESSION
                |   t_begin STATEMENT MORESTATEMENTS t_end
                |   t_if CONDITION t_then STATEMENT
                    // {if ($2) printf("True\n"); else printf("False\n");}
                |   t_while CONDITION t_do STATEMENT
                |   EPSILON
                ;

MORESTATEMENTS  :   t_semicolon STATEMENT MORESTATEMENTS
                |   EPSILON
                ;

CONDITION       :   t_odd EXPRESSION
                    {if (($2 % 2) != 0) {
                        // printf("Odd\n");
                        $$ = 1;
                    }
                    else {
                        // printf("NotOdd\n");
                        $$ = 0;
                    }}
                |   EXPRESSION t_equal EXPRESSION
                    {if ($1 == $3) {
                        // printf("Equal\n");
                        $$ = 1;
                    }
                    else {
                        // printf("Unequal\n");
                        $$ = 0;
                    }}
                |   EXPRESSION t_unequal EXPRESSION
                    {if ($1 != $3) {
                        // printf("Unequal\n");
                        $$ = 1;
                    }
                    else {
                        // printf("NotUnequal\n");
                        $$ = 0;
                    }}
                |   EXPRESSION t_smaller EXPRESSION
                    {if ($1 < $3) {
                        // printf("IsSmaller\n");
                        $$ = 1;
                    }
                    else {
                        // printf("IsNotSmaller\n");
                        $$ = 0;
                    }}
                |   EXPRESSION t_smaller_equ EXPRESSION
                        {if ($1 <= $3) {
                            // printf("IsSmallerEqu\n");
                            $$ = 1;
                        }
                        else {
                            // printf("IsNotSmallerEqu\n");
                            $$ = 0;
                        }}
                |   EXPRESSION t_bigger EXPRESSION
                    {if ($1 > $3) {
                        // printf("IsBigger\n");
                        $$ = 1;
                    }
                    else {
                        // printf("IsNotBigger\n");
                        $$ = 0;
                    }}
                |   EXPRESSION t_bigger_equ EXPRESSION
                    {if ($1 >= $3) {
                        // printf("IsBiggerEqu\n");
                        $$ = 1;
                    }
                    else {
                        // printf("IsNotBiggerEqu\n");
                        $$ = 0;
                    }}
                ;

EXPRESSION      :   SIGN TERM MORETERMS
                    {if ($1) {
                        $$ = (-1 * $2) + $3;
                    }
                    else {
                        $$ = $2 + $3;
                    }}
                ;

SIGN            :   t_plus
                    {$$ = 0;}
                |   t_minus
                    {$$ = 1;}
                |   EPSILON
                    {$$ = 0;}
                ;

MORETERMS       :   t_plus TERM MORETERMS
                    {$$ = $2 + $3;}
                |   t_minus TERM MORETERMS
                    {$$ = (-1 * $2) + $3;}
                |   EPSILON
                ;

TERM            :   FACTOR t_mult TERM
                    {$$ = $1 * $3;}
                |   FACTOR t_div TERM
                    {$$ = $1 / $3;}
                |   FACTOR
                    {$$ = $1;}
                ;

FACTOR          :   t_ident
                    {printf("lookup()\n");}
                |   t_number
                |   t_bracket_open EXPRESSION t_bracket_close
                    {$$ = $2;}
                ;

EPSILON         :
                ;
%%
int main() {
    yyparse();
    return yylex();
}

void yyerror(char *s) {
    fprintf(stderr, "ERROR: %s\n", s);
    exit(1);
}

int yywrap() {
    // printf("Scannen beendet.\n");
    return 1;
}


