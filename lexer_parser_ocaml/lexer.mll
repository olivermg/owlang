{
}

rule translate = parse
        | "current_directory" { print_string ( Sys.getcwd() ); translate lexbuf }
        | _ as c { print_char c; translate lexbuf }
        | eof { () }

{
        let main () =
                let lexbuf = Lexing.from_channel stdin in
                translate lexbuf;
                Printf.printf "bla"

        let _ = Printexc.print main ()
}

