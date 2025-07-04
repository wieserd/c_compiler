%token INT_LITERAL IDENTIFIER INT RETURN PLUS MINUS STAR SLASH LPAREN RPAREN LBRACE RBRACE SEMICOLON EOF

%start program
%type <unit> program

%{
  open Tokens
%}

%%

program: EOF { () }
