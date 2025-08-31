# Swift Subset Compiler

A comprehensive compiler implementation for a subset of the Swift programming language, featuring lexical analysis, parsing, and code generation capabilities.

## 📋 Language Specifications

This compiler supports the following Swift language features:

### 1. **Primitive Types**
- `Int` - Integer numbers
- `Double` - Floating-point numbers  
- `Bool` - Boolean values (true/false)
- `Character` - Single characters
- `String` - Text strings

### 2. **Type Inference**
- Automatic type inference for literals
- Example: `let x = 5` automatically infers `Int` type
- Example: `let name = "Swift"` automatically infers `String` type

### 3. **Variable Declarations**
- `let` - Immutable variables (constants)
- `var` - Mutable variables
```swift
let pi = 3.14159    // Immutable
var counter = 0     // Mutable
```

### 4. **Operators**

#### Arithmetic Operators
- `+` Addition
- `-` Subtraction  
- `*` Multiplication
- `/` Division
- `%` Modulo

#### Relational Operators
- `==` Equal to
- `!=` Not equal to
- `<` Less than
- `>` Greater than
- `<=` Less than or equal to
- `>=` Greater than or equal to

#### Logical Operators
- `&&` Logical AND
- `||` Logical OR
- `!` Logical NOT

#### String Operations
- String concatenation using `+` operator

### 5. **Control Flow**

#### Conditional Statements
```swift
if condition {
    // code
} else {
    // code
}
```

#### Switch Statements
```swift
switch value {
case pattern1:
    // code
case pattern2:
    // code
default:
    // code
}
```

### 6. **Loops**

#### For-In Loops
```swift
for item in collection {
    // code
}
```

#### While Loops
```swift
while condition {
    // code
}
```

#### Repeat-While Loops
```swift
repeat {
    // code
} while condition
```

### 7. **Functions**
- Support for return values and parameters
- Named parameters
- `Void` return type support

```swift
func greet(name: String) -> String {
    return "Hello, " + name
}

func printMessage() -> Void {
    print("Hello World")
}
```

### 8. **Arrays**
- 1D arrays of fixed size
- Element access via subscript notation

```swift
var numbers: [Int] = [1, 2, 3, 4, 5]
let firstNumber = numbers[0]
```

### 9. **User-Defined Types: Structs**
- Define and use simple structs with value semantics
- Access fields with `.` operator

```swift
struct Point {
    var x: Int
    var y: Int
}

var p = Point(x: 3, y: 4)
print(p.x)  // Output: 3
```

---

## Running the Lexical Analyzer

To run the lexical analyzer, follow these platform-specific instructions:

### Prerequisites
Make sure you have the following installed:
- **Flex** (Fast Lexical Analyzer Generator)
- **GCC** or any C compiler
- **Make** (optional, for build automation)

### Step 1: Navigate to the Project Directory
```bash
git clone 
cd "Lexical Analyzer"
```

---

###  **Windows Instructions**

#### Option 1: Using MinGW/MSYS2
```cmd
# Install flex and gcc via MSYS2 package manager
pacman -S flex gcc make

# Generate the lexer
flex scanner.l

# Compile the generated C code
gcc lex.yy.c -o lexer.exe

# Run the lexer with a test file
lexer.exe test_input.swift

# Or run with standard input
lexer.exe
```

#### Option 2: Using Visual Studio with Linux Subsystem (WSL)
```cmd
# Enable WSL and install Ubuntu
wsl --install

# Inside WSL, follow the Linux instructions below
```

---

###  **Linux Instructions**

```bash
# Install flex and gcc (Ubuntu/Debian)
sudo apt-get update
sudo apt-get install flex gcc make

# For CentOS/RHEL/Fedora
sudo yum install flex gcc make
# OR for newer versions:
sudo dnf install flex gcc make

# Generate the lexer from scanner.l
flex scanner.l

# Compile the generated C code
gcc lex.yy.c -o lexer

# Run the lexer with a test file
./lexer test_input.swift

# Or run with standard input
./lexer
```

---

### **macOS Instructions**

```bash
# Install Xcode Command Line Tools (if not already installed)
xcode-select --install

# Install flex using Homebrew (recommended)
brew install flex

# Alternative: Install using MacPorts
sudo port install flex

# Generate the lexer from scanner.l
flex scanner.l

# Compile the generated C code
gcc lex.yy.c -o lexer

# Run the lexer with a test file
./lexer test_input.swift

# Or run with standard input
./lexer
```

---

### 📝 **Creating a Test File**

Create a test Swift file (`test_input.swift`) with sample code:

```swift
let message = "Hello, Swift!"
var counter = 0

func greet(name: String) -> String {
    return "Hello, " + name
}

struct Point {
    var x: Int
    var y: Int
}

if counter < 10 {
    counter = counter + 1
    print(message)
}

while counter > 0 {
    counter = counter - 1
}
```

---

### 🔧 **Troubleshooting**

#### Common Issues:

1. **"flex: command not found"**
   - Install flex using your system's package manager

2. **"gcc: command not found"**
   - Install GCC compiler or build tools for your platform

3. **Permission denied (Linux/macOS)**
   - Make the executable file runnable: `chmod +x lexer`

4. **Windows path issues**
   - Use forward slashes in paths or escape backslashes
   - Consider using WSL for better compatibility

#### Debug Mode:
To see detailed token information, compile with debug flags:
```bash
gcc -DDEBUG lex.yy.c -o lexer_debug
```

---

###