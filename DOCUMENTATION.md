# NimTools API Documentation

Complete reference for all NimTools APIs with examples and usage patterns.

## Table of Contents

- [Numbers Module](#numbers-module)
- [Strings Module](#strings-module)
- [Collections Module](#collections-module)
- [Import Guide](#import-guide)
- [Type Information](#type-information)

---

## Numbers Module

**Import**: `import nimtools/numbers`

### Integer Helpers

#### `isEven(n: SomeInteger) -> bool`
Check if an integer is even.

```nim
assert 4.isEven        # true
assert not 3.isEven    # false
assert 0.isEven        # true
assert (-2).isEven     # true
```

#### `isOdd(n: SomeInteger) -> bool`
Check if an integer is odd.

```nim
assert 3.isOdd         # true
assert not 4.isOdd     # false
assert not 0.isOdd     # false
assert (-1).isOdd      # true
```

#### `divisibleBy(n: SomeInteger, divisor: SomeInteger) -> bool`
Check if n is divisible by divisor.

```nim
assert 10.divisibleBy(5)    # true
assert not 10.divisibleBy(3) # false
assert 0.divisibleBy(5)     # true
assert 15.divisibleBy(3)    # true
```

### Range Operations

#### `between(n: SomeNumber, min_val, max_val: SomeNumber) -> bool`
Check if n is between min_val and max_val (inclusive).

```nim
assert 5.between(1, 10)     # true
assert not 15.between(1, 10) # false
assert 1.between(1, 10)     # true (inclusive)
assert 10.between(1, 10)    # true (inclusive)
assert 5.5.between(1.0, 10.0) # true (works with floats)
```

#### `clamp(n: SomeNumber, min_val, max_val: SomeNumber) -> auto`
Clamp n to be within min_val and max_val.

```nim
assert 15.clamp(1, 10) == 10    # clamps to max
assert (-5).clamp(1, 10) == 1   # clamps to min
assert 5.clamp(1, 10) == 5      # no change needed
assert 15.5.clamp(1.0, 10.0) == 10.0 # works with floats
```

### Math Operations

#### `square(n: SomeNumber) -> auto`
Return the square of n.

```nim
assert 5.square == 25           # int -> int
assert 3.5.square == 12.25      # float -> float
assert 0.square == 0
assert (-3).square == 9
```

#### `cube(n: SomeNumber) -> auto`
Return the cube of n.

```nim
assert 3.cube == 27             # int -> int
assert 2.5.cube == 15.625       # float -> float
assert 0.cube == 0
assert (-2).cube == -8
```

### Float Helpers

#### `isWhole(f: SomeFloat) -> bool`
Check if a float represents a whole number.

```nim
assert 5.0.isWhole      # true
assert not 5.5.isWhole  # false
assert 0.0.isWhole      # true
assert not 0.1.isWhole  # false
```

#### `near(a: SomeFloat, b: SomeFloat, epsilon: SomeFloat = 1e-9) -> bool`
Check if two floats are approximately equal within epsilon.

```nim
assert 0.1.near(0.1000001, 1e-5)  # true (within tolerance)
assert not 0.1.near(0.2)          # false
assert 1.0.near(1.0)              # true (exact match)
assert 0.0.near(0.0)              # true
```

### Functional Programming

#### `|>(x: T, f: proc(x: T): U) -> U`
Pipe operator for functional-style chaining.

```nim
let result = 5 |> square |> (proc(x: int): int = x + 1)
assert result == 26  # 5² + 1 = 26

# Can chain multiple operations
let chained = 3 |> cube |> (proc(x: int): int = x.clamp(1, 20))
assert chained == 20  # 3³ = 27, clamped to 20
```

---

## Strings Module

**Import**: `import nimtools/strings`

### String Checks

#### `startsWith(s: string, prefix: string) -> bool`
Check if string starts with prefix.

```nim
assert "hello".startsWith("he")     # true
assert not "hello".startsWith("hi") # false
assert "hello".startsWith("")       # true (empty prefix)
assert "".startsWith("")            # true
assert not "".startsWith("hi")      # false
```

#### `endsWith(s: string, suffix: string) -> bool`
Check if string ends with suffix.

```nim
assert "hello".endsWith("lo")       # true
assert not "hello".endsWith("hi")   # false
assert "hello".endsWith("")         # true (empty suffix)
assert "".endsWith("")              # true
assert not "".endsWith("hi")        # false
```

#### `hasSubstring(s: string, sub: string) -> bool`
Check if string contains substring.

```nim
assert "hello world".hasSubstring("llo")  # true
assert not "hello".hasSubstring("xyz")    # false
assert "hello".hasSubstring("")           # true (empty substring)
assert not "".hasSubstring("hi")          # false
```

#### `isEmpty(s: string) -> bool`
Check if string is empty.

```nim
assert "".isEmpty           # true
assert not "hello".isEmpty  # false
assert not " ".isEmpty      # false (space is not empty)
```

### Safe Conversions

#### `toIntSafe(s: string) -> Option[int]`
Safely convert string to int, returning None on failure.

```nim
import std/options

assert "123".toIntSafe.get == 123       # successful conversion
assert "abc".toIntSafe.isNone           # failed conversion
assert "-456".toIntSafe.get == -456     # negative numbers
assert "".toIntSafe.isNone              # empty string
assert "123abc".toIntSafe.isNone        # partial numbers fail
```

#### `toFloatSafe(s: string) -> Option[float]`
Safely convert string to float, returning None on failure.

```nim
import std/options

assert "123.45".toFloatSafe.get == 123.45   # successful conversion
assert "abc".toFloatSafe.isNone             # failed conversion
assert "-456.78".toFloatSafe.get == -456.78 # negative numbers
assert "".toFloatSafe.isNone                # empty string
assert "123.45abc".toFloatSafe.isNone       # partial numbers fail
```

### String Manipulation

#### `trim(s: string) -> string`
Remove whitespace from both ends of string.

```nim
assert "  hello  ".trim == "hello"
assert "hello".trim == "hello"     # no change needed
assert "   ".trim == ""            # all whitespace
assert "".trim == ""               # empty string
```

#### `trimStart(s: string) -> string`
Remove whitespace from start of string.

```nim
assert "  hello  ".trimStart == "hello  "
assert "hello".trimStart == "hello"        # no change needed
assert "   ".trimStart == ""               # all whitespace
```

#### `trimEnd(s: string) -> string`
Remove whitespace from end of string.

```nim
assert "  hello  ".trimEnd == "  hello"
assert "hello".trimEnd == "hello"          # no change needed
assert "   ".trimEnd == ""                 # all whitespace
```

#### `splitBy(s: string, delimiter: char) -> seq[string]`
Split string by character delimiter.

```nim
assert "a,b,c".splitBy(',') == @["a", "b", "c"]
assert "hello".splitBy(',') == @["hello"]       # no delimiter found
assert "".splitBy(',') == @[""]                 # empty string
assert "a,,c".splitBy(',') == @["a", "", "c"]   # empty parts
```

#### `repeat(s: string, n: int) -> string`
Repeat string n times.

```nim
assert "hi".repeat(3) == "hihihi"
assert "hello".repeat(0) == ""      # zero repetitions
assert "".repeat(5) == ""           # empty string
assert "x".repeat(1) == "x"         # single repetition
```

#### `reverse(s: string) -> string`
Reverse the string.

```nim
assert "hello".reverse == "olleh"
assert "".reverse == ""             # empty string
assert "a".reverse == "a"           # single character
assert "ab".reverse == "ba"         # two characters
assert "abc".reverse == "cba"       # odd length
```

---

## Collections Module

**Import**: `import nimtools/collections`

**Note**: Import collections before `std/options` to avoid naming conflicts with `filter`.

### Functional Operations

#### `filter[T](s: seq[T], predicate: proc(x: T): bool) -> seq[T]`
Filter sequence elements that match the predicate.

```nim
let nums = @[1, 2, 3, 4, 5]
let evens = nums.filter(proc(x: int): bool = x mod 2 == 0)
assert evens == @[2, 4]

let empty: seq[int] = @[]
assert empty.filter(proc(x: int): bool = x > 0) == @[]
```

#### `map[T, U](s: seq[T], transform: proc(x: T): U) -> seq[U]`
Transform each element in the sequence.

```nim
let nums = @[1, 2, 3]
let doubled = nums.map(proc(x: int): int = x * 2)
assert doubled == @[2, 4, 6]

let strings = @["a", "b", "c"]
let lengths = strings.map(proc(s: string): int = s.len)
assert lengths == @[1, 1, 1]
```

#### `reduce[T](s: seq[T], operation: proc(a, b: T): T) -> T`
Reduce sequence to a single value using the operation.

```nim
let nums = @[1, 2, 3, 4]
let sum = nums.reduce(proc(a, b: int): int = a + b)
assert sum == 10

let product = nums.reduce(proc(a, b: int): int = a * b)
assert product == 24
```

### Predicates

#### `any[T](s: seq[T], predicate: proc(x: T): bool) -> bool`
Check if any element matches the predicate.

```nim
let nums = @[1, 2, 3]
assert nums.any(proc(x: int): bool = x > 2)     # true (3 > 2)
assert not nums.any(proc(x: int): bool = x > 5) # false

let empty: seq[int] = @[]
assert not empty.any(proc(x: int): bool = x > 0) # false (empty)
```

#### `all[T](s: seq[T], predicate: proc(x: T): bool) -> bool`
Check if all elements match the predicate.

```nim
let evens = @[2, 4, 6]
assert evens.all(proc(x: int): bool = x mod 2 == 0) # true

let mixed = @[1, 2, 3]
assert not mixed.all(proc(x: int): bool = x mod 2 == 0) # false

let empty: seq[int] = @[]
assert empty.all(proc(x: int): bool = x > 0) # true (vacuously true)
```

### Access & Info

#### `first[T](s: seq[T]) -> T`
Get the first element of the sequence.

```nim
let nums = @[1, 2, 3]
assert nums.first == 1

let single = @[42]
assert single.first == 42
```

#### `last[T](s: seq[T]) -> T`
Get the last element of the sequence.

```nim
let nums = @[1, 2, 3]
assert nums.last == 3

let single = @[42]
assert single.last == 42
```

#### `isEmpty[T](s: seq[T]) -> bool`
Check if sequence is empty.

```nim
let empty: seq[int] = @[]
assert empty.isEmpty

let nums = @[1, 2, 3]
assert not nums.isEmpty
```

#### `size[T](s: seq[T]) -> int`
Get the size of the sequence (alias for len).

```nim
let empty: seq[int] = @[]
assert empty.size == 0

let nums = @[1, 2, 3]
assert nums.size == 3
```

#### `hasItem[T](s: seq[T], item: T) -> bool`
Check if sequence contains the item.

```nim
let nums = @[1, 2, 3]
assert nums.hasItem(2)      # true
assert not nums.hasItem(4)  # false

let empty: seq[int] = @[]
assert not empty.hasItem(1) # false
```

### Transformations

#### `take[T](s: seq[T], n: int) -> seq[T]`
Take the first n elements from the sequence.

```nim
let nums = @[1, 2, 3, 4, 5]
assert nums.take(3) == @[1, 2, 3]
assert nums.take(0) == @[]
assert nums.take(10) == @[1, 2, 3, 4, 5]  # takes all available
```

#### `drop[T](s: seq[T], n: int) -> seq[T]`
Drop the first n elements from the sequence.

```nim
let nums = @[1, 2, 3, 4, 5]
assert nums.drop(2) == @[3, 4, 5]
assert nums.drop(0) == @[1, 2, 3, 4, 5]   # drops nothing
assert nums.drop(10) == @[]                # drops all
```

#### `reverse[T](s: seq[T]) -> seq[T]`
Reverse the sequence.

```nim
let nums = @[1, 2, 3]
assert nums.reverse == @[3, 2, 1]

let empty: seq[int] = @[]
assert empty.reverse == @[]

let single = @[42]
assert single.reverse == @[42]
```

#### `sort[T](s: seq[T]) -> seq[T]`
Sort the sequence in ascending order.

```nim
let nums = @[3, 1, 4, 1, 5]
assert nums.sort == @[1, 1, 3, 4, 5]

let strings = @["c", "a", "b"]
assert strings.sort == @["a", "b", "c"]
```

#### `chunk[T](s: seq[T], size: int) -> seq[seq[T]]`
Split sequence into chunks of specified size.

```nim
let nums = @[1, 2, 3, 4, 5]
assert nums.chunk(2) == @[@[1, 2], @[3, 4], @[5]]
assert nums.chunk(3) == @[@[1, 2, 3], @[4, 5]]
assert nums.chunk(10) == @[@[1, 2, 3, 4, 5]]  # single chunk

let empty: seq[int] = @[]
assert empty.chunk(2) == @[]
```

#### `unique[T](s: seq[T]) -> seq[T]`
Remove duplicate elements from sequence (preserves first occurrence order).

```nim
let nums = @[1, 2, 2, 3, 1, 4]
assert nums.unique == @[1, 2, 3, 4]

let strings = @["a", "b", "a", "c", "b"]
assert strings.unique == @["a", "b", "c"]

let empty: seq[int] = @[]
assert empty.unique == @[]
```

---

## Import Guide

### Import Everything
```nim
import nimtools
# Imports all modules: numbers, strings, collections
```

### Import Specific Modules
```nim
import nimtools/numbers     # Only number helpers
import nimtools/strings     # Only string helpers
import nimtools/collections # Only collection helpers
```

### Avoid Naming Conflicts
```nim
# Import collections before std/options to avoid filter conflicts
import nimtools/collections
import std/options

# Or use qualified imports
from nimtools/numbers import nil
echo numbers.isEven(4)
```

### Recommended Import Order
```nim
# 1. NimTools modules first
import nimtools/numbers
import nimtools/strings
import nimtools/collections

# 2. Standard library modules after
import std/options
import std/strutils
import std/sequtils
```

---

## Type Information

### Generic Type Constraints

- **`SomeInteger`**: All integer types (`int`, `int8`, `int16`, `int32`, `int64`, `uint`, `uint8`, `uint16`, `uint32`, `uint64`)
- **`SomeFloat`**: All floating-point types (`float`, `float32`, `float64`)
- **`SomeNumber`**: All numeric types (integers and floats)

### Template vs Proc

All NimTools functions are implemented as **templates**, which means:

- **Zero runtime overhead**: Code is inlined at compile time
- **Type safety**: Full compile-time type checking
- **Dot-call syntax**: Natural `value.function()` syntax
- **Generic support**: Works with all compatible types

### Return Types

Most templates return the same type as input or a logical result type:

```nim
# Same type as input
5.square        # int -> int
3.5.square      # float -> float

# Logical result types
4.isEven        # int -> bool
"hello".isEmpty # string -> bool
@[1,2].size     # seq[int] -> int

# Generic transformations
@[1,2,3].map(proc(x: int): string = $x)  # seq[int] -> seq[string]
```

---

## Performance Notes

- All operations are **zero-cost abstractions** - templates inline at compile time
- No runtime overhead compared to writing the operations manually
- Generic templates work efficiently with all supported types
- Memory allocations only occur where logically necessary (e.g., `map`, `filter` creating new sequences)

## Error Handling

NimTools provides comprehensive error handling to catch common mistakes at compile time or runtime:

### Runtime Error Checking

When compiled with bounds checking enabled (`-d:debug` or `--boundChecks:on`), NimTools will raise appropriate exceptions for invalid operations:

#### Collections Module Errors
- **`IndexDefect`**: Thrown when accessing empty sequences
  ```nim
  let empty: seq[int] = @[]
  # These will raise IndexDefect:
  # empty.first
  # empty.last
  ```

- **`ValueError`**: Thrown for invalid parameters
  ```nim
  let nums = @[1, 2, 3]
  # These will raise ValueError:
  # nums.chunk(0)     # chunk size must be positive
  # nums.chunk(-1)    # chunk size must be positive
  # empty.reduce(...)  # cannot reduce empty sequence
  ```

#### Numbers Module Errors
- **`DivByZeroDefect`**: Thrown for division by zero
  ```nim
  # This will raise DivByZeroDefect:
  # 10.divisibleBy(0)
  ```

- **`ValueError`**: Thrown for invalid ranges
  ```nim
  # This will raise ValueError:
  # 5.clamp(10, 1)  # min_val > max_val
  ```

#### Strings Module Errors
- **`ValueError`**: Thrown for invalid parameters
  ```nim
  # This will raise ValueError:
  # "hello".repeat(-1)  # negative repeat count
  ```

### Safe Conversions

String conversion functions return `Option` types for safe error handling:

```nim
import std/options

# Safe conversions never throw exceptions
let maybeInt = "123".toIntSafe
if maybeInt.isSome:
  echo "Converted: ", maybeInt.get
else:
  echo "Conversion failed"

# Or use pattern matching
case "abc".toIntSafe
of Some(value): echo "Got: ", value
of None(): echo "Invalid number"
```

### Compile-Time Safety

- **Type safety** enforced at compile time through generic constraints
- **Template expansion** errors provide clear compile-time feedback
- **Zero-cost abstractions** with full compile-time optimization

### Best Practices

1. **Use safe conversions** for user input: `toIntSafe`, `toFloatSafe`
2. **Check sequence lengths** before using `first`, `last`, `reduce`
3. **Validate parameters** before calling functions with constraints
4. **Enable bounds checking** during development: `nim c -d:debug your_file.nim`
5. **Handle Option types** properly when using safe conversions