import unittest
import std/options
import ../src/nimtools/validation

suite "Validation module tests":
  
  test "requireNonEmpty":
    let nums = @[1, 2, 3]
    # Should not raise
    nums.requireNonEmpty("test")
    
    let empty: seq[int] = @[]
    expect(ValueError):
      empty.requireNonEmpty("test")
  
  test "requirePositive":
    # Should not raise
    5.requirePositive("test")
    
    expect(ValueError):
      0.requirePositive("test")
    
    expect(ValueError):
      (-1).requirePositive("test")
  
  test "requireNonZero":
    # Should not raise
    5.requireNonZero("test")
    (-5).requireNonZero("test")
    
    expect(ValueError):
      0.requireNonZero("test")
  
  test "requireValidRange":
    # Should not raise
    requireValidRange(1, 10, "test")
    requireValidRange(5, 5, "test")  # equal is OK
    
    expect(ValueError):
      requireValidRange(10, 1, "test")
  
  test "safe wrappers":
    let nums = @[1, 2, 3, 4]
    
    # Safe operations that should work
    assert nums.safeFirst == 1
    assert nums.safeLast == 4
    assert nums.safeReduce(proc(a, b: int): int = a + b) == 10
    assert nums.safeChunk(2) == @[@[1, 2], @[3, 4]]
    assert 10.safeDivisibleBy(5) == true
    assert 15.safeClamp(1, 10) == 10
    assert "hi".safeRepeat(3) == "hihihi"
    
    # Operations that should fail
    let empty: seq[int] = @[]
    expect(ValueError):
      discard empty.safeFirst
    
    expect(ValueError):
      discard empty.safeLast
    
    expect(ValueError):
      discard empty.safeReduce(proc(a, b: int): int = a + b)
    
    expect(ValueError):
      discard nums.safeChunk(0)
    
    expect(ValueError):
      discard 10.safeDivisibleBy(0)
    
    expect(ValueError):
      discard 5.safeClamp(10, 1)
    
    expect(ValueError):
      discard "hi".safeRepeat(-1)
  
  test "option wrappers":
    let nums = @[1, 2, 3, 4]
    let empty: seq[int] = @[]
    
    # Option operations that should work
    assert nums.optionFirst.get == 1
    assert nums.optionLast.get == 4
    assert nums.optionReduce(proc(a, b: int): int = a + b).get == 10
    
    # Option operations on empty sequences
    assert empty.optionFirst.isNone
    assert empty.optionLast.isNone
    assert empty.optionReduce(proc(a, b: int): int = a + b).isNone