import nimtools
import std/options

echo "=== Working NimTools API Example ==="

# =============================================================================
# NUMBERS MODULE
# =============================================================================
echo "\n1. NUMBERS MODULE:"

# Integer Helpers
echo "  Integer Helpers:"
echo "    4.isEven = ", 4.isEven
echo "    3.isOdd = ", 3.isOdd
echo "    10.divisibleBy(5) = ", 10.divisibleBy(5)
echo "    10.divisibleBy(3) = ", 10.divisibleBy(3)

# Range Operations
echo "  Range Operations:"
echo "    5.between(1, 10) = ", 5.between(1, 10)
echo "    15.between(1, 10) = ", 15.between(1, 10)
echo "    15.clamp(1, 10) = ", 15.clamp(1, 10)
echo "    (-5).clamp(1, 10) = ", (-5).clamp(1, 10)

# Math Operations
echo "  Math Operations:"
echo "    5.square = ", 5.square
echo "    3.cube = ", 3.cube

# Float Helpers
echo "  Float Helpers:"
echo "    5.0.isWhole = ", 5.0.isWhole
echo "    5.5.isWhole = ", 5.5.isWhole
echo "    0.1.near(0.1000001, 1e-5) = ", 0.1.near(0.1000001, 1e-5)

# Functional Programming (split into separate steps to avoid anonymous proc conflicts)
echo "  Functional Programming:"
let step1 = 5 |> (proc(x: int): int = x.square)
let pipeResult = step1 |> (proc(x: int): int = x + 1)
echo "    5 |> square |> (+1) = ", pipeResult

# =============================================================================
# STRINGS MODULE
# =============================================================================
echo "\n2. STRINGS MODULE:"

# String Checks
echo "  String Checks:"
echo "    'hello'.startsWith('he') = ", "hello".startsWith("he")
echo "    'hello'.endsWith('lo') = ", "hello".endsWith("lo")
echo "    'hello world'.hasSubstring('llo') = ", "hello world".hasSubstring("llo")
echo "    ''.isEmpty = ", "".isEmpty

# Safe Conversions
echo "  Safe Conversions:"
echo "    '123'.toIntSafe = ", "123".toIntSafe
echo "    'abc'.toIntSafe.isNone = ", "abc".toIntSafe.isNone
echo "    '123.45'.toFloatSafe = ", "123.45".toFloatSafe
echo "    'abc'.toFloatSafe.isNone = ", "abc".toFloatSafe.isNone

# String Manipulation
echo "  String Manipulation:"
echo "    '  hello  '.trim = '", "  hello  ".trim, "'"
echo "    '  hello  '.trimStart = '", "  hello  ".trimStart, "'"
echo "    '  hello  '.trimEnd = '", "  hello  ".trimEnd, "'"
echo "    'a,b,c'.splitBy(',') = ", "a,b,c".splitBy(',')
echo "    'hi'.repeat(3) = '", "hi".repeat(3), "'"
echo "    'hello'.reverse = '", "hello".reverse, "'"

# =============================================================================
# COLLECTIONS MODULE
# =============================================================================
echo "\n3. COLLECTIONS MODULE:"

let nums = @[1, 2, 3, 4, 5]
let strings = @["hello", "world", "nim"]

# Functional Operations (each operation in separate statement)
echo "  Functional Operations:"
let evens = nums.filter(proc(x: int): bool = x mod 2 == 0)
echo "    nums.filter(even) = ", evens

let squares = nums.map(proc(x: int): int = x * x)
echo "    nums.map(square) = ", squares

let sum = nums.reduce(proc(a, b: int): int = a + b)
echo "    nums.reduce(sum) = ", sum

# Predicates
echo "  Predicates:"
let hasLarge = nums.any(proc(x: int): bool = x > 3)
echo "    nums.any(>3) = ", hasLarge

let allPositive = nums.all(proc(x: int): bool = x > 0)
echo "    nums.all(>0) = ", allPositive

# Access & Info
echo "  Access & Info:"
echo "    nums.first = ", nums.first
echo "    nums.last = ", nums.last
echo "    nums.isEmpty = ", nums.isEmpty
echo "    nums.size = ", nums.size
echo "    nums.hasItem(3) = ", nums.hasItem(3)

