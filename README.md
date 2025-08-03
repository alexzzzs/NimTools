# NimTools

A lightweight, zero-dependency Nim library that provides expressive, safe, and intuitive helper APIs for Nim's built-in types using template-based dot-call syntax.

## Features

- **Zero runtime overhead**: All helpers are implemented as templates that inline at compile time
- **Dot-call friendly**: Natural syntax like `num.isEven` or `str.startsWith("x")`
- **Fluent chaining**: Beautiful method chaining with anonymous procs that actually works!
- **Modular design**: Import only what you need
- **Type safe**: Uses Nim's type system and generics appropriately
- **Error handling**: Comprehensive runtime validation and safe conversion functions
- **Well tested**: Comprehensive unit tests for all functionality

## Installation

### From GitHub (Available Now)
```bash
# Install latest version
nimble install https://github.com/alexzzzs/NimTools.git

# Install specific version
nimble install https://github.com/alexzzzs/NimTools.git@v0.3.8
```

### From Nimble Registry (Coming Soon)
```bash
# Once approved for official registry
nimble install nimtools
```

## Troubleshooting

### Import Conflicts with Standard Library

Some NimTools functions have the same names as standard library functions. Here's how to handle conflicts:

#### Problem: `startsWith` ambiguity
```nim
import nimtools
import strutils  # ❌ This causes conflicts!

# Error: ambiguous call; both strings.startsWith and strutils.startsWith match
echo "hello".startsWith("he")
```

#### Solution: Use selective imports
```nim
import nimtools
from strutils import toLower  # ✅ Import only what you need

# Now both work without conflicts
echo "hello".startsWith("he")  # Uses NimTools version
echo "HELLO".toLower           # Uses strutils version
```

#### Alternative: Qualify the call
```nim
import nimtools
import strutils

# Explicitly specify which one to use
echo "hello".nimtools.startsWith("he")  # NimTools version
echo strutils.startsWith("hello", "he") # Standard library version
```

### Common Import Patterns

```nim
# ✅ Recommended: Import only NimTools
import nimtools

# ✅ Safe: Selective imports from standard library
import nimtools
from strutils import toLower, toUpper
from sequtils import deduplicate

# ❌ Avoid: Full imports that cause conflicts
import nimtools
import strutils  # Can cause startsWith, endsWith conflicts
import sequtils  # Can cause filter, map conflicts
```

## Quick Start

```nim
import nimtools

# Numbers
echo 4.isEven        # true
echo 5.square        # 25
echo 15.clamp(1, 10) # 10

# Strings
echo "hello".startsWith("he")  # true
echo "  trim me  ".trim        # "trim me"
echo "123".toIntSafe.get       # 123

# Collections - Beautiful chained operations! 🎉
let nums = @[1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

# THE DREAM SYNTAX NOW WORKS!
let result = nums.filter(proc(x: int): bool = x.isEven)
                .map(proc(x: int): int = x.square)
echo result  # @[4, 16, 36, 64, 100]

# Complex chaining also works
let complex = nums.filter(proc(x: int): bool = x > 3)
                 .filter(proc(x: int): bool = x.isOdd)
                 .map(proc(x: int): int = x * 2)
echo complex  # @[10, 14, 18]
```

## Modules

### Numbers (`nimtools/numbers`)

Numeric helpers for integers and floats:

```nim
import nimtools/numbers

# Integer checks
echo 4.isEven           # true
echo 3.isOdd            # true
echo 10.divisibleBy(5)  # true

# Range operations
echo 5.between(1, 10)   # true
echo 15.clamp(1, 10)    # 10

# Math operations
echo 5.square           # 25
echo 3.cube             # 27

# Float helpers
echo 5.0.isWhole        # true
echo 0.1.near(0.1001, 1e-3)  # true

# Pipe operator
let result = 5 |> square |> (proc(x: int): int = x + 1)
echo result  # 26
```

### Strings (`nimtools/strings`)

String manipulation helpers:

```nim
import nimtools/strings

# String checks
echo "hello".startsWith("he")    # true
echo "hello".endsWith("lo")      # true
echo "hello world".hasSubstring("llo")  # true
echo "".isEmpty                  # true

# Safe conversions
echo "123".toIntSafe.get         # 123
echo "abc".toIntSafe.isNone      # true
echo "123.45".toFloatSafe.get    # 123.45

# String manipulation
echo "  hello  ".trim            # "hello"
echo "  hello  ".trimStart       # "hello  "
echo "  hello  ".trimEnd         # "  hello"
echo "a,b,c".splitBy(',')        # @["a", "b", "c"]
echo "hi".repeat(3)              # "hihihi"
echo "hello".reverse             # "olleh"
```

