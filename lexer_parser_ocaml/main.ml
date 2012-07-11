open Printf
open Llvm

let context = global_context ()
let the_module = create_module context "yeah cool jit"
let bld = builder context
let dbl_type = double_type context
let owi32_type = i32_type context

let main _ =
	let maint = function_type owi32_type [| owi32_type |] in
	let mainfn = define_function "main" maint the_module in
	let entrybb = entry_block mainfn in
	position_at_end entrybb bld;
	let v1 = const_float dbl_type 3.0 in
	let v2 = const_float dbl_type 4.0 in
	let v3 = const_int owi32_type 5 in
	let vadd = build_fadd v1 v2 "addtmp" bld in
	(*let i = build_fcmp Fcmp.Ult v1 v2 "cmptmp" bld in*)
	let fnt = function_type dbl_type [| dbl_type; dbl_type |] in
	let fn = define_function "fntmp" fnt the_module in
	let entryfnbb = entry_block fn in
	position_at_end entryfnbb bld;
	let retfn = build_ret vadd bld in
	position_at_end entrybb bld;
	let fn2 = declare_function "fn2tmp" fnt the_module in
	let call = build_call fn [| v1; v2 |] "calltmp" bld in
	let call2 = build_call fn2 [| v1; v2 |] "call2tmp" bld in
	let ret = build_ret v3 bld in
	(*set_value_name "var1" v1;
	printf "name of value v1: %s\n" (value_name v1);
	dump_value vadd;
	dump_value i;
	dump_value fn;
	dump_value call;
	dump_value fn2;
	dump_value call2;*)
	set_linkage Linkage.External fn2;
	dump_module the_module

let _ = Printexc.print main ()

