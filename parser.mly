%{
(* This translator is adapted from SMTCoq's LFSC translator *)
open Ast
open Lexing
open Format
%}

%token <int> INT
%token LPAREN RPAREN EOF
%token INT31_LIST DEC_LIST
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

int31_list_contents:
  | int31 CONS int31_list_contents
    { $1 ^ ";" ^ $3 }
  | NIL { "" }
;

int31_list:
  | INT31_LIST int31_list_contents
    { "[" ^ $2 ^ "]\n" }
;

dec_list_contents:
  | INT CONS dec_list_contents
    { (bin_to_string (dec_to_bin $1)) ^ " :: " ^ $3 }
  | NIL { "nil" }
;

dec_list:
  | DEC_LIST dec_list_contents
    { $2 ^ "\n" }
;

input:
  | int31_list EOF { print_string $1 }
  | dec_list EOF { print_string $1 }
;