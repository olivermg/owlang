#include <cstdio>
#include <string>
#include <map>

#include <llvm/LLVMContext.h>
#include <llvm/BasicBlock.h>
#include <llvm/DerivedTypes.h>
#include <llvm/Module.h>
#include <llvm/GlobalValue.h>
#include <llvm/Value.h>
#include <llvm/Support/IRBuilder.h>
#include <llvm/Support/TypeBuilder.h>

int main( int argc, char* argv[] ) {
	llvm::LLVMContext &Context = llvm::getGlobalContext();
	llvm::Module *theModule;
	llvm::IRBuilder<> builder( Context );
	std::map<std::string, llvm::Value*> namedValue;


	theModule = new llvm::Module( "my cool prog", Context );

	llvm::FunctionType *mainType = llvm::TypeBuilder<llvm::types::i<32>(llvm::types::i<32>), true>::get( Context );
	llvm::Function *mainFunc = llvm::Function::Create( mainType, llvm::Function::ExternalLinkage, "main", theModule );
	llvm::BasicBlock* bb = llvm::BasicBlock::Create( Context, "main", mainFunc );

	llvm::Value* val1 = llvm::ConstantInt::get( Context, llvm::APInt( 32, 1 ) );
	llvm::Value* val2 = llvm::ConstantInt::get( Context, llvm::APInt( 32, 233 ) );
	llvm::Value* valAdd = builder.CreateAdd( val1, val2, "myadd1" );

	llvm::BasicBlock* bbl = llvm::BasicBlock::Create( Context, "left", mainFunc );
	builder.SetInsertPoint( bbl );
	llvm::Value* valLeft = builder.CreateAdd( val1, val1 );
	builder.CreateRet( valLeft );

	llvm::BasicBlock* bbr = llvm::BasicBlock::Create( Context, "right", mainFunc );
	builder.SetInsertPoint( bbr );
	llvm::Value* valRight = builder.CreateAdd( val2, val2 );
	builder.CreateRet( valRight );

	builder.SetInsertPoint( bb );
	llvm::Value* val1EQval2 = builder.CreateICmpEQ( val1, val2 );
	builder.CreateCondBr( val1EQval2, bbl, bbr );
	builder.CreateRet( valAdd );

	theModule->dump();
	//mainFunc->dump();
	//bb->dump();
	//val1->dump();
	//val2->dump();
	//valAdd->dump();

	return 0;
}

