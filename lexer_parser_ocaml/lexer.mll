{
	open Parser
}

rule token = parse
	| [ ' ' '\t' '\n' ]+ { token lexbuf }
	| [ '0' - '9' ]+ { NUMBER }
	| "set" { SET }
	(* | _ { token lexbuf } *)
	| eof { EOF }

{
        let main () =
                let lexbuf = Lexing.from_channel stdin in
                Parser.program token lexbuf;
                Printf.printf "\nend of parsing.\n"

        let _ = Printexc.print main ()
}

