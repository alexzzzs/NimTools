import src/nimtools
import std/options

echo "=== NimTools Error Handling Examples ==="

# Example 1: Safe string to number conversion
echo "\n1. Safe string conversions:"
let userInput = "42"
let invalidInput = "not a number"

let maybeNum = userInput.toIntSafe
if maybeNum.isSome:
  let num = maybeNum.get
  echo "Valid number: ", num
  echo "Is even: ", num.isEven
else:
  echo "Invalid number"

let maybeInvalid = invalidInput.toIntSafe
if maybeInvalid.isSome:
  echo "Valid number: ", maybeInvalid.get
else:
  echo "Invalid input: '", invalidInput, "'"

# Example 2: Safe sequence operations
echo "\n2. Safe sequence operations:"
let numbers = @[1, 2, 3, 4, 5]
let empty: seq[int] = @[]

# Using built-in error handling (debug mode only)
if not numbers.isEmpty:
  echo "First number: ", numbers.first
  echo "Last number: ", numbers.last
  echo "Sum: ", numbers.reduce(proc(a, b: int): int = a + b)

# Using validation helpers (always safe)
try:
  echo "Safe first: ", numbers.safeFirst
  echo "Safe last: ", numbers.safeLast
  echo "Safe sum: ", numbers.safeReduce(proc(a, b: int): int = a + b)
except ValueError as e:
  echo "Error: ", e.msg

# This would fail with validation
try:
  echo "Empty first: ", empty.safeFirst
except ValueError as e:
  echo "Caught error: ", e.msg

# Example 3: Parameter validation
echo "\n3. Parameter validation:"
let data = @[1, 2, 3, 4, 5, 6]

# Safe chunking
try:
  let chunks = data.safeChunk(2)
  echo "Chunks: ", chunks
except ValueError as e:
  echo "Error: ", e.msg

# This would fail
try:
  let badChunks = data.safeChunk(0)
  echo "Bad chunks: ", badChunks
except ValueError as e:
  echo "Caught error: ", e.msg

# Example 4: Safe math operations
echo "\n4. Safe math operations:"
try:
  echo "10 divisible by 5: ", 10.safeDivisibleBy(5)
  echo "10 divisible by 0: ", 10.safeDivisibleBy(0)  # This will fail
except ValueError as e:
  echo "Caught error: ", e.msg

try:
  echo "Clamp 15 to [1,10]: ", 15.safeClamp(1, 10)
  echo "Clamp 5 to [10,1]: ", 5.safeClamp(10, 1)  # This will fail
except ValueError as e:
  echo "Caught error: ", e.msg

# Example 5: Robust user input processing
echo "\n5. Robust user input processing:"
proc processUserNumbers(inputs: seq[string]): seq[int] =
  result = @[]
  for input in inputs:
    let maybeNum = input.toIntSafe
    if maybeNum.isSome:
      result.add(maybeNum.get)
    else:
      echo "Skipping invalid input: '", input, "'"

let userInputs = @["1", "2", "invalid", "4", "not a number", "6"]
let validNumbers = processUserNumbers(userInputs)
echo "Valid numbers: ", validNumbers

if not validNumbers.isEmpty:
  echo "Sum of valid numbers: ", validNumbers.safeReduce(proc(a, b: int): int = a + b)
  echo "Even numbers: ", validNumbers.filter(proc(x: int): bool = x.isEven)

echo "\n=== All examples completed successfully! ==="