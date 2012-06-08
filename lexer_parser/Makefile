CC = clang
CXX = clang++
CFLAGS = -Wall -DYYDEBUG=1
#LDFLAGS = -ll
LDFLAGS = -Wall
LEX = flex
YACC = bison

all: link

link: compile
	$(CXX) -o parser *.o $(LDFLAGS)

compile: lexer parser
	$(CC) -c $(CFLAGS) lexer.c
	$(CXX) -c $(CFLAGS) parser.cc

lexer: lexer.l
	$(LEX) -o lexer.c lexer.l

parser: parser.yy
	$(YACC) -v -g -d -o parser.cc parser.yy

clean:
	rm -vf parser *.o lex.yy.c lexer.c parser.tab.c parser.tab.h lexer.cc parser.cc parser.hh parser.output parser.dot

