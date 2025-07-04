{
  open Tokens
}

rule token = parse
  | "int"    { INT }
  | "return" { RETURN }
  | ['0'-'9']+ as lxm { INT_LITERAL (int_of_string lxm) }
  | ['a'-'z' 'A'-'Z' '_'] ['a'-'z' 'A'-'Z' '0'-'9' '_']* as lxm { IDENTIFIER lxm }
  | '+'      { PLUS }
  | '-'      { MINUS }
  | '*'      { STAR }
  | '/'      { SLASH }
  | '('      { LPAREN }
  | ')'      { RPAREN }
  | '{'      { LBRACE }
  | '}'      { RBRACE }
  | ';'      { SEMICOLON }
  | eof      { EOF }
  | [' ' '\t' '\n' '\r'] { token lexbuf }
  | _        { raise (Failure ("Illegal character: " ^ (Lexing.lexeme lexbuf))) }