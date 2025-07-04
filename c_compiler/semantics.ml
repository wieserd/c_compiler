open Ast

(* Define a simple symbol table entry type *)
type symbol_entry = 
  { name: string
  ; typ: string (* For now, just a string like "int" *)
  }

(* A very basic symbol table as a list of entries *)
type symbol_table = symbol_entry list

(* Global flag to track if any semantic errors were found *)
let semantic_errors_found = ref false

(* Helper to report semantic errors *)
let report_semantic_error msg = 
  semantic_errors_found := true;
  Printf.eprintf "Semantic error: %s\n" msg

(* Function to add a symbol to the table *)
let add_symbol (table: symbol_table) (name: string) (typ: string) : symbol_table = 
  { name; typ } :: table

(* Function to lookup a symbol in the table *)
let lookup_symbol (table: symbol_table) (name: string) : symbol_entry option = 
  List.find_opt (fun entry -> entry.name = name) table

(* Semantic analysis for expressions, returns the type of the expression *)
let analyze_expression (table: symbol_table) (expr: expression) : string = 
  match expr with
  | IntLiteral _ -> "int"
  | Identifier id ->
    match lookup_symbol table id with
    | Some entry -> entry.typ
    | None -> 
      report_semantic_error (Printf.sprintf "Undeclared identifier '%s'" id);
      "error" (* Return "error" type for undeclared identifiers *)

(* Semantic analysis for statements *)
let analyze_statement (table: symbol_table) (stmt: statement) : symbol_table = 
  match stmt with
  | Return expr ->
    let expr_type = analyze_expression table expr in
    if expr_type <> "int" then
      report_semantic_error (Printf.sprintf "Return expression has type '%s', expected 'int'" expr_type);
    table (* Return statements don't add to the symbol table *)
  | Declaration (id, expr_opt) ->
    (match lookup_symbol table id with
    | Some _ -> report_semantic_error (Printf.sprintf "Redeclaration of identifier '%s'" id)
    | None -> ());
    (match expr_opt with
    | Some expr -> 
      let expr_type = analyze_expression table expr in
      if expr_type <> "int" then
        report_semantic_error (Printf.sprintf "Initializer for '%s' has type '%s', expected 'int'" id expr_type);
    | None -> ());
    add_symbol table id "int" (* Assuming all declarations are int for now *)

(* Semantic analysis for function definitions *)
let analyze_function_definition (func_def: function_definition) : unit = 
  Printf.printf "  Analyzing function '%s'\n" func_def.name;
  let current_symbol_table = ref [] in (* Start with an empty symbol table for each function *)
  List.iter (fun stmt -> 
    current_symbol_table := analyze_statement !current_symbol_table stmt
  ) func_def.body;
  Printf.printf "  Finished analyzing function '%s'\n" func_def.name

(* Main semantic analysis function *)
let analyze_program (program: program) : unit = 
  semantic_errors_found := false; (* Reset flag for each analysis run *)
  Printf.printf "Performing semantic analysis...\n";
  List.iter analyze_function_definition program;
  if !semantic_errors_found then
    Printf.printf "Semantic analysis completed with errors.\n"
  else
    Printf.printf "Semantic analysis completed without errors.\n"
