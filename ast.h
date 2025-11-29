/* ast.h */
#ifndef AST_H
#define AST_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef enum {
    NODE_PROGRAM,
    NODE_FUNC_DEF, // Main fonksiyonu icin
    NODE_VAR_DECL,
    NODE_ASSIGN,
    NODE_IF,
    NODE_WHILE,
    NODE_OP,
    NODE_CONST,
    NODE_ID,
    NODE_FUNC_CALL, // printf icin
    NODE_STRING     // "X daha buyuk" gibi stringler icin
} NodeType;

typedef struct ASTNode {
    NodeType type;
    char* val;
    struct ASTNode* left;
    struct ASTNode* right;
    struct ASTNode* next;
} ASTNode;

static ASTNode* createNode(NodeType type, char* val, ASTNode* left, ASTNode* right) {
    ASTNode* node = (ASTNode*)malloc(sizeof(ASTNode));
    node->type = type;
    if (val) node->val = strdup(val); else node->val = NULL;
    node->left = left;
    node->right = right;
    node->next = NULL;
    return node;
}

static void printAST(ASTNode* node, int level) {
    if (!node) return;
    for (int i = 0; i < level; i++) printf("  ");

    switch (node->type) {
        case NODE_PROGRAM: printf("Program root\n"); break;
        case NODE_FUNC_DEF: printf("Function Def: %s\n", node->val); break;
        case NODE_VAR_DECL: printf("VarDecl: %s\n", node->val); break;
        case NODE_ASSIGN: printf("Assign\n"); break;
        case NODE_OP: printf("Op: %s\n", node->val); break;
        case NODE_CONST: printf("Const: %s\n", node->val); break;
        case NODE_ID: printf("ID: %s\n", node->val); break;
        case NODE_IF: printf("If Statement\n"); break;
        case NODE_FUNC_CALL: printf("Function Call: %s\n", node->val); break;
        case NODE_STRING: printf("String: %s\n", node->val); break;
        default: printf("Node\n");
    }

    printAST(node->left, level + 1);
    printAST(node->right, level + 1);
    if (node->next) printAST(node->next, level);
}
#endif