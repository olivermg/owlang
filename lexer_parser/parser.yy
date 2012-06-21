%{
#include <iostream>
#include <vector>
#include <typeinfo>
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

static void store_node_deffn( const char* funcname ) {
	string _name( funcname );

	FunctionDefinitionNode* node = new FunctionDefinitionNode( _name );
	nodes.push_back( node );
}

static void print_nodes() {
	cout << "stored nodes:" << endl;
	nodes.begin();
	while ( !nodes.empty() ) {
		Node* node = nodes.back();
		cout << "  " << typeid( *node ).name();
		//if ( typeid) {
		//cout << "  " << node->name << ", " << node->type << endl;
		//}
		cout << endl;
		nodes.pop_back();
	}
}

static int check_function( const char* funcname ) {
	int found = 0;

	cout << "checking for function " << funcname << endl;
	nodes.begin();
	for ( int i = 0; i < nodes.size(); i++ ) {
		FunctionDefinitionNode* fdnode = (FunctionDefinitionNode*) nodes.at( i );
		if ( fdnode->getName().compare( funcname ) == 0 ) {
			cout << "found function!" << endl;
			found = 1;
		}
	}
	return found;
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
	DEFFN function { cout << level << " found definition for function: " << $2 << endl; store_symbol( $2 ); store_node_deffn( $2 ); } args
	| function { cout << level << " found function call: " << $1 << endl; if ( !check_function( $1 ) ) { yyerror( "undefined function" ); } } args
	;

args:
	| args IDENTIFIER { cout << level << " args identifier: " << $2 << endl; }
	| args NUMBER { cout << level << " args number: " << $2 << endl; }
	| args { cout << level << " args expression begin" << endl; } expression { cout << level << " args expression end" << endl; }
	;

function: IDENTIFIER

