%{
	open Ast

	type argtype =
		Stringarg of string
		| Intarg of int

	let rec printargs l = match l with
		[] -> Printf.printf "\n"
		| Intarg n :: xs -> Printf.printf "%i " n; printargs xs
		| Stringarg s :: xs -> Printf.printf "%s " s; printargs xs
%}

%token DEFFN PRINT OPAREN CPAREN EOF
%token <string> IDENTIFIER
%token <int> NUMBER

%type <string> func
%type <string> message
%type <argtype list> args

%type <unit> program

%start program

%%

program: { }
	| program expression { }
	;

expression:
	OPAREN operation CPAREN { }
	;

operation:
	DEFFN func args { Printf.printf "defining function %s with args " $2; printargs $3 }
	| PRINT message { Printf.printf "printing %s\n" $2 }
	| func args { Printf.printf "calling function %s with args " $1; printargs $2 }
	;

args: { [ ] }
	| args IDENTIFIER { Stringarg $2 :: $1 }
	| args NUMBER { Intarg $2 :: $1 }
	| args expression { $1 }
	;

func: IDENTIFIER  { $1 }
	;

message: IDENTIFIER { $1 }
	;

%%

