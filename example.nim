import nimtools
import std/options

echo "=== NimTools Quick Example ==="

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

# Collections module (split operations to avoid anonymous proc conflicts)
echo "\nCollections:"
let nums = @[1, 2, 3, 4, 5]
echo "  nums = ", nums

# Individual operations work fine
let evens = nums.filter(proc(x: int): bool = x mod 2 == 0)
echo "  nums.filter(even) = ", evens

let squares = nums.map(proc(x: int): int = x * x)
echo "  nums.map(square) = ", squares

let sum = nums.reduce(proc(a, b: int): int = a + b)
echo "  nums.reduce(sum) = ", sum

echo "  nums.take(3) = ", nums.take(3)
echo "  nums.reverse = ", nums.reverse
echo "  @[1,2,2,3].unique = ", @[1, 2, 2, 3].unique

echo "\n✅ All operations completed successfully!"