%token <int> INT_LITERAL
%token <string> IDENTIFIER
%token INT RETURN PLUS MINUS STAR SLASH LPAREN RPAREN LBRACE RBRACE SEMICOLON EOF

%start <unit> program
%type <unit> program

%%

program: EOF { () }
