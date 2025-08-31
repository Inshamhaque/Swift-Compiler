// Complete Swift Subset Test File
// This file tests all features from the specification

// 1. PRIMITIVE TYPES AND TYPE INFERENCE
let intValue = 42;              // Type inference: Int
let doubleValue = 3.14;         // Type inference: Double  
let boolValue = true;           // Type inference: Bool
let stringValue = "Hello";      // Type inference: String
var mutableInt: Int = 100;      // Explicit type annotation
var mutableDouble: Double = 2.5; // Explicit type annotation

// 2. VARIABLE DECLARATIONS
let immutableVar = 10;          // let = immutable
var mutableVar = 20;            // var = mutable
mutableVar = 30;                // Reassignment allowed

// 3. ARITHMETIC OPERATORS
let sum = 5 + 3;
let difference = 10 - 4;
let product = 6 * 7;
let quotient = 15 / 3;
let remainder = 17 % 5;

// 4. RELATIONAL OPERATORS  
let equal = (5 == 5);
let notEqual = (5 != 3);
let lessThan = (3 < 7);
let greaterThan = (8 > 4);
let lessEqual = (5 <= 5);
let greaterEqual = (7 >= 6);

// 5. LOGICAL OPERATORS
let andResult = true && false;
let orResult = true || false;
let notResult = !true;

// 6. STRING CONCATENATION
let greeting = "Hello" + " " + "World";

// 7. CONTROL FLOW - IF/ELSE
if (intValue > 40) {
    print("Large number");
} else {
    print("Small number");
}

// 8. SWITCH STATEMENTS
switch (intValue) {
    case 42:
        print("The answer");
    case 100:
        print("Century");
    default:
        print("Other number");
}

// 9. FOR-IN LOOPS
for i in 1 {
    print("Loop iteration");
}

// 10. WHILE LOOPS
var counter = 0;
while (counter < 3) {
    print("While loop");
    counter = counter + 1;
}

// 11. REPEAT-WHILE LOOPS  
var repeatCounter = 0;
repeat {
    print("Repeat while loop");
    repeatCounter = repeatCounter + 1;
} while (repeatCounter < 2);

// 12. FUNCTION DEFINITIONS
func add(a: Int, b: Int) -> Int {
    return a + b;
}

func greet(name: String) -> Void {
    print("Hello " + name);
}

func noParamsNoReturn() -> Void {
    print("Simple function");
}

// 13. FUNCTION CALLS
let result = add(a: 5, b: 3);
greet(name: "Swift");
noParamsNoReturn();

// 14. ARRAYS
var numbers[5]: Int;            // Fixed size array declaration
numbers[0] = 10;                // Element assignment
numbers[1] = 20;
numbers[2] = 30;
let firstElement = numbers[0];   // Element access

// 15. USER-DEFINED TYPES - STRUCTS
struct Point {
    var x: Int;
    var y: Int;
}

struct Rectangle {
    var width: Double;
    var height: Double;
    var topLeft: Point;
}

// 16. STRUCT INSTANTIATION AND USAGE
var point = Point(x: 3, y: 4);
var rect = Rectangle(width: 10.0, height: 20.0, topLeft: point);

// 17. STRUCT FIELD ACCESS
print(point.x);
print(point.y);
print(rect.width);
print(rect.topLeft.x);

// 18. STRUCT FIELD MODIFICATION
point.x = 5;
rect.height = 25.0;

// 19. COMPLEX EXPRESSIONS
let complexExpr = ((a + b) * c) / (d - e);
let booleanExpr = (x > y) && (z <= w) || !flag;

// 20. NESTED STRUCTS AND ARRAYS
struct Student {
    var name: String;
    var grades[10]: Int;
    var address: Point;
}

var student = Student(name: "John", grades: grades, address: point);
student.grades[0] = 95;
student.address.x = 100;

// 21. FUNCTION WITH MULTIPLE PARAMETERS
func calculateArea(width: Double, height: Double) -> Double {
    return width * height;
}

let area = calculateArea(width: rect.width, height: rect.height);

// 22. MIXED TYPE OPERATIONS
let mixedCalc = intValue + 10;
let comparison = doubleValue > 2.0;

print("Test completed successfully!");