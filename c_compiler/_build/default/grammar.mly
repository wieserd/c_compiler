%start program
%type <unit> program

%%

program: EOF { () }