# Transformations
echo "  Transformations:"
echo "    nums.take(3) = ", nums.take(3)
echo "    nums.drop(2) = ", nums.drop(2)
echo "    nums.reverse = ", nums.reverse
echo "    @[3,1,4,1,5].sort = ", @[3,1,4,1,5].sort
echo "    nums.chunk(2) = ", nums.chunk(2)
echo "    @[1,2,2,3,1,4].unique = ", @[1,2,2,3,1,4].unique

# =============================================================================
# VALIDATION MODULE
# =============================================================================
echo "\n4. VALIDATION MODULE:"

import nimtools/validation

# Validation Helpers
echo "  Validation Helpers:"
try:
  discard nums.requireNonEmpty("test")
  echo "    requireNonEmpty: ✅ passed"
  discard 5.requirePositive("test")
  echo "    requirePositive: ✅ passed"
  discard 10.requireNonZero("test")
  echo "    requireNonZero: ✅ passed"
  requireValidRange(1, 10, "test")
  echo "    requireValidRange: ✅ passed"
except ValueError as e:
  echo "    ❌ Unexpected error: ", e.msg

# Safe Wrappers
echo "  Safe Wrappers:"
try:
  echo "    safeFirst = ", nums.safeFirst
  echo "    safeLast = ", nums.safeLast
  proc add(a, b: int): int = a + b
  echo "    safeReduce = ", nums.safeReduce(add)
  echo "    safeChunk(2) = ", nums.safeChunk(2)
  echo "    safeDivisibleBy = ", 10.safeDivisibleBy(5)
  echo "    safeClamp = ", 15.safeClamp(1, 10)
  echo "    safeRepeat = ", "hi".safeRepeat(3)
except ValueError as e:
  echo "    ❌ Unexpected error: ", e.msg

# Error Cases (should throw exceptions)
echo "  Error Cases (should throw exceptions):"
let empty: seq[int] = @[]

try:
  echo "    Testing empty.safeFirst..."
  echo empty.safeFirst
  echo "    ❌ Should have thrown an error"
except ValueError as e:
  echo "    ✅ Caught expected error: ", e.msg

try:
  echo "    Testing nums.safeChunk(0)..."
  echo nums.safeChunk(0)
  echo "    ❌ Should have thrown an error"
except ValueError as e:
  echo "    ✅ Caught expected error: ", e.msg

# =============================================================================
# INTEGRATION TESTS (split chained operations)
# =============================================================================
echo "\n5. INTEGRATION TESTS:"

# Numbers + Collections (split into separate steps)
echo "  Numbers + Collections:"
let evenNums = nums.filter(proc(x: int): bool = x.isEven)
let evenSquares = evenNums.map(proc(x: int): int = x.square)
echo "    even numbers squared = ", evenSquares

# Strings + Collections
echo "  Strings + Collections:"
let longStrings = strings.filter(proc(s: string): bool = s.len > 3)
echo "    long strings = ", longStrings

# Validation + Collections
echo "  Validation + Collections:"
try:
  let validNums = nums.requireNonEmpty("processing")
  let processed = validNums.map(proc(x: int): int = x * 2)
  echo "    processed numbers = ", processed
except ValueError as e:
  echo "    ❌ Unexpected error: ", e.msg

# =============================================================================
# EDGE CASES
# =============================================================================
echo "\n6. EDGE CASES:"

# Empty sequences
echo "  Empty sequences:"
let emptySeq: seq[int] = @[]
echo "    empty.isEmpty = ", emptySeq.isEmpty
echo "    empty.size = ", emptySeq.size
echo "    empty.take(3) = ", emptySeq.take(3)
echo "    empty.reverse = ", emptySeq.reverse

# Single element
echo "  Single element:"
let single = @[42]
echo "    single.first = ", single.first
echo "    single.last = ", single.last
echo "    single.reverse = ", single.reverse

# Boundary values
echo "  Boundary values:"
echo "    0.isEven = ", 0.isEven
echo "    0.isOdd = ", 0.isOdd
echo "    (-1).isOdd = ", (-1).isOdd
echo "    (-2).isEven = ", (-2).isEven

echo "\n=== All API Tests Complete ==="