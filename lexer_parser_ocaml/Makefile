CC=ocamlc.opt
NATIVECC=ocamlopt.opt
YACC=ocamlyacc
LEX=ocamllex
RM=rm

program: lexer.cmo parser.cmo
	$(CC) -w A -o program parser.cmo lexer.cmo

lexer.cmo: lexer.ml
	$(CC) -w A -c lexer.ml

parser.cmo: parser.ml
	$(CC) -w A -c parser.ml

lexer.ml: lexer.mll parser.cmi
	$(LEX) lexer.mll

parser.cmi: parser.mli
	$(CC) -w A -c parser.mli

parser.mli: parser.mly
	$(YACC) parser.mly

.PHONY: clean
clean:
	$(RM) -vf *.cm[xoi] *.o program parser.mli parser.ml lexer.ml main.byte main.native


MAINFLAGS=-I /Users/oliver/opt/llvm/current/lib/ocaml

main.byte: main.ml
	$(CC) -cc g++ $(MAINFLAGS) -w A llvm.cma main.ml -o main.byte

main.native: main.ml
	$(NATIVECC) -cc g++ $(MAINFLAGS) -w A llvm.cmxa main.ml -o main.native

