open Lexing
open Lexer
open Grammar
open Semantics

let () = 
  let lexbuf = Lexing.from_channel stdin in
  try
    let program = Grammar.program Lexer.token lexbuf in
    Printf.printf "Parsing successful!\n";
    Semantics.analyze_program program; (* Call semantic analysis *)
    Printf.printf "Semantic analysis complete.\n";
  with
  | Failure msg ->
    Printf.eprintf "Lexing error: %s at line %d, character %d\n" msg
      lexbuf.lex_curr_p.pos_lnum
      (lexbuf.lex_curr_p.pos_cnum - lexbuf.lex_curr_p.pos_bol)
  | Grammar.Error ->
    Printf.eprintf "Parsing error at line %d, character %d\n" 
      lexbuf.lex_curr_p.pos_lnum
      (lexbuf.lex_curr_p.pos_cnum - lexbuf.lex_curr_p.pos_bol)
