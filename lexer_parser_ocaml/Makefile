CC=ocamlc.opt
NATIVECC=ocamlopt.opt
OCAMLBUILD=ocamlbuild
YACC=ocamlyacc
LEX=ocamllex
RM=rm
LLVMAS=llvm-as
LLC=llc
CLANG=clang
USERHOME=$(shell echo $$HOME)

program: lexer.cmo parser.cmo
	$(CC) -w A -o program parser.cmo lexer.cmo


lexer.cmo: lexer.ml
	$(CC) -w A -c lexer.ml

lexer.ml: lexer.mll parser.cmi
	$(LEX) lexer.mll


parser.cmo: parser.mli parser.cmi ast.cmo
	$(CC) -w A -c parser.ml

parser.cmi: parser.mli
	$(CC) -w A -c parser.mli

parser.mli: parser.mly
	$(YACC) parser.mly


ast.cmo: ast.ml ast.cmi
	$(CC) -w A -c ast.ml

ast.cmi: ast.mli
	$(CC) -w A -c ast.mli


.PHONY: clean
clean:
	$(OCAMLBUILD) -clean
	$(RM) -vf *.cm[xoi] *.o program parser.mli parser.ml lexer.ml main.byte main.native main-program*


#MAINFLAGS=-I $(USERHOME)/opt/llvm/current/lib/ocaml

main.byte: main.ml
	$(OCAMLBUILD) -cflags -cc,g++,-I,$(USERHOME)/opt/llvm/current/lib/ocaml -lflags -cc,g++,-I,$(USERHOME)/opt/llvm/current/lib/ocaml -lib llvm main.byte
	#$(CC) -cc g++ $(MAINFLAGS) -w A llvm.cma main.ml -o main.byte

main.native: main.ml
	$(OCAMLBUILD) -cflags -cc,g++,-I,$(USERHOME)/opt/llvm/current/lib/ocaml -lflags -cc,g++,-I,$(USERHOME)/opt/llvm/current/lib/ocaml -lib llvm main.native
	#$(NATIVECC) -cc g++ $(MAINFLAGS) -w A llvm.cmxa main.ml -o main.native


main-program.ll: main.native
	./main.native 2>main-program.ll

main-program.bc: main-program.ll
	$(LLVMAS) main-program.ll

main-program.s: main-program.bc
	$(LLC) main-program.bc

main-program: main-program.s
	$(CLANG) -O0 -o main-program main-program.s -lm

