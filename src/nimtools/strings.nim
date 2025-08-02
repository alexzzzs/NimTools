## String helper templates for common string operations
##
## This module provides expressive, zero-overhead helpers for string manipulation
## using template-based dot-call syntax.

import std/options
import std/strutils

template startsWith*(s: string, prefix: string): bool =
  ## Check if string starts with prefix
  ## 
  ## Example:
  ##   assert "hello".startsWith("he")
  ##   assert not "hello".startsWith("hi")
  s.len >= prefix.len and s[0..<prefix.len] == prefix

template endsWith*(s: string, suffix: string): bool =
  ## Check if string ends with suffix
  ## 
  ## Example:
  ##   assert "hello".endsWith("lo")
  ##   assert not "hello".endsWith("hi")
  s.len >= suffix.len and s[s.len - suffix.len..^1] == suffix

template hasSubstring*(s: string, sub: string): bool =
  ## Check if string contains substring
  ## 
  ## Example:
  ##   assert "hello world".hasSubstring("llo")
  ##   assert not "hello".hasSubstring("xyz")
  find(s, sub) >= 0

template isEmpty*(s: string): bool =
  ## Check if string is empty
  ## 
  ## Example:
  ##   assert "".isEmpty
  ##   assert not "hello".isEmpty
  s.len == 0

template toIntSafe*(s: string): Option[int] =
  ## Safely convert string to int, returning None on failure
  ## 
  ## Example:
  ##   assert "123".toIntSafe.get == 123
  ##   assert "abc".toIntSafe.isNone
  try:
    some(parseInt(s))
  except ValueError:
    none(int)

template toFloatSafe*(s: string): Option[float] =
  ## Safely convert string to float, returning None on failure
  ## 
  ## Example:
  ##   assert "123.45".toFloatSafe.get == 123.45
  ##   assert "abc".toFloatSafe.isNone
  try:
    some(parseFloat(s))
  except ValueError:
    none(float)

template trim*(s: string): string =
  ## Remove whitespace from both ends of string
  ## 
  ## Example:
  ##   assert "  hello  ".trim == "hello"
  strip(s)

template trimStart*(s: string): string =
  ## Remove whitespace from start of string
  ## 
  ## Example:
  ##   assert "  hello  ".trimStart == "hello  "
  var result = s
  var i = 0
  while i < result.len and result[i] in {' ', '\t', '\n', '\r'}:
    inc i
  result[i..^1]

template trimEnd*(s: string): string =
  ## Remove whitespace from end of string
  ## 
  ## Example:
  ##   assert "  hello  ".trimEnd == "  hello"
  var result = s
  var i = result.len - 1
  while i >= 0 and result[i] in {' ', '\t', '\n', '\r'}:
    dec i
  result[0..i]

template splitBy*(s: string, delimiter: char): seq[string] =
  ## Split string by character delimiter
  ## 
  ## Example:
  ##   assert "a,b,c".splitBy(',') == @["a", "b", "c"]
  s.split(delimiter)

template repeat*(s: string, n: int): string =
  ## Repeat string n times
  ## 
  ## Example:
  ##   assert "hi".repeat(3) == "hihihi"
  var result = ""
  for i in 0..<n:
    result.add(s)
  result

template reverse*(s: string): string =
  ## Reverse the string
  ## 
  ## Example:
  ##   assert "hello".reverse == "olleh"
  var result = s
  for i in 0..<(result.len div 2):
    swap(result[i], result[result.len - 1 - i])
  result
