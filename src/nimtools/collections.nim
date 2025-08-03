## Collection helper templates for sequences and arrays
##
## This module provides expressive, zero-overhead helpers for functional programming
## operations on Nim's built-in collection types using template-based dot-call syntax.

import std/algorithm

## Functional programming helpers

template filter*[T](s: seq[T], predicate: untyped): seq[T] =
  ## Filter sequence elements that match the predicate
  ##
  ## Example:
  ##   let nums = @[1, 2, 3, 4, 5]
  ##   assert nums.filter(proc(x: int): bool = x mod 2 == 0) == @[2, 4]
  (block:
    var result: seq[T] = @[]
    for item in s:
      if predicate(item):
        result.add(item)
    result)

template map*[T](s: seq[T], transform: untyped): untyped =
  ## Transform each element in the sequence
  ##
  ## Example:
  ##   let nums = @[1, 2, 3]
  ##   assert nums.map(proc(x: int): int = x * 2) == @[2, 4, 6]
  (block:
    var result: seq[type(transform(s[0]))] = @[]
    for item in s:
      result.add(transform(item))
    result)

template reduce*[T](s: seq[T], operation: untyped): T =
  ## Reduce sequence to a single value using the operation
  ##
  ## Example:
  ##   let nums = @[1, 2, 3, 4]
  ##   assert nums.reduce(proc(a, b: int): int = a + b) == 10
  (block:
    when compileOption("boundChecks"):
      if s.len == 0:
        raise newException(ValueError, "Cannot reduce empty sequence")
    var result = s[0]
    for i in 1..<s.len:
      result = operation(result, s[i])
    result)

template any*[T](s: seq[T], predicate: untyped): bool =
  ## Check if any element matches the predicate
  ##
  ## Example:
  ##   let nums = @[1, 2, 3]
  ##   assert nums.any(proc(x: int): bool = x > 2)
  (block:
    var result = false
    for item in s:
      if predicate(item):
        result = true
        break
    result)

template all*[T](s: seq[T], predicate: untyped): bool =
  ## Check if all elements match the predicate
  ##
  ## Example:
  ##   let nums = @[2, 4, 6]
  ##   assert nums.all(proc(x: int): bool = x mod 2 == 0)
  (block:
    var result = true
    for item in s:
      if not predicate(item):
        result = false
        break
    result)

template first*[T](s: seq[T]): T =
  ## Get the first element of the sequence
  ##
  ## Example:
  ##   let nums = @[1, 2, 3]
  ##   assert nums.first == 1
  when compileOption("boundChecks"):
    if s.len == 0:
      raise newException(IndexDefect, "Cannot get first element of empty sequence")
  s[0]

template last*[T](s: seq[T]): T =
  ## Get the last element of the sequence
  ##
  ## Example:
  ##   let nums = @[1, 2, 3]
  ##   assert nums.last == 3
  when compileOption("boundChecks"):
    if s.len == 0:
      raise newException(IndexDefect, "Cannot get last element of empty sequence")
  s[^1]

template isEmpty*[T](s: seq[T]): bool =
  ## Check if sequence is empty
  ##
  ## Example:
  ##   assert @[].isEmpty
  ##   assert not @[1].isEmpty
  s.len == 0

template size*[T](s: seq[T]): int =
  ## Get the size of the sequence (alias for len)
  ##
  ## Example:
  ##   let nums = @[1, 2, 3]
  ##   assert nums.size == 3
  s.len

## Sequence transformation helpers

template chunk*[T](s: seq[T], size: int): seq[seq[T]] =
  ## Split sequence into chunks of specified size
  ##
  ## Example:
  ##   let nums = @[1, 2, 3, 4, 5]
  ##   assert nums.chunk(2) == @[@[1, 2], @[3, 4], @[5]]
  when compileOption("boundChecks"):
    if size <= 0:
      raise newException(ValueError, "Chunk size must be positive, got: " & $size)
  var result: seq[seq[T]] = @[]
  var i = 0
  while i < s.len:
    let endIdx = min(i + size, s.len)
    result.add(s[i..<endIdx])
    i += size
  result

template take*[T](s: seq[T], n: int): seq[T] =
  ## Take the first n elements from the sequence
  ##
  ## Example:
  ##   let nums = @[1, 2, 3, 4, 5]
  ##   assert nums.take(3) == @[1, 2, 3]
  if n >= s.len: s else: s[0..<n]

template drop*[T](s: seq[T], n: int): seq[T] =
  ## Drop the first n elements from the sequence
  ##
  ## Example:
  ##   let nums = @[1, 2, 3, 4, 5]
  ##   assert nums.drop(2) == @[3, 4, 5]
  if n >= s.len: @[] else: s[n..^1]

template reverse*[T](s: seq[T]): seq[T] =
  ## Reverse the sequence
  ##
  ## Example:
  ##   let nums = @[1, 2, 3]
  ##   assert nums.reverse == @[3, 2, 1]
  algorithm.reversed(s)

template sort*[T](s: seq[T]): seq[T] =
  ## Sort the sequence in ascending order
  ##
  ## Example:
  ##   let nums = @[3, 1, 2]
  ##   assert nums.sort == @[1, 2, 3]
  algorithm.sorted(s)

template unique*[T](s: seq[T]): seq[T] =
  ## Remove duplicate elements from sequence
  ##
  ## Example:
  ##   let nums = @[1, 2, 2, 3, 1]
  ##   assert nums.unique == @[1, 2, 3]
  var result: seq[T] = @[]
  for item in s:
    var found = false
    for existing in result:
      if item == existing:
        found = true
        break
    if not found:
      result.add(item)
  result

template hasItem*[T](s: seq[T], item: T): bool =
  ## Check if sequence contains the item
  ##
  ## Example:
  ##   let nums = @[1, 2, 3]
  ##   assert nums.hasItem(2)
  ##   assert not nums.hasItem(4)
  item in s