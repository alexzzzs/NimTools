## Collection helper templates for sequences and arrays
##
## This module provides expressive, zero-overhead helpers for functional programming
## operations on Nim's built-in collection types using template-based dot-call syntax.

import std/algorithm
import macros

## Chaining support - uses genSym for truly unique proc names

macro chainFilter*[T](s: seq[T], predicate: untyped): untyped =
  ## Filter with chaining support - generates unique proc names to avoid conflicts
  let procName = genSym(nskProc, "filterProc")
  
  result = newStmtList()
  result.add quote do:
    proc `procName`(x: auto): bool = `predicate`(x)
    
  result.add quote do:
    block:
      var filtered: seq[type(`s`[0])] = @[]
      for item in `s`:
        if `procName`(item):
          filtered.add(item)
      filtered

macro chainMap*[T](s: seq[T], transform: untyped): untyped =
  ## Map with chaining support - generates unique proc names to avoid conflicts
  let procName = genSym(nskProc, "mapProc")
  
  result = newStmtList()
  result.add quote do:
    proc `procName`(x: auto): auto = `transform`(x)
    
  result.add quote do:
    block:
      var mapped: seq[type(`procName`(`s`[0]))] = @[]
      for item in `s`:
        mapped.add(`procName`(item))
      mapped

macro chainReduce*[T](s: seq[T], operation: untyped): untyped =
  ## Reduce with chaining support - generates unique proc names to avoid conflicts
  let procName = genSym(nskProc, "reduceProc")
  
  result = newStmtList()
  result.add quote do:
    proc `procName`(a, b: auto): auto = `operation`(a, b)
    
  result.add quote do:
    block:
      when compileOption("boundChecks"):
        if `s`.len == 0:
          raise newException(ValueError, "Cannot reduce empty sequence")
      var result = `s`[0]
      for i in 1..<`s`.len:
        result = `procName`(result, `s`[i])
      result

## Functional programming helpers

template filter*[T](s: seq[T], predicate: untyped): untyped =
  ## Filter sequence elements that match the predicate (with chaining support)
  ##
  ## Example:
  ##   let nums = @[1, 2, 3, 4, 5]
  ##   assert nums.filter(proc(x: int): bool = x mod 2 == 0) == @[2, 4]
  ##   
  ##   # Chaining also works!
  ##   let result = nums.filter(proc(x: int): bool = x.isEven)
  ##                   .map(proc(x: int): int = x.square)
  s.chainFilter(predicate)

template map*[T](s: seq[T], transform: untyped): untyped =
  ## Transform each element in the sequence (with chaining support)
  ##
  ## Example:
  ##   let nums = @[1, 2, 3]
  ##   assert nums.map(proc(x: int): int = x * 2) == @[2, 4, 6]
  ##   
  ##   # Chaining also works!
  ##   let result = nums.filter(proc(x: int): bool = x.isEven)
  ##                   .map(proc(x: int): int = x.square)
  s.chainMap(transform)

template reduce*[T](s: seq[T], operation: untyped): untyped =
  ## Reduce sequence to a single value using the operation (with chaining support)
  ##
  ## Example:
  ##   let nums = @[1, 2, 3, 4]
  ##   assert nums.reduce(proc(a, b: int): int = a + b) == 10
  ##   
  ##   # Chaining also works!
  ##   let result = nums.filter(proc(x: int): bool = x.isEven)
  ##                   .reduce(proc(a, b: int): int = a + b)
  s.chainReduce(operation)

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
