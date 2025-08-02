## Numeric helper templates for integers and floats
##
## This module provides expressive, zero-overhead helpers for numeric operations
## using template-based dot-call syntax.

import std/math

## Integer helpers

template isEven*(n: SomeInteger): bool =
  ## Check if an integer is even
  ##
  ## Example:
  ##   assert 4.isEven
  ##   assert not 3.isEven
  when n is string:
    {.error: "isEven() only works with integers, not strings. Use toIntSafe() to convert first.".}
  when n is SomeFloat:
    {.error: "isEven() only works with integers. For floats, use: myFloat.int.isEven or check isWhole() first.".}
  (n and 1) == 0

template isOdd*(n: SomeInteger): bool =
  ## Check if an integer is odd
  ##
  ## Example:
  ##   assert 3.isOdd
  ##   assert not 4.isOdd
  when n is string:
    {.error: "isOdd() only works with integers, not strings. Use toIntSafe() to convert first.".}
  when n is SomeFloat:
    {.error: "isOdd() only works with integers. For floats, use: myFloat.int.isOdd or check isWhole() first.".}
  (n and 1) == 1

template divisibleBy*(n: SomeInteger, divisor: SomeInteger): bool =
  ## Check if n is divisible by divisor
  ##
  ## Example:
  ##   assert 10.divisibleBy(5)
  ##   assert not 10.divisibleBy(3)
  when compileOption("boundChecks"):
    if divisor == 0:
      raise newException(DivByZeroDefect, "Cannot check divisibility by zero")
  (n mod divisor) == 0

template between*(n: SomeNumber, min_val, max_val: SomeNumber): bool =
  ## Check if n is between min_val and max_val (inclusive)
  ##
  ## Example:
  ##   assert 5.between(1, 10)
  ##   assert not 15.between(1, 10)
  n >= min_val and n <= max_val

template clamp*(n: SomeNumber, min_val, max_val: SomeNumber): auto =
  ## Clamp n to be within min_val and max_val
  ##
  ## Example:
  ##   assert 15.clamp(1, 10) == 10
  ##   assert (-5).clamp(1, 10) == 1
  ##   assert 5.clamp(1, 10) == 5
  when compileOption("boundChecks"):
    if min_val > max_val:
      raise newException(ValueError, "min_val (" & $min_val & ") cannot be greater than max_val (" & $max_val & ")")
  if n < min_val: min_val
  elif n > max_val: max_val
  else: n

template square*(n: SomeNumber): auto =
  ## Return the square of n
  ##
  ## Example:
  ##   assert 5.square == 25
  ##   assert 3.5.square == 12.25
  n * n

template cube*(n: SomeNumber): auto =
  ## Return the cube of n
  ##
  ## Example:
  ##   assert 3.cube == 27
  ##   assert 2.5.cube == 15.625
  n * n * n

## Float helpers

template isWhole*(f: SomeFloat): bool =
  ## Check if a float represents a whole number
  ##
  ## Example:
  ##   assert 5.0.isWhole
  ##   assert not 5.5.isWhole
  f == floor(f)

template near*(a: SomeFloat, b: SomeFloat, epsilon: SomeFloat = 1e-9): bool =
  ## Check if two floats are approximately equal within epsilon
  ##
  ## Example:
  ##   assert 0.1.near(0.1000001, 1e-5)
  ##   assert not 0.1.near(0.2)
  abs(a - b) < epsilon

## Pipe operator

template `|>`*[T, U](x: T, f: proc(x: T): U): U =
  ## Pipe operator for functional-style chaining
  ##
  ## Example:
  ##   let result = 5 |> square |> (proc(x: int): int = x + 1)
  ##   assert result == 26
  f(x)
