%token SET NUMBER EOF

%type <unit> program expression

%start program

%%

program: { }
	| program expression { }
	;

expression:
	SET NUMBER { }
	;

%%

