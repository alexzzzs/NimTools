import nimtools
import std/options

echo "=== NimTools v0.4.0 - Revolutionary Chaining Example ==="

# Numbers module
echo "\nNumbers:"
echo "  4.isEven = ", 4.isEven
echo "  5.square = ", 5.square
echo "  15.clamp(1, 10) = ", 15.clamp(1, 10)
echo "  12.divisibleBy(3) = ", 12.divisibleBy(3)

# Strings module
echo "\nStrings:"
echo "  \"hello\".startsWith(\"he\") = ", "hello".startsWith("he")
echo "  \"123\".toIntSafe = ", "123".toIntSafe
echo "  \"  trim me  \".trim = \"", "  trim me  ".trim, "\""
echo "  \"hi\".repeat(3) = ", "hi".repeat(3)

# Collections module
echo "\nCollections:"
let nums = @[1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
echo "  nums = ", nums

# Individual operations
let evens = nums.filter(proc(x: int): bool = x.isEven)
echo "  nums.filter(isEven) = ", evens

let squares = nums.map(proc(x: int): int = x.square)
echo "  nums.map(square) = ", squares

let sum = nums.reduce(proc(a, b: int): int = a + b)
echo "  nums.reduce(sum) = ", sum

# THE BREAKTHROUGH - Chaining that was impossible before!
echo "\n🎉 REVOLUTIONARY CHAINING:"
let chainResult = nums.filter(proc(x: int): bool = x > 3)
                     .filter(proc(x: int): bool = x.isEven)
                     .map(proc(x: int): int = x.square)
                     .take(3)

echo "  Chained result: ", chainResult

echo "  nums.take(3) = ", nums.take(3)
echo "  nums.reverse = ", nums.reverse
echo "  @[1,2,2,3].unique = ", @[1, 2, 2, 3].unique

echo "\n✅ All operations completed successfully!"
echo "🚀 The impossible chaining syntax now works in Nim!"