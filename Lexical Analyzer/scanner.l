#include <stdio.h>
#include <string.h>
#include <stdlib.h>

enum {
    
    // Keywords
    LET = 258, VAR, FUNC, RETURN, IF, ELSE, FOR, IN, WHILE, REPEAT, SWITCH, CASE, DEFAULT, STRUCT,
    PRINT,
    
    // Type Names
    TYPE_INT, TYPE_DOUBLE, TYPE_BOOL, TYPE_CHAR, TYPE_STRING, TYPE_VOID,
    
    // Literals & Identifier
    IDENTIFIER, INT_LITERAL, DOUBLE_LITERAL, STRING_LITERAL, BOOL_LITERAL,
    
    // Relational and Logical Operators
    EQ, NEQ, LT, GT, LTE, GTE, AND, OR, NOT, ARROW,
    
    // Arithmetic Operators
    PLUS, MINUS, MULTIPLY, DIVIDE, MODULO,
    
    // Other Operators
    ASSIGN, DOT,
    
    // Delimiters
    LPAREN, RPAREN, LBRACE, RBRACE, LBRACKET, RBRACKET, SEMICOLON, COMMA, COLON
};

typedef union {
    int ival;
    double dval;
    int bval;
    char *sval;
} YYSTYPE;

YYSTYPE yylval;

%}

%option noyywrap
%option yylineno

DIGIT           [0-9]
LETTER          [a-zA-Z_]
IDENTIFIER_CHAR [a-zA-Z0-9_]

%%

[ \t\n]+	{ /* ignore whitespace */ }
"//".* 		{ /* ignore comments */ }

"let"		{ return LET; }
"var"		{ return VAR; }
"func"		{ return FUNC; }
"return"	{ return RETURN; }
"if"		{ return IF; }
"else"		{ return ELSE; }
"for"		{ return FOR; }
"in"		{ return IN; }
"while"		{ return WHILE; }
"repeat"	{ return REPEAT; }
"switch"	{ return SWITCH; }
"case"		{ return CASE; }
"default"	{ return DEFAULT; }
"struct"	{ return STRUCT; }
"print"		{ return PRINT; }

"Int"		{ return TYPE_INT; }
"Double"	{ return TYPE_DOUBLE; }
"Bool"		{ return TYPE_BOOL; }
"Character"	{ return TYPE_CHAR; }
"String"	{ return TYPE_STRING; }
"Void"		{ return TYPE_VOID; }

{DIGIT}+			{ yylval.ival = atoi(yytext); return INT_LITERAL; }
{DIGIT}+\.{DIGIT}+		{ yylval.dval = atof(yytext); return DOUBLE_LITERAL; }
\"[^"\n]*\"			{ yylval.sval = strdup(yytext); return STRING_LITERAL; }
"true"				{ yylval.bval = 1; return BOOL_LITERAL; }
"false"				{ yylval.bval = 0; return BOOL_LITERAL; }

{LETTER}{IDENTIFIER_CHAR}*	{ yylval.sval = strdup(yytext); return IDENTIFIER; }

"=="		{ return EQ; }
"!="		{ return NEQ; }
"<="		{ return LTE; }
">="		{ return GTE; }
"<"		{ return LT; }
">"		{ return GT; }
"&&"		{ return AND; }
"||"		{ return OR; }
"!"		{ return NOT; }
"->"		{ return ARROW; }

"+"		{ return PLUS; }
"-"		{ return MINUS; }
"*"		{ return MULTIPLY; }
"/"		{ return DIVIDE; }
"%"		{ return MODULO; }

"="		{ return ASSIGN; }
"."		{ return DOT; }

"("		{ return LPAREN; }
")"		{ return RPAREN; }
"{"		{ return LBRACE; }
"}"		{ return RBRACE; }
"["		{ return LBRACKET; }
"]"		{ return RBRACKET; }
";"		{ return SEMICOLON; }
","		{ return COMMA; }
":"		{ return COLON; }

.		{ printf("Unexpected character: %c\n", yytext[0]); }

%%

int main(int argc, char **argv) {
    if (argc > 1) {
        FILE *file = fopen(argv[1], "r");
        if (!file) {
            perror(argv[1]);
            return 1;
        }
        yyin = file;
    }

    int token;
    while ((token = yylex())) {
        printf("Line %d, Token: ", yylineno);
        switch (token) {
            // Keywords
            case LET: printf("LET"); break;
            case VAR: printf("VAR"); break;
            case FUNC: printf("FUNC"); break;
            case RETURN: printf("RETURN"); break;
            case IF: printf("IF"); break;
            case ELSE: printf("ELSE"); break;
            case FOR: printf("FOR"); break;
            case IN: printf("IN"); break;
            case WHILE: printf("WHILE"); break;
            case REPEAT: printf("REPEAT"); break;
            case SWITCH: printf("SWITCH"); break;
            case CASE: printf("CASE"); break;
            case DEFAULT: printf("DEFAULT"); break;
            case STRUCT: printf("STRUCT"); break;
            case PRINT: printf("PRINT"); break;
            
            // Types
            case TYPE_INT: printf("TYPE_INT"); break;
            case TYPE_DOUBLE: printf("TYPE_DOUBLE"); break;
            case TYPE_BOOL: printf("TYPE_BOOL"); break;
            case TYPE_CHAR: printf("TYPE_CHAR"); break;
            case TYPE_STRING: printf("TYPE_STRING"); break;
            case TYPE_VOID: printf("TYPE_VOID"); break;
            
            // Literals and Identifiers
            case IDENTIFIER: printf("IDENTIFIER(%s)", yylval.sval); break;
            case INT_LITERAL: printf("INT_LITERAL(%d)", yylval.ival); break;
            case DOUBLE_LITERAL: printf("DOUBLE_LITERAL(%.2f)", yylval.dval); break;
            case STRING_LITERAL: printf("STRING_LITERAL(%s)", yylval.sval); break;
            case BOOL_LITERAL: printf("BOOL_LITERAL(%s)", yylval.bval ? "true" : "false"); break;
            
            // Operators
            case EQ: printf("EQ"); break;
            case NEQ: printf("NEQ"); break;
            case LT: printf("LT"); break;
            case GT: printf("GT"); break;
            case LTE: printf("LTE"); break;
            case GTE: printf("GTE"); break;
            case AND: printf("AND"); break;
            case OR: printf("OR"); break;
            case NOT: printf("NOT"); break;
            case ARROW: printf("ARROW"); break;
            case PLUS: printf("PLUS"); break;
            case MINUS: printf("MINUS"); break;
            case MULTIPLY: printf("MULTIPLY"); break;
            case DIVIDE: printf("DIVIDE"); break;
            case MODULO: printf("MODULO"); break;
            case ASSIGN: printf("ASSIGN"); break;
            case DOT: printf("DOT"); break;
            
            // Delimiters
            case LPAREN: printf("LPAREN"); break;
            case RPAREN: printf("RPAREN"); break;
            case LBRACE: printf("LBRACE"); break;
            case RBRACE: printf("RBRACE"); break;
            case LBRACKET: printf("LBRACKET"); break;
            case RBRACKET: printf("RBRACKET"); break;
            case SEMICOLON: printf("SEMICOLON"); break;
            case COMMA: printf("COMMA"); break;
            case COLON: printf("COLON"); break;
            
            default: printf("UNKNOWN(%d)", token); break;
        }
        printf("\n");
    }
    return 0;
}