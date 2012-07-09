open Printf
open Llvm

let context = global_context ()
let the_module = create_module context "yeah cool jit"
let builder = builder context
let double_type = double_type context

let main _ = let v1 = const_float double_type 3.0 in
	let v2 = const_float double_type 4.0 in
	let vadd = build_fadd v1 v2 "addtmp" builder in
	set_value_name "var1" v1;
	printf "name of value v1: %s\n" (value_name v1);
	dump_value vadd;
	dump_module the_module

let _ = Printexc.print main ()

