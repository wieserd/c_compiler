%token <int> INT_LITERAL
%token <string> IDENTIFIER
%token INT RETURN PLUS MINUS STAR SLASH LPAREN RPAREN LBRACE RBRACE SEMICOLON EOF ASSIGN

%start program
%type <Ast.program> program

%{
  open Tokens
  open Ast
%}

%%

program: function_definition+ EOF { $1 }

function_definition:
  INT IDENTIFIER LPAREN RPAREN LBRACE statement+ RBRACE
  { { name = $2; body = $6 } }

statement:
  | RETURN expression SEMICOLON { Return $2 }
  | INT IDENTIFIER SEMICOLON { Declaration ($2, None) }
  | INT IDENTIFIER ASSIGN expression SEMICOLON { Declaration ($2, Some $4) }

expression:
  | INT_LITERAL { IntLiteral $1 }
  | IDENTIFIER { Identifier $1 }
