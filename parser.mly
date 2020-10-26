%{
(* This translator is adapted from SMTCoq's LFSC translator *)
open Ast
open Lexing
open Format
%}

%token <int> INT
%token LPAREN RPAREN EOF 
%token I31 D0 D1 CONS NIL

%start input
%type <unit> input

%%

integer:
  | D0 integer { false :: $2 }
  | D1 integer { true :: $2 }
  | D0 { false :: [] }
  | D1 { true :: [] }
;

int31:
  | I31 integer
    { (to_string_dec $2) }
;

list_contents:
| int31 CONS list_contents
    { $1 ^ ";" ^ $3 }
| NIL { "" }
;

int31_list:
  | list_contents
    { "[" ^ $1 ^ "]\n" }
;

input:
  | int31_list EOF { print_string $1 }
;