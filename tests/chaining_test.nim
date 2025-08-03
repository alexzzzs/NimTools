import unittest
import ../src/nimtools

suite "Chaining module tests":
  
  test "basic filter chaining":
    let nums = @[1, 2, 3, 4, 5]
    let evens = nums.filter(proc(x: int): bool = x mod 2 == 0)
    check evens == @[2, 4]
  
  test "basic map chaining":
    let nums = @[1, 2, 3]
    let squares = nums.map(proc(x: int): int = x * x)
    check squares == @[1, 4, 9]
  
  test "basic reduce chaining":
    let nums = @[1, 2, 3, 4]
    let sum = nums.reduce(proc(a, b: int): int = a + b)
    check sum == 10
  
  test "filter -> map chaining":
    let nums = @[1, 2, 3, 4, 5]
    let result = nums.filter(proc(x: int): bool = x mod 2 == 0)
                    .map(proc(x: int): int = x * x)
    check result == @[4, 16]
  
  test "complex multi-step chaining":
    let nums = @[1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    let result = nums.filter(proc(x: int): bool = x > 3)
                    .filter(proc(x: int): bool = x mod 2 == 0)
                    .map(proc(x: int): int = x * x)
    check result == @[16, 36, 64, 100]
  
  test "filter -> reduce chaining":
    let nums = @[1, 2, 3, 4, 5]
    let sum = nums.filter(proc(x: int): bool = x mod 2 == 1)
                 .reduce(proc(a, b: int): int = a + b)
    check sum == 9  # 1 + 3 + 5
  
  test "map -> reduce chaining":
    let nums = @[1, 2, 3]
    let sumOfSquares = nums.map(proc(x: int): int = x * x)
                          .reduce(proc(a, b: int): int = a + b)
    check sumOfSquares == 14  # 1 + 4 + 9
  
  test "chaining with nimtools functions":
    let nums = @[1, 2, 3, 4, 5, 6]
    let result = nums.filter(proc(x: int): bool = x.isEven)
                    .map(proc(x: int): int = x.square)
    check result == @[4, 16, 36]
  
  test "empty sequence chaining":
    let empty: seq[int] = @[]
    let result = empty.filter(proc(x: int): bool = x > 0)
                     .map(proc(x: int): int = x * 2)
    check result == @[]
  
  test "single element chaining":
    let single = @[5]
    let result = single.filter(proc(x: int): bool = x > 0)
                      .map(proc(x: int): int = x * 2)
    check result == @[10]