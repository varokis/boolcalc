%{
  /*
    This file is part of rpn-calc:
    Reverse Polish notation (RPN) calculator written in C++ using flex and bison.
    Copyright (C) 2013 nikagra <nikagra@gmail.com>

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program. If not, see <http://www.gnu.org/licenses/>.
  */

 #include <stdio.h>
 #include <math.h>
 #include "global.h"
 void yyerror (char const *);
 extern int yylex(void);
%}

%token BOOL
%token KON DIS NEG IMP EQU
%token EOL

/*
 *Grammar rules and actions
 */
%%
input:
      /* empty */
    | input line
    ;

line:
      EOL
    | expr EOL      { printf("%g\n", $1); }
    ;

expr:
      BOOL              { $$ = $1; }
    | expr NEG          { $$ = !$1; }
    | expr expr KON     { $$ = $1 && $2; }
    | expr expr DIS     { $$ = $1 || $2; }
    | expr expr IMP     { $$ = !$1 || $2; }
    | expr expr EQU     { $$ = $1 == $2; }
    ;

%%
