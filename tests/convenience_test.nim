import unittest
import ../src/nimtools

suite "Convenience methods tests":

  test "sum":
    let nums = @[1, 2, 3, 4, 5]
    check nums.sum == 15
    
    let floats = @[1.5, 2.5, 3.0]
    check floats.sum == 7.0

  test "product":
    let nums = @[2, 3, 4]
    check nums.product == 24
    
    let ones = @[1, 1, 1, 1]
    check ones.product == 1

  test "min and max":
    let nums = @[3, 1, 4, 1, 5, 9, 2, 6]
    check nums.min == 1
    check nums.max == 9
    
    let single = @[42]
    check single.min == 42
    check single.max == 42

  test "average":
    let nums = @[1, 2, 3, 4, 5]
    check nums.average == 3.0
    
    let evens = @[2, 4, 6, 8]
    check evens.average == 5.0

  test "count":
    let nums = @[1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    check nums.count(proc(x: int): bool = x.isEven) == 5
    check nums.count(proc(x: int): bool = x > 5) == 5
    check nums.count(proc(x: int): bool = x > 100) == 0

  test "join":
    let nums = @[1, 2, 3, 4, 5]
    check nums.join() == "1, 2, 3, 4, 5"
    check nums.join(" | ") == "1 | 2 | 3 | 4 | 5"
    check nums.join("") == "12345"
    
    let words = @["hello", "world", "nim"]
    check words.join(" ") == "hello world nim"

  test "chaining with convenience methods":
    let nums = @[1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    
    # Chain filter -> sum
    let evenSum = nums.filter(proc(x: int): bool = x.isEven).sum
    check evenSum == 30  # 2 + 4 + 6 + 8 + 10
    
    # Chain map -> product
    let squares = @[1, 2, 3].map(proc(x: int): int = x.square)
    check squares.product == 36  # 1 * 4 * 9
    
    # Chain filter -> map -> average
    let result = nums.filter(proc(x: int): bool = x <= 5)
                    .map(proc(x: int): int = x * 2)
                    .average
    check result == 6.0  # (2 + 4 + 6 + 8 + 10) / 5

  test "real-world example - data analysis":
    let salesData = @[100, 250, 75, 400, 150, 300, 50, 500, 200, 350]
    
    # Analyze sales performance
    let totalSales = salesData.sum
    let avgSales = salesData.average
    let maxSale = salesData.max
    let minSale = salesData.min
    let bigSales = salesData.count(proc(x: int): bool = x >= 300)
    
    check totalSales == 2375
    check avgSales == 237.5
    check maxSale == 500
    check minSale == 50
    check bigSales == 4
    
    # Complex analysis chain
    let premiumSalesAvg = salesData
      .filter(proc(x: int): bool = x >= 200)  # Premium sales only: [250, 400, 300, 500, 200, 350]
      .map(proc(x: int): int = (x * 110) div 100)  # Add 10% tax: [275, 440, 330, 550, 220, 385]
      .average
    
    # Average of [275, 440, 330, 550, 220, 385] = 2200/6 = 366.67
    check abs(premiumSalesAvg - 366.67) < 0.1