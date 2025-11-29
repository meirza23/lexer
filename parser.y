/* parser.y */
%{
#include <stdio.h>
#include <stdlib.h>
#include "ast.h"

extern int yylex();
extern int yyparse();
extern FILE* yyin;
void yyerror(const char* s);

ASTNode* root;
%}

%union {
    char* sval;
    struct ASTNode* node;
}

%token <sval> TOKEN_ID TOKEN_NUMBER TOKEN_STRING TOKEN_OP
%token TOKEN_INT TOKEN_FLOAT TOKEN_IF TOKEN_ELSE TOKEN_WHILE TOKEN_RETURN
%token TOKEN_LBRACE TOKEN_RBRACE TOKEN_SEMI TOKEN_EQ

%type <node> program function_def statement_list statement var_decl assignment if_stmt func_call return_stmt

%left TOKEN_OP

%%

program:
    function_def { root = $1; }
    ;

/* Main fonksiyonu gibi yapilari yakalar: int main() { ... } */
function_def:
    TOKEN_INT TOKEN_ID '(' ')' TOKEN_LBRACE statement_list TOKEN_RBRACE {
        $$ = createNode(NODE_FUNC_DEF, $2, $6, NULL);
    }
    ;

statement_list:
    statement { $$ = $1; }
    | statement statement_list { $$ = $1; $$->next = $2; }
    ;

statement:
    var_decl { $$ = $1; }
    | assignment { $$ = $1; }
    | if_stmt { $$ = $1; }
    | func_call { $$ = $1; }
    | return_stmt { $$ = $1; }
    ;

var_decl:
    TOKEN_INT TOKEN_ID TOKEN_EQ TOKEN_NUMBER TOKEN_SEMI {
        ASTNode* idNode = createNode(NODE_ID, $2, NULL, NULL);
        ASTNode* valNode = createNode(NODE_CONST, $4, NULL, NULL);
        $$ = createNode(NODE_VAR_DECL, "int", idNode, valNode);
    }
    | TOKEN_FLOAT TOKEN_ID TOKEN_EQ TOKEN_NUMBER TOKEN_SEMI {
        ASTNode* idNode = createNode(NODE_ID, $2, NULL, NULL);
        ASTNode* valNode = createNode(NODE_CONST, $4, NULL, NULL);
        $$ = createNode(NODE_VAR_DECL, "float", idNode, valNode);
    }
    ;

assignment:
    TOKEN_ID TOKEN_EQ TOKEN_NUMBER TOKEN_SEMI {
        ASTNode* idNode = createNode(NODE_ID, $1, NULL, NULL);
        ASTNode* valNode = createNode(NODE_CONST, $3, NULL, NULL);
        $$ = createNode(NODE_ASSIGN, "=", idNode, valNode);
    }
    ;

if_stmt:
    TOKEN_IF '(' TOKEN_ID TOKEN_OP TOKEN_ID ')' TOKEN_LBRACE statement_list TOKEN_RBRACE TOKEN_ELSE TOKEN_LBRACE statement_list TOKEN_RBRACE {
        /* Basitlik olsun diye expression kismini ID OP ID yaptim */
        ASTNode* leftID = createNode(NODE_ID, $3, NULL, NULL);
        ASTNode* rightID = createNode(NODE_ID, $5, NULL, NULL);
        ASTNode* condition = createNode(NODE_OP, $4, leftID, rightID);
        
        // If'in solu condition, sağı True blogu, next'i Else blogu olsun (basitlestirilmis)
        ASTNode* ifNode = createNode(NODE_IF, "if", condition, $8);
        ifNode->next = $12; // Else blogu
        $$ = ifNode;
    }
    ;

/* printf("...", ...); yakalamak icin */
func_call:
    TOKEN_ID '(' TOKEN_STRING ')' TOKEN_SEMI {
        ASTNode* strNode = createNode(NODE_STRING, $3, NULL, NULL);
        $$ = createNode(NODE_FUNC_CALL, $1, strNode, NULL);
    }
    ;

return_stmt:
    TOKEN_RETURN TOKEN_NUMBER TOKEN_SEMI {
         $$ = createNode(NODE_OP, "return", NULL, NULL);
    }
    ;

%%

void yyerror(const char* s) {
    fprintf(stderr, "Hata: %s\n", s);
}

int main(int argc, char* argv[]) {
    if (argc > 1) {
        FILE* file = fopen(argv[1], "r");
        if (!file) {
            perror("Dosya acilamadi");
            return 1;
        }
        yyin = file;
    }
    yyparse();
    printAST(root, 0);
    return 0;
}