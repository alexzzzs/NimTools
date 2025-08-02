# Package

version       = "0.3.5"
author        = "NimTools Contributors"
description   = "Lightweight, zero-dependency Nim library with expressive helper APIs for numbers, strings, and collections"
license       = "MIT"
srcDir        = "src"
skipDirs      = @["tests"]

# Metadata for package registry
packageName   = "nimtools"
bin           = @[]
installExt    = @["nim"]

# Dependencies

requires "nim >= 1.6.0"

# Tasks

task test, "Run all tests":
  echo "Running NimTools test suite..."
  exec "nim c -r tests/numbers_test.nim"
  exec "nim c -r tests/strings_test.nim"
  exec "nim c -r tests/collections_test.nim"
  exec "nim c -r tests/error_handling_test.nim"
  exec "nim c -r tests/validation_test.nim"
  echo "All tests completed successfully!"

task docs, "Generate documentation":
  echo "Generating documentation..."
  exec "nim doc --project --index:on --git.url:https://github.com/alexzzzs/NimTools --git.commit:main src/nimtools.nim"
  echo "Documentation generated in htmldocs/"

task example, "Run example":
  echo "Running example..."
  exec "nim c -r example.nim"

task clean, "Clean build artifacts":
  echo "Cleaning build artifacts..."
  exec "rm -f *.exe tests/*.exe"
  exec "rm -rf nimcache htmldocs"