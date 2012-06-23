%{
#include <iostream>
#include "parser_help.hh"

using std::cout;
using std::cerr;
using std::endl;
using std::string;

int level = 0;

extern "C" {
	int yylex( void );
	int yywrap() {
		return 1;
	}
}

extern int yydebug;
extern int yyparse( void );

void yyerror( const char* str ) {
	cerr <<  "error: " << str << endl;
	_exit(1);
}

int main( int argc, char* argv[] ) {
	//yydebug = 1;
	yyparse();
	print_symbols();
	print_nodes();
	return 0;
}
%}

%union {
	int number;
	char* string;
}

%token DEFFN PRINT OPAREN CPAREN
%token <string> IDENTIFIER
%token <number> NUMBER

%type <string> function
%type <string> message

%start program

%%

program:
	| program expression
	;

expression:
	{ level++; } OPAREN operation CPAREN { level--; }
	;

operation:
	DEFFN function { cout << level << " found definition for function: " << $2 << endl; store_symbol( $2 ); store_node_deffn( $2 ); } args
	| PRINT message { cout << level << " message: " << $2 << endl; }
	| function { cout << level << " found function call: " << $1 << endl; if ( !check_function( $1 ) ) { yyerror( "undefined function" ); } } args
	;

args:
	| args IDENTIFIER { cout << level << " args identifier: " << $2 << endl; }
	| args NUMBER { cout << level << " args number: " << $2 << endl; }
	| args { cout << level << " args expression begin" << endl; } expression { cout << level << " args expression end" << endl; }
	;

function: IDENTIFIER

message: IDENTIFIER