### Collections (`nimtools/collections`)

Functional programming helpers for sequences:

```nim
import nimtools/collections

let nums = @[1, 2, 3, 4, 5]

# Functional operations
echo nums.filter(proc(x: int): bool = x mod 2 == 0)  # @[2, 4]
echo nums.map(proc(x: int): int = x * 2)             # @[2, 4, 6, 8, 10]
echo nums.reduce(proc(a, b: int): int = a + b)       # 15

# Predicates
echo nums.any(proc(x: int): bool = x > 3)            # true
echo nums.all(proc(x: int): bool = x > 0)            # true

# Access and info
echo nums.first                  # 1
echo nums.last                   # 5
echo nums.size                   # 5
echo nums.isEmpty                # false

# Transformations
echo nums.take(3)                # @[1, 2, 3]
echo nums.drop(2)                # @[3, 4, 5]
echo nums.reverse                # @[5, 4, 3, 2, 1]
echo nums.sort                   # @[1, 2, 3, 4, 5]
echo nums.chunk(2)               # @[@[1, 2], @[3, 4], @[5]]

# Utilities
echo @[1, 2, 2, 3].unique        # @[1, 2, 3]
echo nums.hasItem(3)             # true
```

## Usage

```nim
# Import everything
import nimtools

# Or import specific modules
import nimtools/numbers
import nimtools/strings
import nimtools/collections
```

## Running Tests

```bash
nimble test
```

## Error Handling

NimTools provides comprehensive error handling to help catch mistakes early:

### Runtime Validation
When compiled with bounds checking (`-d:debug`), NimTools validates parameters and raises appropriate exceptions:

```nim
import nimtools

# These will raise helpful errors in debug mode:
let empty: seq[int] = @[]
# empty.first  # IndexDefect: Cannot get first element of empty sequence

let nums = @[1, 2, 3]
# nums.chunk(0)  # ValueError: Chunk size must be positive, got: 0

# 10.divisibleBy(0)  # DivByZeroDefect: Cannot check divisibility by zero
```

### Safe Conversions
String conversions return `Option` types for safe error handling:

```nim
import std/options

let maybeNum = "123".toIntSafe
if maybeNum.isSome:
  echo "Got number: ", maybeNum.get
else:
  echo "Invalid input"
```

### Validation Helpers
Optional validation module for extra safety with exception-based error handling:

```nim
import nimtools/validation

let data = @[1, 2, 3, 4]
echo data.safeFirst        # 1 (with validation)
echo data.safeChunk(2)     # @[@[1, 2], @[3, 4]] (with validation)

# These will throw exceptions if invalid:
let empty: seq[int] = @[]
# echo empty.safeFirst     # ValueError: Cannot perform first on empty sequence
```

See `ERROR_GUIDE.md` for comprehensive error handling examples and best practices.

## 🎉 Breakthrough: Fluent Chaining Now Works!

**We solved the anonymous proc limitation!** Using advanced macro techniques, NimTools now supports the beautiful chained syntax you've always wanted:

```nim
# ✨ THIS NOW WORKS! ✨
let result = nums.filter(proc(x: int): bool = x.isEven)
                .map(proc(x: int): int = x.square)
                .reduce(proc(a, b: int): int = a + b)

# Complex multi-step chaining
let complex = data.filter(proc(x: int): bool = x > 5)
                 .filter(proc(x: int): bool = x.isOdd)
                 .map(proc(x: int): int = x.cube)
```

**How it works:** Compile-time macros generate unique proc names, completely bypassing Nim's anonymous proc conflicts while maintaining zero runtime overhead!

## Design Philosophy

NimTools follows these principles:

1. **Zero runtime overhead**: Templates inline code at compile time
2. **Expressive syntax**: Dot-call syntax feels natural and readable
3. **Type safety**: Leverages Nim's type system for safety
4. **Modularity**: Import only what you need
5. **Simplicity**: Easy to understand and use

## Contributing

Contributions are welcome! Please ensure:

- All new helpers have comprehensive tests
- Documentation includes examples
- Code follows existing style conventions
- Templates are used for zero-overhead inlining

## License

MIT License - see LICENSE file for details.

## Roadmap

- [x] Collections helpers (filter, map, reduce as dot-calls)
- [ ] Date/time utilities
- [ ] Math constants and advanced operations
- [ ] Optional macro-based DSLs
- [ ] Advanced collections (groupBy, partition, etc.)
- [ ] File system utilities