CC = cc
CFLAGS = -Wall
#LDFLAGS = -ll
LDFLAGS =
LEX = flex
YACC = bison

all: link

link: compile
	$(CC) -o parser *.o $(LDFLAGS)

compile: lexer parser
	$(CC) -c $(CFLAGS) *.c

lexer: lexer.l
	$(LEX) lexer.l

parser: parser.y
	$(YACC) -d parser.y

clean:
	rm -vf parser *.o lex.yy.c parser.tab.c

