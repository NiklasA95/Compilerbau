/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_PL0_PARSER_TAB_H_INCLUDED
# define YY_YY_PL0_PARSER_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    t_const = 258,
    t_var = 259,
    t_procedure = 260,
    t_assign = 261,
    t_call = 262,
    t_read = 263,
    t_write = 264,
    t_begin = 265,
    t_end = 266,
    t_if = 267,
    t_then = 268,
    t_while = 269,
    t_do = 270,
    t_odd = 271,
    t_semicolon = 272,
    t_comma = 273,
    t_dot = 274,
    t_plus = 275,
    t_minus = 276,
    t_mult = 277,
    t_div = 278,
    t_equal = 279,
    t_unequal = 280,
    t_smaller = 281,
    t_smaller_equ = 282,
    t_bigger = 283,
    t_bigger_equ = 284,
    t_bracket_open = 285,
    t_bracket_close = 286,
    t_digit = 287,
    t_ident = 288
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_PL0_PARSER_TAB_H_INCLUDED  */
