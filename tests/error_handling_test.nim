import unittest
import ../src/nimtools

suite "Error Handling Tests":
  
  test "collections error handling":
    # Test empty sequence operations
    let empty: seq[int] = @[]
    
    expect(IndexDefect):
      discard empty.first
    
    expect(IndexDefect):
      discard empty.last
    
    expect(ValueError):
      discard empty.reduce(proc(a, b: int): int = a + b)
    
    # Test invalid chunk size
    let nums = @[1, 2, 3]
    expect(ValueError):
      discard nums.chunk(0)
    
    expect(ValueError):
      discard nums.chunk(-1)
  
  test "numbers error handling":
    # Test division by zero
    expect(DivByZeroDefect):
      discard 10.divisibleBy(0)
    
    # Test invalid clamp range
    expect(ValueError):
      discard 5.clamp(10, 1)  # min > max
  
  test "strings error handling":
    # Test negative repeat
    expect(ValueError):
      discard "hello".repeat(-1)
    
    # Test edge cases that should work
    assert "hello".startsWith("")  # empty prefix should return true
    assert "hello".endsWith("")    # empty suffix should return true
    assert "".startsWith("")       # both empty should return true
    assert "".endsWith("")         # both empty should return true
    
    # Test normal cases still work
    assert "hello".startsWith("he")
    assert "hello".endsWith("lo")
    assert not "hello".startsWith("hi")
    assert not "hello".endsWith("hi")