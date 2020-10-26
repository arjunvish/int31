%{
(* This translator is adapted from SMTCoq's LFSC translator *)
open Ast
open Lexing
open Format
%}

%token <int> INT
%token LPAREN RPAREN EOF 
%token I31 D0 D1

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
    { (to_string_dec $2) ^ "\n" }
;

input:
  | int31 EOF { print_string $1 }
;