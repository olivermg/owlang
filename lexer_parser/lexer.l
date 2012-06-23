%{
#include <stdio.h>
#include "parser.hh"
%}

%%

deffn					{ return DEFFN; }
print					{ return PRINT; }
\(					{ return OPAREN; }
\)					{ return CPAREN; }
[0-9]+					{ yylval.number = atoi( yytext ); return NUMBER; }
[a-zA-Z][a-zA-Z0-9]*			{ yylval.string = yytext; return IDENTIFIER; }
[ \t\n]+				/* ignore whitespace */;
.					{ fprintf( stderr, "unknown token found.\n" ); yyterminate(); }

%%

