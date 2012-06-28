CC=ocamlc
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
	$(RM) -vf *.cm[xoi] *.o program parser.mli parser.ml lexer.ml

