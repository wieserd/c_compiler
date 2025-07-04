{}

rule token = parse
  | "int"    { Parser.INT }
  | "return" { Parser.RETURN }
  | ['0'-'9']+ as lxm { Parser.INT_LITERAL (int_of_string lxm) }
  | ['a'-'z' 'A'-'Z' '_'] ['a'-'z' 'A'-'Z' '0'-'9' '_']* as lxm { Parser.IDENTIFIER lxm }
  | '+'      { Parser.PLUS }
  | '-'      { Parser.MINUS }
  | '*'      { Parser.STAR }
  | '/'      { Parser.SLASH }
  | '('      { Parser.LPAREN }
  | ')'      { Parser.RPAREN }
  | '{'      { Parser.LBRACE }
  | '}'      { Parser.RBRACE }
  | ';'      { Parser.SEMICOLON }
  | eof      { Parser.EOF }
  | [' ' '\t' '\n' '\r'] { token lexbuf }
  | _        { raise (Failure ("Illegal character: " ^ (Lexing.lexeme lexbuf))) }