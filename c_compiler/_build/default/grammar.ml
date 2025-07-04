
(* This generated code requires the following version of MenhirLib: *)

let () =
  MenhirLib.StaticVersion.require_20240715

module MenhirBasics = struct
  
  exception Error
  
  let _eRR =
    fun _s ->
      raise Error
  
  type token = Tokens.token
  
end

include MenhirBasics

# 6 "grammar.mly"
  
  open Tokens

# 26 "grammar.ml"

module Tables = struct
  
  include MenhirBasics
  
  let token2terminal : token -> int =
    fun _tok ->
      match _tok with
      | Tokens.EOF ->
          14
      | Tokens.IDENTIFIER ->
          13
      | Tokens.INT ->
          12
      | Tokens.INT_LITERAL ->
          11
      | Tokens.LBRACE ->
          10
      | Tokens.LPAREN ->
          9
      | Tokens.MINUS ->
          8
      | Tokens.PLUS ->
          7
      | Tokens.RBRACE ->
          6
      | Tokens.RETURN ->
          5
      | Tokens.RPAREN ->
          4
      | Tokens.SEMICOLON ->
          3
      | Tokens.SLASH ->
          2
      | Tokens.STAR ->
          1
  
  and error_terminal =
    0
  
  and token2value : token -> Obj.t =
    fun _tok ->
      match _tok with
      | Tokens.EOF ->
          Obj.repr ()
      | Tokens.IDENTIFIER ->
          Obj.repr ()
      | Tokens.INT ->
          Obj.repr ()
      | Tokens.INT_LITERAL ->
          Obj.repr ()
      | Tokens.LBRACE ->
          Obj.repr ()
      | Tokens.LPAREN ->
          Obj.repr ()
      | Tokens.MINUS ->
          Obj.repr ()
      | Tokens.PLUS ->
          Obj.repr ()
      | Tokens.RBRACE ->
          Obj.repr ()
      | Tokens.RETURN ->
          Obj.repr ()
      | Tokens.RPAREN ->
          Obj.repr ()
      | Tokens.SEMICOLON ->
          Obj.repr ()
      | Tokens.SLASH ->
          Obj.repr ()
      | Tokens.STAR ->
          Obj.repr ()
  
  and default_reduction =
    (2, "$")
  
  and error =
    (15, "\000\002\000\000\000\000")
  
  and start =
    1
  
  and action =
    ((8, "\029\000\000"), (4, "p"))
  
  and lhs =
    (1, "@")
  
  and goto =
    ((2, "\192"), (2, "\192"))
  
  and semantic_action =
    [|
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = _1;
          MenhirLib.EngineTypes.startp = _startpos__1_;
          MenhirLib.EngineTypes.endp = _endpos__1_;
          MenhirLib.EngineTypes.next = _menhir_stack;
        } = _menhir_stack in
        let _1 : unit = Obj.magic _1 in
        let _endpos__0_ = _menhir_stack.MenhirLib.EngineTypes.endp in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos__1_ in
        let _v : (
# 4 "grammar.mly"
      (unit)
# 135 "grammar.ml"
        ) = 
# 12 "grammar.mly"
             ( () )
# 139 "grammar.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
    |]
  
  and trace =
    None
  
end

module MenhirInterpreter = struct
  
  module ET = MenhirLib.TableInterpreter.MakeEngineTable (Tables)
  
  module TI = MenhirLib.Engine.Make (ET)
  
  include TI
  
end

let program =
  fun lexer lexbuf : (
# 4 "grammar.mly"
      (unit)
# 169 "grammar.ml"
  ) ->
    Obj.magic (MenhirInterpreter.entry `Legacy 0 lexer lexbuf)

module Incremental = struct
  
  let program =
    fun initial_position : (
# 4 "grammar.mly"
      (unit)
# 179 "grammar.ml"
    ) MenhirInterpreter.checkpoint ->
      Obj.magic (MenhirInterpreter.start 0 initial_position)
  
end
