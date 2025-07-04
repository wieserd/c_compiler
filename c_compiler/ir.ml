open Ast

(* Define basic IR instructions *)
type ir_instruction =
  | I_Assign of Ast.identifier * Ast.expression (* Simplified for now *)
  | I_Return of Ast.expression
  | I_Declare of Ast.identifier

(* A list of IR instructions represents the IR for a function *)
type ir_program = ir_instruction list

(* Function to generate IR from an expression *)
let generate_ir_from_expression (expr: Ast.expression) : ir_instruction list = 
  match expr with
  | Ast.IntLiteral _ -> [] (* No IR needed for simple literals yet *)
  | Ast.Identifier _ -> [] (* No IR needed for simple identifiers yet *)

(* Function to generate IR from a statement *)
let generate_ir_from_statement (stmt: Ast.statement) : ir_instruction list = 
  match stmt with
  | Ast.Return expr ->
    (generate_ir_from_expression expr) @ [I_Return expr]
  | Ast.Declaration (id, expr_opt) ->
    let assign_ir = match expr_opt with
      | Some expr -> (generate_ir_from_expression expr) @ [I_Assign (id, expr)]
      | None -> []
    in
    [I_Declare id] @ assign_ir

(* Function to generate IR for a function definition *)
let generate_ir_from_function_definition (func_def: Ast.function_definition) : ir_program = 
  Printf.printf "  Generating IR for function '%s'\n" func_def.name;
  List.concat (List.map generate_ir_from_statement func_def.body)

(* Main IR generation function *)
let generate_ir (program: Ast.program) : ir_program list = 
  Printf.printf "Generating Intermediate Representation...\n";
  List.map generate_ir_from_function_definition program