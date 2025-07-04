open Lexing

let () = 
  let lexbuf = Lexing.from_channel stdin in
  try
    let program = Grammar.program Lexer.token lexbuf in
    Printf.printf "Parsing successful!\n";
    Semantics.analyze_program program; (* Call semantic analysis *)
    Printf.printf "Semantic analysis complete.\n";
  with
  | Failure msg ->
    let pos = lexbuf.lex_curr_p in
    Printf.eprintf "Lexing error: %s at line %d, column %d\n" msg
      pos.pos_lnum
      (pos.pos_cnum - pos.pos_bol)
  | Grammar.Error ->
    let pos = lexbuf.lex_curr_p in
    Printf.eprintf "Parsing error at line %d, column %d\n" 
      pos.pos_lnum
      (pos.pos_cnum - pos.pos_bol)