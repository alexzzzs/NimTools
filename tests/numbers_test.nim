import unittest
import ../src/nimtools/numbers

suite "Numbers module tests":
  
  test "isEven":
    check 4.isEven
    check not 3.isEven
    check 0.isEven
    check not (-1).isEven
    check (-2).isEven
  
  test "isOdd":
    check 3.isOdd
    check not 4.isOdd
    check not 0.isOdd
    check (-1).isOdd
    check not (-2).isOdd
  
  test "divisibleBy":
    check 10.divisibleBy(5)
    check not 10.divisibleBy(3)
    check 0.divisibleBy(5)
    check 15.divisibleBy(3)
  
  test "between":
    check 5.between(1, 10)
    check not 15.between(1, 10)
    check 1.between(1, 10)
    check 10.between(1, 10)
    check not 0.between(1, 10)
    check 5.5.between(1.0, 10.0)
  
  test "clamp":
    check 15.clamp(1, 10) == 10
    check (-5).clamp(1, 10) == 1
    check 5.clamp(1, 10) == 5
    check 1.clamp(1, 10) == 1
    check 10.clamp(1, 10) == 10
    check 15.5.clamp(1.0, 10.0) == 10.0
  
  test "square":
    check 5.square == 25
    check 3.5.square == 12.25
    check 0.square == 0
    check (-3).square == 9
  
  test "cube":
    check 3.cube == 27
    check 2.5.cube == 15.625
    check 0.cube == 0
    check (-2).cube == -8
  
  test "isWhole":
    check 5.0.isWhole
    check not 5.5.isWhole
    check 0.0.isWhole
    check not 0.1.isWhole
  
  test "near":
    check 0.1.near(0.1000001, 1e-5)
    check not 0.1.near(0.2)
    check 1.0.near(1.0)
    check 0.0.near(0.0)
  
  test "pipe operator":
    proc squareProc(x: int): int = x.square
    proc addOneProc(x: int): int = x + 1
    let result = 5 |> squareProc |> addOneProc
    check result == 26