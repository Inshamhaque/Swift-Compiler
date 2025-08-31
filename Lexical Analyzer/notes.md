# Structure of a Lex File (`scanner.l`)

A **Lex file** is divided into **three sections**, separated by `%%`.  

The general structure looks like this:

```lex
%{
    // Declarations in C (headers, global variables, enums, etc.)
%}

Definitions (regex patterns and macros)

%%
Rules Section (patterns → actions)

%%
User Code Section (main function, helper functions)
```

---

## 1. **Definitions Section** (Header Part)

This is the **first section**, enclosed in `%{ ... %}`.

* You write **C code** here that will be copied directly into the generated C file.
* Typically includes:

  * Standard headers (`stdio.h`, `string.h`, etc.)
  * Token definitions (`enum` for keywords, operators, etc.)
  * Global variables (like `yylval`)

### Example from `scanner.l`:

```c
%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

// these are the tokens that our lexer and parser will use to compile the code
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

// Semantic values for tokens
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
```

✔ **Key points**:

* `%option noyywrap` tells Lex we don't need a `yywrap()` function.
* `%option yylineno` makes Lex automatically track line numbers.
* Macros like `DIGIT`, `LETTER` make regex definitions reusable.

---

## 2. **Rules Section**

The second section (between the **two `%%`**) contains **regex patterns** and their corresponding **actions**.

* Each line: `pattern { action }`
* When the lexer sees a match, it executes the corresponding action (usually `return TOKEN;`).

### Example Rules:

```lex
%%

// Whitespace and comments
[ \t\n]+	        { /* ignore whitespace */ }
"//".* 		        { /* ignore comments */ }

// Keywords
"let"		        { return LET; }
"var"		        { return VAR; }
"func"		        { return FUNC; }
"return"	        { return RETURN; }
"if"		        { return IF; }
"else"		        { return ELSE; }
...
"print"		        { return PRINT; }

// Types
"Int"		        { return TYPE_INT; }
"Double"	        { return TYPE_DOUBLE; }
"Bool"		        { return TYPE_BOOL; }
"Character"	        { return TYPE_CHAR; }
"String"	        { return TYPE_STRING; }
"Void"		        { return TYPE_VOID; }

// Literals
{DIGIT}+			{ yylval.ival = atoi(yytext); return INT_LITERAL; }
{DIGIT}+\.{DIGIT}+	{ yylval.dval = atof(yytext); return DOUBLE_LITERAL; }
\"[^"\n]*\"			{ yylval.sval = strdup(yytext); return STRING_LITERAL; }
"true"				{ yylval.bval = 1; return BOOL_LITERAL; }
"false"				{ yylval.bval = 0; return BOOL_LITERAL; }

// Identifiers
{LETTER}{IDENTIFIER_CHAR}*	{ yylval.sval = strdup(yytext); return IDENTIFIER; }

// Operators
"=="		{ return EQ; }
"!="		{ return NEQ; }
"<="		{ return LTE; }
">="		{ return GTE; }
"<"		    { return LT; }
">"		    { return GT; }
"&&"		{ return AND; }
"||"		{ return OR; }
"!"		    { return NOT; }
"->"		{ return ARROW; }

// Arithmetic
"+"		    { return PLUS; }
"-"		    { return MINUS; }
"*"		    { return MULTIPLY; }
"/"		    { return DIVIDE; }
"%"		    { return MODULO; }

// Assignment and punctuation
"="		    { return ASSIGN; }
"."		    { return DOT; }
"("		    { return LPAREN; }
")"		    { return RPAREN; }
"{"		    { return LBRACE; }
"}"		    { return RBRACE; }
"["		    { return LBRACKET; }
"]"		    { return RBRACKET; }
";"		    { return SEMICOLON; }
","		    { return COMMA; }
":"		    { return COLON; }

// Catch-all for unexpected characters
.		{ printf("Unexpected character: %c\n", yytext[0]); }
```

✔ **Key points**:

* `yytext` is a global variable containing the current matched string.
* `yylval` stores semantic values (like integer, string) for tokens.
* Returning tokens like `LET`, `EQ`, `PLUS` makes them available to the parser.

---

## 3. **User Code Section**

The last section (after the second `%%`) contains C code, usually a `main()` function to test the lexer.

### Example from `scanner.l`:

```c
%%

int main(int argc, char **argv) {
    if (argc > 1) {
        FILE *file = fopen(argv[1], "r");
        if (!file) {
            perror(argv[1]);
            return 1;
        }
        yyin = file;   // redirect input
    }

    int token;
    while ((token = yylex())) {
        printf("Line %d, Token: ", yylineno);
        switch (token) {
            case LET: printf("LET"); break;
            case VAR: printf("VAR"); break;
            case FUNC: printf("FUNC"); break;
            ...
            case IDENTIFIER: printf("IDENTIFIER(%s)", yylval.sval); break;
            case INT_LITERAL: printf("INT_LITERAL(%d)", yylval.ival); break;
            case DOUBLE_LITERAL: printf("DOUBLE_LITERAL(%.2f)", yylval.dval); break;
            ...
            default: printf("UNKNOWN(%d)", token); break;
        }
        printf("\n");
    }
    return 0;
}
```

✔ **Key points**:

* `yyin` is the input stream (default = `stdin`, but here we use a file).
* `yylex()` is the lexer function generated by Lex.
* Each token is printed along with its line number for debugging.

---

## ✅ Summary

A **Lex file (`.l`)** has 3 parts:

1. **Definitions Section**
   * Includes headers, token enums, macros, global variables.

2. **Rules Section**
   * Contains regex patterns and actions (returning tokens).
   * Translates source code into tokens for the parser.

3. **User Code Section**
   * Typically a `main()` function or helper functions.
   * For testing/debugging the lexer.

This structure allows Lex to convert **raw source code** into a **stream of tokens**, which the parser can then process according to grammar rules.