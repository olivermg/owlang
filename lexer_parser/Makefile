CC = clang
CXX = clang++
CFLAGS = -Wall -DYYDEBUG=1 `llvm-config --cppflags`
LDFLAGS = -Wall `llvm-config --ldflags --libs core`
LEX = flex
YACC = bison

all: parser

parser: lexer.o parser_help.o parser.o nodes.o
	$(CXX) -o parser lexer.o parser_help.o parser.o nodes.o $(LDFLAGS)

nodes.o: nodes.cc nodes.hh
	$(CXX) -c $(CFLAGS) nodes.cc

lexer.o: lexer.c parser.cc
	$(CC) -c $(CFLAGS) lexer.c

parser_help.o: parser_help.cc parser_help.hh
	$(CXX) -c $(CFLAGS) parser_help.cc

parser.o: parser.cc parser.hh
	$(CXX) -c $(CFLAGS) parser.cc

lexer.c: lexer.l
	$(LEX) -o lexer.c lexer.l

parser.hh: parser.cc

parser.cc: parser.yy
	$(YACC) -v -g -d -o parser.cc parser.yy

.PHONY: clean
clean:
	rm -vf parser *.o lex.yy.c lexer.c parser.tab.c parser.tab.h lexer.cc parser.cc parser.hh parser.output parser.dot

