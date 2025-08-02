## Validation helpers for safer NimTools usage
##
## This module provides optional validation functions that can help catch
## common mistakes before they cause runtime errors.

import std/options

## Sequence validation

template requireNonEmpty*[T](s: seq[T], operation: string = "operation"): void =
  ## Validate that a sequence is not empty before operations that require elements
  ##
  ## Example:
  ##   let nums = @[1, 2, 3]
  ##   nums.requireNonEmpty("first")  # OK
  ##   let empty: seq[int] = @[]
  ##   empty.requireNonEmpty("first")  # raises ValueError
  if s.len == 0:
    raise newException(ValueError, "Cannot perform " & operation & " on empty sequence")

template requirePositive*(n: int, name: string = "value"): void =
  ## Validate that an integer is positive
  ##
  ## Example:
  ##   let size = 5
  ##   size.requirePositive("chunk size")  # OK
  ##   let invalid = -1
  ##   invalid.requirePositive("chunk size")  # raises ValueError
  if n <= 0:
    raise newException(ValueError, name & " must be positive, got: " & $n)

template requireNonZero*(n: SomeNumber, name: string = "value"): void =
  ## Validate that a number is not zero
  ##
  ## Example:
  ##   let divisor = 5
  ##   divisor.requireNonZero("divisor")  # OK
  ##   let zero = 0
  ##   zero.requireNonZero("divisor")  # raises ValueError
  if n == 0:
    raise newException(ValueError, name & " cannot be zero")

template requireValidRange*[T](min_val, max_val: T, operation: string = "operation"): void =
  ## Validate that min <= max for range operations
  ##
  ## Example:
  ##   requireValidRange(1, 10, "clamp")  # OK
  ##   requireValidRange(10, 1, "clamp")  # raises ValueError
  if min_val > max_val:
    raise newException(ValueError, "Invalid range for " & operation & ": min (" & $min_val & ") > max (" & $max_val & ")")

## Safe wrappers for common operations

template safeFirst*[T](s: seq[T]): T =
  ## Safely get first element with validation
  ##
  ## Example:
  ##   let nums = @[1, 2, 3]
  ##   let first = nums.safeFirst  # returns 1
  s.requireNonEmpty("first")
  s[0]

template safeLast*[T](s: seq[T]): T =
  ## Safely get last element with validation
  ##
  ## Example:
  ##   let nums = @[1, 2, 3]
  ##   let last = nums.safeLast  # returns 3
  s.requireNonEmpty("last")
  s[^1]

template safeReduce*[T](s: seq[T], operation: proc(a, b: T): T): T =
  ## Safely reduce with validation
  ##
  ## Example:
  ##   let nums = @[1, 2, 3, 4]
  ##   let sum = nums.safeReduce(proc(a, b: int): int = a + b)
  s.requireNonEmpty("reduce")
  var result = s[0]
  for i in 1..<s.len:
    result = operation(result, s[i])
  result

template safeChunk*[T](s: seq[T], size: int): seq[seq[T]] =
  ## Safely chunk with validation
  ##
  ## Example:
  ##   let nums = @[1, 2, 3, 4, 5]
  ##   let chunks = nums.safeChunk(2)  # @[@[1, 2], @[3, 4], @[5]]
  size.requirePositive("chunk size")
  var result: seq[seq[T]] = @[]
  var i = 0
  while i < s.len:
    let endIdx = min(i + size, s.len)
    result.add(s[i..<endIdx])
    i += size
  result

template safeDivisibleBy*(n: SomeInteger, divisor: SomeInteger): bool =
  ## Safely check divisibility with validation
  ##
  ## Example:
  ##   assert 10.safeDivisibleBy(5)  # true
  ##   # 10.safeDivisibleBy(0)  # raises ValueError
  divisor.requireNonZero("divisor")
  (n mod divisor) == 0

template safeClamp*[T](n: T, min_val, max_val: T): T =
  ## Safely clamp with validation
  ##
  ## Example:
  ##   assert 15.safeClamp(1, 10) == 10
  ##   # 5.safeClamp(10, 1)  # raises ValueError
  requireValidRange(min_val, max_val, "clamp")
  if n < min_val: min_val
  elif n > max_val: max_val
  else: n

template safeRepeat*(s: string, n: int): string =
  ## Safely repeat string with validation
  ##
  ## Example:
  ##   assert "hi".safeRepeat(3) == "hihihi"
  ##   # "hi".safeRepeat(-1)  # raises ValueError
  if n < 0:
    raise newException(ValueError, "Cannot repeat string negative times: " & $n)
  var result = ""
  for i in 0..<n:
    result.add(s)
  result

## Option-based safe wrappers (no exceptions thrown)

template optionFirst*[T](s: seq[T]): Option[T] =
  ## Get first element as Option (returns none if empty)
  ##
  ## Example:
  ##   let nums = @[1, 2, 3]
  ##   let first = nums.optionFirst  # some(1)
  ##   let empty: seq[int] = @[]
  ##   let first = empty.optionFirst  # none(int)
  if s.len > 0: some(s[0]) else: none(T)

template optionLast*[T](s: seq[T]): Option[T] =
  ## Get last element as Option (returns none if empty)
  ##
  ## Example:
  ##   let nums = @[1, 2, 3]
  ##   let last = nums.optionLast  # some(3)
  ##   let empty: seq[int] = @[]
  ##   let last = empty.optionLast  # none(int)
  if s.len > 0: some(s[^1]) else: none(T)

template optionReduce*[T](s: seq[T], operation: proc(a, b: T): T): Option[T] =
  ## Reduce sequence as Option (returns none if empty)
  ##
  ## Example:
  ##   let nums = @[1, 2, 3, 4]
  ##   let sum = nums.optionReduce(proc(a, b: int): int = a + b)  # some(10)
  ##   let empty: seq[int] = @[]
  ##   let sum = empty.optionReduce(proc(a, b: int): int = a + b)  # none(int)
  if s.len == 0: none(T)
  else:
    var result = s[0]
    for i in 1..<s.len:
      result = operation(result, s[i])
    some(result)