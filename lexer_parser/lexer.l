%{
#include "parser.tab.h"
%}

%%

\(							return OPAREN;
\)							return CPAREN;
[0-9]+						return NUMBER;
[a-zA-Z][a-zA-Z0-9]*		return IDENTIFIER;
[ \t\n]+					;

%%

