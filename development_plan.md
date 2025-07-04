# C Compiler in OCaml - Development Plan

This document outlines the phased development plan to transform the current skeleton into a functional C compiler.

## Current Status

The project currently provides a basic `dune` setup and a `main.ml` entry point. The `README.md` outlines the high-level stages of a compiler. It does not yet perform any compilation.

## Goal

To develop a C compiler capable of translating C source code into executable assembly code (e.g., x86-64 assembly).

## Development Phases

### Phase 1: Lexical Analysis (Lexer)

*   **Goal:** Convert raw C source code into a stream of tokens.
*   **Tools:** `ocamllex`
*   **Tasks:**
    *   Define all necessary tokens for the C language (keywords, identifiers, operators, integer/floating-point literals, string literals, comments, etc.).
    *   Write the `lexer.mll` file containing regular expressions for token recognition.
    *   Generate the `lexer.ml` module using `ocamllex`.
*   **Verification:**
    *   Create small C code snippets (e.g., `int main() { return 0; }`, `a = b + 1;`).
    *   Write tests to feed these snippets to the lexer and assert that the correct sequence of tokens is produced.

### Phase 2: Syntax Analysis (Parser)

*   **Goal:** Construct an Abstract Syntax Tree (AST) from the token stream, representing the grammatical structure of the C program.
*   **Tools:** `menhir`
*   **Tasks:**
    *   Define the AST data types in `ast.ml` to represent C constructs (e.g., expressions, statements, declarations, functions).
    *   Write the `parser.mly` file, defining the C grammar rules using Menhir's syntax.
    *   Associate grammar rules with actions to build AST nodes.
    *   Generate the `parser.ml` module using `menhir`.
*   **Verification:**
    *   Parse various valid C code snippets (e.g., variable declarations, arithmetic expressions, `if` statements, `for` loops, function definitions).
    *   Inspect the generated ASTs to ensure they accurately reflect the source code's structure.
    *   Test with invalid C code to ensure the parser correctly reports syntax errors.

### Phase 3: Semantic Analysis

*   **Goal:** Check the AST for semantic correctness (e.g., type compatibility, variable scope, function signature matching) and annotate it with additional information.
*   **Tasks:**
    *   Implement a symbol table mechanism to store information about declared identifiers (variables, functions, types) and their scopes.
    *   Develop type checking rules for expressions and statements.
    *   Implement checks for variable declaration before use, correct function arguments, etc.
    *   Annotate the AST with type information or resolve symbol references.
    *   Implement a robust error reporting mechanism for semantic errors.
*   **Verification:**
    *   Test with C code containing common semantic errors (e.g., type mismatches, undeclared variables, incorrect function calls).
    *   Verify that valid C code passes semantic analysis without errors and that the AST is correctly annotated.

### Phase 4: Intermediate Representation (IR) Generation

*   **Goal:** Translate the semantically-checked AST into a lower-level, machine-independent Intermediate Representation (IR). This simplifies subsequent optimization and code generation.
*   **Tasks:**
    *   Define the IR data structures in `ir.ml` (e.g., three-address code, control flow graph, or a custom IR).
    *   Implement a traversal of the AST that generates corresponding IR instructions.
    *   Handle control flow (loops, conditionals) and function calls in the IR.
*   **Verification:**
    *   Generate IR for various C programs (e.g., simple arithmetic, loops, function calls).
    *   Inspect the generated IR to ensure it correctly represents the program's logic and control flow.

### Phase 5: Code Generation

*   **Goal:** Translate the Intermediate Representation into target machine code (e.g., x86-64 assembly).
*   **Tasks:**
    *   Implement a module (`codegen.ml`) that maps IR instructions to specific assembly instructions for the chosen target architecture.
    *   Develop a register allocation strategy to efficiently use CPU registers.
    *   Implement handling of function calls, stack frames, and calling conventions.
    *   Generate the final assembly file (`.s`).
*   **Verification:**
    *   Generate assembly code for simple C programs.
    *   Use an external assembler (e.g., `gcc` or `nasm`) to assemble the generated `.s` file into an executable.
    *   Run the executable and verify its behavior matches the original C program.

### Phase 6: Driver/Main Compiler Logic

*   **Goal:** Integrate all compiler phases into a cohesive executable that handles input/output and orchestrates the compilation process.
*   **Tasks:**
    *   Modify `main.ml` to parse command-line arguments (e.g., input C file, output assembly file).
    *   Implement file reading and writing.
    *   Call the lexer, parser, semantic analyzer, IR generator, and code generator in the correct sequence.
    *   Implement robust error handling and reporting throughout the compilation pipeline.
*   **Verification:**
    *   Perform end-to-end tests by compiling various C programs from source to executable assembly.
    *   Test with valid and invalid C programs to ensure correct behavior and error reporting.

## General Considerations

*   **Build System:** Continue to leverage `dune` for managing dependencies, compilation, and testing.
*   **Testing:** Prioritize writing unit tests for each component and integration tests for the overall compiler pipeline.
*   **Error Handling:** Implement clear and informative error messages at each stage of the compiler.
*   **Incremental Development:** Develop and test each phase incrementally before moving to the next.
*   **Documentation:** Maintain clear internal documentation for complex algorithms and data structures.
