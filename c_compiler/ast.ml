type identifier = string

type expression =
  | IntLiteral of int
  | Identifier of identifier

type statement =
  | Return of expression
  | Declaration of identifier * expression option

type function_definition =
  { name: identifier
  ; body: statement list
  }

type program = function_definition list
