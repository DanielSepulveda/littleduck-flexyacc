%{
  void yyerror(const char *s);
  #include <stdio.h>
  #include <stdlib.h>
  extern FILE* yyin;
  int yylex();
%}

%token PROGRAM VAR IF ELSE PRINT TYPE MULOP
%token ADOP STRING INTEGER FLOAT IDENTIFIER
%token LT GT NE SEMI COLON COMA
%token LP RP LB RB EQ

%start programa

%%

vars: 
  | VAR var_declaration
  ;

var_declaration: vars_declaration_1
  | vars_declaration_1 var_declaration
  ;

vars_declaration_1: var_list COLON TYPE SEMI
  ;

var_list: IDENTIFIER
  | IDENTIFIER COMA var_list
  ;

cte: IDENTIFIER
  | INTEGER
  | FLOAT
  ;

factor: LP expresion RP
  | ADOP cte
  | cte
  ;

termino: termino MULOP factor
  | factor
  ;

exp: exp ADOP termino
  | termino
  ;

conditional_exp: GT exp
  | LT exp
  | NE exp
  ;

expresion: exp
  | exp conditional_exp
  ;

bloque_body: bloque_body estatuto
  | estatuto
  ;

bloque: LB bloque_body RB
  ;

print_stmt: expresion
  | STRING
  ;

escritura: PRINT LP print_list RP SEMI
  ;

print_list: print_stmt COMA print_list
  | print_stmt
  ;

asignacion: IDENTIFIER EQ expresion SEMI
  ;

else_condicion: ELSE bloque
  ;

condicion: IF LP expresion RP bloque condicion_1
  ;

condicion_1: else_condicion SEMI
  | SEMI
  ;

estatuto: asignacion
  | condicion
  | escritura
  ;

programa: PROGRAM IDENTIFIER SEMI vars bloque {fprintf(stdout, "ok!\n");}
  ;

%%

int main() {
	yyin = fopen("test.txt", "r");
  yyparse();
  fclose(yyin);
  return 0;
}

void yyerror(const char* s) {
	fprintf(stderr, "Parse error: %s\n", s);
	exit(1);
}
