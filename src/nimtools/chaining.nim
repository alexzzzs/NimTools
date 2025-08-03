## Chaining module - Enables fluent method chaining with anonymous procs
##
## This module uses macros to generate unique proc names, bypassing Nim's
## anonymous proc redefinition limitation and enabling beautiful chained syntax.

import macros

var uniqueId {.compileTime.} = 0

macro chainFilter*[T](s: seq[T], predicate: untyped): untyped =
  ## Filter with chaining support - generates unique proc names to avoid conflicts
  ##
  ## Example:
  ##   let result = nums.chainFilter(proc(x: int): bool = x.isEven)
  ##                   .chainMap(proc(x: int): int = x.square)
  inc uniqueId
  let procName = ident("filterProc" & $uniqueId)
  
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
  ##
  ## Example:
  ##   let result = nums.chainFilter(proc(x: int): bool = x.isEven)
  ##                   .chainMap(proc(x: int): int = x.square)
  inc uniqueId
  let procName = ident("mapProc" & $uniqueId)
  
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
  ##
  ## Example:
  ##   let sum = nums.chainReduce(proc(a, b: int): int = a + b)
  inc uniqueId
  let procName = ident("reduceProc" & $uniqueId)
  
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

# Note: The chaining versions (chainFilter, chainMap, chainReduce) are the 
# primary interface. The regular collections module provides the base templates.