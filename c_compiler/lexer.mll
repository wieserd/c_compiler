{
}

rule token = parse
  | "int"    { Grammar.INT }
  | "return" { Grammar.RETURN }
  | ['0'-'9']+ as lxm { Grammar.INT_LITERAL (int_of_string lxm) }
  | ['a'-'z' 'A'-'Z' '_'] ['a'-'z' 'A'-'Z' '0'-'9' '_']* as lxm { Grammar.IDENTIFIER lxm }
  | '+'      { Grammar.PLUS }
  | '-'      { Grammar.MINUS }
  | '*'      { Grammar.STAR }
  | '/'      { Grammar.SLASH }
  | '('      { Grammar.LPAREN }
  | ')'      { Grammar.RPAREN }
  | '{'      { Grammar.LBRACE }
  | '}'      { Grammar.RBRACE }
  | ';'      { Grammar.SEMICOLON }
  | eof      { Grammar.EOF }
  | [' ' '\t' '\n' '\r'] { token lexbuf }
  | _        { raise (Failure ("Illegal character: " ^ (Lexing.lexeme lexbuf))) }

