
(* This generated code requires the following version of MenhirLib: *)

let () =
  MenhirLib.StaticVersion.require_20240715

module MenhirBasics = struct
  
  exception Error
  
  let _eRR =
    fun _s ->
      raise Error
  
  type token = Parser.token
  
end

include MenhirBasics

module Tables = struct
  
  include MenhirBasics
  
  let token2terminal : token -> int =
    fun _tok ->
      match _tok with
      | Parser.EOF ->
          14
      | Parser.IDENTIFIER _ ->
          13
      | Parser.INT ->
          12
      | Parser.INT_LITERAL _ ->
          11
      | Parser.LBRACE ->
          10
      | Parser.LPAREN ->
          9
      | Parser.MINUS ->
          8
      | Parser.PLUS ->
          7
      | Parser.RBRACE ->
          6
      | Parser.RETURN ->
          5
      | Parser.RPAREN ->
          4
      | Parser.SEMICOLON ->
          3
      | Parser.SLASH ->
          2
      | Parser.STAR ->
          1
  
  and error_terminal =
    0
  
  and token2value : token -> Obj.t =
    fun _tok ->
      match _tok with
      | Parser.EOF ->
          Obj.repr ()
      | Parser.IDENTIFIER _v ->
          Obj.repr _v
      | Parser.INT ->
          Obj.repr ()
      | Parser.INT_LITERAL _v ->
          Obj.repr _v
      | Parser.LBRACE ->
          Obj.repr ()
      | Parser.LPAREN ->
          Obj.repr ()
      | Parser.MINUS ->
          Obj.repr ()
      | Parser.PLUS ->
          Obj.repr ()
      | Parser.RBRACE ->
          Obj.repr ()
      | Parser.RETURN ->
          Obj.repr ()
      | Parser.RPAREN ->
          Obj.repr ()
      | Parser.SEMICOLON ->
          Obj.repr ()
      | Parser.SLASH ->
          Obj.repr ()
      | Parser.STAR ->
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
# 6 "parser.mly"
      (unit)
# 129 "parser.ml"
        ) = 
# 10 "parser.mly"
             ( () )
# 133 "parser.ml"
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
# 6 "parser.mly"
      (unit)
# 163 "parser.ml"
  ) ->
    Obj.magic (MenhirInterpreter.entry `Legacy 0 lexer lexbuf)

module Incremental = struct
  
  let program =
    fun initial_position : (
# 6 "parser.mly"
      (unit)
# 173 "parser.ml"
    ) MenhirInterpreter.checkpoint ->
      Obj.magic (MenhirInterpreter.start 0 initial_position)
  
end
