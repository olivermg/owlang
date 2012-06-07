%{
#include <stdio.h>
#include <string.h>

int level = 0;

void yyerror( const char* str ) {
	fprintf( stderr, "error: %s\n", str );
}

int yywrap() {
	return 1;
}

int main( int argc, char* argv[] ) {
	yyparse();
	return 0;
}
%}

%token OPAREN CPAREN IDENTIFIER NUMBER

%%

program:
	| program expression
	;

expression:
	{ level++; } oparen function args cparen { level--; }
	;

args:
	| args identifier { printf( "%02d args identifier\n", level ); }
	| args number { printf( "%02d args number\n", level ); }
	| args { printf( "%02d args expression begin\n", level ); } expression { printf( "%02d args expression end\n", level ); }
	;

oparen: OPAREN
function: IDENTIFIER
identifier: IDENTIFIER
number: NUMBER
cparen: CPAREN

