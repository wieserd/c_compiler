open Lexing
open Lexer

let () = 
  let lexbuf = Lexing.from_channel stdin in
  let rec loop () = 
    let token = Lexer.token lexbuf in
    match token with
    | EOF -> print_endline "EOF"
    | _ -> 
      print_endline (Printf.sprintf "Token: %s" (match token with
                                                  | INT -> "INT"
                                                  | RETURN -> "RETURN"
                                                  | INT_LITERAL i -> "INT_LITERAL(" ^ (string_of_int i) ^ ")"
                                                  | IDENTIFIER s -> "IDENTIFIER(" ^ s ^ ")"
                                                  | PLUS -> "PLUS"
                                                  | MINUS -> "MINUS"
                                                  | STAR -> "STAR"
                                                  | SLASH -> "SLASH"
                                                  | LPAREN -> "LPAREN"
                                                  | RPAREN -> "RPAREN"
                                                  | LBRACE -> "LBRACE"
                                                  | RBRACE -> "RBRACE"
                                                  | SEMICOLON -> "SEMICOLON"
                                                  | EOF -> "EOF"));
      loop ()
  in
  try
    loop ()
  with Failure msg ->
    Printf.eprintf "Lexing error: %s at line %d, character %d\n" msg
      lexbuf.lex_curr_p.pos_lnum
      (lexbuf.lex_curr_p.pos_cnum - lexbuf.lex_curr_p.pos_bol)