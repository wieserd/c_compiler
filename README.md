# C Compiler in OCaml

This document outlines the structure of a compiler for the C programming language, written in OCaml.

## Current Status

The project is now set up with a working lexer and parser generation. The `dune` build system is configured to generate `lexer.ml` from `lexer.mll` and `grammar.ml` (and `grammar.mli`) from `grammar.mly`.

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
*   **Output:** An AST (currently a placeholder that accepts EOF).
*   **Modules:** `grammar.mly`, `tokens.mli` (defines token types).

## 3. Semantic Analysis

*   **Purpose:** To check the AST for semantic errors that are not caught by the parser. This includes type checking, scope analysis (ensuring variables are declared before use), etc.
*   **Implementation:** A recursive function that traverses the AST.
*   **Input:** The AST from the parser.
*   **Output:** An annotated AST (with type information) or a list of semantic errors.
*   **Modules:** `semantics.ml` (planned)

## 4. Intermediate Representation (IR) Generation

*   **Purpose:** To translate the AST into a lower-level, machine-independent representation. This makes optimization and code generation simpler. We will use a simple three-address code representation.
*   **Implementation:** A module that traverses the AST and generates IR code.
*   **Input:** The semantically-checked AST.
*   **Output:** A sequence of IR instructions.
*   **Modules:** `ir.ml` (planned)

## 5. Code Generation

*   **Purpose:** To translate the Intermediate Representation into target machine code (e.g., x86 assembly).
*   **Implementation:** A module that maps IR instructions to assembly instructions.
*   **Input:** The IR code.
*   **Output:** An assembly file (`.s`).
*   **Modules:** `codegen.ml` (planned)

## 6. Driver

*   **Purpose:** The main executable that ties all the components together. It will handle command-line arguments, open files, and call the different compiler stages in order.
*   **Modules:** `main.ml`