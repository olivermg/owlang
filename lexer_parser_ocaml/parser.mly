%token DEFFN PRINT OPAREN CPAREN EOF
%token <string> IDENTIFIER
%token <int> NUMBER

%type <string> func
%type <string> message
%type <int list> args

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
	DEFFN func args { Printf.printf "defining function %s\n" $2;
		let rec f l = match l with
			[] -> ()
			| x::xs -> Printf.printf "%i " x; f xs; in
				f $3 }
	| PRINT message { Printf.printf "printing %s\n" $2 }
	| func args { Printf.printf "calling function %s\n" $1 }
	;

args: { [ 1 ] }
	| args IDENTIFIER { [ 2 ] }
	| args NUMBER { [ 3 ] }
	| args expression { [ 4 ] }
	;

func: IDENTIFIER  { $1 }
	;

message: IDENTIFIER { $1 }
	;

%%

