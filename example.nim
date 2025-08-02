import src/nimtools/numbers
import src/nimtools/strings
import src/nimtools/collections
import std/options

echo "=== NimTools Example ==="
echo ""

echo "Numbers:"
echo "4.isEven = ", 4.isEven
echo "5.square = ", 5.square
echo "15.clamp(1, 10) = ", 15.clamp(1, 10)
echo "7.between(5, 10) = ", 7.between(5, 10)
echo "12.divisibleBy(3) = ", 12.divisibleBy(3)
echo "5.0.isWhole = ", 5.0.isWhole
echo ""

echo "Strings:"
echo "\"hello\".startsWith(\"he\") = ", "hello".startsWith("he")
echo "\"hello\".endsWith(\"lo\") = ", "hello".endsWith("lo")
echo "\"hello world\".hasSubstring(\"llo\") = ", "hello world".hasSubstring("llo")
echo "\"  trim me  \".trim = \"", "  trim me  ".trim, "\""
echo "\"123\".toIntSafe = ", "123".toIntSafe
echo "\"abc\".toIntSafe.isNone = ", "abc".toIntSafe.isNone
echo "\"hi\".repeat(3) = ", "hi".repeat(3)
echo "\"hello\".reverse = ", "hello".reverse
echo ""

echo "Collections:"
let nums = @[1, 2, 3, 4, 5]
echo "nums = ", nums
proc evenPredicate(x: int): bool = x mod 2 == 0
echo "nums.filter(even) = ", nums.filter(evenPredicate)
proc squareFunc(x: int): int = x * x
echo "nums.map(square) = ", nums.map(squareFunc)
proc addFunc(a, b: int): int = a + b
echo "nums.reduce(sum) = ", nums.reduce(addFunc)
echo "nums.take(3) = ", nums.take(3)
echo "nums.reverse = ", nums.reverse
echo "@[1,2,2,3].unique = ", @[1, 2, 2, 3].unique