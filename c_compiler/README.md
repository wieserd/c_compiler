# C Compiler in OCaml

This document outlines the structure of a compiler for the C programming language, written in OCaml.

## Summary of Current Progress

This project is a work-in-progress C compiler implemented in OCaml. We have successfully integrated the initial phases of a compiler pipeline:

*   **Lexical Analysis (Lexer):** Converts raw C source code into a stream of tokens.
*   **Syntax Analysis (Parser):** Builds an Abstract Syntax Tree (AST) from the token stream.
*   **Semantic Analysis:** Performs basic type checking and scope analysis on the AST, identifying undeclared variables and redeclarations.
*   **Intermediate Representation (IR) Generation:** Translates the AST into a simplified three-address code-like Intermediate Representation.
*   **Code Generation:** Generates basic x86-64 assembly code from the IR.

The compiler currently handles simple C functions with integer declarations, assignments, and return statements.

## Current Status

All core compiler phases (Lexer, Parser, Semantic Analysis, IR Generation, Code Generation) are integrated and the project builds without warnings. The compiler can process simple C code and produce corresponding x86-64 assembly output.

## Code Structure

The project is organized into the following modules:

*   `main.ml`: The main entry point of the compiler. It orchestrates the entire compilation pipeline: lexing, parsing, semantic analysis, IR generation, and code generation.
*   `lexer.mll`: Defines the lexical rules for the C language using `ocamllex`. It converts the input character stream into a token stream.
*   `grammar.mly`: Defines the grammar rules for a subset of the C language using `menhir`. It constructs the Abstract Syntax Tree (AST) from the token stream.
*   `tokens.mli`: Defines the types for all tokens recognized by the lexer and used by the parser. This separation helps avoid naming conflicts and provides a clear interface for tokens.
*   `ast.ml`: Defines the Abstract Syntax Tree (AST) data types. This represents the hierarchical structure of the C source code after parsing.
*   `semantics.ml`: Implements the semantic analysis phase. It includes a symbol table for scope management and performs basic type checking and redeclaration checks.
*   `ir.ml`: Defines the Intermediate Representation (IR) data structures and contains the logic to translate the AST into this lower-level representation.
*   `codegen.ml`: Defines the x86-64 assembly instruction types and implements the code generation logic, translating the IR into assembly code.

## 1. The Lexer (Lexical Analysis)

*   **Purpose:** To convert the raw C source code (a stream of characters) into a stream of tokens.
*   **Implementation:** This is implemented using `ocamllex`, a lexical analyzer generator.
*   **Input:** `program.c` (conceptually, currently takes input from stdin in `main.ml` for testing).
*   **Output:** A list of tokens, e.g., `[INT(5); PLUS; IDENT("x"); SEMICOLON]`
*   **Modules:** `lexer.mll`

## 2. The Parser (Syntax Analysis)

*   **Purpose:** To take the stream of tokens from the lexer and build an Abstract Syntax Tree (AST) that represents the grammatical structure of the code.
*   **Implementation:** This is implemented using `menhir`, a parser generator for OCaml.
*   **Input:** A stream of tokens from the lexer.
*   **Output:** An AST.
*   **Modules:** `grammar.mly`, `tokens.mli` (defines token types).

## 3. Semantic Analysis

*   **Purpose:** To check the AST for semantic errors that are not caught by the parser. This includes type checking, scope analysis (ensuring variables are declared before use), etc.
*   **Implementation:** A recursive function that traverses the AST.
*   **Input:** The AST from the parser.
*   **Output:** An annotated AST (with type information) or a list of semantic errors.
*   **Modules:** `semantics.ml`

## 4. Intermediate Representation (IR) Generation

*   **Purpose:** To translate the AST into a lower-level, machine-independent representation. This makes optimization and code generation simpler. We will use a simple three-address code representation.
*   **Implementation:** A module that traverses the AST and generates IR code.
*   **Input:** The semantically-checked AST.
*   **Output:** A sequence of IR instructions.
*   **Modules:** `ir.ml`

## 5. Code Generation

*   **Purpose:** To translate the Intermediate Representation into target machine code (e.g., x86 assembly).
*   **Implementation:** A module that maps IR instructions to assembly instructions.
*   **Input:** The IR code.
*   **Output:** An assembly file (`.s`).
*   **Modules:** `codegen.ml`

## 6. Driver

*   **Purpose:** The main executable that ties all the components together. It will handle command-line arguments, open files, and call the different compiler stages in order.
*   **Modules:** `main.ml`
