%{
(* This translator is adapted from SMTCoq's LFSC translator *)

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
  | D0 integer { "0"^$2 }
  | D1 integer { "1"^$2 }
  | D0 { "0" }
  | D1 { "1" }
;

int31:
  | I31 integer
    { $2^"\n" }
;

input:
  | int31 EOF { print_string $1 }
;