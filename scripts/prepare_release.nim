#!/usr/bin/env nim
## Script to prepare a new release of NimTools

import std/[os, strutils, strformat]

proc runCmd(cmd: string) =
  echo fmt"Running: {cmd}"
  let result = execShellCmd(cmd)
  if result != 0:
    echo fmt"Command failed with exit code: {result}"
    quit(1)

proc main() =
  echo "🚀 Preparing NimTools Release"
  echo "=============================="
  
  # Check if we're in the right directory
  if not fileExists("nimtools.nimble"):
    echo "❌ Error: nimtools.nimble not found. Run this from the project root."
    quit(1)
  
  # Run tests
  echo "\n📋 Running tests..."
  runCmd("nimble test")
  
  # Verify installation
  echo "\n✅ Verifying installation..."
  runCmd("nimble verify")
  
  # Clean build artifacts
  echo "\n🧹 Cleaning build artifacts..."
  runCmd("nimble clean")
  
  # Check git status
  echo "\n📊 Checking git status..."
  runCmd("git status --porcelain")
  
  echo "\n✨ Release preparation complete!"
  echo "\nNext steps:"
  echo "1. Update version in nimtools.nimble if needed"
  echo "2. Commit any changes: git add . && git commit -m 'Prepare release vX.Y.Z'"
  echo "3. Create and push tag: git tag vX.Y.Z && git push origin vX.Y.Z"
  echo "4. Publish to nimble: nimble publish"

when isMainModule:
  main()