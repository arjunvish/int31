{
(**************************************************************************)
(*                                                                        *)
(*     SMTCoq                                                             *)
(*     Copyright (C) 2011 - 2019                                          *)
(*                                                                        *)
(*     See file "AUTHORS" for the list of authors                         *)
(*                                                                        *)
(*   This file is distributed under the terms of the CeCILL-C licence     *)
(*                                                                        *)
(**************************************************************************)


(* This parser is adapted from Jane Street sexplib parser *)

  open Printf
  open Lexing
  open Parser

  let found_newline ({ lex_curr_p; _ } as lexbuf) diff =
    lexbuf.lex_curr_p <-
      {
        lex_curr_p with
        pos_lnum = lex_curr_p.pos_lnum + 1;
        pos_bol = lex_curr_p.pos_cnum - diff;
      }

  (* same length computation as in [Lexing.lexeme] *)
  let lexeme_len { lex_start_pos; lex_curr_pos; _ } = lex_curr_pos - lex_start_pos

  let main_failure lexbuf msg =
    let { pos_lnum; pos_bol; pos_cnum; pos_fname = _ } = lexeme_start_p lexbuf in
    let msg =
      sprintf
        "Sexplib.Lexer.main: %s at line %d char %d"
        msg pos_lnum (pos_cnum - pos_bol)
    in
    failwith msg

  module type T = sig
    module Quoted_string_buffer : sig
      type t
      val create : int -> t
      val add_char : t -> char -> unit
      val add_substring : t -> string -> int -> int -> unit
      val add_lexeme : t -> lexbuf -> unit
      val clear : t -> unit
      val of_buffer : Buffer.t -> t
    end
    module Token : sig
      type t
      val lparen : t
      val rparen : t
      val integer : string -> t
      val i31 : t
      val d0 : t
      val d1 : t
      val cons : t
      val nil : t
      val eof : t
      type s = Quoted_string_buffer.t -> Lexing.lexbuf -> t
    end
  end


  (* Create and populate a hashtable *)
  let mk_hashtbl init =
    let tbl = List.length init |> Hashtbl.create in
    init |> List.iter (fun (k, v) -> Hashtbl.add tbl k v) ;
    tbl

  module Make (X : T) : sig
    val main : ?buf:Buffer.t -> Lexing.lexbuf -> X.Token.t
  end = struct (* BEGIN FUNCTOR BODY CONTAINING GENERATED CODE *)
    open X

}

let lf = '\010'
let lf_cr = ['\010' '\013']
let dos_newline = "\013\010"
let blank = [' ' '\009' '\012']
let unquoted = [^ ';' '(' ')' '"' '\\' ':' '@' '!' ] # blank # lf_cr
let digit = ['0'-'9']
let hexdigit = digit | ['a'-'f' 'A'-'F']

let unquoted_start =
  unquoted # ['#' '|'] | '#' unquoted # ['|'] | '|' unquoted # ['#']

let integer = digit+
let ident = ('_')* ['a'-'z' 'A'-'Z' '\'' ]['a'-'z' 'A'-'Z' '0'-'9' '\\' '_']*


rule main buf = parse
  | lf | dos_newline { found_newline lexbuf 0;
                       main buf lexbuf }
  | blank+ { main buf lexbuf }
  | '(' { Token.lparen }
  | ')' { Token.rparen }
  | integer as i { Token.integer i }
  | "Int31.I31" { Token.i31 }
  | "Int31.D0" { Token.d0 }
  | "Int31.D1" { Token.d1 }
  | "::" { Token.cons }
  | "nil" { Token.nil }
  | eof { Token.eof }


{ (* RESUME FUNCTOR BODY CONTAINING GENERATED CODE *)

    let main ?buf =
      let buf =
        match buf with
        | None -> Quoted_string_buffer.create 64
        | Some buf ->
          Buffer.clear buf;
          Quoted_string_buffer.of_buffer buf
      in
      main buf

  end (* END FUNCTOR BODY CONTAINING GENERATED CODE *)

  module Vanilla =
    Make (struct
      module Quoted_string_buffer = struct
        include Buffer
        let add_lexeme _ _ = ()
        let of_buffer b = b
      end
      module Token = struct
        open Parser
        type t = token
        type s = Quoted_string_buffer.t -> Lexing.lexbuf -> t
        let lparen = LPAREN
        let rparen = RPAREN
        let integer i = INT (int_of_string i)
        let i31 = I31
        let d0 = D0
        let d1 = D1
        let cons = CONS
        let nil = NIL
        let eof = EOF
      end
    end)


  let main = Vanilla.main

}
