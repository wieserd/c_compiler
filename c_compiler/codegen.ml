open Ir

(* Define basic x86-64 assembly instructions *)
type assembly_instruction =
  | Mov of string * string (* e.g., Mov "rax", "0" *)
  | Ret
  | Push of string
  | Pop of string
  | Add of string * string
  | Sub of string * string
  | Label of string
  | Global of string
  | Section of string

(* Function to convert an AST expression to a string for assembly *)
let ast_expression_to_asm_operand (expr: Ast.expression) : string = 
  match expr with
  | Ast.IntLiteral i -> string_of_int i
  | Ast.Identifier id -> id (* For now, assume identifiers are directly usable as operands *)

(* Function to generate assembly from IR instructions *)
let generate_assembly_from_ir (ir_list: ir_instruction list) : assembly_instruction list = 
  List.concat (List.map (fun ir_instr ->
    match ir_instr with
    | I_Return expr ->
      [ Mov ("rax", ast_expression_to_asm_operand expr)
      ; Ret
      ]
    | I_Declare _id ->
      (* For now, declarations don't generate explicit assembly instructions here.
         They will be handled by stack management in a more complete compiler. *)
      []
    | I_Assign (id, expr) ->
      [ Mov (id, ast_expression_to_asm_operand expr) (* Simplified: direct move to variable name *)
      ]
  ) ir_list)

(* Main code generation function *)
let generate_code (ir_programs: ir_program list) : assembly_instruction list = 
  Printf.printf "Generating Code...\n";
  let all_assembly_instructions = 
    List.concat (List.map (fun ir_program ->
      (* For each function's IR, generate assembly *)
      let func_assembly = generate_assembly_from_ir ir_program in
      (* Add function prologue/epilogue for main for now *)
      [ Global "main"
      ; Section "text"
      ; Label "main"
      ; Push "rbp"
      ; Mov ("rbp", "rsp")
      ] @ func_assembly @
      [ Pop "rbp"
      ; Ret (* Redundant if I_Return is last, but good for structure *)
      ]
    ) ir_programs)
  in
  Printf.printf "Code generation complete.\n";
  all_assembly_instructions

(* Function to print assembly instructions *)
let print_assembly (asm_instructions: assembly_instruction list) : unit = 
  List.iter (fun instr ->
    match instr with
    | Mov (dest, src) -> Printf.printf "  mov %s, %s\n" dest src
    | Ret -> Printf.printf "  ret\n"
    | Push reg -> Printf.printf "  push %s\n" reg
    | Pop reg -> Printf.printf "  pop %s\n" reg
    | Add (op1, op2) -> Printf.printf "  add %s, %s\n" op1 op2
    | Sub (op1, op2) -> Printf.printf "  sub %s, %s\n" op1 op2
    | Label l -> Printf.printf "%s:\n" l
    | Global l -> Printf.printf "  .global %s\n" l
    | Section s -> Printf.printf "  .section %s\n" s
  ) asm_instructions