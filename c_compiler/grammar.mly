%token INT_LITERAL IDENTIFIER INT RETURN PLUS MINUS STAR SLASH LPAREN RPAREN LBRACE RBRACE SEMICOLON EOF ASSIGN

%start program
%type <unit> program

%{
  open Tokens
%}

%%

program: EOF { () }
