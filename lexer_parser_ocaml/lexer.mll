{
	open Parser
}

rule token = parse
	| "deffn" { DEFFN }
	| "print" { PRINT }
	| '(' { OPAREN }
	| ')' { CPAREN }
	| [ '0' - '9' ]+ as num { NUMBER (int_of_string num) }
	| [ 'a' - 'z' ][ 'a' - 'z' 'A' - 'Z' '0' - '9' ]* as id { IDENTIFIER id }
	| [ ' ' '\t' '\n' ]+ { token lexbuf }
	| eof { EOF }
	(* | _ { token lexbuf } *)

{
        let main () =
                let lexbuf = Lexing.from_channel stdin in
                Parser.program token lexbuf;
                Printf.printf "\nend of parsing.\n"

        let _ = Printexc.print main ()
}

