import unittest
import std/options
import ../src/nimtools/strings

suite "Strings module tests":
  
  test "startsWith":
    check "hello".startsWith("he")
    check not "hello".startsWith("hi")
    check "hello".startsWith("")
    check "".startsWith("")
    check not "".startsWith("hi")
  
  test "endsWith":
    check "hello".endsWith("lo")
    check not "hello".endsWith("hi")
    check "hello".endsWith("")
    check "".endsWith("")
    check not "".endsWith("hi")
  
  test "hasSubstring":
    check "hello world".hasSubstring("llo")
    check not "hello".hasSubstring("xyz")
    check "hello".hasSubstring("")
    check not "".hasSubstring("hi")
  
  test "isEmpty":
    check "".isEmpty
    check not "hello".isEmpty
    check not " ".isEmpty
  
  test "toIntSafe":
    check "123".toIntSafe.get == 123
    check "abc".toIntSafe.isNone
    check "-456".toIntSafe.get == -456
    check "".toIntSafe.isNone
    check "123abc".toIntSafe.isNone
  
  test "toFloatSafe":
    check "123.45".toFloatSafe.get == 123.45
    check "abc".toFloatSafe.isNone
    check "-456.78".toFloatSafe.get == -456.78
    check "".toFloatSafe.isNone
    check "123.45abc".toFloatSafe.isNone
  
  test "trim":
    check "  hello  ".trim == "hello"
    check "hello".trim == "hello"
    check "   ".trim == ""
    check "".trim == ""
  
  test "trimStart":
    check "  hello  ".trimStart == "hello  "
    check "hello".trimStart == "hello"
    check "   ".trimStart == ""
  
  test "trimEnd":
    check "  hello  ".trimEnd == "  hello"
    check "hello".trimEnd == "hello"
    check "   ".trimEnd == ""
  
  test "splitBy":
    check "a,b,c".splitBy(',') == @["a", "b", "c"]
    check "hello".splitBy(',') == @["hello"]
    check "".splitBy(',') == @[""]
    check "a,,c".splitBy(',') == @["a", "", "c"]
  
  test "repeat":
    check "hi".repeat(3) == "hihihi"
    check "hello".repeat(0) == ""
    check "".repeat(5) == ""
    check "x".repeat(1) == "x"
  
  test "reverse":
    check "hello".reverse == "olleh"
    check "".reverse == ""
    check "a".reverse == "a"
    check "ab".reverse == "ba"
    check "abc".reverse == "cba"