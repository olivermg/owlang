#include <iostream>
#include <vector>
#include <typeinfo>
#include "parser_help.hh"
#include "nodes.hh"

using std::cout;
using std::cerr;
using std::endl;
using std::vector;
using std::string;

vector<string> symbols;
vector<Node*> nodes;

void store_symbol( const char* symbolname ) {
	string name( symbolname );
	symbols.push_back( name );
}

void print_symbols() {
	cout << "stored symbols:" << endl;
	symbols.begin();
	while ( !symbols.empty() ) {
		cout << "  " << symbols.back() << endl;
		symbols.pop_back();
	}
}

void store_node_deffn( const char* funcname ) {
	string _name( funcname );

	FunctionDefinitionNode* node = new FunctionDefinitionNode( _name );
	nodes.push_back( node );
}

void print_nodes() {
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

int check_function( const char* funcname ) {
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

