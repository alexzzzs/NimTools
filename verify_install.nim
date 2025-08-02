## Installation verification script
## Run this after installing nimtools to verify it works correctly

# Use local import for development, change to 'import src/nimtools' after installation
import src/nimtools

echo "🧪 Testing NimTools Installation..."
echo ""

# Test numbers module
echo "📊 Numbers Module:"
assert 4.isEven
assert 5.square == 25
assert 15.clamp(1, 10) == 10
echo "  ✅ All number functions working"

# Test strings module  
echo "📝 Strings Module:"
assert "hello".startsWith("he")
assert "hello".reverse == "olleh"
assert "  test  ".trim == "test"
echo "  ✅ All string functions working"

# Test collections module
echo "📚 Collections Module:"
let nums = @[1, 2, 3, 4, 5]
assert nums.filter(proc(x: int): bool = x mod 2 == 0) == @[2, 4]
assert nums.map(proc(x: int): int = x * 2) == @[2, 4, 6, 8, 10]
assert nums.take(3) == @[1, 2, 3]
echo "  ✅ All collection functions working"

echo ""
echo "🎉 NimTools installation verified successfully!"
echo "📖 See DOCUMENTATION.md for complete API reference"