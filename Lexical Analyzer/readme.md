## LEXICAL ANALYZER

- This is the word splitter component of any compiler. Consider an enlish language sentence as :
"This is a programming Language 123 !"

- The Lexical Analyzer job is to split this into different types like :
WORD("This"), WORD("is"), WORD("a"), WORD("programming"), WORD("Language"), Number("123"), EXCALAMATION_MARK("!")

In programming, the code "var score = 100;" will be splitted as :- 

1. The keyword "var"

2. The identifier "score"

3. The operator "="

4. The number "100"

4. The semicolon ";"

## What's a .lex file and what's inside a .lex file 

- A .lex file (used by the lex or flex tool) defines the words of your programming language. Its job is to scan the raw source code text and break it down into a stream of meaningful units called tokens with the help of set of regular expressions.

- Then this file is used be lex/flex tool to generate lex.yy.c file containing a yylex() function which will be called by the parser ie the .yacc file which will cover in the part 2 of this Project. 

## Flow of Execution

.lex file -> lex/flex tool -> .lex.yy.c (containing yylex()) 