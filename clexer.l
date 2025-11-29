/* clexer.l */
%{
#include <stdio.h>
#include <string.h>
#include "ast.h"
#include "parser.tab.h"
%}

%%

^"#".* { /* Preprocessor (include vs) yutuluyor, islem yapma */ }

"int"       { return TOKEN_INT; }
"float"     { return TOKEN_FLOAT; }
"if"        { return TOKEN_IF; }
"else"      { return TOKEN_ELSE; }
"while"     { return TOKEN_WHILE; }
"return"    { return TOKEN_RETURN; } /* Return eklendi */

[0-9]+(\.[0-9]+)? { 
    yylval.sval = strdup(yytext); 
    return TOKEN_NUMBER; 
}

\"([^\\\"]|\\.)*\" { 
    yylval.sval = strdup(yytext); 
    return TOKEN_STRING; /* String literal eklendi */
}

[a-zA-Z_][a-zA-Z0-9_]* { 
    yylval.sval = strdup(yytext); 
    return TOKEN_ID; 
}

"//".* { } /* Yorum satiri yut */
[ \t\n]+    { } /* Bosluk yut */

"="         { return TOKEN_EQ; }
"=="|"!="|"<"|">"|"+"|"-"|"*"|"/" { 
    yylval.sval = strdup(yytext);
    return TOKEN_OP; 
}

";" { return TOKEN_SEMI; }
"{" { return TOKEN_LBRACE; }
"}" { return TOKEN_RBRACE; }
"(" { return '('; }
")" { return ')'; }
"," { return ','; }

.   { printf("Bilinmeyen karakter: %s\n", yytext); }

%%

int yywrap(void) { return 1; }