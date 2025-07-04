# C Compiler in OCaml - Development Plan

## 1. Introduction & Current Status

This document outlines the ongoing development plan for our C compiler written in OCaml. We have successfully implemented and integrated the foundational phases of a compiler pipeline:

*   **Lexical Analysis (Lexer):** Converts raw C source code into a stream of tokens.
*   **Syntax Analysis (Parser):** Builds an Abstract Syntax Tree (AST) from the token stream for a basic subset of C.
*   **Semantic Analysis:** Performs basic type checking and scope analysis on the AST, identifying undeclared variables and redeclarations.
*   **Intermediate Representation (IR) Generation:** Translates the AST into a simplified three-address code-like Intermediate Representation.
*   **Code Generation:** Generates basic x86-64 assembly code from the IR.

The compiler currently handles simple C functions with integer declarations, assignments, and return statements. All phases are integrated, and the project builds cleanly.

## 2. Overall Goal

Our overarching goal is to develop a C compiler capable of translating a significant subset of the C programming language into optimized, executable x86-64 assembly code.

## 3. Development Roadmap: Phased Approach

We will proceed with development in distinct phases, focusing on expanding language features, refining intermediate representations, improving code generation, and ensuring robust testing.

### Phase 1: Expanding Language Features (Parser & Semantic Analysis)

**Goal:** To significantly broaden the subset of C that the compiler can parse and semantically analyze.

**Modules Involved:** `grammar.mly`, `ast.ml`, `semantics.ml`

**Tasks:**

*   **Arithmetic Expressions:**
    *   **Goal:** Support standard arithmetic operations.
    *   **Details:** Implement parsing and AST representation for addition (`+`), subtraction (`-`), multiplication (`*`), and division (`/`). Extend semantic analysis to type-check these operations.
*   **Conditional Statements (`if`, `else if`, `else`):**
    *   **Goal:** Enable conditional execution paths.
    *   **Details:** Implement parsing and AST representation for `if` statements, including `else if` and `else` clauses. Extend semantic analysis for condition expressions.
*   **Looping Constructs (`while`, `for`):**
    *   **Goal:** Allow repetitive execution of code blocks.
    *   **Details:** Implement parsing and AST representation for `while` and `for` loops. Extend semantic analysis for loop conditions and body.
*   **Function Calls:**
    *   **Goal:** Support calling user-defined and standard library functions.
    *   **Details:** Implement parsing and AST representation for function calls (initially, functions without arguments or with simple integer arguments). Extend semantic analysis to check function declarations and argument types/counts.
*   **Basic Data Types:**
    *   **Goal:** Introduce more fundamental C data types.
    *   **Details:** Expand type system beyond `int` to include `char` and `void`. Update lexer, parser, and semantic analysis to handle these types.

### Phase 2: Improving Intermediate Representation (IR)

**Goal:** To make the Intermediate Representation more expressive and suitable for optimization, accommodating the newly added language features.

**Modules Involved:** `ir.ml`

**Tasks:**

*   **IR for Arithmetic Operations:**
    *   **Goal:** Represent arithmetic operations explicitly in the IR.
    *   **Details:** Define new IR instructions (e.g., `I_Add`, `I_Sub`, `I_Mul`, `I_Div`) to represent arithmetic computations.
*   **IR for Control Flow:**
    *   **Goal:** Enable representation of conditional and loop structures.
    *   **Details:** Introduce IR instructions for conditional jumps (`I_JumpIfTrue`, `I_JumpIfFalse`) and unconditional jumps (`I_Jump`), along with labels (`I_Label`).
*   **IR for Function Calls:**
    *   **Goal:** Represent function calls and argument passing in the IR.
    *   **Details:** Define IR instructions for function calls (`I_Call`) and argument handling (`I_Arg`).

### Phase 3: Advanced Code Generation

**Goal:** To generate more efficient, correct, and idiomatic x86-64 assembly code for the expanded IR.

**Modules Involved:** `codegen.ml`

**Tasks:**

*   **Register Allocation:**
    *   **Goal:** Efficiently utilize CPU registers to minimize memory access.
    *   **Details:** Implement a basic register allocation strategy (e.g., a simple linear scan or graph coloring approach) to assign variables to registers.
*   **Stack Management:**
    *   **Goal:** Correctly manage the call stack for local variables and function calls.
    *   **Details:** Implement proper stack frame setup and teardown (e.g., `push rbp`, `mov rbp, rsp`, stack space allocation for local variables, `pop rbp`).
*   **Assembly for Arithmetic:**
    *   **Goal:** Generate correct x86-64 instructions for all arithmetic operations.
    *   **Details:** Map IR arithmetic instructions to corresponding x86-64 instructions (e.g., `add`, `sub`, `imul`, `idiv`).
*   **Assembly for Control Flow:**
    *   **Goal:** Translate conditional and loop IR into branching assembly.
    *   **Details:** Generate jump instructions (`jmp`, `je`, `jne`, etc.) and labels to implement `if` and loop constructs.
*   **Assembly for Function Calls:**
    *   **Goal:** Implement correct x86-64 calling conventions.
    *   **Details:** Generate assembly for passing arguments, making function calls (`call`), and handling return values according to the System V AMD64 ABI (or a simplified version).

### Phase 4: Testing and Refinement

**Goal:** To ensure the correctness, stability, and robustness of the compiler through rigorous testing and continuous improvement.

**Modules Involved:** All modules, test scripts/framework

**Tasks:**

*   **Unit Tests:**
    *   **Goal:** Verify the correctness of individual compiler components.
    *   **Details:** Write comprehensive unit tests for the lexer, parser, semantic analyzer, IR generator, and code generator. Use OCaml's testing frameworks (e.g., Alcotest, OUnit).
*   **Integration Tests:**
    *   **Goal:** Validate the entire compilation pipeline with more complex C programs.
    *   **Details:** Create a suite of C test programs covering various language features and edge cases. Automate the compilation and execution of these tests, comparing output with expected results.
*   **Error Handling & Reporting:**
    *   **Goal:** Provide clear, precise, and user-friendly error messages.
    *   **Details:** Continue to refine error reporting at all stages of the compiler, including line and column numbers, and context-specific messages.
*   **Optimization (Future Consideration):**
    *   **Goal:** Improve the performance of the generated assembly code.
    *   **Details:** Explore basic optimizations such as constant folding, dead code elimination, and common subexpression elimination.

## 4. General Considerations

*   **Build System:** Continue to leverage `dune` for managing dependencies, compilation, and testing.
*   **Incremental Development:** Develop and test each feature and phase incrementally before moving to the next.
*   **Documentation:** Maintain clear internal documentation for complex algorithms, data structures, and design decisions.
*   **Version Control:** Utilize Git for version control, committing small, logical changes frequently.
