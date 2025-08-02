import unittest
import ../src/nimtools/collections

suite "Collections module tests":
  
  test "filter":
    let nums = @[1, 2, 3, 4, 5]
    let evens = nums.filter(proc(x: int): bool = x mod 2 == 0)
    check evens == @[2, 4]
    
    let empty: seq[int] = @[]
    let emptyResult: seq[int] = @[]
    check empty.filter(proc(x: int): bool = x > 0) == emptyResult
  
  test "map":
    let nums = @[1, 2, 3]
    let doubled = nums.map(proc(x: int): int = x * 2)
    check doubled == @[2, 4, 6]
    
    let strings = @["a", "b", "c"]
    let lengths = strings.map(proc(s: string): int = s.len)
    check lengths == @[1, 1, 1]
  
  test "reduce":
    let nums = @[1, 2, 3, 4]
    let sum = nums.reduce(proc(a, b: int): int = a + b)
    check sum == 10
    
    let product = nums.reduce(proc(a, b: int): int = a * b)
    check product == 24
  
  test "any":
    let nums = @[1, 2, 3]
    check nums.any(proc(x: int): bool = x > 2)
    check not nums.any(proc(x: int): bool = x > 5)
    
    let empty: seq[int] = @[]
    check not empty.any(proc(x: int): bool = x > 0)
  
  test "all":
    let evens = @[2, 4, 6]
    check evens.all(proc(x: int): bool = x mod 2 == 0)
    
    let mixed = @[1, 2, 3]
    check not mixed.all(proc(x: int): bool = x mod 2 == 0)
    
    let empty: seq[int] = @[]
    check empty.all(proc(x: int): bool = x > 0)  # vacuously true
  
  test "first and last":
    let nums = @[1, 2, 3]
    check nums.first == 1
    check nums.last == 3
    
    let single = @[42]
    check single.first == 42
    check single.last == 42
  
  test "isEmpty and size":
    let empty: seq[int] = @[]
    check empty.isEmpty
    check empty.size == 0
    
    let nums = @[1, 2, 3]
    check not nums.isEmpty
    check nums.size == 3
  
  test "chunk":
    let nums = @[1, 2, 3, 4, 5]
    check nums.chunk(2) == @[@[1, 2], @[3, 4], @[5]]
    check nums.chunk(3) == @[@[1, 2, 3], @[4, 5]]
    check nums.chunk(10) == @[@[1, 2, 3, 4, 5]]
    
    let empty: seq[int] = @[]
    let emptyChunks: seq[seq[int]] = @[]
    check empty.chunk(2) == emptyChunks
  
  test "take and drop":
    let nums = @[1, 2, 3, 4, 5]
    check nums.take(3) == @[1, 2, 3]
    let emptyTake: seq[int] = @[]
    check nums.take(0) == emptyTake
    check nums.take(10) == @[1, 2, 3, 4, 5]
    
    check nums.drop(2) == @[3, 4, 5]
    check nums.drop(0) == @[1, 2, 3, 4, 5]
    let emptyDrop: seq[int] = @[]
    check nums.drop(10) == emptyDrop
  
  test "reverse":
    let nums = @[1, 2, 3]
    check nums.reverse == @[3, 2, 1]
    
    let empty: seq[int] = @[]
    let emptyReverse: seq[int] = @[]
    check empty.reverse == emptyReverse
    
    let single = @[42]
    check single.reverse == @[42]
  
  test "sort":
    let nums = @[3, 1, 4, 1, 5]
    check nums.sort == @[1, 1, 3, 4, 5]
    
    let strings = @["c", "a", "b"]
    check strings.sort == @["a", "b", "c"]
  
  test "unique":
    let nums = @[1, 2, 2, 3, 1, 4]
    check nums.unique == @[1, 2, 3, 4]
    
    let strings = @["a", "b", "a", "c", "b"]
    check strings.unique == @["a", "b", "c"]
    
    let empty: seq[int] = @[]
    let emptyUnique: seq[int] = @[]
    check empty.unique == emptyUnique
  
  test "hasItem":
    let nums = @[1, 2, 3]
    check nums.hasItem(2)
    check not nums.hasItem(4)
    
    let empty: seq[int] = @[]
    check not empty.hasItem(1)
  
  # test "find":
  #   let nums = @[1, 2, 3, 4]
  #   check nums.find(proc(x: int): bool = x > 2) == 2
  #   check nums.find(proc(x: int): bool = x > 10) == -1
  #   
  #   let empty: seq[int] = @[]
  #   check empty.find(proc(x: int): bool = x > 0) == -1