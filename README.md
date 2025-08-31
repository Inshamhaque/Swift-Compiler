## Swift Subset Compiler

This a compiler based on the swift subset language complying to these specifications :-


1. Primitive Types
  • Int, Double, Bool, Character, String
2. Type Inference
  • Allow type inference for literals (e.g., let x = 5 infers Int)
3. Variable Declarations
  • let (immutable), var (mutable)
4. Operators
  • Arithmetic: +, -, *, /, %
  • Relational: ==, !=, <, >, <=, >=
  • Logical: &&, ||, !
  • String concatenation using +
5. Control Flow
  • if, else
  • switch with case, default
6. Loops
  • for-in loops
  • while and repeat-while
7. Functions
  • Return values and parameters
  • Named parameters
  • Support Void return type
8. Arrays
  • 1D arrays of fixed size
  • Element access via subscript notation
9. User-Defined Types: struct
  • Define and use simple structs with value semantics
  • Access fields with . operator
  struct Point {
  var x: Int
  var y: Int
  }
  var p = Point(x: 3, y: 4)  
  print(p.x)
