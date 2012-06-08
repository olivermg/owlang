CC = clang
CXX = clang++
CFLAGS = -Wall -DYYDEBUG=1
LDFLAGS = -Wall
LEX = flex
YACC = bison

all: parser

parser: lexer.o parser.o
	$(CXX) -o parser lexer.o parser.o $(LDFLAGS)

lexer.o: lexer.c parser.cc
	$(CC) -c $(CFLAGS) lexer.c

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

