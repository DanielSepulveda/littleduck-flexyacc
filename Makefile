all: lang

y.tab.c y.tab.h: parser.y
	yacc -d parser.y

lex.yy.c: scanner.l y.tab.h
	lex scanner.l

lang: lex.yy.c y.tab.c y.tab.h
	gcc lex.yy.c y.tab.c -o lang

clean:
	rm lang lex.yy.c y.tab.c y.tab.h
