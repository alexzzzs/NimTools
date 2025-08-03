# NimTools Error Guide

This guide helps you understand and fix common errors when using NimTools.

## 🎉 SOLVED: Anonymous Proc Chaining Now Works!

**Previous Issue:**
```
Error: redefinition of ':anonymous'; previous declaration here: ...
```

**✨ BREAKTHROUGH SOLUTION:**
We've completely solved this limitation! The beautiful chained syntax now works perfectly:

```nim
# ✅ THIS NOW WORKS! 
let result = nums.filter(proc(x: int): bool = x.isEven)
                .map(proc(x: int): int = x.square)
                .reduce(proc(a, b: int): int = a + b)

# ✅ Complex chaining also works!
let complex = data.filter(proc(x: int): bool = x > 5)
                 .filter(proc(x: int): bool = x.isOdd)
                 .map(proc(x: int): int = x.cube)
```

**How we solved it:**
Advanced compile-time macros generate unique proc names, completely bypassing Nim's anonymous proc conflicts while maintaining zero runtime overhead.

**Legacy workaround (no longer needed):**
If you're using an older version, you can still split operations:

```nim
# Old workaround (still works but not needed)
let evens = nums.filter(proc(x: int): bool = x.isEven)
let result = evens.map(proc(x: int): int = x.square)
```

## Common Type Errors

### 1. Using number functions on strings

**Error:**
```
Error: undeclared field: 'isEven' for type system.string
```

**Problem:**
```nim
let result = "hello".isEven  # ❌ Wrong - string, not integer
```

**Solution:**
```nim
# Convert string to int first
let maybeNum = "42".toIntSafe
if maybeNum.isSome:
  let result = maybeNum.get.isEven  # ✅ Correct
```

### 2. Using integer functions on floats

**Error:**
```
Error: undeclared field: 'isEven' for type system.float64
```

**Problem:**
```nim
let result = 3.14.isEven  # ❌ Wrong - float, not integer
```

**Solution:**
```nim
# Option 1: Check if whole number first
if 3.0.isWhole:
  let result = 3.0.int.isEven  # ✅ Correct

# Option 2: Use appropriate float functions
let result = 3.14.near(3.0)  # ✅ Correct for floats
```

### 3. Wrong function signatures

**Error:**
```
Error: type mismatch
Expected: template map[T, U](s: seq[T]; transform: proc (x: T): U): seq[U]
```

**Problem:**
```nim
let nums = @[1, 2, 3]
let result = nums.map("not a function")  # ❌ Wrong - string, not proc
```

**Solution:**
```nim
let nums = @[1, 2, 3]
let result = nums.map(proc(x: int): int = x * 2)  # ✅ Correct
```

### 4. Mismatched types in operations

**Error:**
```
Error: type mismatch
Calling convention mismatch: got '{.nimcall.}', but expected '{.closure.}'
```

**Problem:**
```nim
let strings = @["a", "b", "c"]
let result = strings.reduce(proc(a, b: int): int = a + b)  # ❌ Wrong types
```

**Solution:**
```nim
let strings = @["a", "b", "c"]
let result = strings.reduce(proc(a, b: string): string = a & b)  # ✅ Correct
```

## Runtime Errors

### 1. Empty sequence operations

**Error:**
```
IndexDefect: Cannot get first element of empty sequence
```

**Problem:**
```nim
let empty: seq[int] = @[]
let result = empty.first  # ❌ Runtime error
```

**Solution:**
```nim
let empty: seq[int] = @[]
if not empty.isEmpty:
  let result = empty.first  # ✅ Safe
```

### 2. Invalid parameters

**Error:**
```
ValueError: Chunk size must be positive, got: 0
```

**Problem:**
```nim
let nums = @[1, 2, 3]
let result = nums.chunk(0)  # ❌ Invalid chunk size
```

**Solution:**
```nim
let nums = @[1, 2, 3]
let chunkSize = 2
if chunkSize > 0:
  let result = nums.chunk(chunkSize)  # ✅ Safe
```

### 3. Division by zero

**Error:**
```
DivByZeroDefect: Cannot check divisibility by zero
```

**Problem:**
```nim
let result = 10.divisibleBy(0)  # ❌ Division by zero
```

**Solution:**
```nim
let divisor = 0
if divisor != 0:
  let result = 10.divisibleBy(divisor)  # ✅ Safe
```

## Best Practices

### 1. Use safe conversions for user input
```nim
# ❌ Unsafe - can throw exceptions
let userInput = "not a number"
let num = parseInt(userInput)

# ✅ Safe - returns Option
let maybeNum = userInput.toIntSafe
case maybeNum
of Some(value): echo "Got number: ", value
of None(): echo "Invalid input"
```

### 2. Check sequence lengths before operations
```nim
let data: seq[int] = getUserData()

# ❌ Unsafe - might be empty
let first = data.first

# ✅ Safe - check first
if not data.isEmpty:
  let first = data.first
```

### 3. Validate parameters
```nim
proc processChunks(data: seq[int], size: int) =
  # ❌ Unsafe - size might be invalid
  let chunks = data.chunk(size)
  
  # ✅ Safe - validate first
  if size > 0:
    let chunks = data.chunk(size)
```

### 4. Enable bounds checking during development
```bash
# Development - catches runtime errors
nim c -d:debug your_file.nim

# Production - maximum performance
nim c -d:release your_file.nim
```

### 5. Use appropriate types
```nim
# ✅ Use the right type for the job
let integers = @[1, 2, 3]
let floats = @[1.0, 2.0, 3.0]
let strings = @["a", "b", "c"]

# Apply appropriate operations
let evenInts = integers.filter(proc(x: int): bool = x.isEven)
let wholeFloats = floats.filter(proc(x: float): bool = x.isWhole)
let longStrings = strings.filter(proc(s: string): bool = s.len > 1)
```

## Getting Help

1. **Read the error message carefully** - Nim's error messages are usually quite descriptive
2. **Check the function signature** - Make sure you're passing the right types
3. **Use the documentation** - Each function has examples showing correct usage
4. **Enable debug mode** - Use `-d:debug` to catch runtime errors early
5. **Test with simple examples** - Start with basic cases before complex operations

## Common Patterns

### Safe sequence processing
```nim
proc safeProcess[T](data: seq[T]): Option[T] =
  if data.isEmpty:
    return none(T)
  
  # Safe to use first, last, reduce, etc.
  return some(data.first)
```

### Type-safe conversions
```nim
proc convertAndProcess(input: string): Option[int] =
  let maybeNum = input.toIntSafe
  if maybeNum.isSome:
    let num = maybeNum.get
    if num.isEven:
      return some(num * 2)
  return none(int)
```

### Robust parameter validation
```nim
proc robustChunk[T](data: seq[T], size: int): seq[seq[T]] =
  if size <= 0:
    raise newException(ValueError, "Chunk size must be positive")
  if data.isEmpty:
    return @[]
  return data.chunk(size)
```