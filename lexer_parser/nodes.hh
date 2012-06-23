#include <string>
#include <llvm/Value.h>

using std::string;
using llvm::Value;

class Node {
	public:
	virtual ~Node();
	virtual Value* codeGen();
};

class FunctionDefinitionNode: public Node {
	private:
	string name;

	public:
	FunctionDefinitionNode( string funcname );
	virtual string getName();
};

class FunctionCallNode: public Node {
	private:
	string name;

	public:
	FunctionCallNode( string funcname );
	virtual string getName();
};

