#include "nodes.hh"

Node::~Node() {
}

Value* Node::codeGen() {
	return NULL;
}



FunctionDefinitionNode::FunctionDefinitionNode( string funcname ) {
	this->name = funcname;
}

string FunctionDefinitionNode::getName() {
	return name;
}



FunctionCallNode::FunctionCallNode( string funcname ) {
	this->name = funcname;
}

string FunctionCallNode::getName() {
	return name;
}

