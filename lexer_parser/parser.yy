%{
#include <iostream>
#include <vector>

std::vector<std::string> symbols;
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
	std::cerr <<  "error: " << str << std::endl;
}

static void store_symbol( const char* symbolname ) {
	std::string name( symbolname );
	symbols.push_back( name );
}

static void print_symbols() {
	std::cout << "stored symbols:" << std::endl;
	symbols.begin();
	while ( !symbols.empty() ) {
		std::cout << "  " << symbols.back() << std::endl;
		symbols.pop_back();
	}
}

int main( int argc, char* argv[] ) {
	//yydebug = 1;
	yyparse();
	print_symbols();
	return 0;
}
%}

%union {
	int number;
	char* string;
}

%token DEFFN OPAREN CPAREN
%token <string> IDENTIFIER
%token <number> NUMBER

%type <string> function

%start program

%%

program:
	| program expression
	;

expression:
	{ level++; } OPAREN operation CPAREN { level--; }
	;

operation:
	DEFFN function { std::cout << level << " found definition for function: " << $2 << std::endl; store_symbol( $2 ); } args
	| function { std::cout << level << " found function call: " << $1 << std::endl; } args
	;

args:
	| args IDENTIFIER { std::cout << level << " args identifier: " << $2 << std::endl; }
	| args NUMBER { std::cout << level << " args number: " << $2 << std::endl; }
	| args { std::cout << level << " args expression begin" << std::endl; } expression { std::cout << level << " args expression end" << std::endl; }
	;

function: IDENTIFIER

