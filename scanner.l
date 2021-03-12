%{
  #include "y.tab.h"
%}

%%
program                           return PROGRAM;
var                               return VAR;
if                                return IF;
else                              return ELSE;
print                             return PRINT;
int|float                         return TYPE;
"<"                               return LT;
">"                               return GT;
"<>"                              return NE;
";"                               return SEMI;
":"                               return COLON;
","                               return COMA;
"("                               return LP;
")"                               return RP;
"{"                               return LB;
"}"                               return RB;
"="                               return EQ;
"*"|"/"                           return MULOP;
"+"|"-"                           return ADOP;
\"[^\"]*\"                        return STRING;
[1-9][0-9]*                       return INTEGER;
[1-9][0-9]*"."[0-9]+              return FLOAT;
[a-zA-Z][_a-zA-Z0-9]*             return IDENTIFIER;
[ \t\n]                           ;
%%

int yywrap(void)
{
  return 1;
}
