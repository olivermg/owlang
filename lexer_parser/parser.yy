%{
#include <iostream>
#include <vector>
#include "nodes.hh"

using std::cout;
using std::cerr;
using std::endl;
using std::vector;
using std::string;

vector<string> symbols;
vector<Node*> nodes;

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
}

static void store_symbol( const char* symbolname ) {
	string name( symbolname );
	symbols.push_back( name );
}

static void print_symbols() {
	cout << "stored symbols:" << endl;
	symbols.begin();
	while ( !symbols.empty() ) {
		cout << "  " << symbols.back() << endl;
		symbols.pop_back();
	}
}

static void store_node( const char* name, const char* type ) {
	string _name( name );
	string _type( type );

	Node* node = new Node();
	node->name = _name;
	node->type = _type;
	nodes.push_back( node );
}

static void print_nodes() {
	cout << "stored nodes:" << endl;
	nodes.begin();
	while ( !nodes.empty() ) {
		Node* node = nodes.back();
		cout << "  " << node->name << ", " << node->type << endl;
		nodes.pop_back();
	}
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
	DEFFN function { cout << level << " found definition for function: " << $2 << endl; store_symbol( $2 ); store_node( $2, "function" ); } args
	| function { cout << level << " found function call: " << $1 << endl; } args
	;

args:
	| args IDENTIFIER { cout << level << " args identifier: " << $2 << endl; }
	| args NUMBER { cout << level << " args number: " << $2 << endl; }
	| args { cout << level << " args expression begin" << endl; } expression { cout << level << " args expression end" << endl; }
	;

function: IDENTIFIER

